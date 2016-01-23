require_relative './helper'

describe 'server' do
  it 'gets the index' do
    get '/'
    expect(last_response).to be_ok
  end
end