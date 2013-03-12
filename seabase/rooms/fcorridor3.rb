room(:fcorridor3) do
  self.desc = <<-DESC
    The corridor narrows here slightly at a junction between walkways.
    Exits are to the east, west & south. There's an awful smell of 
    rubbish coming from somewhere!
  DESC
  self.short_desc = "Corridor"
  
  self.exit_east  = :fcorridor2
  self.exit_west  = :fcorridor4
  self.exit_south = :food_store
  
  item(:switch, 'switch') do
    self.presence = "switch"
    self.desc = "Its marked LEFT and RIGHT"
    self.short_desc = "Switch"
  
    self.script_push = <<-SCRIPT
      puts  self.children
      puts "It's jammed on RIGHT. Maybe if I had some thing to SHORT the SWITCH"
    SCRIPT
    
    self.script_short = <<-SCRIPT
      if get_room.find(:fork)
        puts "CRACK!! ZAPP!!"
        get_root.move(:fork, :void)
        get_root.move(:melted_metal, :fcorridor3)
        
        target = get_room.find(:conveyor_belt)
        target.presence = "Conveyor belt (moving LEFT)"
        target.going_right = false
      end
    SCRIPT
  end
  
  scenery(:conveyor_belt, 'conveyor') do
    self.presence = "Conveyor belt (moving RIGHT)"
    self.desc = "It's quite big...maybe I should CLIMB on to it..."
    self.going_right = true
    
    self.script_climb = <<-SCRIPT
      if self.going_right == true
        puts "WHOOPS..It's going the wrong way."
        puts "I am thrown off!"
      else
        puts "I am sitting on a sloping metal belt"
        puts "OUCH! I've landed somewhere!"
        get_root.move(:player, :refuse_compartment, false)
      end
    SCRIPT
  end
end