module PostAccessable
  extend ActiveSupport::Concern

  included do
    def votes
      post.votes
    end

    def body
      post.body
    end
  end
end
