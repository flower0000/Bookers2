class BooksController < ApplicationController

 def index
  @book = Book.new
  @books = Book.all
  @user = current_user
 end

 def create
  @book = Book.new(book_params)
  @book.user_id = current_user.id
  #use_idはなにもしないと空なので，入力してあげる必要があるため現在ログインしているidカラムの値を入れてあげる必要有
  if @book.save
    flash[:notice] = "successfully"
    redirect_to book_path(@book.id)
  else
    flash[:alert] = "error"
    @user = current_user
    @books = Book.all
    render :index

  end
 end

 def show
  @book = Book.new#テンプレ用

  @bookdata = Book.find(params[:id])#User infoで空のインスタンス変数を渡す必要があるので別名で作成
  #投稿の1データ
  @user = @bookdata.user

 end

 def edit
  @book = Book.find(params[:id])
  if @book.user.id == current_user.id
    render :edit
  else
    redirect_to books_path
  end
 end

 def update
  book = Book.find(params[:id])#ここの時点ではまだeditアクションで引っ張ってきたデータが入っている(まだ更新できていない。更新前のid番のデータを取得)
  if book.update(book_params)#editのhtmlで入力した記述がストロングパラメーターを経由してbookの情報を上書きされる挙動が実行される
  flash[:notice] = "successfully"
  redirect_to book_path(book.id)
  else
   flash[:alert] = "error"
   @book = book#もう一度editのviewファイルに値を返すためにインスタンス変数にbookの内容を入れなおしてあげる
   render :edit
  end
 end

 def destroy
  @book = Book.find(params[:id])
  @book.destroy
  redirect_to books_path
 end

 private
 def book_params
  params.require(:book).permit(:title, :body)
 end

end
