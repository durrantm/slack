describe 'Channel Posting', :type => :feature do

  p = PageObject.new('spec/support/locators.yml')
  now = Time.now.to_s

  before :each do
    sign_in p
  end

  it "lets you post in general", :happy do
    click_link('general')
    find(p.message_post).send_keys 'test_message' + now
    find(p.message_post).send_keys :enter
    expect(page).to have_content 'test_message' + now
  end

end
