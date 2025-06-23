class CollectionsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "collections_#{current_user.id}"
  end
end
