require 'cuba'
require 'uuid'

damage_hash = {}

Cuba.define do
  on get do

    on "damage/:guid" do |guid|  
      res.write damage_hash[guid]
      res.write "<a rel='create_damage' href='/damage'>Create new damage</a>"
      res.write "<a rel='self' href='/damage/#{guid}'>skadan</a>"
    end

    on "damage" do
      res.write "<form rel='create_damage' action='/damage' method='post'>"
      res.write "Skadenummer <input type='text' name='damage_id'>"
      res.write "Skadedatum <input type='text' name='damage_date'>"
      res.write "<input type='submit' value='Submit'>"
      res.write "</form>"
    end

    

    on root do
      res.redirect "/damage"
    end


  end

  on post do
  	on "damage" do
	
	    on param("damage_id"), param("damage_date") do |damage_id, damage_date|
	      guid = UUID.new.generate
	      damage_hash[guid] = {:guid => guid, :damage_id => damage_id, :damage_date => damage_date}
	      res.write "Skada skapad med uuid #{guid}, skadeid = #{damage_id}, skadedatum = #{damage_date}"
        res.write "<a rel='damage' href='/damage/#{guid}'>skadan</a>"
      end
    end
  end

end
