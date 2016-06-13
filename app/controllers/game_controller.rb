class GameController < ApplicationController

  def index
    @rankings = Ranking.all
  end

  def choose_game

  end

  def game_number
    #interante game working - number
  end

  def save_name
     session[:name] = params[:name]
     redirect_to game_word_path
  end

  def game_word

    @tries = []
    @gameword = nil

    if session[:game] == nil

      @gameword = random_game

      session[:game] = @gameword.id
    else
      GameWord.all.each do |game|
        if game.id == session[:game]
          @gameword = game
          break
        end
      end
    end

    if params[:letter] != nil
      if session[:letter] != nil
        @tries = session[:letter]
      end
      @tries << params[:letter].upcase
      session[:letter] = @tries
    end

    @word = answer(@gameword.answer.upcase, @tries)
    @wrong = wrong_letter(@gameword.answer.upcase, @tries)

    if !@word.include?("_")
      redirect_to you_won_path
    elsif @wrong >= 10
      redirect_to you_lost_path
    end
    session[:tries] = @tries.size

    @image = "0#{@wrong}.jpg"

  end

  def you_won

    @ranking = Ranking.new(name: session[:name], tries: session[:tries], game: 1)
    @ranking.save

    session[:letter] = nil
    session[:game] = nil
    #message you win! ranking!
  end

  def you_lost
    session[:letter] = nil
    session[:game] = nil
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

  def random_game
    @game_words = GameWord.all
    size = @game_words.size - 1
    random = Random.new
    @game_words[random.rand(size)]
  end

end
