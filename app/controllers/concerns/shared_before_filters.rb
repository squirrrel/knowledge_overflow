module SharedBeforeFilters
  extend ActiveSupport::Concern

  included do
    before_action :set_entity, only: [:show, :edit, :update, :destroy, :vote]
    before_action :set_vote, only: [:vote]
    before_action :set_current_votes_number, only: [:vote]
  end
end
