require 'open-uri'

class GamesController < ApplicationController
    VOWELS = %w(A E I O U Y)
  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    #letras
    @letters = params[:letters].split
    #palabras
    @word = params[:word].upcase
    #si se incluye y si son palabras en ingles
    @include = include?(@word, @letters)

    @english_word = english_word?(@word)
  end

  private

  def include?(word, letters)
      word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

end
