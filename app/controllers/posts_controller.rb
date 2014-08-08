class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]

  def index
    @posts = Post.all.sort_by { |x| x.total_votes }.reverse
  end

  def show
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user 
    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    if @post.user == current_user
      render :edit
    else
      flash[:error] = "You can only edit your own posts."
      redirect_to post_path(@post)
    end
  end

  def update
    if @post.user == current_user
      if @post.update(post_params)
        flash[:notice] = "The post was updated"
        redirect_to post_path(@post)
      else
        render :edit
      end
    else
      redirect_to root_path
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, user: current_user, vote: params[:vote])

    respond_to do |format|
      format.html { redirect_to :back, notice: vote_message(@vote)}
      format.js
    end
  end

  private 
  # strong paramaters

  def vote_message(vote)
    if vote.valid?
      "Your vote was counted."
    else
      "Sorry you can only vote once"
    end
  end

  def post_params
    #:post is the top level key
    # params.require(:post).permit(:title, :url)
    #params.require(:post).permit! works for everything
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
    @comment = Comment.new 
  end
end
