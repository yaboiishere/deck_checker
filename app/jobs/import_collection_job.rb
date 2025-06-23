class ImportCollectionJob < ApplicationJob
  queue_as :default

  def perform(user_id, upload_path)
    # Assuming you have a method that takes a user and file
    result = Parsers::ManaboxCsv.csv_to_cards(user_id, upload_path)

    # You can track status via DB, Notification system, or broadcast
    if result == :success
      Rails.logger.info "Import success for user #{user_id}"
    else
      Rails.logger.error "Import failed, logging errors for user #{user_id}"
    end
    errors = ImportError.where(user_id: user_id, file_name: upload_path)
    if errors.any?
      Rails.logger.error "Import errors found for user #{user_id} in file #{upload_path}"
      ImportError.where(user_id: user_id, file_name: upload_path).each do |error|
        Rails.logger.error "Import error for user #{error.user_id}: #{error.error_message} in file #{error.file_name}"
      end
    end

    user = User.find(user_id)

    Turbo::StreamsChannel.broadcast_replace_to(:collections, target: "collections-list", partial: "collections/collection", collection: user.collections.reload)

    # ActionCable.server.broadcast(
    #   "collections_#{user_id}",
    #   Turbo::StreamsChannel.render_action(
    #     :replace,
    #     target: "collections-list",
    #     partial: "collections/collection",
    #     collection: user.collections.reload
    #   )
    # )
  ensure
    File.delete(upload_path) if File.exist?(upload_path)
  end
end
