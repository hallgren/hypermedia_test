require 'cuba'
require 'uuid'

damage_hash = {}

Cuba.define do
  on get do
    on "new_damage" do
      res.write "<form action='/create_damage' method='post'>"
      res.write "Skadenummer <input type='text' name='damage_id'>"
      res.write "Skadedatum <input type='text' name='damage_date'>"
      res.write "<input type='submit' value='Submit'>"
      res.write "</form>"
    end

    on "damage/:guid" do |guid|  
    	res.write damage_hash[guid]
    end

    on root do
      res.redirect "/new_damage"
    end


  end

  on post do
  	on "create_damage" do
	
	  on param("damage_id"), param("damage_date") do |damage_id, damage_date|
	    guid = UUID.new.generate
	    damage_hash[guid] = {:guid => guid, :damage_id => damage_id, :damage_date => damage_date}
	    res.write "Skada skapad med uuid #{guid}, skadeid = #{damage_id}, skadedatum = #{damage_date}"
        res.write "<a href='/damage/#{guid}'>skadan</a>"
      end
    end
  end

end
