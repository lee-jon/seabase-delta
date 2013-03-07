room(:station_alpha) do
  self.destination = :station_beta
  self.desc = <<-DESC
    I am on a platform at STATION "ALPHA"
  DESC
  self.short_desc = "Station Alpha"
  
  item(:torch, 'torch') do
    self.desc = <<-DESC
      Well every adventure's GOT to have one of these hasn't it?
    DESC
    self.short_desc = "Torch"
    self.presence = "Torch"

    #TODO self.script to do the desc on pick up like the original game?
  end
end