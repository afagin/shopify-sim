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
end