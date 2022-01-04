class Article < ApplicationRecord
    belongs_to :magazine, :class_name => 'Magazine', :foreign_key => 'magazine_id'
    has_many :comments, dependent: :destroy
end
