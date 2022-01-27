class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :authenticate_user! , except: [:index , :show]  #before yousignin you cant do any action eccept show and index
  before_action :corerct_user , only: [:edit , :update , :destroy]

  # GET /books or /books.json
  def index
    @books = Book.all
    @library = Library.all
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    # @book = Book.new
    @book = current_user.books.build

    all_lib_name = []
    for lib_name in Library.all do
        all_lib_name = all_lib_name.push(lib_name.library_name)
    end
    @library = all_lib_name
  end

  # GET /books/1/edit
  def edit
    all_lib_name = []
    for lib_name in Library.all do
        all_lib_name = all_lib_name.push(lib_name.library_name)
    end
    @library = all_lib_name
  end

  # POST /books or /books.json
  def create
    # @book = Book.new(book_params)

    @book = current_user.books.build(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
    @library = Library.all
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end

    @library = Library.all
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def corerct_user
      @book = current_user.books.find_by(id: params[:id])
      redirect_to books_path, notice: "Not autorized edit this book" if @book.nil?
    end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:book_name, :author_name, :library_id, :user_id , :library_name , :language)
    end
end
