require 'delegate'

class Presenter < SimpleDelegator
  def members
    [OpenStruct.new(role: :owner, name: 'nicola')]
  end
end

query do |params|
  Presenter.new(CommunityRepository.find(params[:id]))
end
