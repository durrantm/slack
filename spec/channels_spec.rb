describe 'Channel Management', :type => :feature do

  p = PageObject.new('spec/support/locators.yml')
  channel_name = SecureRandom.base64.gsub(/\W+/, '')[0..8].downcase

  before :each do
    sign_in p
  end

  it "has a Channels section", :smoke do
    expect(page).to have_content "Channels"
  end

  describe "new channel", :smoke do

    after(:each) do
      delete_channel p
    end

    it "can be added", :happy do
      find(p.add_channel).click
      fill_in p.channel_title, with: channel_name
      find(p.channel_purpose).send_keys 'delete_me'
      click_on p.save_channel
      sleep_short
      expect(page).to have_link(channel_name)
    end

  end

  def delete_channel p
    begin
      sleep_short
      find(p.channel_actions).click
      find(p.additional_options).click
      sleep_short
      find(p.delete_channel).click
      check p.delete_channel_checkbox
      find(p.delete_action).click
      rescue Capybara::ElementNotFound => e
        p 'Unable to delete channel in cleanup after example'
    end
  end
end
