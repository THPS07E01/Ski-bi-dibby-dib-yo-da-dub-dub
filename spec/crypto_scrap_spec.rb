require_relative '../lib/crypto_scrap'

describe 'crypto_scrapper' do
  it 'is not nil' do
    expect(crypto_scrapper).not_to be_nil
  end

  it 'is not empty' do
    expect(crypto_scrapper).not_to be_empty 
  end
end