require_relative './helper'

describe ShopifyFilter do
  include ShopifyFilter

  it "renders images" do
    expect(img_url(nil, "pico")).to eq("http://placehold.it/16x16")
    expect(img_url(nil, "compact")).to eq("http://placehold.it/160x160")
    expect(img_url(nil, "asdf")).to eq("http://placehold.it/300x300?text=invalid+size")
  end
end