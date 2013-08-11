command do |post_attributes|
  attrs = post_attributes
  .merge(author: context[:user_identity], status: 'draft')

  Post.create(attrs).id
end
