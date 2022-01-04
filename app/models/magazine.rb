class Magazine < ApplicationRecord
    belongs_to :publisher, :class_name => 'Publisher', :foreign_key => 'publisher_id'
    has_many :articles, dependent: :destroy
end
