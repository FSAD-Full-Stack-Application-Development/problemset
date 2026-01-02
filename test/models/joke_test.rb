require "test_helper"

class JokeTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    joke = Joke.new(
      author_name: "Test Author",
      category: "Test Category", 
      quote: "This is a test joke with sufficient length to pass validation."
    )
    assert joke.valid?
  end

  test "should require quote" do
    joke = Joke.new(author_name: "Test Author", category: "Test")
    assert_not joke.valid?
    assert_includes joke.errors[:quote], "can't be blank"
  end

  test "should require author_name" do
    joke = Joke.new(category: "Test", quote: "This is a test joke with sufficient length.")
    assert_not joke.valid?
    assert_includes joke.errors[:author_name], "can't be blank"
  end

  test "should validate quote minimum length" do
    joke = Joke.new(
      author_name: "Test Author",
      category: "Test",
      quote: "Short"
    )
    assert_not joke.valid?
    assert_includes joke.errors[:quote], "is too short (minimum is 10 characters)"
  end

  test "should validate quote maximum length" do
    joke = Joke.new(
      author_name: "Test Author",
      category: "Test",
      quote: "a" * 501
    )
    assert_not joke.valid?
    assert_includes joke.errors[:quote], "is too long (maximum is 500 characters)"
  end

  test "should validate author_name maximum length" do
    joke = Joke.new(
      author_name: "a" * 101,
      category: "Test",
      quote: "This is a test joke with sufficient length."
    )
    assert_not joke.valid?
    assert_includes joke.errors[:author_name], "is too long (maximum is 100 characters)"
  end

  test "should validate category maximum length" do
    joke = Joke.new(
      author_name: "Test Author",
      category: "a" * 51,
      quote: "This is a test joke with sufficient length."
    )
    assert_not joke.valid?
    assert_includes joke.errors[:category], "is too long (maximum is 50 characters)"
  end

  test "by_category_scope_should_order_by_category_then_author_name" do
    # Clear existing jokes to avoid fixture interference
    Joke.delete_all
    
    joke1 = Joke.create!(author_name: "Z Author", category: "A Category", quote: "Test joke one with sufficient length for validation.")
    joke2 = Joke.create!(author_name: "A Author", category: "B Category", quote: "Test joke two with sufficient length for validation.")
    joke3 = Joke.create!(author_name: "A Author", category: "A Category", quote: "Test joke three with sufficient length for validation.")

    jokes = Joke.by_category
    assert_equal joke3, jokes.first  # A Category, A Author
    assert_equal joke1, jokes.second # A Category, Z Author
    assert_equal joke2, jokes.third  # B Category, A Author
  end

  test "distinct_categories_should_return_sorted_unique_categories" do
    # Clear existing jokes to avoid fixture interference
    Joke.delete_all
    
    Joke.create!(author_name: "Author 1", category: "Programming", quote: "Test joke one with sufficient length.")
    Joke.create!(author_name: "Author 2", category: "AI", quote: "Test joke two with sufficient length.")
    Joke.create!(author_name: "Author 3", category: "Programming", quote: "Test joke three with sufficient length.")
    Joke.create!(author_name: "Author 4", category: "", quote: "Test joke four with sufficient length.")
    Joke.create!(author_name: "Author 5", category: nil, quote: "Test joke five with sufficient length.")

    categories = Joke.distinct_categories
    assert_equal ["AI", "Programming"], categories
  end
end
