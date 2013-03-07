room(:deep_freeze) do
  self.short_desc = "deep_freeze"
  self.desc = <<-DESC
    This is the DDDEEP FFFREEEZE SECTION. The way out is EAST.
  DESC
  
  self.exit_east = :laundry
  
  item(:stick_of_gum, 'gum') do
    self.presence = "Stick of Bubble Gum"
    self.desc = "Its rock hard!"
  end
end