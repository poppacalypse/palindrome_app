require_relative 'test_helper'

class PalindromeAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_form_presence
    get '/palindrome'
    assert doc(last_response).at_css('form')
  end

  def test_non_palindrome_submission
    # post '/check', { phrase: "Not a palindrome" }

    # When a hash is the final argument in a list of arguments, we can omit the curly braces
    post 'check', phrase: "Not a palindrome"

    # assert doc(last_response).at_css('p').content.include? "isn't a palindrome"

    #alternative using `assert_includes`
    assert_includes doc(last_response).at_css('p').content, "isn't a palindrome"
    assert doc(last_response).at_css('form')
  end

  def test_palindrome_submission
    post 'check', phrase: "Able was I, ere I saw Elba."
    assert_includes doc(last_response).at_css('p').content, "is a palindrome"
  end
end
