class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :answers
  has_many :questions
  # has_one :votes_cloud

  # after_create :set_votes_cloud, unless: :votes_cloud_present?

  # def get_vote_flag(entity: entity)
  #   votes_cloud.cloud[entity.table_name][entity.id.to_s]
  # end

  # private
  # def set_votes_cloud
  #   VotesCloud.create user_id: id
  # end

  # def votes_cloud_present?
  #   !votes_cloud.nil?
  # end
end
