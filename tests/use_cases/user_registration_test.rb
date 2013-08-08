require_relative "../test_helper"

describe UserRegistrationUseCase do

  def registration
    @registration ||= UserRegistrationUseCase.new
  end

  def user_administration
    @user_administration ||= UserAdministrationUseCase.new('admin')
  end

  it "must respond positively" do
    result = registration.register(login:'oleg@com.com',
                      password: 'pass1',
                      password_confirmation: 'pass1')

    assert { result.ok? == true }

    users = user_administration.users(filter: :awaiting_confirmation)
    oleg = users.find{|u| u.login == 'oleg@com.com' }

    assert { oleg != nil }

    confirmaton = registration.confirmaton_for('oleg@com.com')

    registration.confirm(key: confirmaton.key)

    oleg = user_administration.users(filter: :active).find{|u| u.login == 'oleg@com.com'}
    assert { oleg != nil }
  end
end
