room(:food_store) do
  self.short_desc = "food_store"
  self.desc = <<-DESC
    The seems to be some sort of FOOD-STORE. The way out is NORTH.
  DESC
  
  self.exit_north = :fcorridor3
  
  item(:wicker_cage, 'cage') do
    self.presence = "Wicker Cage"
    self.fixed = true
    
    #TODO the delow doesn't work??? Even if there's no child
    self.script_examine = <<-SCRIPT
      if self.children.nil?
        return false
      else
        puts "I see something"
        self.open = true
        get_root.move(:hen, parent)
        return false
      end
    SCRIPT
    
    self.script_take = <<-SCRIPT
      puts "Thanks-but NO THANKS!"
      return false
    SCRIPT
    
    item(:hen, 'hen') do
      self.presence = "Hen"
      self.desc = "It is asleep"
      self.fixed = true
      
      item(:egg, 'egg') do
      end
    end
  end
end