class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true
    
    # 1 user = N articles
    has_many :articles
end
