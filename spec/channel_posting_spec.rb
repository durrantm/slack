describe 'Channel Posting', :type => :feature do

  p = PageObject.new('spec/support/locators.yml')
  random_text = SecureRandom.base64
  new_random_text = SecureRandom.base64

  before :each do
    sign_in p
    click_link('general')
  end

  after :each do
    delete_post p, random_text
  end

  it "lets you post in general", :happy do
    find(p.message_post).send_keys 'test_message_' + random_text
    find(p.message_post).send_keys :enter
    expect(page).to have_content 'test_message_' + random_text
  end

  it "lets you edit a post in general", :happy do
    find(p.message_post).send_keys random_text
    find(p.message_post).send_keys :enter
    expect(page).to have_content random_text
    find(p.message_post).send_keys :arrow_up
    sleep_short
    find(p.message_save_edit).send_keys new_random_text
    find(p.message_save_edit).send_keys :enter
    expect(find(p.main_container)).to have_content new_random_text
  end

  def delete_post p, random_text
    click_link('general')
    find(p.last_message).click
    find(p.message_more_actions).click
    find(p.delete_message).click
    find(p.delete_message_confirm).click
    expect(page).to_not have_content(random_text)
  end

end
