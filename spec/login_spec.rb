describe 'Logins work as expected', :type => :feature do

  p = PageObject.new('spec/support/locators.yml')

  def sleep_short
    sleep 1
  end

  before :each do
    visit @root
  end

  it 'Show a login link', :smoke do
    expect(page).to have_link('Sign in')
  end

  before :each do
    click_link('Sign in')
  end

  it 'Allows user to login', :happy do
    find(p.domain).send_keys('ultimateweather')
    click_button('submit_team_domain')
    sleep_short
    find(p.email).send_keys("m2@snap2web.com")
    find(p.pw).send_keys("utahutah")
    find(p.sign_in).click
    expect(page).to have_content('Direct Messages')
  end

  it 'Prevents user from logging in if domain is not known', :sad do
    find(p.domain).send_keys('notvalidultimateweather')
    click_button('submit_team_domain')
    expect(page).to have_content "We couldn’t find your workspace"
  end

  it 'Prevents user from logging in if username is not known', :sad do
    find(p.domain).send_keys('ultimateweather')
    click_button('submit_team_domain')
    sleep_short
    find(p.email).send_keys("not-known@not-known.com")
    find(p.pw).send_keys("aaaaaaaa")
    find(p.sign_in).click
    expect(page).to have_content "you entered an incorrect email address or password"
  end

  it 'Prevents user from logging in if password is invalid', :sad do
    find(p.domain).send_keys('ultimateweather')
    click_button('submit_team_domain')
    sleep_short
    find(p.email).send_keys("m2@snap2web.com")
    find(p.pw).send_keys("aaaaaaaa")
    find(p.sign_in).click
    expect(page).to have_content "you entered an incorrect email address or password"
  end

end
