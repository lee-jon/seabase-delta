room(:tcorridor4) do
  self.desc = <<-DESC
    The WALKWAY twists on EAST and WEST and meets up with another gangway NORTH.
    There is a gentle humming sound.
  DESC

  self.exit_north = :power_distribution
  self.exit_east  = :tcorridor1
  self.exit_west  = :tcorridor3
end
