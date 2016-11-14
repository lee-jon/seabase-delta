room(:tavern) do
  self.short_desc = "tavern"
  self.desc = <<-DESC
    I'm in THE SEA-BASE TAVERN. There is a passage leading off west.
  DESC

  self.exit_west = :living_quarters

  item(:barrel, "barrel") do
    self.presence = "Barrel"
    self.desc = <<-DESC
      Label-"HO-HO" RUM. Its empty. Just as well to keep a clear head in this game!
    DESC
  end
end
