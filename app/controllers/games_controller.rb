require 'open-uri'
require 'json'

class GamesController < ApplicationController
  LETTERS = ('a'..'z').to_a

  def new
    @grid = []
    10.times do
      @grid << LETTERS.sample
    end
  end

  def score
    word = params[:word].split('')
    grid_letters = params[:letters].split
    inclusion = true
    word.each { |letter| inclusion &&= grid_letters.count(letter) >= word.count(letter) }

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    english_word = JSON.parse(open(url).read)['found']
    if inclusion == false
      @result = { message: "#{params[:word].capitalize} is not in the grid.", result: 0 }
    elsif english_word == true
      @result = { result: word.size, message: "Well done! #{params[:word].capitalize} is a nice word." }
    else
      @result = { message: "#{params[:word].capitalize} is not an English word!", result: 0 }
    end
  end
end
