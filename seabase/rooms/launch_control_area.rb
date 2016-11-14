room(:launch_control_area) do
  self.short_desc = "Launch control area"
  self.desc = <<-DESC
    LAUNCH CONTROL AREA<br>
    Metal paths lead SOUTH and NORTH.
  DESC

  self.exit_north = :launch_pad
  self.exit_south = :computer_room

  item(:envelope, 'envelope') do
    self.presence = "Envelope"
    self.openable = true

    item(:certificate, 'certificate') do
      self.presence = "certificate"
      self.desc = <<-DESC
        CERTIFICATE OF INSURANCE
        <br>The Adventurer is hereby
        <br>insured against loss of
        <br>sleep,headaches,tearing
        <br>out of hair and sudden
        <br>outbursts of"Now I see!"
      DESC

      self.script_read = <<-SCRIPT
        puts self.desc
      SCRIPT
    end
  end
end
