room(:murky_depths) do
  self.short_desc = "Murky Depths"
  self.desc = <<-DESC
    I am swimming around in the MURKY DEPTHS of the OCEAN. Yellow streaks of
    blurry light from the base reach out for a few hundred yards into the lonely
    blackness. To the WEST the lightbeams seem to dance along the edge of some
    huge long object resting on the sea-bed.
  DESC

  self.exit_west = :deck_of_ship

  scenery(:open_sea_filled_hatch, 'hatch') do
    self.presence = "Open sea-filled hatch"

    self.script_enter = <<-SCRIPT
      get_root.move(:player, :airlock)

      return false
    SCRIPT
  end

  item(:mini_sub, 'sub') do
    self.presence = "Mini-sub"
    self.desc = "A minature submarine"
    self.fixed = true

    self.released = false

    self.script_enter = <<-SCRIPT
      get_root.move(:player, :submarine)
      return false
    SCRIPT
  end

  scenery(:octopus, 'octopus') do
    self.presence = "Giant Octopus"
    self.desc = "BIG but nothing to write home about...."
  end
end
