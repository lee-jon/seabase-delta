room(:at_long_table) do
  self.exit_west = :food_farm
  self.short_desc ="Long Table"
  self.script_enter = <<-SCRIPT
      puts "WHEEEEEE!!!"
      puts "You slide majestically across the room on the seaweed."
      puts "Feet won't grip!"
      puts ""
      puts "What's that on the TABLE?"
      puts "You slide past the table back to the entrance of the room.."
      puts ""

      return false
  SCRIPT
end