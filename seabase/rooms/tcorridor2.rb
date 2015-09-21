room(:tcorridor2) do
  self.desc = <<-DESC
    I've reached the THIRD LEVEL in a TWISTING TUBULAR WALKWAY leading
    EAST/WEST. A small compartment is NORTH. SOUTH leads into the LIFT.
  DESC

  self.exit_south = :lift1d
  self.exit_west  = :tcorridor1
  self.exit_east  = :tcorridor3
  self.exit_north = :armoury

  self.scenery(:glass_case, 'case') do
    self.presence = "Glass case"
    self.desc = <<-DESC
      IN CASE OF DESPERATE FRUSTRATION<br>
      *BREAK GLASS*
    DESC
    # TODO: Break glass
  end
end
