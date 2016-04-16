module IdFriendable
  extend ActiveSupport::Concern

  included do
    def cid
      "#{namespace}-#{id}"
    end

    def namespace
      self.class.name.downcase!
    end
  end
end
