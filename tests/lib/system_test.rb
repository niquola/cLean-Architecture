require_relative '../test_helper'

describe 'System' do
  def system
    @system ||= System
    .new("#{File.dirname(__FILE__)}/use_cases")
  end

  class Post < OpenStruct
    def self.next_identity
      @id = (@id || 0).succ
    end

    def self.create(attrs)
      self.new(attrs.merge(id: next_identity)).tap do |obj|
	@posts<< obj
      end
    end

    def self.all
      @posts ||= []
    end

    def self.find(id)
      all.find{|i| i.id == id }
    end
  end

  it "" do
    blog = system
    .use_case(:blog, user_identity: 'niquola')


    posts = blog.q(:list_posts,
		   filter: 'draft',
		   order: 'by_date',
		   limit: 10)

    assert { posts == [] }

    post_id = blog.c(:create_post,
		     title: 'cLean Architecture',
		     abstract: 'Article about cLean architecture')

    post = blog.q(:post,
		  post_id: post_id)

    assert {
      ! blog.q(:list_posts,
	     filter: 'published',
	     order: 'by_date',
	     limit: 10).include?(post)
    }

    assert { post.author == 'niquola' }
    assert { post.title == 'cLean Architecture' }
    assert { post.status == 'draft' }

    assert {
      blog.q(:list_posts,
	     filter: 'draft',
	     order: 'by_date',
	     limit: 10).include?(post)
    }

    blog.c(:publish_post,
	   post_id: post_id)

    assert {
      blog.q(:post, post_id: post_id).status == 'published'
    }

    assert {
      ! blog.q(:list_posts,
	     filter: 'draft',
	     order: 'by_date',
	     limit: 10).include?(post)
    }
  end
end
