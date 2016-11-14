room(:the_hold) do
  self.short_desc = "the_hold"
  self.desc = <<-DESC
    I am down in THE HOLD of the OLD WRECK.
    The only way out is UP
  DESC

  self.exit_up = :deck_of_ship

  item(:telescope, 'telescope', 'ancient') do
    self.presence = "Ancient telescope"
    self.desc = <<-DESC
      You peer through the Eyepiece and...

      I see nothing special.
    DESC
  end

  item(:cannon, 'cannon') do
    self.presence = "Rusty cannon"
    self.fixed = true
    self.desc = <<-DESC
      What's that down in the barrel? If I had
      some-thing to LEVER the CANNON..
    DESC

    self.script_lever = <<-LEVER
      if !get_room.find(:wood)
        puts "With what? My bare hands?"
        return false
      else
        puts "I see something..." # Wasn't in original

        cannon = get_root.find(:cannon)
        cannon.desc = ""
        cannon.presence = "TIPPED-UP cannon"

        get_root.move(:rusty_ball, :the_hold)
      end
    LEVER
  end
end
