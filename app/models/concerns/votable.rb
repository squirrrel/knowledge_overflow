module Votable
  extend ActiveSupport::Concern

  included do
    def votes_number
      self.post.votes
    end
  end
end
