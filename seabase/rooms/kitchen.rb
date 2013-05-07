room(:kitchen) do
  self.desc = <<-DESC
    I am in a well used KITCHEN. Exit is WEST.
  DESC
  
  self.exit_west = :dinning_room
  
  item(:shelves, 'shelves') do
    self.presence = "Shelves"
    self.examined = false
    self.script_examine = <<-SCRIPT
      if self.examined == false
        puts "I see something..."
        
        get_root.move(:flour, parent, false)
        self.examined = true
        
        return false
      else
        return true
      end
    SCRIPT
  end
  
  item(:hotplate, 'hotplate') do
    self.presence = "Hotplate"
    self.desc = "Its ON and HOT!"
  end
  
  item(:fridge, 'fridge') do
    self.presence = "Fridge"
    self.openable = true
    
    item(:milk, 'milk', 'carton') do
      self.presence = 'Carton of Milk'
    end
  end
end