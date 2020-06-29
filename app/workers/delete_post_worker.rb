
class DeletePostWorker
  include Sidekiq::Worker

  def perform(post_id, *args)
    @post = Post.find(post_id)
    @post.destroy
  end
end
