require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index; render plain: "OK"; end
  end

  it "responds successfully" do
    get :index
    expect(response).to be_successful
  end
end
