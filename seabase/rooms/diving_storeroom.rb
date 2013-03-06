room(:diving_storeroom) do
  self.short_desc = "Diving Storeroom"
  self.desc = <<-DESC
    I am in the DIVING STOREROOM. A corridor leads NORTH.
  DESC

  self.exit_north = :corridor1

  item(:cupboard, 'cupboard') do
    openable = true
    fixed = true
    self.presence = "Cupboard"

    item(:diving_suit, 'diving suit') do
      self.desc = "There's a HOSE fitted."
      self.presence = "Diving suit"
      #TODO - when you wear suit it checks for air and says
      # "Not until you have some AIR matey!"
    end
  end
end