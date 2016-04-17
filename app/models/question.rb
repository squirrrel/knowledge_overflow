class Question < ActiveRecord::Base
  include IdFriendable
  include PostAccessable

  belongs_to :user
  has_many :answers
  has_one :post, as: :postable, required: true

  acts_as_taggable_on :tags

  accepts_nested_attributes_for :post

  validates :header, presence: :true
end
