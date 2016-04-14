module CalculateVotes
  extend ActiveSupport::Concern

  included do
  end

  private
  def calculate_votes
    flag = @vote.try(:flag)

    params[:increase] ? increase() : (params[:decrease] ? decrease() : @entity_current_votes)
  end

  def increase
    @vote.update_attribute :flag, 'increased'
    @entity_current_votes + 1
  end

  def decrease
    @vote.update_attribute :flag, 'decreased'
    @entity_current_votes - 1
  end
end
