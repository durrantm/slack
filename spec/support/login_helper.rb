module LoginHelper

  def sign_in p
    visit @login
    find(p.domain).send_keys('ultimateweather')
    click_button('submit_team_domain')
    sleep_short
    find(p.email).send_keys("m2@snap2web.com")
    find(p.pw).send_keys("utahutah")
    find(p.sign_in).click
    acknowledge_desktop_notifications p
  end

  def acknowledge_desktop_notifications p
    sleep_medium
    if all(p.dismiss_banner).count > 0
      find(p.dismiss_banner).click
    end
  end

end
