class Profile < ApplicationRecord
  # has_one :user  
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  # validates_uniqueness_of :user_id, message: "can not have more than one profile per user"

  # undefined method `country_select' for #<SimpleForm::FormBuilder:0x00007f8068dac2b8>
  def country_name
    country = self.country
    ISO3166::Country[country]
  end
end
