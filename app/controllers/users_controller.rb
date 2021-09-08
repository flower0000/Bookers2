class UsersController < ApplicationController

 def show #投稿主詳細ページ
  @book = Book.new
  @user = User.find(params[:id])#showで選択したユーザーの情報を入れたい
  #ここまでがテンプレ部で使用するインスタンス変数

  @books = @user.books #ここの記述を確認する，@userで入った情報(1ユーザー)に関連付けられた投稿すべてを探したい
                       #アソシエーションでhas many booksで表記されているので.booksと表記することで全ての投稿を@booksに入れることができる
 end

 def index #User一覧
  @users = User.all
  @book = Book.new#テンプレートで使用する空のインスタンス変数
  @user = current_user#現在ログインしているユーザーの情報（name,title,profile_image_id）
 end

 def edit
  @user = User.find(params[:id])
  if current_user == @user
    render :edit
  else
    redirect_to user_path(current_user.id)
  end
 end

 def update
  @user = User.find(params[:id])
  if @user.update(user_params)
  flash[:notice] = "successfully"
  redirect_to user_path(@user.id)
  else
   flash[:alert] = "error"
   render :edit
  end
 end

 private

 def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
 end

end
