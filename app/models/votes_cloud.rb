class VotesCloud
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :user_id, type: String
  field :flag,    type: String
end
