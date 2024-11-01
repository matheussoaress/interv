# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :create_books

  def index
    render json: { books: @books }, status: :ok
  end

  def create
    book = Book.new
    book.id = @books.last.id + 1
    book.title = permitted_params[:title]
    book.author = permitted_params[:author]
    book.publication_year = permitted_params[:publication_year]
    @books << book

    render json: { book: book }, status: :created
  end

  def destroy
    book = @books.find { |b| b.id == params[:id].to_i }
    raise ActiveRecord::RecordNotFound unless book

    @books.delete(book)
    render json: { book: book }, status: :ok
  rescue
    render json: { message: 'book not found'}, status: :not_found
  end

  def show
    book = @books.find { |b| b.id == params[:id].to_i }
    raise ActiveRecord::RecordNotFound unless book

    render json: { book: book }, status: :ok
  rescue
    render json: { message: 'book not found'}, status: :not_found
  end

  def update
    book = @books.find { |b| b.id == params[:id].to_i }
    raise ActiveRecord::RecordNotFound unless book
    permitted_params.each do |param|
      book.send("#{param[0].to_sym}=", param[1])
    end

    render json: { book: book }, status: :ok
  end

  private

  def permitted_params
    params.require(:book).permit(:title, :author, :publication_year)
  end

  def create_books
    @books = (1..10).map do |i|
      book = Book.new
      book.id = i
      book.title = "Title #{i}"
      book.author = "Author #{i}" #should be another class
      book.publication_year = 2000 + i
      book
    end
  end
end
