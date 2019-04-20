describe 'Channels', :type => :feature do

  p = PageObject.new('spec/support/locators.yml')

  before :each do
    sign_in p
  end

  it "has a Channels section", :smoke do
    expect(page).to have_content "Channels"
  end

  it "has lets me add a channel", :happy do
    find("button[data-qa=channel_sidebar__plus__channels]").click
    sleep 1
    find "input#channel_create_title"
    fill_in "channel_create_title", with: 'delete_me'
    find("div[aria-label='Channel purpose']").send_keys 'delete_me'
    sleep 10
  end

end
