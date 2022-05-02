class Reminder < ActiveRecord::Base
    belongs_to :subscription

    #end date and reminder type fields must exist
    validates :end_date, presence: true
    validates :reminder_type, presence: true

    #searches through users to return the owner of the subscription reminder
    scope :belonging_to_user, -> (user) {
        where(subscription_id: user.subscriptions.includes(:subscription_id))
    }

end