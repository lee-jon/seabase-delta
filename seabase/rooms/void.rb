room(:void) do
  self.desc = "You are in the void - how did you get here?"
  self.short_desc = "The Void"
  item(:mover, 'mover', 'metallic') do
    self.presence = "The mover is here."
  end

  item(:tube_car, 'car') do
    self.presence = "Travel-Tube car"
    self.script_enter = <<-SCRIPT
      get_root.move(:player, :carriage)
      return false
    SCRIPT
  end
  
  scenery(:pockets, 'pocket') do
    self.script_examine = <<-SCRIPT
      if self.children.nil?
        return false
      else
        puts "You look through the pockets and see a card!"
        self.open = true
        get_root.find(:dead_body).presence =
          "Dead body - with pockets hanging out"
        get_root.move(:plastic_card, parent)
        return false
      end
    SCRIPT
    item(:plastic_card, 'card', 'plastic') do
      self.usage = 6
      self.desc = <<-DESC
        TRAVEL PERMIT issues to and for use of secret agent -
        SIGNED -"MAJOR I.RON.FOIL"
      DESC
      self.short_desc = "Plastic card"
      self.presence = "Plastic card"
      
      self.script_use = <<-SCRIPT
        self.usage -= 1
        if args[0].nil?
          puts "Insert it where?"
          return false
        elsif args[0].tag != :smallslot
          puts "You can't put that there."

          return false
        elsif get_room.open
          puts get_room.short_desc
          return false
        else
          puts "SHHHHH...sliding doors close."
          puts "The car hurtles along the tunnel at high speed"
          puts " and then jolts to a halt"
          puts "POING! Card pops out."

          dest = get_root.find(:tube_car).get_room.destination
          get_root.move(:tube_car, dest, false)

          return false
        end
      SCRIPT
    end
  end
end