class Publisher < ApplicationRecord
    has_many :magazines, dependent: :destroy
end
