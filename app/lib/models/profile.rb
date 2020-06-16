module Models
  class Profile < ApplicationRecord
    belongs_to :user
  end
end