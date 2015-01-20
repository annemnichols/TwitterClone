class TweetsController < ApplicationController
  before_action :set_user, except: [:index]
	before_action :set_tweet, only: [:edit, :update, :destroy, :show]

  def index
    @tweets = Tweet.all.order("created_at desc")
  end

  def show
  end

  def new
   if is_authorized?
    @tweet = @user.tweets.new  
   else
    flash[:notice] = "Nice try.  You can't create tweets for other users."
    redirect_to user_path(@user)    
   end

  end

  def edit
    unless is_authorized?
      flash[:notice] = "Nice try.  You can't edit tweets for other users."
      redirect_to user_path(@user)
    end
  end	

  def create
  	@tweet = @user.tweets.build(tweet_params)

    if is_authorized?
  	 if @tweet.save
  		  redirect_to user_path(@user)
  	 else
  		  render :new
  	 end
    else
      flash[:notice] = "Nice try.  You can't create tweets for other users."
      render :new
    end  
  end


  def update
  	if is_authorized?
     if @tweet.update(tweet_params)
  		redirect_to user_path(@user)
  	 else
  		  render :edit
  	 end
    end
  end

  def destroy
    if is_authorized?    
  	 @tweet.destroy
  	 redirect_to user_path(@user) 
    else
      flash[:notice] = "Nice try.  You can't delete tweets for other users."
      redirect_to user_path(@user)     
    end
  end

  private

    def is_authorized?
      @user == current_user
    end
      
    def set_user
      @user = User.find(params[:user_id])
    end

  	def set_tweet
  		@tweet = Tweet.find(params[:id])
  	end

  	def tweet_params
  		params.require(:tweet).permit(:body, :user_id)
  	end
end
