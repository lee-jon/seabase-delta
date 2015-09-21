room(:station_foxtrot) do
  self.short_desc = "Station Foxtrot"
  self.desc = <<-DESC
    I am on a platform at STATION "FOXTROT". The tube-car is so fast it's hard to say just how far I have travvelled...
  DESC

  self.destination = :station_alpha

  item(:screwdriver, 'screwdriver') do
    self.short_desc = "Screwdriver"
    self.presence = "Screwdriver"
  end
end
