room(:deck_of_ship) do
  self.short_desc = "deck_of_ship"
  self.desc = <<-DESC
    I have floated gently onto the deck of an OLD WRECKED SHIP.
    A crack leads DOWN and to the EAST is the SEA-BASE.
  DESC

  self.exit_east = :murky_depths
  self.exit_down = :the_hold

  scenery(:mast, 'mast') do
    self.presence = "Tall mast"
    self.desc = <<-DESC
      LEVER & LEVER & SONS - MAST MAKERS
    DESC
  end

  item(:plank, 'plank', 'long') do
    self.presence = "Long plank (nailed to deck)"
    self.desc = <<-DESC
      A SHIMMERING GHOSTLY figure appears &
      says in a watery voice:<br>
      "In bygone days this fine ship sank,
      and traitors made to WALK THE PLANK"
    DESC

    self.fixed = true

    self.script_get = <<-SCRIPT
      # TODO get plank in the game returns "Its NAILED to the deck."
      # But default text appears too in this engine.
      
      if !get_room.find(:nails).pulled
        puts "Its NAILED to the deck"
        return false
      end
    SCRIPT
  end

  item(:nails, 'nails') do
    self.fixed = true
    self.pulled = false

    self.script_pull = <<-SCRIPT
      return false unless get_room.find(:dental_pincers)
      return false if self.pulled

      puts "OK" # TODO? in the game this just refreshes

      plank = get_room.find(:plank)
      plank.presence = "Long plank"
      plank.desc = "See what you can MAKE..."
      plank.fixed = false
      self.fixed = false

      self.pulled = true
      self.presence = "Handfull of nails"
      self.desc = plank.desc

      get_root.move(:nails, :deck_of_ship)
    SCRIPT
  end
end
