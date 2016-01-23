require_relative './helper'

describe 'server' do
  it 'gets the index' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to have_tag('title') do
      with_text /Page title from index\.yaml/
    end
    expect(last_response.body).to have_tag('meta[itemprop=url]', with: {content: "http://example.com/products/helloworld"})
    expect(last_response.body).to have_tag('p[role=contentinfo]') do
      with_text /Copyright © \d+ MyStore\./
    end
  end

  it 'gets /shopify_common.js' do
    get '/shopify_common.js'
    expect(last_response).to be_ok
    expect(last_response.content_type).to eq "application/javascript;charset=utf-8"
    expect(last_response.body).to eq File.read("./skeleton-theme/assets/shopify_common.js")
  end

  it 'gets /arrow-down.svg' do
    get '/arrow-down.svg'
    expect(last_response).to be_ok
    expect(last_response.content_type).to eq "image/svg+xml"
    expect(last_response.body).to have_tag('svg', with: {width: '15px', height: '15px'}) do
      with_tag('path', with: {fill: 'black'})
    end
  end
end