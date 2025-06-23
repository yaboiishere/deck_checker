class CollectionsController < ApplicationController
  # GET /cards or /cards.json
  def index
    # @collections = Card.includes([ :language, :currency, :mtg_set, :collections ])
    #   .where(collections: { user_id: Current.user.id }).order(:name)

    @collections = Collection.where(user_id: Current.user.id).includes(card: [ :language, :currency, :mtg_set ]).order("cards.name")


    if params[:q].present?
      @collections = @collections.where("cards.name ILIKE ?", "%#{params[:q]}%")
    end

    @collections = @collections.page(params[:page])
  end

  def show
    @card = Card.includes([ :language, :currency, :mtg_set, :collections ]).find(params.expect(:id))
  end

  def import
    file = params[:file]
    path = Rails.root.join("tmp", "uploads", "#{SecureRandom.uuid}_#{file.original_filename}")
    FileUtils.mkdir_p(File.dirname(path))
    File.open(path, "wb") { |f| f.write(file.read) }

    ImportCollectionJob.perform_later(Current.user.id, path.to_s)

    redirect_to cards_path, notice: "Collection import started. You will be notified when it is complete."
  end

  def destroy
    Current.user.collections.delete_all

       redirect_to collections_path, notice: "Collection deleted successfully."
  end
end
