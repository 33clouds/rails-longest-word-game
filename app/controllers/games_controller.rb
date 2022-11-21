require "json"
require "open-uri"

class GamesController < ApplicationController
  def word_exists?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = URI.open(url).read
    JSON.parse(response)["found"]
  end
  helper_method :word_exists?

  def only_letters?(word, letters)
    word.chars.all? do |letter|
      letters.count(letter) >= word.count(letter)
    end
  end
  helper_method :only_letters?

  def new
    @letters = Array.new(10) do
      ('A'..'Z').to_a.sample
    end
  end

  def score
    @guess = params["guess"]
    @letters = params["grid"].chars
  end
end
