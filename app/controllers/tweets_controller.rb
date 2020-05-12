class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.create(tweet_params)
    if @tweet.save
      redirect_to root_path, notice: "投稿が完了しました"
    else
      flash.now[:alert] = "メッセージの投稿に失敗しました"
      render :new
    end
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
      redirect_to root_path, notice: "編集が完了しました"
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
      redirect_to root_path, notice: "削除が完了しました"
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def edit
  end

  def search
    @tweets = Tweet.search(params[:keyword])
  end

  private
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id]) 
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
