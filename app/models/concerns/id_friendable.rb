module IdFriendable
  extend ActiveSupport::Concern

  included do
    def cid
      "#{namespace}-#{id}"
    end
  end

  def namespace
    self.class.name.downcase!
  end
end
