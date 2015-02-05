class LearnedWordsController < ApplicationController
  before_action :set_learned_word, only: [:show, :edit, :update, :destroy]
  respond_to :json

  def index
    @learned_words = LearnedWord.items_for(params[:course_id])
    render json: @learned_words, each_serializer: LearnedWordSerializer
  end

  def show
  end

  def new
    @learned_word = LearnedWord.new
  end

  def edit
  end

  def create
    @learned_word = LearnedWord.new(learned_word_params)

    if @learned_word.save
      redirect_to @learned_word, notice: 'Course item was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @learned_word.update(learned_word_params)
      head :ok
    else
      render json: { error: "error" }, status: :bad_request
    end
  end

  def destroy
    @learned_word.destroy
    redirect_to learned_words_url, notice: 'Course item was successfully destroyed.'
  end

  private
    def set_learned_word
      @learned_word = LearnedWord.find(params[:id])
    end

    def learned_word_params
      params.require(:learned_word).permit(:times_repeated, :last_learned, :word_id, :user_id)
    end
end
