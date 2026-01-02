require "test_helper"

class JokesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @joke = jokes(:one)
  end

  test "should get index" do
    get ps2_url
    assert_response :success
    assert_select "h1", /Tech Jokes Database/i
  end

  test "should get index via jokes route" do
    get jokes_url
    assert_response :success
    assert_select "h1", /Tech Jokes Database/i
  end

  test "should display jokes in index" do
    get ps2_url
    assert_response :success
    assert_select "div.joke-item", minimum: 1
  end

  test "should create joke with valid parameters" do
    assert_difference("Joke.count") do
      post jokes_url, params: { 
        joke: { 
          author_name: "Test Author", 
          category: "Testing", 
          quote: "This is a test joke with sufficient length to pass validation." 
        } 
      }
    end
    assert_redirected_to ps2_url
    assert_match /successfully added/, flash[:notice]
  end

  test "should not create joke with invalid parameters" do
    assert_no_difference("Joke.count") do
      post jokes_url, params: { 
        joke: { 
          author_name: "", 
          category: "Testing", 
          quote: "Short" 
        } 
      }
    end
    assert_response :success
    assert_match /Error adding joke/, flash[:error]
  end

  test "should create joke with new category" do
    assert_difference("Joke.count") do
      post jokes_url, params: { 
        joke: { 
          author_name: "Test Author", 
          category: "new_category",
          new_category: "Brand New Category", 
          quote: "This is a test joke with a brand new category that should work fine." 
        } 
      }
    end
    assert_redirected_to ps2_url
    joke = Joke.last
    assert_equal "Brand New Category", joke.category
  end

  test "should handle new category selection without providing category name" do
    assert_no_difference("Joke.count") do
      post jokes_url, params: { 
        joke: { 
          author_name: "Test Author", 
          category: "new_category",
          new_category: "", 
          quote: "This should fail because no new category name was provided." 
        } 
      }
    end
    assert_redirected_to ps2_url
    assert_match /Please enter a new category name/, flash[:error]
  end

  test "should get search" do
    get search_jokes_url
    assert_response :success
  end

  test "should search jokes by quote" do
    get search_jokes_url, params: { search_type: "quote", search_term: "programmer" }
    assert_response :success
  end

  test "should search jokes by author" do
    get search_jokes_url, params: { search_type: "author_name", search_term: "Tech" }
    assert_response :success
  end

  test "should search jokes by category" do
    get search_jokes_url, params: { search_type: "category", search_term: "Programming" }
    assert_response :success
  end

  test "should get about page" do
    get jokes_about_url
    assert_response :success
  end

  test "should export jokes as xml" do
    get export_jokes_url, params: { format: :xml }
    assert_response :success
    assert_equal "application/xml; charset=utf-8", response.content_type
  end

  test "should kill joke" do
    post kill_joke_url(@joke.id)
    assert_redirected_to ps2_url
    assert_match /killed/, flash[:notice]
  end

  test "should erase personalization" do
    # First kill a joke to have some personalization
    post kill_joke_url(@joke.id)
    
    # Then erase personalization
    post erase_personalization_url
    assert_redirected_to ps2_url
    assert_match /erased/, flash[:notice]
  end

  test "should sort jokes by date" do
    get ps2_url, params: { sort_by: "date" }
    assert_response :success
  end

  test "should sort jokes by category" do
    get ps2_url, params: { sort_by: "category" }
    assert_response :success
  end

  test "should handle pagination" do
    get ps2_url, params: { page: 1 }
    assert_response :success
  end

  test "should handle missing import url" do
    assert_no_difference("Joke.count") do
      post import_jokes_url, params: { import_url: "" }
    end
    
    assert_redirected_to ps2_url
    assert_match /Please provide a URL/, flash[:error]
  end

  test "should handle invalid import url" do
    assert_no_difference("Joke.count") do
      post import_jokes_url, params: { import_url: "not-a-valid-url" }
    end
    
    assert_redirected_to ps2_url
    assert_match /Error importing jokes/, flash[:error]
  end
end