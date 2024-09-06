class Customer < User
  has_many :reservations, foreign_key: :user_id
end
