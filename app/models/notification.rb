class Notification < ApplicationRecord
  defalt_scope -> { order(create_at: :desc) }
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  
  belongs_to :visitor, class_name: 'EndUser', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'EndUser', foreign_key: 'visited_id', optional: true
end
