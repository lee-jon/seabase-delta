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
  end
end
