module IdFriendable
  extend ActiveSupport::Concern

  included do
    def cid
      "#{self.class.table_name}-#{self.id}"
    end
  end
end
