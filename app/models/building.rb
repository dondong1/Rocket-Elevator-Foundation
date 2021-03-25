class Building < ApplicationRecord
   has_many :building_details 
   belongs_to :customer
   belongs_to :address
   has_many :batteries
   has_many :interventions

   def loc_building
    "#{address.address} - #{address.city}"
   end
end
