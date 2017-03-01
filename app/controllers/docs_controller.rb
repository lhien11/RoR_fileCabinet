class DocsController < ApplicationController
  before_action :find_doc, only: [:show, :edit, :update, :destroy]

  def index
    @docs = Doc.all.order("created_at DESC")
  end

  def show
  end

  def new
    @doc = Doc.new
  end

  def create
    @doc = Doc.new(doc_params)

    # @doc = current_user.docs.build(doc_params)
    #
    if @doc.save
      redirect_to @doc
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    # - Checks if the document has been updated
    if @doc.update(doc_params)
      redirect_to @doc
    else
      # - If not, then render the edit page instead of redirect
      render 'edit'
    end
  end

  def destroy
    @doc.destroy
    redirect_to docs_path
  end

  private

    # - Doc Params and Find Doc so we are in compliance with DRY

    def find_doc
      @doc = Doc.find(params[:id])
    end

    def doc_params
      params.require(:doc).permit(:title, :content)
    end

end
