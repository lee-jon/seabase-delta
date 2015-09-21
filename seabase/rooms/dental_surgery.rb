room(:dental_surgery) do
  self.short_desc = "dental_surgery"
  self.desc = <<-DESC
    Spotless white tiles are all around in the DENTAL SURGERY. The exit is east.
  DESC

  self.exit_east = :living_quarters

  item(:dental_pincers, 'pincers', 'dental') do
    self.presence   = "Dental Pincers"
    self.short_desc = "Dental Pincers"
  end
end
