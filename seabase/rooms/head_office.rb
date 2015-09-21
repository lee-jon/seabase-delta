room(:head_office) do
  self.short_desc = "head_office"
  self.desc = <<-DESC
    ****H E A D - O F F I C E****<br>
    I've never seen an office like this one! The huge oval-shaped compartment
    is full of noisy pulsating racks of equipment. Not a typewriter or filing
    cabinet in sight! A brightly lit passage leads off NORTH.
  DESC

  self.exit_north = :fcorridor4

  item(:auto_clerk, 'auto-clerk') do
    self.fixed = true
    self.presence = "Auto-clerk"

    self.script_examine = <<-SCRIPT
      puts "I see something..."

      get_root.move(:officeslot, :head_office, false)

      return false
    SCRIPT

    item(:officeslot, 'slot') do
      self.fixed = true
      self.presence = "Small slot"
      self.short_desc = "Small slot"
    end
  end
end
