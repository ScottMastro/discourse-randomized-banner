# frozen_string_literal: true

class CollectionView::CollectionController < ::ApplicationController

  def index


    topic = Topic.find_by(id: params[:id])

    STDERR.puts '------------------------------------------------------------'
    STDERR.puts '------------------------------------------------------------'
    STDERR.puts topic.posts
    STDERR.puts '------------------------------------------------------------'

    if topic.nil? | ! guardian.can_see_topic?(topic)
      raise Discourse::NotFound
      render json: { topic: nil }
      return
    end
    
    user = topic.user
    posts = Post.where(topic_id: params[:id]).order(:id)

    if ! user.nil?
      avatar_template = user.avatar_template    
    end

    STDERR.puts '------------------------------------------------------------'

    posts = posts.select{ |post| post.user_id == user.id }

    STDERR.puts '------------------------------------------------------------'

    collection_posts = posts.map { |post|
      collection_post={}
  
      collection_post[:date] = post[:created_at]
      collection_post[:id] = post[:id]

      html = Nokogiri::HTML.fragment(post[:cooked])
      collection_post[:imgs] = html.css('img').map { |l| p l.attr('src') }

      html = Nokogiri::HTML.fragment(post[:cooked])
      html.search('img').remove
      collection_post[:cooked] = html
      
      collection_post
    }

    render json: {avatar_template: avatar_template, user: user, topic: topic, 
                  posts: posts, collection_posts: collection_posts }
  end
end
