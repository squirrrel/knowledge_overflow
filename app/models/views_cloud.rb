class ViewsCloud
  include Mongoid::Document

  field :user_id, type: String
  field :question_id, type: String
end
