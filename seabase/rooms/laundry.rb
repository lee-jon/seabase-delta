room(:laundry) do
  self.short_desc = "laundry"
  self.desc = <<-DESC
    I have wantered into the LAUNDRY AREA. There is an ICY COLD Tunnel WEST
    & Exit EAST.
  DESC

  self.exit_west = :deep_freeze
  self.exit_east = :dinning_room

  item(:steam_iron, 'iron') do
    self.presence = "Steam-Iron"
    self.desc = "Its ON and HOT!"
    self.short_desc = "Iron"
  end

  item(:washing_line, 'line') do
    self.presence = "Washing line"
    self.desc = "It's LONG....but not that STRONG.."
    self.short_desc = "Washing line"
    self.with_magnet = false
    self.with_attachment = false
    self.thrown = false

    self.script_throw = <<-SCRIPT
      return if !self.with_magnet
      return if !get_room.find(:deep_liftshaft)
      return if self.thrown

      puts "CLINK!....Magnet picks up something.."

      self.presence = "Wash-line+Magnet(Hanging down liftshaft)"
      self.with_attachment = true
      self.fixed = true

      get_root.move(self, :lift2)
    SCRIPT

    self.script_pull = <<-SCRIPT
      if self.with_attachment
        puts "OK"
        get_root.move(:small_metal_disc, :lift2, false)

        self.with_attachment = false
        self.thrown = true
        self.fixed = false
        self.presence = self.short_desc

        return false
      else
        puts "NOPE"
        return false
      end
    SCRIPT
  end
end
