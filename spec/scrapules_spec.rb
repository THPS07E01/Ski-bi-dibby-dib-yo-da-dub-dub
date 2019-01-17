require_relative '../lib/scrapules'

describe 'get_scrapules_urls' do

  it 'is not nil' do
    expect(get_scrapules_urls).not_to be_nil
  end

  it 'has a certain amount of element in it' do
    expect get_scrapules_urls.length > 20
  end

end

describe 'get_townhall_email' do

  it 'is an array' do
    expect get_townhall_email(get_scrapules_infos(get_scrapules_urls)).class == Array
  end

  it 'count if there is several scrapules' do
  	expect get_townhall_email(get_scrapules_infos(get_scrapules_urls)).length > 20
  end

  it 'has the created keys' do
    expect(get_townhall_email(get_scrapules_infos(get_scrapules_urls))).to include {Prenom}
    expect(get_townhall_email(get_scrapules_infos(get_scrapules_urls))).to include {Nom}
    expect(get_townhall_email(get_scrapules_infos(get_scrapules_urls))).to include {Mail}
  end

  it 'verify the first name of a scrapule' do
    expect get_townhall_email(get_scrapules_infos(get_scrapules_urls))[0][0]['Prenom'] == "Damien"
  end

  it 'verify if value is String' do
  	expect get_townhall_email(get_scrapules_infos(get_scrapules_urls))[0][0]['Prenom'].class == String
  end

end