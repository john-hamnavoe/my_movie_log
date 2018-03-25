class WatchLike < ApplicationRecord
  belongs_to :watch
  belongs_to :friend, class_name: 'User'
  
  validates :watch, uniqueness: { scope: :friend }
end
