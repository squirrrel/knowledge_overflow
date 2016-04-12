module Calculate_Votes
  extend ActiveSupport::Concern

  included do
  end

  private
  def calculate_votes entity
    current_votes = entity.votes_number

    record = VotesCloud.find_or_create_by(user_id: 1, "#{entity.namespace}_id": entity.id)

    flag = record.try(:flag)

    if params[:increase] && (!flag || flag == 'decreased')
      increase(record, current_votes)
    elsif params[:decrease] && (!flag || flag == 'increased')
      decrease(record, current_votes)
    else
      current_votes
    end
  end

  def increase record, current_votes
    record.update_attribute(:flag, 'increased')
    current_votes + 1
  end

  def decrease record, current_votes
    record.update_attribute(:flag, 'decreased')
    current_votes - 1
  end
end
