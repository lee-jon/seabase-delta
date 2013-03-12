room(:deep_freeze) do
  self.short_desc = "deep_freeze"
  self.desc = <<-DESC
    This is the DDDEEP FFFREEEZE SECTION. The way out is EAST.
  DESC
  
  self.exit_east = :laundry
  
  item(:stick_of_gum, 'gum') do
    self.presence   = "Stick of Bubble Gum"
    self.desc       = "Its rock hard!"
    self.short_desc = "Gum"
    self.chewed     = false
    
    self.script_chew = <<-SCRIPT
      puts chewed ? "OK. Nothing happens." : "SLURP! Yum... Quite tasty!"
      self.short_desc = "Soft gooeey gum"
      self.desc = nil
      self.chewed = true

      return false
    SCRIPT
    
    scenery(:bubble, 'bubble') do
      # This is here to execute the blow bubble verb
      self.script_blow = <<-BLOW
        if self.parent.chewed
          puts "PUFF! BLOW! the Bubble is GROWING!"
          puts "AND GROWING!"
          puts "BANG!!! WOW! That could wake the dead!"

          if get_room.tag == :food_store
            if get_root.find(:hen).parent.tag == :food_store
              if get_root.find(:egg).parent.tag == :hen
                puts "<br>CLUCK! CLUCK! CLUCK!- HEN IS AROUSED!"
                puts "And Does her duty!"
                get_root.find(:hen).presence = "Brighted eyed hen"
                get_root.move(:egg, :food_store, false)
              end
            end
          end
        else
          puts "The gum is hard!" #TODO check this text in the original game
        end
      BLOW
    end
  end
end