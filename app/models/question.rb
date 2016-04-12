class Question < ActiveRecord::Base
  include IdFriendable
  include Votable

  belongs_to :user
  has_many :answers
  has_one :post, as: :postable, required: true

  accepts_nested_attributes_for :post
end
