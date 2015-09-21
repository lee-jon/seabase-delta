room(:food_farm) do
  self.exit_west  = :walkway
  self.exit_south = :station_charlie
  self.exit_east  = :at_long_table

  self.desc = <<-DESC
    I've entered the FOOD-FARM AREA. Yuk! The floor is almost completely
    covered with GREEN SLIMEY SEAWEED! Exits are SOUTH and WEST.
  DESC
  self.short_desc = "Food farm."

  item(:long_table, 'table', 'long') do
    self.desc = "It's to the EAST - at the other side of the room..."
    self.short_desc = "A table."
    self.presence   = "Long table."
  end

  scenery(:seaweed, 'seaweed') do
  end
end
