class UserAuthenticationUseCase
  extend UseCase

  def initialize(*args)
  end

  command :authenticate
  command :close_session

  query :session
end
