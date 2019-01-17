require_relative '../lib/cityhall_scrap'

describe 'crypto_scrapper' do
  it 'is not nil' do
    expect(get_townhall_email(get_townhall_urls)).not_to be_nil
  end

  it 'is not empty' do
    expect(get_townhall_email(get_townhall_urls)).not_to be_empty 
  end
end