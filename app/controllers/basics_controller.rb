require 'ferrum'
require 'nokogiri'

class BasicsController < ApplicationController
  def index
    # --- Q1: Page generation time & Rails env ---
    @generated_at = Time.current.strftime("%Y-%m-%d %H:%M:%S")
    @rails_env = Rails.env

     # --- Q2: Logging & intentional error ---
    begin
      Rails.logger.error "[AI News Aggregator] About to divide by 0 for testing."
      result = 1 / 0
    rescue ZeroDivisionError => e
      Rails.logger.error "[AI News Aggregator] Caught error: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
    end

    # --- Q3: Fetch AI news ---
    @mit_news, @venturebeat_news = fetch_ai_news
  end

  private

def fetch_ai_news
  @fetch_logs = []  # Initialize log array

  #define browser options
  browser = Ferrum::Browser.new(
    headless: true,
    browser_path: "/usr/bin/chromium", # path inside container
    process_timeout: 30,
    browser_options: { "no-sandbox" => nil }
  )

  # --- MIT Technology Review ---
  begin
    @fetch_logs << "[AI News Aggregator] Navigating to MIT Tech Review..."
    browser.goto "https://www.technologyreview.com/topic/artificial-intelligence/"
    sleep 1
    mit_html = browser.body
    @fetch_logs << "[AI News Aggregator] Fetched MIT HTML length: #{mit_html.length}"

    mit_doc = Nokogiri::HTML(mit_html)
    mit_news = mit_doc.css('a[data-event-category="topic-feed"]').map do |link|
  url = link['href']
  url = "https://www.technologyreview.com#{url}" unless url.start_with?('http')

  title = link.at_css('h3')&.text&.strip
  title ||= link.at_css('div')&.text&.strip   # fallback if h3 missing
  title ||= link.text.strip                   # last fallback

  { title: title, url: url }
end.reject { |item| item[:title].empty? }   # remove empty titles
.first(10)
    @fetch_logs << "[AI News Aggregator] MIT headlines found: #{mit_news.size}"
  rescue => e
    @fetch_logs << "[AI News Aggregator] Error fetching MIT Tech Review: #{e.message}"
    mit_news = []
  end

  # --- VentureBeat ---
  begin
    @fetch_logs << "[AI News Aggregator] Navigating to VentureBeat..."
    browser.goto "https://venturebeat.com/category/ai/"
    vb_html = browser.body
    @fetch_logs << "[AI News Aggregator] Fetched VentureBeat HTML length: #{vb_html.length}"

    vb_doc = Nokogiri::HTML(vb_html)
    venturebeat_news = vb_doc.css('h2 a, h3 a').map do |link|
      url = link['href']
      url = "https://venturebeat.com#{url}" unless url.start_with?('http')
      { title: link.text.strip, url: url }
    end.first(10)
    @fetch_logs << "[AI News Aggregator] VentureBeat headlines found: #{venturebeat_news.size}"
  rescue => e
    @fetch_logs << "[AI News Aggregator] Error fetching VentureBeat: #{e.message}"
    venturebeat_news = []
  end

  browser.quit
  return mit_news, venturebeat_news
end


end
