room(:at_long_table) do
  self.exit_west = :food_farm
  self.short_desc ="Long Table"
  self.script_enter = <<-SCRIPT
    if get_root.find(:flippers).worn
      puts "FLIP! FLOP! FLIP! FLOP! - You waddle over to the table - find"
      puts "something - then waddle back...."

      get_root.move(:large_key, :food_farm)

      return false
    else
      puts "WHEEEEEE!!!"
      puts "You slide majestically across the room on the seaweed."
      puts "Feet won't grip!"
      puts ""
      puts "What's that on the TABLE?"
      puts "You slide past the table back to the entrance of the room.."
      puts ""

      return false
    end
  SCRIPT

  item(:large_key, 'key') do
    self.presence = "Large key"
    self.short_desc = "Large key"
  end
end
