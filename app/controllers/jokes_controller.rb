class JokesController < ApplicationController
  protect_from_forgery except: :import
  def index
    # Get killed joke IDs from cookies
    killed_ids = get_killed_joke_ids
    
    # Handle sorting with pagination, excluding killed jokes
    if params[:sort_by] == "date"
      @jokes = Joke.where.not(id: killed_ids).order(:created_at).page(params[:page]).per(5)
    else
      @jokes = Joke.where.not(id: killed_ids).by_category.page(params[:page]).per(5)
    end
    
    @joke = Joke.new
    @has_personalization = killed_ids.any?
  end

  def create
    # Handle new category logic first
    new_category = params[:joke][:new_category] if params[:joke]
    selected_category = params[:joke][:category] if params[:joke]
    
    category_to_use = selected_category
    if new_category.present?
      category_to_use = new_category.strip
    elsif selected_category == 'new_category'
      # If "new category" was selected but no new category provided
      flash[:error] = "Please enter a new category name"
      redirect_to ps2_path and return
    end
    
    # Create joke with the determined category
    joke_attrs = joke_params
    joke_attrs[:category] = category_to_use
    @joke = Joke.new(joke_attrs)
    
    if @joke.save
      flash[:notice] = 'Tech joke was successfully added.'
      redirect_to ps2_path
    else
      # Add debugging for validation errors
      Rails.logger.debug "Joke validation errors: #{@joke.errors.full_messages}"
      flash[:error] = "Error adding joke: #{@joke.errors.full_messages.join(', ')}"
      
      # Reload jokes for display with current sort and pagination, excluding killed jokes
      killed_ids = get_killed_joke_ids
      if params[:sort_by] == "date"
        @jokes = Joke.where.not(id: killed_ids).order(:created_at).page(params[:page]).per(5)
      else
        @jokes = Joke.where.not(id: killed_ids).by_category.page(params[:page]).per(5)
      end
      @has_personalization = killed_ids.any?
      render :index
    end
  end

  def search
    search_term = params[:search]
    killed_ids = get_killed_joke_ids
    
    if search_term.present?
      # Case-insensitive search in both quote and author_name with pagination, excluding killed jokes
      jokes_query = Joke.where.not(id: killed_ids)
                        .where("quote ILIKE ? OR author_name ILIKE ?", 
                               "%#{search_term}%", "%#{search_term}%")
      
      # Apply sorting to search results
      if params[:sort_by] == "date"
        @jokes = jokes_query.order(:created_at).page(params[:page]).per(5)
      else
        @jokes = jokes_query.by_category.page(params[:page]).per(5)
      end
      
      flash.now[:notice] = "Found #{jokes_query.count} joke(s) matching '#{search_term}'"
    else
      # No search term, show all jokes with pagination, excluding killed jokes
      if params[:sort_by] == "date"
        @jokes = Joke.where.not(id: killed_ids).order(:created_at).page(params[:page]).per(5)
      else
        @jokes = Joke.where.not(id: killed_ids).by_category.page(params[:page]).per(5)
      end
    end
    
    @joke = Joke.new
    @has_personalization = killed_ids.any?
    render :index
  end

  def about
    # Show database architecture explanation
  end

  def export
    # Get all jokes (not filtered by personalization for complete export)
    @jokes = Joke.all.order(:id)
    
    respond_to do |format|
      format.xml { 
        # Create custom XML format
        xml = Builder::XmlMarkup.new(:indent => 2)
        xml.instruct!
        xml.jokes do
          @jokes.each do |joke|
            xml.joke do
              xml.id joke.id
              xml.quote joke.quote
              xml.author_name joke.author_name
              xml.category joke.category
              xml.created_at joke.created_at.iso8601
            end
          end
        end
        render xml: xml.target!
      }
      format.json { 
        render json: @jokes.to_json(
          :only => [:id, :quote, :author_name, :category, :created_at]
        )
      }
    end
  end

  def import
    url = params[:import_url]
    
    if url.blank?
      flash[:error] = "Please provide a URL to import from."
      redirect_to ps2_path
      return
    end

    begin
      # Fetch XML from the provided URL
      require 'net/http'
      require 'rexml/document'
      
      uri = URI(url)
      response = Net::HTTP.get_response(uri)
      
      if response.code != '200'
        flash[:error] = "Failed to fetch data from URL. HTTP Status: #{response.code}"
        redirect_to ps2_path
        return
      end

      # Check if response looks like XML
      response_body = response.body.strip
      unless response_body.start_with?('<?xml') || response_body.start_with?('<jokes')
        flash[:error] = "The URL does not return XML data. Please ensure the URL returns XML format (not JSON or HTML)."
        redirect_to ps2_path
        return
      end

      # Parse XML
      doc = REXML::Document.new(response_body)
      imported_count = 0
      skipped_count = 0

      # Extract jokes from XML - support multiple formats
      doc.elements.each('jokes/joke') do |joke_element|
        # Try our format first (quote, author_name, category)
        quote = joke_element.elements['quote']&.text
        author_name = joke_element.elements['author_name']&.text
        category = joke_element.elements['category']&.text
        
        # If not found, try AIT server format (content, author, category)
        if quote.blank?
          quote = joke_element.elements['content']&.text
        end
        if author_name.blank?
          author_name = joke_element.elements['author']&.text
        end
        
        # Skip if essential data is missing
        next if quote.blank? || author_name.blank?
        
        # Check if joke already exists (avoid duplicates based on quote)
        existing_joke = Joke.find_by(quote: quote)
        if existing_joke
          skipped_count += 1
          next
        end
        
        # Create new joke
        new_joke = Joke.new(
          quote: quote,
          author_name: author_name,
          category: category.present? ? category : 'Imported'
        )
        
        if new_joke.save
          imported_count += 1
        else
          skipped_count += 1
        end
      end

      if imported_count > 0
        flash[:notice] = "Successfully imported #{imported_count} joke(s). #{skipped_count} joke(s) were skipped (duplicates or invalid data)."
      else
        flash[:error] = "No jokes were imported. #{skipped_count} joke(s) were skipped."
      end

    rescue URI::InvalidURIError
      flash[:error] = "Invalid URL format. Please provide a valid URL."
    rescue Timeout::Error, Errno::ETIMEDOUT
      flash[:error] = "Request timed out. Please check the URL and try again."
    rescue REXML::ParseException => e
      flash[:error] = "Invalid XML format. The URL must return valid XML data, not JSON or other formats. Error: #{e.message}"
    rescue Net::HTTPError => e
      flash[:error] = "HTTP error: #{e.message}"
    rescue => e
      flash[:error] = "Error importing jokes: #{e.message}"
    end

    redirect_to ps2_path
  end

  def kill_joke
    joke_id = params[:id]
    killed_ids = get_killed_joke_ids
    
    unless killed_ids.include?(joke_id)
      killed_ids << joke_id
      # Store as space-separated string in cookie (expires in 1 year)
      cookies[:killed_jokes] = {
        value: killed_ids.join(' '),
        expires: 1.year.from_now
      }
    end
    
    flash[:notice] = "Joke has been killed and will no longer appear for you."
    
    # Redirect back to the appropriate page
    if params[:search].present?
      redirect_to search_jokes_path(search: params[:search], sort_by: params[:sort_by], page: params[:page])
    else
      redirect_to ps2_path(sort_by: params[:sort_by], page: params[:page])
    end
  end

  def erase_personalization
    # Expire the cookie by setting it to expire in the past
    cookies[:killed_jokes] = {
      value: '',
      expires: 1.day.ago
    }
    
    flash[:notice] = "Your personalization has been erased. All jokes are now visible again."
    redirect_to ps2_path
  end

  private

  def get_killed_joke_ids
    killed_jokes_cookie = cookies[:killed_jokes]
    if killed_jokes_cookie.present?
      killed_jokes_cookie.split(' ').map(&:to_i)
    else
      []
    end
  end

  def joke_params
    params.require(:joke).permit(:author_name, :category, :quote)
  end
end
