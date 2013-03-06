room(:station_foxtrot) do
  self.short_desc = "Station Foxtrot"
  self.desc = <<-DESC
    I am on a platform at STATION "FOXTROT"
  DESC

  self.destination = :station_alpha

  item(:screwdriver, 'screwdriver') do
    self.short_desc = "Screwdriver"
    self.presence = "Screwdriver"
  end
end