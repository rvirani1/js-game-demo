class HangmenController < ApplicationController

  before_action :authenticate_user!
  respond_to :json, only: [:answer]

  def index
    @hangmen = current_user.all_games
  end

  def show
    @hangman = current_user.hangmen.find params[:id]
    gon.hangman_id = params[:id]
  end


  def create
    hangman = current_user.hangmen.create! answer: Hangman::WORD_LIST.sample
    redirect_to hangman
  end

  def update
    hangman = current_user.hangmen.find params[:id]
    hangman.guess params[:guess] unless hangman.finished?
    redirect_to hangman
  end


  def new_challenge
  end

  def create_challenge
    params["data"].each do |challenge_data|
      challenged_id = challenge_data["person"]
      answer = challenge_data["word"]
      current_user.hangmen.create!( challenged_id: challenged_id, answer: answer )
    end
    Pusher.trigger('challenges', 'newchallenge', {challenger: current_user.email} )
    redirect_to hangmen_path, :notice => "Successfully created new challenges"
  end

  def answer
    hangman = Hangman.find(params[:id])
    hangman.solve_puzzle
    render json: [hangman.answer]
  end

  def hint
    hangman = Hangman.find(params[:id])
    render json: [hangman.hint]
  end
end
