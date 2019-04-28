describe 'Thread Posting', :type => :feature do

  p = PageObject.new('spec/support/locators.yml')
  random_text_message = SecureRandom.base64
  random_text_thread = SecureRandom.base64
  new_random_text = SecureRandom.base64

  before do
    sign_in p
    click_channel('test')
  end

  after do
    delete_thread p
    delete_post p, random_text_message
  end

  it "lets you post a thread to a message in general", :happy do
    find(p.message_post).send_keys random_text_message
    find(p.message_post).send_keys :enter
    find(p.last_message).click
    find(p.start_thread).click
    find(p.thread_new).send_keys(random_text_thread)
    find(p.thread_new).send_keys :enter
    sleep_short
    expect(find_all(p.thread)[-1].text.match (random_text_thread)).to be
    sleep_short
  end

	def delete_thread p
    begin
		  first(p.thread_textbox).hover
		  all(p.thread_menu).last.hover
		  all(p.thread_optional_menu).last.click
		  click_on('Delete message')
		  click_on('Delete')
    rescue Capybara::ExpectationNotMet => e
      p 'Unable to delete thread'
    end
	end

  def delete_post p, random_text_message
    begin
      sleep_short
      find(p.message, text: random_text_message).click
      find(p.message_more_actions).click
      sleep_short
      find(p.delete_message).click
      find(p.delete_message_confirm).click
    rescue Capybara::ExpectationNotMet => e
      p 'Unable to delete message'
    end
  end

end
