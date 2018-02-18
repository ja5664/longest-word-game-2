require 'open-uri'

class GamesController < ApplicationController
  def new
    letters = ("a".."z").to_a
    @chosen_letters = []
    number_of_letters = 10
    until @chosen_letters.length == number_of_letters
      sample = letters.sample
      if @chosen_letters.index(sample)
        puts "letter already present"
      else
        @chosen_letters << sample
      end
    end
    @chosen_letters
  end

  def score
    attempt = params[:attempt].split("")
    grid = params[:grid].split(" ")
    letters_not_used = grid - attempt
    valid = word_in_dictionary(params[:attempt])
    if attempt.length + letters_not_used.length != grid.length
      @result = {valid: false, text: "invalid as the letters were not in the grid"}
    elsif valid["found"]
      @result = {valid: true, text: "valid based on the words in the grid and was a word in the dictionary"}
    else
      @result = {valid: false, text: "not valid - the words are in the grid but the word is not in the dictionary"}
    end
  end

  private

  def word_in_dictionary(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    wagon_dict_read = open(url).read
    JSON.parse(wagon_dict_read)
  end
end
