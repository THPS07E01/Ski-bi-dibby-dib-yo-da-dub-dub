require_relative '../lib/cityhall_scrap'

describe 'get_townhall_urls' do

  it 'is not nil' do
    expect(get_townhall_urls).not_to be_nil
  end

  it 'has a certain amount of element in it' do
    expect get_townhall_urls.length > 20
  end

end

describe 'get_townhall_email' do

  it 'is an array' do
    expect get_townhall_email(get_townhall_urls).class == Array
  end

  it 'count if there is several cities' do
  	expect get_townhall_email(get_townhall_urls).length > 20
  end

  it 'has some cities' do
    expect(get_townhall_email(get_townhall_urls)).to include {BOUQUEVAL}
    expect(get_townhall_email(get_townhall_urls)).to include {GROSLAY}
    expect(get_townhall_email(get_townhall_urls)).to include {PISCOP}
    expect(get_townhall_email(get_townhall_urls)).to include {CHARS}
  end

  it 'the e-mails of some cities' do
    expect get_townhall_email(get_townhall_urls)[0]['BOUQUEVAL'] == "mairiebouqueval@wanadoo.fr"
  end

  it 'verify if value is String' do
  	expect get_townhall_email(get_townhall_urls)[0]['BOUQUEVAL'].class == String
  end

end