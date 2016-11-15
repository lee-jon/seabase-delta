room(:plank_platform) do
  self.short_desc = "I'm STANDING on one end of a SEESAW. Exit is SOUTH"
  self.desc = short_desc

  # TODO in the game you have to JUMP to exit!
  self.exit_south = :launch_pad
end
