class BooksController < ApplicationController
		before_action :authenticate_user!
		before_action :correct_user, only: [:edit, :update]
	def index
		@book = Book.new
		@books = Book.all
		@user = User.find(current_user.id)
	end

	def create
		@books = Book.all
		@user = User.find(current_user.id)
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		if @book.save
			flash[:notice]="Book was successfully created."
		    redirect_to book_path(@book)
		else
			render template: "books/index"
		end
	end

	def show
		@book = Book.find(params[:id])
		@user = User.find(@book.user.id)
		@booknew = Book.new
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		@book.user_id = current_user.id
		if @book.update(book_params)
			flash[:notice]="Book was successfully updated."
			redirect_to book_path(@book)
		else
			render :edit
		end
	end

	def destroy
		@book = Book.find(params[:id])
		if @book.destroy
			flash[:notice]="Book was successfully destroyed."
			redirect_to books_path
		end
	end

	private
	def book_params
		params.require(:book).permit(:title,:body)
	end
	def correct_user
		book = Book.find(params[:id])
		if current_user.id != book.user.id
			redirect_to books_path
		end
	end
end
