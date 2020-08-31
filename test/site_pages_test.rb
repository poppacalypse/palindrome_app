require_relative 'test_helper'

# ======== A live web app ==============
# ------ Ch. 10.3 Layouts --------------

class PalindromeAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get '/'
    assert last_response.ok?
    # assert doc(last_response).css('h1').first
    assert doc(last_response).at_css('h1') # shorthand for grabbing first element of CSS bc it's so common

    # ----- Ch. 10.4 Embedded Ruby ----------
    # Test for changing titles dynamically
    assert_equal "Learn Enough Ruby Sample App | Home", doc(last_response).at_css('title').content

    # Test for factoring navigation into a different file
    assert doc(last_response).at_css('nav')
  end

  def test_about
    get '/about'
    assert last_response.ok?
    assert doc(last_response).at_css('h1')
    assert_equal "Learn Enough Ruby Sample App | About", doc(last_response).at_css('title').content
  end

  def test_palindrome
    get '/palindrome'
    assert last_response.ok?
    assert doc(last_response).at_css('h1')
    assert_equal "Learn Enough Ruby Sample App | Palindrome Detector", doc(last_response).at_css('title').content
  end

end
