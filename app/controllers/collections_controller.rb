class CollectionsController < ApplicationController
  # GET /cards or /cards.json
  def index
    @collections = collection_query(params)
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

    redirect_to collections_path, notice: "Collection import started. Cards will appear shortly."
  end

  def destroy
    Current.user.collections.delete_all
    redirect_to collections_path, notice: "Collection deleted successfully."
  end

  def load_more
    offset = params[:offset].to_i
    @collections = collection_query(params).offset(offset)

    render partial: "collections/collection", collection: @collections, formats: :html
  end

  private
  def collection_query(params)
    collections = Collection
            .where(user_id: Current.user.id)
            .includes(card: [ :language, :currency, :mtg_set ])
            .order("cards.created_at DESC")
            .limit(Collection.per_page)
    if params[:q].present?
      collections = collections.where("cards.name ILIKE ?", "%#{params[:q]}%")
    end

    collections
  end
end
