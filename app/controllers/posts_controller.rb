class PostsController < ApplicationController

  before_filter :require_admin, :only => [ :edit, :update, :new, :create, :destroy ]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by_id( params[:id] )
  end

  def edit
    @post = Post.find_by_id( params[:id] )
  end

  def update
    @post = Post.find_by_id( params[:id] )

    if @post.update_attributes( params[:post] )
      redirect_to post_path( @post.id )
    else
      redirect_back_or_default edit_post_path( @post.id )
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new( params[:post] )
    
    if @post.save
      redirect_to post_path( @post.id )
    else
      redirect_back_or_default new_post_path
    end
  end

  def destroy
    @post = Post.find_by_id( params[:id] )
    @post.destroy
  end
end
