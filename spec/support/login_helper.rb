module LoginHelper
  def sign_in p
    visit @root
    click_link('Sign in')
    find(p.domain).send_keys('ultimateweather')
    click_button('submit_team_domain')
    sleep_short
    find(p.email).send_keys("m2@snap2web.com")
    find(p.pw).send_keys("utahutah")
    find(p.sign_in).click
  end
end
