command do |params|
  Post.find(params[:post_id]).status = 'published'
end
