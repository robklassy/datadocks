class Server < User
  has_many :server_tables, foreign_key: :user_id
  has_many :tables, through: :server_tables
end
