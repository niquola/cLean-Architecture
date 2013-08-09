require_relative "../test_helper"

describe UserRegistrationUseCase do

  def registration
    @registration ||= UserRegistrationUseCase.new
  end

  def user_administration
    @user_administration ||= UserAdministrationUseCase.new('admin')
  end

  def auth
    @auth ||= UserAuthenticationUseCase.new('admin')
  end

  it "must respond positively" do
    registration
    .register(login:'oleg@com.com',
	      password: 'pass1',
	      password_confirmation: 'pass1')
    .tap do |result|
      assert { result.ok? == true }
    end

    user_administration
    .users(filter: :awaiting_confirmation)
    .find{|u| u.login == 'oleg@com.com' }
    .tap do |oleg|
      assert { oleg != nil }
    end

    confirmaton = registration
    .confirmaton_for('oleg@com.com')

    registration
    .confirm(key: confirmaton.key)


    auth
    .authenticate(login: 'oleg@com.com', password: 'pass1')
    .tap do |session_key|
      session =  auth.session(session_key)
      assert { session.identity != nil }
      auth.close_session(session_key)

      assert { auth.session(session_key) == nil }
    end


    user_administration
    .users(filter: :active)
    .find{|u| u.login == 'oleg@com.com'}
    .tap do |oleg|
      assert { oleg != nil }
    end
  end
end
