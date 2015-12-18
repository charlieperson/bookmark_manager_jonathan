feature 'signup' do
  scenario 'ensure that user count goes up upon sign up' do
    visit ('/signup')
    fill_in 'email', with: 'charlieperson@gmail.com'
    fill_in 'password', with: '2001'
    click_button('Sign up')
    user = User.first
    expect(user.id).to eq(1)
    end
  end
