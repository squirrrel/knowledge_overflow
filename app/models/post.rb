class Post < ActiveRecord::Base
  belongs_to :postable, polymorphic: true

  validates :body, presence: :true, allow_blank: false
end
