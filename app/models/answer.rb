class Answer < ActiveRecord::Base
  include IdFriendable
  include Votable

  belongs_to :user
  belongs_to :question, required: true
  has_one :post, as: :postable, required: true
end
