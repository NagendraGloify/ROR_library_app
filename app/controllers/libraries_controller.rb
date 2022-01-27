class LibrariesController < ApplicationController
  before_action :set_library, only: %i[ show edit update destroy ]
  before_action :authenticate_user! , except: [:index , :show]  #before yousignin you cant do any action eccept show and index
  before_action :corerct_user , only: [:edit , :update , :destroy]

  # GET /libraries or /libraries.json
  def index
    @libraries = Library.all
  end

  # GET /libraries/1 or /libraries/1.json
  def show

    all_book_name = []
    for book_name in Book.all do
       if book_name.library_name == @library.library_name

        all_book_name = all_book_name.push(book_name.book_name)

       end
    end

    @book = all_book_name 

    @book1 = Book.all 



  end

  # GET /libraries/new
  def new
    @library = Library.new
  end

  # GET /libraries/1/edit
  def edit
  end

  # POST /libraries or /libraries.json
  def create
    @library = Library.new(library_params)

    respond_to do |format|
      if @library.save(validate: false)
        format.html { redirect_to library_url(@library), notice: "Library was successfully created." }
        format.json { render :show, status: :created, location: @library }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /libraries/1 or /libraries/1.json
  def update
    respond_to do |format|
      if @library.update(library_params)
        format.html { redirect_to library_url(@library), notice: "Library was successfully updated." }
        format.json { render :show, status: :ok, location: @library }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1 or /libraries/1.json
  def destroy
    @library.destroy

    respond_to do |format|
      format.html { redirect_to libraries_url, notice: "Library was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def corerct_user
    @library = current_user.libraries.find_by(id: params[:id])
    redirect_to libraries_path, notice: "Not autorized edit this library" if @library.nil?
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def library_params
      params.require(:library).permit(:library_name, :opening_time, :closing_time, :user_id)
    end
end
