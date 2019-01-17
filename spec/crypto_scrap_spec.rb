require_relative '../lib/crypto_scrap.rb'

describe 'crypto_scrapper' do
  it 'is not nil' do
    expect(crypto_scrapper).not_to be_nil
  end

  it "the type returned is an array" do
    expect(crypto_scrapper).to eq(Array)
  end

  it 'is not empty' do
    expect(crypto_scrapper).not_to be_empty 
  end
end