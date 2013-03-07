room(:head_office) do
  self.short_desc = "head_office"
  self.desc = <<-DESC
    ****H E A D - O F F I C E****<br>
    A brightly lit passage leads off NORTH
  DESC
  
  self.exit_south = :fcorridor4
  
  item(:auto_clerk, 'auto-clerk') do
    self.presence = "auto-clerk"
    self.desc = ""
    
    item(:officeslot, 'slot') do
      self.fixed = true
      self.short_desc = "small slot"
      self.presence = "small slot"
    end
  end
end