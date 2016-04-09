module Calculate_Votes
  extend ActiveSupport::Concern

  included do
  end

  private
  def calculate_votes entity
    current_votes = entity.votes_number

    # params[:increase] ? (current_votes + 1) : (params[:decrease] ? (current_votes - 1) : (raise 'parameter missing'))
    if params[:increase]
      current_votes + 1
    elsif params[:decrease]
      current_votes - 1
    else
      raise 'parameter missing'
    end
  end
end
