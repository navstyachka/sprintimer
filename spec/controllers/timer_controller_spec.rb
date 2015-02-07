require 'spec_helper'

describe TimerController do
  render_views

  context "Create timer" do

    it "If not pass data when response unsuccessful" do
      post "create", format: :json
      response.should_not be_success
      Timer.all.size.should==0
    end

    it "Creates timer" do
      post "create", format: :json, data: "{1: 1000}"
      response.should be_success
      Timer.all.size.should==1
    end

  end
end