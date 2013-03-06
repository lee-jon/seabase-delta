room(:corridor4) do
  self.short_desc = "Corridor."
  self.desc = <<-DESC
    East / West curving corridor. There is a
    dimly lit alcove to the south.
  DESC
  
  self.exit_west  = :corridor3
  self.exit_east  = :corridor1
  self.exit_south = :lift1
  
  scenery(:chute, 'chute') do
    fixed = true
    presence = "Large metal chute (sloping up)"
    
    self.desc = <<-DESC
      Nasty smell of rubbish
    DESC
    self.script_enter do
      puts "You slide back down. It's too steep."
      return false
    end
  end
end