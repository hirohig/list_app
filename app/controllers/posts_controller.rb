class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def top
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(name: params[:name], user_id: @current_user.id)
    @user = User.find_by(id: @post.user_id)
    if @post.save
      flash[:notice] = "メモを追加しました"
      redirect_to("/users/#{@user.id}")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.name = params[:name]
    if @post.save
      flash[:notice] = "メモを編集しました"
      redirect_to("/users/#{@current_user.id}")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "メモを削除しました"
    redirect_to("/users/#{@current_user.id}")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
