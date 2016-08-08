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
  end
end
