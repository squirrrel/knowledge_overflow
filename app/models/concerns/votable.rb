module Votable
  extend ActiveSupport::Concern

  included do
    def votes_number
      post.votes
    end
  end
end
