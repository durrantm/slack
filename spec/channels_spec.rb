describe 'Channel Management', :type => :feature do

  p = PageObject.new('spec/support/locators.yml')

  before :each do
    sign_in p
  end

  it "has a Channels section", :smoke do
    expect(page).to have_content "Channels"
  end

	describe "new channel" do

		after(:each) do
      delete_channel p
		end

		it "can be added", :happy do
			find(p.add_channel).click
			fill_in p.channel_title, with: 'delete_me'
			find(p.channel_purpose).send_keys 'delete_me'
			click_on p.save_channel
      sleep_short
			expect(page.text).to match(/You just created/)
		end

	end

  def delete_channel p
    find(p.channel_actions).click
    find(p.additional_options).click
    find(p.delete_channel).click
    check p.delete_channel_checkbox
    find(p.delete_action).click
  end

end
