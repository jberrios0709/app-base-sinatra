module Models
  class Role < ApplicationRecord
    has_many :users
  end
end