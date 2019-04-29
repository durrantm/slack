describe 'Direct messages with Slackbot work as expected', :type => :feature do

  p = PageObject.new('spec/support/locators.yml')
  random_text = SecureRandom.base64

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

  describe "can try to post messages" do

    after :each do
      delete_post(p, random_text)
    end

		it "Saying Hi to Slackbot shows up" do
			click_link('Slackbot')
			find(p.message_post).send_keys 'Hello ' + random_text
			find(p.message_post).send_keys :enter
			sleep_short
			expect(find(p.main_container)).to have_content 'Hello ' + random_text
		end

    def delete_post p, random_text
      find(p.slackbot).click
      find(p.last_message).click
      find(p.message_more_actions).click
      find(p.delete_message).click
      find(p.delete_message_confirm).click
      sleep_short
      find(p.last_message).click
      find(p.message_more_actions).click
      find(p.delete_message).click
      find(p.delete_message_confirm).click
      expect(page).to_not have_content(random_text)
    end

	end
end
