room(:warhead) do
  self.short_desc = "warhead"
  self.desc = <<-DESC
    I am sitting on top of the WARHEAD.
    If the missile fired now I'd get home a bit quicker than I'd planned!
    A ladder leads DOWN.
  DESC

  self.exit_down = :warhead_platform
end
