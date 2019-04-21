describe 'Direct messages with Slackbot work as expected', :type => :feature do

  p = PageObject.new('spec/support/locators.yml')

  before :each do
    sign_in p
  end

  it "has a Direct Messages section", :smoke do
    expect(find p.direct_messages).to be
  end

  it "has a Direct Messages section with Slackbot", :smoke do
    expect(find p.slackbot).to be
  end

  it "Clicking on Slackbot shows Slackbot as the channel in the channel header name", :happy do
    click_link('general')
    click_link('Slackbot')
    expect(find p.slackbot_channel).to have_content 'Slackbot'
  end

end
