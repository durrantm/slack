describe 'Thread Posting', :type => :feature do

  p = PageObject.new('spec/support/locators.yml')
  random_text = SecureRandom.base64
  new_random_text = SecureRandom.base64

  before :each do
    sign_in p
    click_link('test')
  end

  after :each do
    delete_thread p
    delete_post p, random_text
  end

  it "lets you post a thread to a message in general", :happy do
    find(p.message_post).send_keys 'test_message_' + random_text
    find(p.message_post).send_keys :enter
    find(p.last_message).click
sleep 1
    find(p.start_thread).click
sleep 2
    first('div[data-qa=message_input')
sleep
#    find(p.thread_textbox).click
sleep 2
    find(p.thread_textbox).send_keys('test_message_' + random_text)
sleep 3
    find(p.thread_textbox).send_keys :enter
sleep 3
    expect(page).to have_content 'test_message_' + random_text
  end

	def delete_thread p
#		first('span[data-qa=text-atom]').hover
#		all('span[data-qa=text-atom]').last.hover
#		all('button[data-qa=more_message_actions]').last.click
		first(p.thread_textbox).hover
		all(p.thread_menu).last.hover
		all(p.thread_optional_menu).last.click
		click_on('Delete message')
		click_on('Delete')
	end

  def delete_post p, random_text
    sleep_short
    find(p.general_channel, text: 'test').click
    find(p.last_message).click
    find(p.message_more_actions).click
    sleep_short
    find(p.delete_message).click
    find(p.delete_message_confirm).click
  end

end
