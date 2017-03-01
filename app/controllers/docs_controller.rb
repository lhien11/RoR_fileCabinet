class DocsController < ApplicationController

  # - DRY, finds the doc necessary for these actions so that we do not repeat ourselves
  before_action :find_doc, only: [:show, :edit, :update, :destroy]

  def index
    @docs = Doc.where(user_id: current_user).order("created_at DESC")
  end

  def show
  end

  def new
    @doc = current_user.docs.build
  end

  def create
    @doc = current_user.docs.build(doc_params)

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
