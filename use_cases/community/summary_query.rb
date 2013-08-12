query do |params|
  CommunityRepository.find(params[:id])
end
