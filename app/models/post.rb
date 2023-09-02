class Post < ApplicationRecord
    belongs_to :users

    validates :text, presence: true
end
