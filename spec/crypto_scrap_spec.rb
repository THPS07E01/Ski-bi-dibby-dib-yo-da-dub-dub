require_relative '../lib/crypto_scrap'

describe 'crypto_scrapper' do
  it 'is not nil' do
    expect(crypto_scrapper).not_to be_nil
  end

  it 'is an array' do
    expect crypto_scrapper.class == Array
  end

  it 'count if there is several currencies' do
  	expect crypto_scrapper.length > 1000
  end

  it 'has well known currencies contained into hash' do
    expect(crypto_scrapper).to include {BTC}
    expect(crypto_scrapper).to include {ETH}
    expect(crypto_scrapper).to include {DASH}
    expect(crypto_scrapper).to include {XMR}
  end

  it 'verify if value is over a certain amount' do
    expect crypto_scrapper[0]['BTC'] > 1000
  end

  it 'verify if value is Float' do
  	expect crypto_scrapper[0]['BTC'].class == Float
  end

end


    