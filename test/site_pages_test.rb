require_relative 'test_helper'

# ======== A live web app ==============
# ------ Ch. 10.3 Layouts --------------

class PalindromeAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  # Exercise: Eliminate duplication by creating a `setup` method (which is automatically run before each test) that defines an instance variable for the base title.
  def setup
    @base_title = "Palindrome App"
  end

  def test_index
    get '/'
    assert last_response.ok?
    # assert doc(last_response).css('h1').first
    assert doc(last_response).at_css('h1') # shorthand for grabbing first element of CSS bc it's so common

    # ----- Ch. 10.4 Embedded Ruby ----------
    # Test for changing titles dynamically
    # assert_equal "Palindrome App | Home", doc(last_response).at_css('title').content

    # Using `setup` instance variable
    assert_equal "#{@base_title} | Home", doc(last_response).at_css('title').content

    # Test for factoring navigation into a different file
    assert doc(last_response).at_css('nav')
  end

  def test_about
    get '/about'
    assert last_response.ok?
    assert doc(last_response).at_css('h1')
    assert doc(last_response).at_css('nav')

    # We can also factor the title content like this:
    title_content = doc(last_response).at_css('title').content
    # assert_equal "Palindrome App | About", title_content
    assert_equal "#{@base_title} | About", title_content
  end

  def test_palindrome
    get '/palindrome'
    assert last_response.ok?
    assert doc(last_response).at_css('h1')
    # assert_equal "Palindrome App | Palindrome Detector", doc(last_response).at_css('title').content
    title_content = doc(last_response).at_css('title').content
    assert_equal "#{@base_title} | Palindrome Detector", title_content
    assert doc(last_response).at_css('nav')
  end

end
