require 'ostruct'

class UserAdministrationUseCase
  extend UseCase

  def initialize(user)
    @user = user
  end

  query :users
end

