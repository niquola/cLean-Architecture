require 'ostruct'

query do |params|
  Post.find(params[:post_id])
end
