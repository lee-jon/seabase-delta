room(:refuse_compartment) do
  self.desc = <<-DESC
    "I am in the smelly REFUSE COMPARTMENT."
  DESC

  # Exits - none

  item(:bowl, 'bowl', 'mixing') do
    self.presence   = "Old mixing bowl"
    self.short_desc = "Old mixing bowl"
  end

  item(:foil, 'foil')  do
    self.presence   = 'Crumpled up aluminium cooking foil'
    self.short_desc = "Foil"
    self.desc = "On reflection...It's..well..CRUMPLED!"
    self.smooth = false

    self.script_iron = <<-SCRIPT
      puts "You iron the foil"
      self.presence   = 'Smooth sheet of Aluminium cooking foil'
      self.desc = "Smooth sheet of Aluminium cooking foil."
      self.short_desc = "Smooth sheet of Aluminium cooking foil."
      self.smooth = true
    SCRIPT
  end

  scenery(:chute, 'chute') do
    self.presence = "Large metal chute (Sloping down)"

    self.script_enter = <<-SCRIPT
      puts "Wheeeeee!!!"
      puts "OUCH! I've landed somewhere!"
      get_root.move(:player, :corridor4, false)
      return false
    SCRIPT
  end

  scenery(:conveyor_belt2, 'conveyor') do
    self.presence = "Conveyor belt"
  end
end
