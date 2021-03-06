class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:show, :update]}

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/users/#{@user.id}")
    else
      @error_message = "ユーザー名またはパスワードが間違っています"
      @name = params[:user][:name]
      @password = params[:user][:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id)
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:user][:name]

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def index
    @users = User.all
  end

  private

    def user_params
      params.require(:user).permit(:name, :password)
    end

    def ensure_correct_user
      if @current_user.id != params[:id].to_i
        flash[:notice] = "権限がありません"
        redirect_to("/users/#{@current_user.id}")
      end
    end
end
