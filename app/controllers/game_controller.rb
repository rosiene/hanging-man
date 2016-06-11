class GameController < ApplicationController

  def index

  end

  def choose_game
    #input name and choose the game
  end

  def game_number
    #interante game working - number
  end

  def game_word
    #session[:answer] = @gameword.id
    @tries = []
    @gameword = { answer:"Slack" , clue: "slack.jpg" }

    if params[:letter] != nil
      if session[:letter] != nil
        @tries = session[:letter]
      end
      @tries << params[:letter].upcase
      session[:letter] = @tries
    end

    @word = answer(@gameword[:answer], @tries)
    @wrong = wrong_letter(@gameword[:answer], @tries)

    if !@word.include?("_")
        render "you_won"
    elsif @wrong >= 10
      render "you_lost"

    end

    @image = "0#{@wrong}.jpg"

  end

  def you_won
    session[:letter] = nil
    #message you win! ranking!
  end

  def you_lost
    session[:letter] = nil
    #message you win! ranking!
  end

  def answer(word, tries)
    answer = word.split(//)

    show_word = []

    if tries.empty?
      answer.each { |x| show_word << "_" }
    else
      answer.each do |answer_letter|
        if tries.include?(answer_letter.upcase)
          show_word << answer_letter.upcase
        else
          show_word << "_"
        end
      end
    end
    show_word
  end

  def wrong_letter(word, tries)
    wrong = 1
    tries.each do |letter|
      if !word.include?(letter.upcase)
        wrong += 1
      end
    end
    wrong
  end
end
