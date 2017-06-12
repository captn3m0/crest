require "../spec_helper"

describe Crest do
  it "do GET request" do
    response = Crest.get("#{TEST_SERVER_URL}")
    (response.body).should eq("Hello World!")
  end

  it "do POST request" do
    response = Crest.post("#{TEST_SERVER_URL}/post/1/comments", payload: {:title => "Title"})
    (response.body).should eq("Post with title `Title` created")
  end

  it "upload file" do
    file = File.open("#{__DIR__}/../support/fff.png")
    response = Crest.post("#{TEST_SERVER_URL}/upload", payload: {:image1 => file})
    (response.body).should eq("Upload ok")
  end

  it "do POST nested params" do
    response = Crest.post("#{TEST_SERVER_URL}/post_nested", payload: {:params1 => "one", :nested => {:params2 => "two"}})
    (response.body).should eq("params1=one&nested%5Bparams2%5D=two")
  end

  describe "Resource" do
    it "do GET request" do
      resource = Crest::Resource.new("#{TEST_SERVER_URL}/post/1/comments", {"Content-Type" => "application/json"})
      response = resource.get()
      (response.body).should eq("Post 1: comments")
    end

    it "do POST request" do
      resource = Crest::Resource.new("#{TEST_SERVER_URL}/post/1/comments")
      response = resource.post({:title => "Title"})
      (response.body).should eq("Post with title `Title` created")
    end

    # TODO JSON
    # it "do POST JSON request" do
    #   params = {:title => "Title"}.to_json
    #   resource = Crest::Resource.new("#{TEST_SERVER_URL}/post/1/json", {"Content-Type" => "application/json"})
    #   response = resource.post(params)
    #   (response.body).should eq("Post with title `Title` created")
    # end

  end
end
