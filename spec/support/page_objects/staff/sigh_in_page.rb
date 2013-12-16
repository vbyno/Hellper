class Staff::SignInPage < BasicPage
  def initialize
    @content = 'Log in'
    super(new_user_session_path)
  end

  def log_in(user)
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Log In'
    self
  end

  def log_out!
    click_on 'Log out'
    self
  end
end
