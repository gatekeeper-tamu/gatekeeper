class TempSharedSubscription < ApplicationRecord
    belongs_to :subscription
    validates :end_date, presence: true

    #set sharing duration
    before_validation on: [:create, :update] do
        self.end_date = (Date.today + 7.days) unless (self.end_date != nil)
    end
end
