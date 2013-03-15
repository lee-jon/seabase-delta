room(:kitchen) do
  self.short_desc = "kitchen"
  self.desc = <<-DESC
    I am in a well ised KITCHEN. Exit is WEST.
  DESC
  
  self.exit_west = :dinning_room
  
  item(:shelves, 'shelves') do
    self.presence = "Shelves"
    self.script_examine = <<-SCRIPT
      #examining shows bag of flour
    SCRIPT
  end
  item(:hotplate, 'hotplate') do
    self.presence = "Hotplate"
  end
  item(:fridge, 'fridge') do
    self.presence = "Fridge"
  end
end