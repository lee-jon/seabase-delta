## ### ### ### ### ### ### ### ##
##        SEABASE DELTA        ##
## ### ### ### ### ### ### ### ##

# Originally by Firebire software using the Quilled package 1986
# Recreated, in Ruby, by Lee-Jon, for the IF engine
#
# Have a look at github/lee-jon

# In Subsunk, the journalist Ed Lines, stranded aboard the wrecked submarine
# Sea Lion, successfully sent a distress signal to headquarters and now awaits
# rescue. But the message has been intercepted by enemy agents, who arrange for
# Sea Lion to be towed into Seabase Delta, where she will not be found. Ed
# Lines emerges from the submarine to find the Seabase mysteriously deserted;
# he must discover its secrets and escape.

# Compiled 2017-05-04 16:02:54 +0100

class Player < Node
  def do_fasten(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('fastern')
  end

  def do_unfasten(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('unfastern')
  end

  def do_chew(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('chew')
  end

  def do_unscrew(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('unscrew')
  end

  def do_tie(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('tie')
  end

  def do_blow(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('blow')
  end

  def do_throw(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('throw')
  end

  def do_turn(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('turn')
  end

  def do_short(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('short')
  end

  def do_fire(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('fire')
  end

  def do_fill(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('fill')
  end

  def do_sign(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('sign')
  end

  def do_reflect(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('reflect')
  end

  def do_iron(*words)
    if get_room.find(:steam_iron)
      item = get_room.find(words)
      return if item.nil?
      item.script('iron')
    else
      puts "You do not have the iron"
    end
  end

  def do_wear(*thing)
    thing = get_room.find(thing)

    return if thing.nil?
    if !thing.wearable
      puts "You cannot wear that"

      return
    end

    if thing.parent.tag == :player
      puts "You wear #{thing.short_desc}"

      thing.short_desc << " (worn)"
      thing.worn  = true
      thing.fixed = true
    else
      puts "You are not carrying this."
    end
  end

  def do_stick(*words)
    return unless get_room.find(:lift1b_buttons)
    item = get_room.find(:stick_of_gum)

    if item.nil?
      puts "Stick what exactly?"
      return
    end

    if item.chewed == true
      puts "SPLAT! GUM sticks the Button in.."
      get_root.find(:lift1d).accessible = true
    else
      puts "The gum is hard." #TODO get official text
    end
  end

  # Verb for making pancake - to be refactored and made generic if
  # Note uses get ROOT, not get_room method
  def do_make(*words)
    item = get_root.find(words)

    if item.tag == :seesaw
      needed = [:barrel, :plank, :hammer, :nails]
      if needed.map { |item| get_room.find(item) }.all?
        needed.each { |item| get_root.move(item, :void) }

        get_root.move(:seesaw, parent)
      else
        return false
      end
    elsif item.tag == :pancake
      if get_room.find(:milk) && get_room.find(:flour) && get_room.find(:bowl) && get_room.find(:egg)
        puts "Dolup, Slop, Slush!"
        get_root.move(:milk, :void)
        get_root.move(:bowl, :void)
        get_root.move(:flour, :void)
        get_root.move(:egg, :void)
        get_root.move(:bowl_of_mixture, parent, false)
      else
        puts "Its not possible to do that" #TODO: Make this canonical
        return false
      end
    else
      false
    end
  end

  def do_cook(*words)
    item = get_root.find(words)
    if get_room.find(:bowl_of_mixture) && get_room.find(:hotplate)
      get_root.move(:bowl_of_mixture, :void)
      get_root.move(:bowl, parent, false)
      get_root.move(:pancake, parent, false)
    else
      return false
    end
  end

  def do_connect(*words)
    if words[0] != "hose"
      puts "I do not know how to connect that"
      return false
    else
      if get_room.find(:air_bottle) && get_room.find(:diving_suit)
        puts "You connect up the air supply and slip on the SUIT....."
        get_root.move(:diving_suit, :void)
        get_root.move(:air_bottle, :void)

        get_root.move(:connected_suit, self)
      else
        puts "Not sure what you mean" #TODO: get actual text here
      end
    end
  end

  def do_shout(*words)
    if get_room.find(:microphone)
      puts "ZZZZZZZAANG!..The sound of metal sliding over metal and a DAZZLING BEAM of LIGHT from the SOUTH..\n"
      puts "ZZAAAANG!...THUD! Something slams shut. The BEAM of LIGHT disappears"
    else
      puts "OK. Nothing happened"
    end
  end

  def do_type(*number)
    missile =  get_room.find(:small_missile)
    return false if missile.nil?

    if number[0] == missile.bearing && missile.bearing_set == false
      missile.script('set_bearing')
    elsif number[0] == missile.elevation && missile.bearing_set == true
      missile.script('fire')
    else
      return false
    end
  end

  def do_lever(*words)
    item = get_room.find(words)
    return if item.nil?
    result = item.script('lever')
  end

  def do_walk(*words)
    words = ["seesaw"] if words.include? "plank"

    item = get_room.find(words)
    return if item.nil?
    item.script("walk")
  end

  def do_jump(*direction)
    return if get_room.script_jump.nil?

    get_root.move(:player, get_room.script_jump)
  end
end

Node.root do
self.title = "seabase"
self.intro = "Seabase delta, classic 1984 game by Firebird software"
self.help  = "Use your 'ed Ed, & always EXAMINE things."
room(:airlock) do
  self.desc = "I am in the AIRLOCK. There's a dull silence in this cramped dingy compartment."
  self.short_desc = "Airlock"

  self.empty = true

  item(:wheel, 'wheel') do
    self.presence = "Large wheel"
    self.fixed = true

    self.script_turn = <<-SCRIPT
      if get_room.empty
        if get_room.find(:connected_suit)
          get_room.empty = false

          puts "AIRLOCK fills with seawater"
          puts "Metallic voice says- 'Standby for EJECT'"
          puts "WHOOSHH!"
          puts ""

          get_root.move(:player, :murky_depths, false)

        else
          puts "AIRLOCK fills with seawater. CHOKE! GASP! NO AIR....I'M DROWING"
          puts "AAAARGH"
          puts ""
          puts "GAME OVER"
          get_root.move(:player, :void)
        end

      else
        get_room.empty = true

        puts "The room is emptying"

        get_root.move(:player, :station_beta)
      end
    SCRIPT
  end

  item(:sign, 'sign') do
    self.presence = "Sign"
    self.desc = "Automatic Air-Lock"
    self.fixed = true
  end
end

room(:armoury) do
  self.short_desc = "armoury"
  self.desc = <<-DESC
    The SEA-BASE ARMOURY. The exit is SOUTH
  DESC

  self.exit_south = :tcorridor2

  item(:spear_gun, 'speargun') do
    self.presence = "Speargun (loaded)"
    self.loaded = true

    self.script_fire = <<-SCRIPT
      if get_room.find(:octopus) && self.loaded
        puts "SSHHHH! Spear hits in the eye!"
        puts "And it gets really annoyed"

        self.loaded = false

        self.presence = "Empty speargun"
        self.short_desc = "Empty speargun"

        get_root.move(:ink, :murky_depths)
      else
        if self.loaded
          puts "Not just yet Ed!"
        else
          puts "I can't do that Ed."
        end

        return false
      end
    SCRIPT
  end
end

room(:at_long_table) do
  self.exit_west = :food_farm
  self.short_desc ="Long Table"
  self.script_enter = <<-SCRIPT
    if get_root.find(:flippers).worn
      puts "FLIP! FLOP! FLIP! FLOP! - You waddle over to the table - find"
      puts "something - then waddle back...."

      get_root.move(:large_key, :food_farm)

      return false
    else
      puts "WHEEEEEE!!!"
      puts "You slide majestically across the room on the seaweed."
      puts "Feet won't grip!"
      puts ""
      puts "What's that on the TABLE?"
      puts "You slide past the table back to the entrance of the room.."
      puts ""

      return false
    end
  SCRIPT

  item(:large_key, 'key') do
    self.presence = "Large key"
    self.short_desc = "Large key"
  end
end

room(:bottle_store) do
  self.short_desc = "bottle_store"
  self.desc = <<-DESC
    The Gas Bottle Store. The exit is south.
  DESC

  self.exit_south = :fcorridor1

  item(:air_bottle, 'bottle') do
    self.presence   = "Air bottle"
    self.short_desc = "Air bottle"
    self.desc = "There's a HOSE fitted"
  end
end

room(:carriage) do
  self.desc = <<-DESC
    I'm in the Travel-Tube car. A metallic voice from the
    loudspeaker-"CLUNK-CLICK OR YOU'RE SURE TO BE SICK"
  DESC
  
  self.short_desc = <<-DESC
    A metallic voice from the loudspeaker-"CLUNK-CLICK OR YOU'RE
    SURE TO BE SICK"
  DESC

  self.script_exit = <<-SCRIPT
    if get_room.open
      current_station = get_root.find(:tube_car).get_room
      get_root.move(:player, current_station, false)
      puts current_station.short_desc
    else
      puts "Still belted up!"
    end
  SCRIPT

  item(:seatbelt, 'belt', 'seatbelt') do
    self.fixed = true
    self.short_desc = 'seat belt.'
    self.presence = "seat belt."
    self.script_fastern = <<-SCRIPT
      puts "OK"
      self.get_room.open = false
    SCRIPT
    self.script_unfastern = <<-SCRIPT
      puts "OK"
      self.get_room.open = true
    SCRIPT
  end

  item(:smallslot, 'slot') do
    self.fixed = true
    self.short_desc = "small slot."
    self.presence = "small slot"
  end
end

room(:computer_memory_banks) do
  self.short_desc = "Computer memory banks"
  self.desc = <<-DESC
    This is a small compartment containing the COMPUTER MEMORY BANKS. Exit is EAST.
  DESC

  self.exit_east = :computer_room

  item(:cassette, 'cassette') do
    self.presence   = "Cassette"
    self.short_desc = "Cassette"
    self.desc       = "HEAVY METAL MUSIC"

    self.script_use = <<-SCRIPT
      if get_room.find(:tape_player)
        get_root.move(:tape_player, :computer_memory_banks)
        get_root.move(:cassette, :void)

        item = get_root.find(:tape_player)

        item.playing = true
        item.presence << " (Playing HEAVY METAL music)"
        item.short_desc = item.presence
        item.desc = nil
        
        return false
      else
        return true
      end
    SCRIPT
  end
end

room(:computer_room) do
  self.desc = <<-DESC
    I am in the SEABASE MAIN COMPUTER ROOM. Corridors lead NORTH, SOUTH, & WEST.
  DESC

  self.exit_south = :tcorridor3
  self.exit_north = :launch_control_area
  self.exit_west  = :computer_memory_banks

  self.script_enter = <<-SCRIPT
    if get_root.find(:tv_camera).covered == true
      return true
    else

      puts "Metallic voice:"
      puts 'SECURITY ALERT! ANTI-PERSONAL GUNS...AIM...FIRE! AAAGGGHHH!!!'
      puts ""
      puts "You run quickly back to the corridor!"
      puts "\n\n"

      return false
    end
  SCRIPT

  scenery(:computer, 'computer') do
    self.presence = "Computer"
    self.desc = "It's an ANSTRATARI SPECODORE"
  end
end

room(:corridor1) do
  self.exit_north = :station_beta
  self.exit_east  = :corridor2
  self.exit_west  = :corridor4
  self.exit_south = :diving_storeroom

  self.desc = <<-DESC
    I've entered a large CURVING CORRIDOR. It stretches out
    EAST/WEST & Walkways lead NORTH & SOUTH.
  DESC
  self.short_desc = "Corridor"
end
room(:corridor2) do
  self.short_desc = "E/W Corridor."
  self.desc = <<-DESC
    The CURVING EAST/WEST CORRIDOR continues here.
    There is a simly lit ALCOVE to the SOUTH.
  DESC

  self.exit_west = :corridor1
  self.exit_east = :corridor3
  self.exit_south = :lift2


  item(:sign_missile, 'sign') do
    self.presence = "Sign"
    self.fixed = true
    self.desc = <<-DESC
      In case of ELEVATOR breakdown contact MISS. ISLES on "199"
    DESC
    self.script_read = <<-SCRIPT
      puts 'In case of ELEVATOR breakdown contact MISS. ISLES on "199"'
    SCRIPT
  end
end

room(:corridor3) do
  self.desc = <<-DESC
    This CORRIDOR still stretches EAST/WEST. I get the strangest feeling
    - like I am walking around a huge WHITE MINT! There is also a
    compartment to the NORTH.
  DESC
  self.short_desc = "Corridor"
    
  self.exit_west = :corridor2
  self.exit_east = :corridor4
  self.exit_north = :electronic_workshop
end
room(:corridor4) do
  self.short_desc = "Corridor."
  self.desc = <<-DESC
    East / West curving corridor. There is a
    dimly lit ALCOVE to the SOUTH.
  DESC

  self.exit_west  = :corridor3
  self.exit_east  = :corridor1
  self.exit_south = :lift1

  scenery(:chute, 'chute') do
    self.fixed = true
    self.presence = "Large metal chute (sloping up)"

    self.desc = <<-DESC
      Nasty smell of rubbish
    DESC
    self.script_enter = <<-SCRIPT
      puts "You slide back down. It's too steep."
      return false
    SCRIPT
  end
end

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

    self.script_walk = <<-SCRIPT
      puts "HMM..seems quite springy..even after all those years.."
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

room(:deep_freeze) do
  self.short_desc = "deep_freeze"
  self.desc = <<-DESC
    This is the DDDEEP FFFREEEZE SECTION. The way out is EAST.
  DESC
  
  self.exit_east = :laundry
  
  item(:stick_of_gum, 'gum') do
    self.presence   = "Stick of Bubble Gum"
    self.desc       = "Its rock hard!"
    self.short_desc = "Gum"
    self.chewed     = false
    
    self.script_chew = <<-SCRIPT
      puts chewed ? "OK. Nothing happens." : "SLURP! Yum... Quite tasty!"
      self.short_desc = "Soft gooeey gum"
      self.desc = nil
      self.chewed = true

      return false
    SCRIPT
    
    self.script_
    
    scenery(:bubble, 'bubble') do
      # This is here to execute the blow bubble verb
      self.script_blow = <<-BLOW
        if self.parent.chewed
          puts "PUFF! BLOW! the Bubble is GROWING!"
          puts "AND GROWING!"
          puts "BANG!!! WOW! That could wake the dead!"

          if get_room.tag == :food_store
            if get_root.find(:hen).parent.tag == :food_store
              if get_root.find(:egg).parent.tag == :hen
                puts "<br>CLUCK! CLUCK! CLUCK!- HEN IS AROUSED!"
                puts "And Does her duty!"
                get_root.find(:hen).presence = "Brighted eyed hen"
                get_root.move(:egg, :food_store, false)
              end
            end
          end
        else
          puts "The gum is hard!" #TODO check this text in the original game
        end
      BLOW
    end
  end
end
room(:dental_surgery) do
  self.short_desc = "dental_surgery"
  self.desc = <<-DESC
    Spotless white tiles are all around in the DENTAL SURGERY. The exit is east.
  DESC

  self.exit_east = :living_quarters

  item(:dental_pincers, 'pincers', 'dental') do
    self.presence   = "Dental Pincers"
    self.short_desc = "Dental Pincers"
  end
end

room(:dinning_room) do
  self.short_desc = "Dining room"
  self.desc = <<-DESC
    The DINNING ROOM AREA. Walkways lead NORTH EAST and WEST.
  DESC

  self.exit_north = :fcorridor2
  self.exit_east  = :kitchen
  self.exit_west  = :laundry

  item(:flippers, 'flippers', 'sure-grip') do
    self.presence   = "Pair of \"Sure Grip\" Flippers"
    self.short_desc = "Pair of \"Sure Grip\" Flippers"
    self.worn       = false
    self.wearable   = true
  end

  item(:fork, 'fork') do
    self.presence ="Fork"
    self.desc = "One of it's PRONGS is missing."
  end
end

room(:diving_storeroom) do
  self.short_desc = "Diving Storeroom"
  self.desc = <<-DESC
    I am in the DIVING STOREROOM. A corridor leads NORTH.
  DESC

  self.exit_north = :corridor1

  item(:cupboard, 'cupboard') do
    self.openable = true
    self.fixed = true
    self.presence = "Cupboard"

    item(:diving_suit, 'suit') do
      self.desc = "There's a HOSE fitted."
      self.presence = "Diving suit"
      self.connected_to_air = false
      #TODO - when you wear suit it checks for air and says
      # "Not until you have some AIR matey!"
      self.script_wear = <<-SCRIPT
        if self.connected_to_air
          puts "OK"
        else
          puts "not until you have some AIR matey!"
        end
      SCRIPT
    end
  end
end

room(:fcorridor1) do
  self.desc = <<-DESC
    This is the second lever corridor system going east & west. The lift
    entrance is south and a walkway also leads north.
  DESC
  
  self.exit_south = :lift1b
  self.exit_north = :bottle_store
  self.exit_east  = :fcorridor2
  self.exit_west  = :fcorridor4
end
room(:fcorridor2) do
  self.short_desc = "Corridor"
  self.desc = <<-DESC
    As the CORRIDOR continues EAST/WEST, I begin to with I was still on the
    SUB'. At least the gangways were straight!
    There are also compartments to the NORTH and SOUTH.
  DESC

  self.exit_south = :dinning_room
  self.exit_north = :surgery
  self.exit_east  = :fcorridor3
  self.exit_west  = :fcorridor1
end

room(:fcorridor3) do
  self.desc = <<-DESC
    The corridor narrows here slightly at a junction between walkways.
    Exits are to the east, west & south. There's an awful smell of
    rubbish coming from somewhere!
  DESC
  self.short_desc = "Corridor"

  self.exit_east  = :fcorridor4
  self.exit_west  = :fcorridor2
  self.exit_south = :food_store

  item(:switch, 'switch') do
    self.presence = "Large Switch"
    self.desc = "Its marked LEFT and RIGHT"
    self.short_desc = "Switch"

    self.script_push = <<-SCRIPT
      puts  self.children
      puts "It's jammed on RIGHT. Maybe if I had some thing to SHORT the SWITCH"
    SCRIPT

    self.script_short = <<-SCRIPT
      if get_room.find(:fork)
        puts "CRACK!! ZAPP!!"
        get_root.move(:fork, :void)
        get_root.move(:melted_metal, :fcorridor3)

        target = get_room.find(:conveyor_belt)
        target.presence = "Conveyor belt (moving LEFT)"
        target.going_right = false
      end
    SCRIPT
  end

  scenery(:conveyor_belt, 'conveyor') do
    self.presence = "Conveyor belt (moving RIGHT)"
    self.desc = "It's quite big...maybe I should CLIMB on to it..."
    self.going_right = true

    self.script_climb = <<-SCRIPT
      if self.going_right == true
        puts "WHOOPS..It's going the wrong way."
        puts "I am thrown off!"
      else
        puts "I am sitting on a sloping metal belt"
        puts "OUCH! I've landed somewhere!"
        get_root.move(:player, :refuse_compartment, false)
      end
      return false
    SCRIPT
  end
end

room(:fcorridor4) do
  self.short_desc = "Corridor"
  self.desc = <<-DESC
    The east/west curving corridor leads on with a very
    brightly lit Walk-way south.
  DESC

  self.exit_east  = :fcorridor1
  self.exit_west  = :fcorridor3
  self.exit_south = :head_office
end

room(:food_farm) do
  self.exit_west  = :walkway
  self.exit_south = :station_charlie
  self.exit_east  = :at_long_table

  self.desc = <<-DESC
    I've entered the FOOD-FARM AREA. Yuk! The floor is almost completely
    covered with GREEN SLIMEY SEAWEED! Exits are SOUTH and WEST.
  DESC
  self.short_desc = "Food farm."

  item(:long_table, 'table', 'long') do
    self.desc = "It's to the EAST - at the other side of the room..."
    self.short_desc = "A table."
    self.presence   = "Long table."
  end

  scenery(:seaweed, 'seaweed') do
  end
end

room(:food_store) do
  self.short_desc = "food_store"
  self.desc = <<-DESC
    The seems to be some sort of FOOD-STORE. The way out is NORTH.
  DESC

  self.exit_north = :fcorridor3

  item(:wicker_cage, 'cage') do
    self.presence = "Wicker Cage"
    self.fixed = true

    #TODO the delow doesn't work??? Even if there's no child
    self.script_examine = <<-SCRIPT
      if self.children.nil?
        return false
      else
        puts "I see something"
        self.open = true
        get_root.move(:hen, parent)
        return false
      end
    SCRIPT

    self.script_take = <<-SCRIPT
      puts "Thanks-but NO THANKS!"
      return false
    SCRIPT

    item(:hen, 'hen') do
      self.presence = "Hen"
      self.desc = "It is asleep..."
      self.fixed = true

      item(:egg, 'egg') do
        self.presence   = "Large brown egg"
        self.short_desc = "Large brown egg"
      end
    end
  end
end

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

room(:kitchen) do
  self.desc = <<-DESC
    I am in a well used KITCHEN. Exit is WEST.
  DESC
  
  self.exit_west = :dinning_room
  
  item(:shelves, 'shelves') do
    self.presence = "Shelves"
    self.examined = false
    self.script_examine = <<-SCRIPT
      if self.examined == false
        puts "I see something..."
        
        get_root.move(:flour, parent, false)
        self.examined = true
        
        return false
      else
        return true
      end
    SCRIPT
  end
  
  item(:hotplate, 'hotplate') do
    self.presence = "Hotplate"
    self.desc = "Its ON and HOT!"
  end
  
  item(:fridge, 'fridge') do
    self.presence = "Fridge"
    self.openable = true
    
    item(:milk, 'milk', 'carton') do
      self.presence = 'Carton of Milk'
    end
  end
end
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

room(:launch_pad) do
  self.short_desc = "Huge launch pad"
  self.desc = <<-DESC
    I have reached the HUGE LAUNCH PAD. A metal path leads SOUTH
  DESC

  self.exit_south = :launch_control_area

  scenery(:platform, "platform") do
    self.presence = "Warhead platform"
    self.desc = <<-DESC
      Way up high....Can't reach!
    DESC
  end

  scenery(:nuclear_missile, "missile") do
    self.presence = "Huge nuclear missile"
    self.desc = <<-DESC
      It is controlled by a BEAM of LIGHT near that platform...
    DESC

    self.active = true
  end
end

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

room(:library) do
  self.short_desc = "library"
  self.desc = <<-DESC
    This is the LIBRARY. Exits lead WEST and SOUTH.
  DESC

  self.exit_south = :shower_room
  self.exit_west  = :music_room

  self.script_enter = <<-SCRIPT
    puts "MUSIC seems louder now\n" if get_root.find(:music_room).music_on

    return true
  SCRIPT

  item(:cookbook, "cookbook") do
    self.presence = "Cookbook"
    self.fixed    = true
    self.desc     = '"MAKING PANCAKES" by LEN SCOVER'
    self.read     = false

    self.script_examine = <<-SCRIPT
      self.desc
      self.read = true
    SCRIPT
  end
end

room(:lift1) do
  self.short_desc = "Lift no. 1"
  self.desc = <<-DESC
    Sea-base lift Number >1<.
    The exit is to the north.
  DESC

  self.exit_north = :corridor4
  self.exit_up    = :lift1b
  self.exit_down  = :lift1c

  self.script_enter = <<-SCRIPT
    puts "A light comes on<br>"
    return true
  SCRIPT

  item(:lift1_buttons, 'button') do
    fixed = true
    self.presence = "Row of buttons"
    self.script_push = <<-SCRIPT
      puts "Which one... UP or DOWN"
    SCRIPT
  end

  self.script_up  = <<-SCRIPT
    #TODO This doesn't work!
    puts "Shhh doors close. Lift ascends."
    puts "Doors open."
  SCRIPT

  self.script_down = <<-SCRIPT
    puts "Bottom floor!"
    return false
  SCRIPT
end

room(:lift1b) do
  self.short_desc = "Lift no. 1"
  self.desc = <<-DESC
    Sea-base lift Number >1<.
    The exit is to the north.
  DESC

  self.exit_down  = :lift1
  self.exit_up    = :lift1d
  self.exit_north = :fcorridor1

  item(:lift1b_buttons, 'button') do
    fixed = true
    self.presence = "Row of buttons"
    self.script_push = <<-SCRIPT
      puts "Which one... UP or DOWN"
    SCRIPT
  end
end

room(:lift1c) do
  self.short_desc = "lift1c"
  self.desc = <<-DESC    
  DESC
  
  #TODO This shoud be removed
  self.script_enter = <<-ENTER
    puts "Bottom floor\n"
    return false
  ENTER
end
room(:lift1d) do
  self.short_desc = "lift1d"
  self.desc = <<-DESC
    Top floor lift
  DESC

  self.accessible = false

  self.exit_down  = :lift1b
  self.exit_north = :tcorridor2

  item(:lift1d_buttons, 'button') do
    fixed = true
    self.presence = "Row of buttons"
    self.script_push = <<-SCRIPT
      puts "Which one... UP or DOWN"
    SCRIPT
  end

  self.script_enter = <<-SCRIPT
    if self.accessible != true
      puts "PING! OH BLOW! button keeps popping out!"
      puts "I need something to STICK it.."
      return false
    else
      puts "Lift goes up"
      return true
    end
  SCRIPT
end

room(:lift2) do
  self.short_desc = "Lift 2"
  self.desc = <<-DESC
    Sea-Base Lift Number >2<. The EXIT is to the NORTH.
  DESC

  self.exit_north = :corridor2

  scenery(:floor_panel, 'panel') do
    self.desc     = "It can be OPENED but It's LOCKED!"
    self.presence = "Floor panel"
    self.openable = true

    self.script_open = <<-SCRIPT
      if get_room.find(:large_key)
        puts "I see something!!"

        self.presence = "Open Floor panel"
        self.openable = false

        get_root.move(:deep_liftshaft, :lift2)

        return false
      else
        puts "it can be OPENED but it's LOCKED"

        return false
      end
    SCRIPT

    scenery(:deep_liftshaft, 'shaft') do
      self.presence = 'Deep liftshaft'
      self.desc = "It's a long way down. There might be something down there but I can't see that far!"

      item(:small_metal_disc, 'disc') do
        self.presence   = "Small metal disc"
        self.short_desc = "Small metal disc"
        self.desc       = "One play"

        self.script_use = <<-SCRIPT
          if get_room.find(:games_machine)
            get_room.find(:games_machine).playing = true
            
            puts "It's one of those PLATFORM GAMES. A clown is jumping up and down on a Circus SEESAW...."
          end
        SCRIPT
      end
    end
  end

  scenery(:lift2_buttons, 'buttons') do
    self.presence = "Row of buttons"

    self.script_push = <<-SCRIPT
      puts "OK. Nothing Happened."
    SCRIPT
  end
end

room(:living_quarters) do
  self.desc = <<-DESC
    The Base takes on a more homely appearance as in the LIVING QUARTERS.
    Exits go NORTH, SOUTH, EAST and WEST
  DESC

  self.exit_north = :restroom
  self.exit_south = :tcorridor1
  self.exit_west  = :dental_surgery
  self.exit_east = :tavern

  item(:writing_bureau, 'bureau', 'writing') do
    self.presence = "Writing bureau"
    self.fixed    = true
    self.openable = true
    self.script_open = <<-SCRIPT
      puts "I see something..."
      get_root.move(:fountain_pen, :living_quarters, false)
    SCRIPT
  end
end

room(:missile_room) do
  self.exit_south = :station_echo

  self.desc = <<-DESC
      I am in the TIGER-FISH MISSILE ROOM. Exit is SOUTH.
  DESC

  item(:small_missile, 'missile', 'small') do
    self.fixed = true
    self.desc = <<-DESC
      Not to be confused with the HUGE NUCLEAR MISSILE you've got to stop!
      DESC
    self.presence = "Small Tiger-Fish missile"

    self.bearing_set = false
    self.bearing = "104"
    self.elevation = "199"

    self.script_set_bearing = <<-SCRIPT
      self.bearing_set = true

      get_root.find(:display_screen).desc = "ENTER ELEVATION FIGURES NOW:"

      puts "The screen reads:ENTRY ACCEPTED"
      puts "ENTER ELEVATION FIGURES NOW:"
    SCRIPT

    self.script_fire = <<-SCRIPT
      get_root.move(:small_missile, :void)
      get_root.find(:mast).presence = "Broken mast"
      get_root.find(:mast).desc = nil
      get_root.move(:wood, :deck_of_ship)

      puts "WHOOOOSH!! TIGER-FISH MISSILE IS FIRED AND HEADS OUT TOWARDS THE OLD WRECK..."
      puts "CRACK!... It hits the MAST of the WRECK!"
    SCRIPT
  end

  item(:display_screen, 'screen') do
    self.fixed = true

    self.desc = <<-DESC
      To aim missile enter 1. Degrees Bearing. 2. Elevation.
      Enter bearing figures now:
    DESC

    self.presence = "Display screen"
    self.read = ""
  end

  item(:keyboard, 'keyboard', 'small') do
    self.fixed = true
    self.presence = "Small keyboard"
  end
end

room(:murky_depths) do
  self.short_desc = "Murky Depths"
  self.desc = <<-DESC
    I am swimming around in the MURKY DEPTHS of the OCEAN. Yellow streaks of
    blurry light from the base reach out for a few hundred yards into the lonely
    blackness. To the WEST the lightbeams seem to dance along the edge of some
    huge long object resting on the sea-bed.
  DESC

  self.exit_west = :deck_of_ship

  scenery(:open_sea_filled_hatch, 'hatch') do
    self.presence = "Open sea-filled hatch"

    self.script_enter = <<-SCRIPT
      get_root.move(:player, :airlock)

      return false
    SCRIPT
  end

  item(:mini_sub, 'sub') do
    self.presence = "Mini-sub"
    self.desc = "A minature submarine"
    self.fixed = true

    self.released = false

    self.script_enter = <<-SCRIPT
      get_root.move(:player, :submarine)
      return false
    SCRIPT
  end

  scenery(:octopus, 'octopus') do
    self.presence = "Giant Octopus"
    self.desc = "BIG but nothing to write home about...."
  end
end

room(:music_room) do
  self.short_desc = "music_room"
  self.desc = <<-DESC
    I've walked into the MUSIC ROOM. The exit is EAST
  DESC

  self.music_on  = false

  self.exit_east = :library

  self.script_enter = <<-SCRIPT
    if self.music_on
      puts "Oh what a din! Sounds like an old Rock & Roll song!-"
      puts "WITH A BARREL OF LAUGHS,"
      puts "AND WHAT THE SPIRITS ADVISE,"
      puts "WE'RE DOING HAMMER & NAILS,"
      puts "TO GET OUR BODIES TO RISE..."
    end

    return true
  SCRIPT

  item(:loudspeaker, 'loudspeaker') do
    self.fixed = true
    self.presence = "Loudspeaker"
    self.desc = "It has a loose magnet"

    item(:magnet, 'magnet') do
      self.presence = "Magnet"
      self.script_unscrew = <<-SCRIPT
        puts "Could help you get to the bottom of a problem..."
        get_root.move(:loudspeaker, :void)
        get_root.move(:magnet, :music_room, false)
      SCRIPT

      self.script_tie = <<-SCRIPT
        line = get_root.find(:washing_line)

        if get_room.find(:washing_line)
          get_root.move(:magnet, :void)
          get_root.move(:washing_line, :lift2)

          line.presence   << " (with magnet attached)"
          line.short_desc << " (with magnet attached)"
          line.with_magnet = true

          puts "OK"
        else
          puts "I don't know how to do that"
          return true
        end
      SCRIPT
    end
  end

  item(:hifi_unit, 'hifi', 'unit') do
    self.fixed = true
    self.presence = "Hifi unit"
  end
end

room(:plank_platform) do
  self.short_desc = "I'm STANDING on one end of a SEESAW. Exit is SOUTH"
  self.desc = short_desc
  self.script_jump = :launch_pad
end

room(:power_distribution) do
  self.short_desc = "power_distribution"
  self.desc = <<-DESC
    This is the POWER DISTRIBUTION ROOM. The exits are NORTH, SOUTH & EAST.
  DESC

  # Exits
  self.exit_east  = :reactor
  self.exit_south = :tcorridor4

  item(:power_distribution_switch, 'switch') do
    self.fixed = true
    self.presence = "Switch"

    self.script_push = <<-SCRIPT
      get_root.find(:music_room).music_on = true
      puts "I can hear the faint sound of MUSIC"
    SCRIPT
  end
end

room(:reactor) do
  self.short_desc = "reactor"
  self.desc = <<-DESC
    I'm in the REACTOR ROOM. The exit is WEST.
  DESC

  self.exit_west = :power_distribution

  item(:hammer, 'hammer') do
    self.presence = "Hammer"
    self.desc = "See what you can MAKE"
  end
end

room(:refuse_compartment) do
  self.desc = <<-DESC
    "I am in the smelly REFUSE COMPARTMENT."
  DESC

  # Exits - none

  item(:bowl, 'bowl', 'mixing') do
    self.presence   = "Old mixing bowl"
    self.short_desc = "Old mixing bowl"
  end

  item(:foil, 'foil')  do
    self.presence   = 'Crumpled up aluminium cooking foil'
    self.short_desc = "Foil"
    self.desc = "On reflection...It's..well..CRUMPLED!"
    self.smooth = false

    self.script_iron = <<-SCRIPT
      puts "You iron the foil"
      self.presence   = 'Smooth sheet of Aluminium cooking foil'
      self.desc = "Smooth sheet of Aluminium cooking foil."
      self.short_desc = "Smooth sheet of Aluminium cooking foil."
      self.smooth = true
    SCRIPT
  end

  scenery(:chute, 'chute') do
    self.presence = "Large metal chute (Sloping down)"

    self.script_enter = <<-SCRIPT
      puts "Wheeeeee!!!"
      puts "OUCH! I've landed somewhere!"
      get_root.move(:player, :corridor4, false)
      return false
    SCRIPT
  end

  scenery(:conveyor_belt2, 'conveyor') do
    self.presence = "Conveyor belt"
  end
end

room(:restroom) do
  self.short_desc = "restroom"
  self.desc = <<-DESC
    I've entered a cosy looking RESTROOM.
    There's a damp tunnel to the NORTH and a
    Walk-tube to the SOUTH.
  DESC

  self.exit_north = :shower_room
  self.exit_south = :living_quarters

  item(:games_machine, 'machine') do
    self.presence = "Video games machine"
    self.desc     = "Insert DISC for PLAY"
    self.fixed    = true
    self.playing  = false
  end

  item(:joystick, 'joystick') do
    self.presence = 'Joystick'
    self.desc     = 'Try PUSHING & PULLING it...'
    self.fixed    = true

    self.script_push = <<-SCRIPT
      if get_root.find(:games_machine).playing
        puts "Clown flips up into the air! This is fun! But back to the quest..."
      end
    SCRIPT

    self.script_push = <<-SCRIPT
      if get_root.find(:games_machine).playing
        puts "Clown throws a black ball.."
      end
    SCRIPT
  end
end

room(:security_control) do
  self.short_desc = "security_control"
  self.desc = <<-DESC
    This is SEABASE SECURITY CONTROL. The way out is NORTH.
  DESC

  self.exit_north = :shadowy_tunnel

  scenery(:knob, 'knob') do
    self.presence = "Knob"
    self.desc = "Mini-Sub Release"

    self.script_pull = <<-SCRIPT
      get_root.find(:submarine).released = true
      puts "OK"
    SCRIPT
  end
end

room(:shadowy_tunnel) do
  self.short_desc = "shadowy_tunnel"
  self.desc = <<-DESC
    I'm at the end of a DARK SHADOWY TUNNEL. The way back is NORTH.
  DESC

  self.exit_north = :tcorridor1

  scenery(:sliding_doors, 'doors') do
    self.presence = "Huge metal sliding doors"
    self.desc = "Shut tight and HEAVY man"

    self.unlocked = false

    self.script_enter = <<-SCRIPT
      return false unless self.unlocked

      get_root.move(:player, :security_control)

      return false
    SCRIPT
  end
end

room(:shower_room) do
  self.desc = <<-DESC
    I am in the SHOWER-ROOM. The exits are NORTH and SOUTH.
  DESC

  self.exit_north = :library
  self.exit_south = :restroom

  self.script_enter = <<-SCRIPT
    puts "I can hear the faint sound of music." if get_root.find(:music_room).music_on

    return true
  SCRIPT

  scenery(:tap, 'tap') do
    self.presence = 'Tap'
    self.short_desc = 'Tap'
  end
end

room(:station_alpha) do
  self.destination = :station_beta
  self.desc = <<-DESC
    I am on a platform at STATION "ALPHA" still further up the track. THe curiosly mixed coloured lighting seems to give each station a character of its own. THere appears to be no other obvious exits from here.
  DESC
  self.short_desc = "Station Alpha"

  item(:torch, 'torch') do
    self.desc = <<-DESC
      Well every adventure's GOT to have one of these hasn't it?
    DESC
    self.short_desc = "Torch"
    self.presence = "Torch"

    #TODO self.script to do the desc on pick up like the original game?
  end
end

room(:station_beta) do
  self.exit_south = :corridor1
  self.destination = :station_charlie
  self.desc = <<-DESC
    I am on a platform at STATION "BETA". A connecting walk-tube
    leads off SOUTH.
  DESC
  scenery(:hatch, 'hatch') do
    self.presence = "Closed hatch"
    #TODO hatch doesn't work as expected. Needs open and closed
    self.openable = true

    self.script_enter = <<-SCRIPT
      return false if !self.open

      puts ""
      puts "Bang! Hatch slams shut!"
      get_root.move(:player, :airlock)

      return false
    SCRIPT

    self.script_open = <<-SCRIPT
      self.presence = "Open hatch"
    SCRIPT
  end
end

room(:station_charlie) do
  self.exit_north = :food_farm
  self.destination = :station_delta
  self.desc = <<-DESC
    I am standing on a metallic platform in a large dome. A brightly lit
    sign above the walkway says TRAVEL-TUBE STATION CHARLIE. A walkway
    leads NORTH.
  DESC
  self.short_desc = "Charlie Station."
  self.script_enter_car = <<-SCRIPT
    puts "You enter the travel-tube car"
    # TODO
  SCRIPT

  item(:lever, 'lever') do
    self.presence = "Lever"
    self.script_pull = <<-SCRIPT
      puts "Whoosh! A travel-car arrives."
      puts "The door opens"
      get_root.move(:tube_car, parent, false)
    SCRIPT
  end
  item(:rail_tracks, 'tracks', 'rail-tracks') do
    self.desc = "OUCH! Your hair stands on end!"
    self.presence = "Rail-tracks"
  end
end
room(:station_delta) do
  self.exit_north = :observation_dome
  self.destination = :station_echo
  self.desc = <<-DESC
    I am on a platform at STATION DELTA. The platform
    opens out to the NORTH.
  DESC
  self.short_desc = "Station Delta"
end
room(:observation_dome) do
  self.exit_south = :station_delta
  self.desc = <<-DESC
    This is the OBSERVATION DOME. The exit is to the SOUTH.
    DESC
  self.short_desc = "Observation dome."
  item(:huge_window, 'window') do
    self.fixed = true
    self.desc = <<-DESC
      The murky sea stretches out before me. In on direction I see a
      SMALL MISSILE BAY and in the other- some sort of POLE sticking
      out of some WRECKAGE.
      DESC
    self.presence = "Huge viewing window"
  end
end
room(:station_echo) do
  self.short_desc = "Station Echo."
  self.desc = <<-DESC
    I am on a platform at STATION ECHO. There is a compartment to the NORTH.
  DESC
  
  self.exit_north = :missile_room
  self.destination = :station_foxtrot
end
room(:station_foxtrot) do
  self.short_desc = "Station Foxtrot"
  self.desc = <<-DESC
    I am on a platform at STATION "FOXTROT". The tube-car is so fast it's hard to say just how far I have travvelled...
  DESC

  self.destination = :station_alpha

  item(:screwdriver, 'screwdriver') do
    self.short_desc = "Screwdriver"
    self.presence = "Screwdriver"
  end
end

room(:submarine) do
  self.short_desc = "submarine"
  self.desc = <<-DESC
    I've clambered into the MINI-SUB.
  DESC

  self.released = false

  self.script_exit = <<-SCRIPT
    get_root.move(:player, :murky_depths)
  SCRIPT

  scenery(:small_lever, 'lever') do
    self.presence = "Small lever"

    self.script_pull = <<-SCRIPT
      puts "HUMM...The engines start.."

      if parent.released
        if get_root.find(:nuclear_missile).active
          puts "NO. I just can't be so cowardly. I have to stop that missile..."
        else
          puts "WELL DONE ED!!!"
          puts "WHAT A STORY THIS IS GOING TO MAKE!"
          puts "\n"
          sleep 5
          puts "END OF GAME"
          get_root.move(:player, void)
          sleep 10
          puts "Try again?"
          exit
        end
      else
        puts 'Metalic-voice-"NO SECURITY RELEASE.'
        puts 'MINI-SUB LAUNCH ABORTED!"'
      end
    SCRIPT
  end
end

room(:surgery) do
  self.short_desc = "surgery"
  self.desc = <<-DESC
    I'm in the DOCTORS SURGERY. Exit is SOUTH
  DESC

  self.exit_south = :fcorridor2

  item(:thermometer, 'thermometer') do
    self.presence   = "thermometer"
    self.short_desc = "thermometer"
    self.desc = <<-DESC
      104 DEGREES! WOW! This adventure must have really FIRED
      YOUR IMAGINATION!
    DESC
  end
end

room(:tavern) do
  self.short_desc = "tavern"
  self.desc = <<-DESC
    I'm in THE SEA-BASE TAVERN. There is a passage leading off west.
  DESC

  self.exit_west = :living_quarters

  item(:barrel, "barrel") do
    self.presence = "Barrel"
    self.desc = <<-DESC
      Label-"HO-HO" RUM. Its empty. Just as well to keep a clear head in this game!
    DESC
  end
end

room(:tcorridor1) do
  self.short_desc = "Corridor"
  self.desc = <<-DESC
    The TWISTING WALKWAY meets a junction of TUBES leading NORTH, SOUTH, EAST
    and WEST.
  DESC

  self.exit_north = :living_quarters
  self.exit_south = :shadowy_tunnel
  self.exit_east  = :tcorridor2
  self.exit_west  = :tcorridor4

  self.script_enter = <<-SCRIPT
    if get_root.find(:tape_player).playing && get_room.find(:microphone).unplayed
      puts "ZZZZZZZAANG!..The sound of metal sliding over metal and a DAZZLING BEAM of LIGHT from the SOUTH..\n\n"

      get_room.find(:microphone).unplayed = false
      doors = get_root.find(:sliding_doors)
      doors.unlocked = true
      doors.presence = "Huge OPEN metal sliding doors"
      doors.desc = nil
    end

    return true
  SCRIPT

  scenery(:microphone, 'microphone') do
    self.presence = "Microphone"
    self.unplayed = true
  end
end

room(:tcorridor2) do
  self.desc = <<-DESC
    I've reached the THIRD LEVEL in a TWISTING TUBULAR WALKWAY leading
    EAST/WEST. A small compartment is NORTH. SOUTH leads into the LIFT.
  DESC

  self.exit_south = :lift1d
  self.exit_west  = :tcorridor1
  self.exit_east  = :tcorridor3
  self.exit_north = :armoury

  self.scenery(:glass_case, 'case') do
    self.presence = "Glass case"
    self.desc = <<-DESC
      IN CASE OF DESPERATE FRUSTRATION<br>
      *BREAK GLASS*
    DESC
    # TODO: Break glass
  end
end

room(:tcorridor3) do
  self.desc = <<-DESC
    The WALKWAY seems to get steeper here as it continues EAST & WEST. There's
    a HUGE PASSAGE to the NORTH.
  DESC

  self.exit_west  = :tcorridor2
  self.exit_north = :computer_room
  self.exit_east  = :tcorridor4

  item(:tv_camera, 'camera', 'tv') do
    self.presence = "TV Camera"
    self.desc = <<-DESC
      The LENS seems to be scanning along that CORRIDOR to the NORTH.
      I don't like the look of that.
    DESC

    self.covered = false
  end
end

room(:tcorridor4) do
  self.desc = <<-DESC
    The WALKWAY twists on EAST and WEST and meets up with another gangway NORTH.
    There is a gentle humming sound.
  DESC

  self.exit_north = :power_distribution
  self.exit_east  = :tcorridor1
  self.exit_west  = :tcorridor3
end

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

# The void room is a place to put all the nodes which have no natural place
# in the game world.
room(:void) do
  self.desc = "You are in the void - how did you get here?"
  self.short_desc = "The Void"

  item(:mover, 'mover', 'metallic') do
    self.presence = "The mover is here."
  end

  item(:tube_car, 'car') do
    self.presence = "Travel-Tube car"
    self.script_enter = <<-SCRIPT
      get_root.move(:player, :carriage)
      return false
    SCRIPT
  end

  scenery(:pockets, 'pocket') do
    self.script_examine = <<-SCRIPT
      if self.children.nil?
        return false
      else
        puts "You look through the pockets and see a card!"
        self.open = true
        get_root.find(:dead_body).presence =
          "Dead body - with pockets hanging out"
        get_root.move(:plastic_card, parent)
        return false
      end
    SCRIPT
    item(:plastic_card, 'card', 'plastic') do
      self.usage = 5

      self.desc = <<-DESC
        TRAVEL PERMIT issues to and for use of secret agent -
        SIGNED -"MAJOR I.RON.FOIL"
      DESC

      self.short_desc = "Plastic card"
      self.presence = "Plastic card"

      self.script_use = <<-SCRIPT
        if args[0].nil?
          puts "Insert it where?"
          return false
        elsif args[0].tag == :smallslot
          if get_room.open
            puts get_room.short_desc
            return false
          elsif usage == 0
            puts "A metallic voice - SORRY - YOU HAVE USED"
            puts " UP YOUR TRAVEL PERMIT - PLEASE REPORT TO"
            puts "HEAD OFFICE & SIGN FOR NEW CARD - THANKYOU"
            return false
          else
            self.usage -= 1

            puts "SHHHHH...sliding doors close."
            puts "The car hurtles along the tunnel at high speed"
            puts " and then jolts to a halt"
            puts "POING! Card pops out."

            dest = get_root.find(:tube_car).get_room.destination
            get_root.move(:tube_car, dest, false)

            return false
          end
        elsif args[0].tag == :officeslot
          get_root.move(:plastic_card, :void)

          puts "a metal ARM drops down revealing a FORM."
          puts "Metallic voice- 'THANK YOU SIR - SIGN FOR YOUR NEW CARD'"

          get_root.move(:form, :head_office)

          return false
        else
          puts "You can't put that there."

          return false
        end
      SCRIPT
    end
  end

  item(:form, 'form') do
    self.presence = "Paper form"
    self.desc = ""

    # TODO: How do you know about I.ron Form's signature
    self.script_sign = <<-SCRIPT
      if !get_room.find(:fountain_pen)
        puts "With what? My bare hands?"

        return false
      end

      if !get_room.find(:fountain_pen).filled
        puts "It's EMPTY Ed!"
      else
        puts "You forge I.Ron Foil's signature!"

        puts "a NEW CARD pops out of the machine and it switches off..."

        get_root.move(:form, :void)
        get_root.move(:plastic_card, :head_office)
        get_root.find(:plastic_card).usage = 6
      end
    SCRIPT
  end

  scenery(:melted_metal, 'metal') do
    self.presence = "melted metal fork"
  end

  item(:flour, "flour", "bag of") do
    self.presence   = "Bag of Flour"
    self.short_desc = "Bag of Flour"
  end

  item(:bowl_of_mixture, 'bowl', 'mixture') do
    self.presence   = "Bowl of pancake mixture"
    self.short_desc = "Bowl of pancake mixture"
  end

  item(:pancake, 'pancake') do
    self.presence   = "Pancake"
    self.short_desc = "Pancake"

    self.script_throw = <<-SCRIPT
      puts "Wheee..."
      puts "Splat Goodshot!"
      get_root.move(:pancake, :void)
      get_root.find(:tv_camera).covered = true
      get_root.find(:tv_camera).presence = "TV Camera (Pancake covering lens)"
    SCRIPT
  end

  item(:fountain_pen, 'pen', 'fountain') do
    self.presence = "Fountain pen"
    self.desc = "It's Empty Ed!"
    self.filled = false

    self.script_fill = <<-SCRIPT
      if get_room.find(:ink)
        puts "OK"

        self.filled = true
        self.presence = "Fountain pen (full of ink)"
        self.short_desc = "Fountain pen (full of ink)"
        self.desc = nil
        get_root.move(self, :murky_depths)
      end
    SCRIPT
  end

  item(:connected_suit, 'suit') do
    self.presence   = "Diving suit (with Air Bottle Attached)"
    self.short_desc = "Diving suit (with Air Bottle Attached)"
    self.fixed = true
  end

  item(:ink, 'ink') do
    self.presence = "Clouds of ink"
    self.fixed = true
  end

  item(:wood, 'wood') do
    self.presence = "Length of strong wood"
    self.desc = "LEVER & LEVER & SONS - MAST MAKERS"
  end

  item(:rusty_ball, "ball") do
    self.presence = "Rusty ball"
    self.short_desc = "Rusty ball"
    self.desc = "Round and black"

    self.script_throw = <<-SCRIPT
      if self.get_room.tag == :plank_platform
        puts "Ball hits the other end of SEESAW..."
        sleep 1
        puts "Wheeeee!!!"
        sleep 1
        get_root.move(:rusty_ball, :plank_platform)
        get_root.move(:player, :warhead_platform)
      end
    SCRIPT
  end

  item(:seesaw, "seesaw") do
    self.presence = "Seesaw"

    self.script_walk = <<-SCRIPT
      if parent.tag == :player
        puts "Drop it first Ed!"
      elsif parent.tag == :launch_pad
        get_root.move(:player, :plank_platform)
      else # if not in the right room
        puts "Not just yet Ed!"
      end
    SCRIPT
  end
end

room(:walkway) do
  self.exit_east = :food_farm
  self.desc = <<-DESC
    I am in a LARGE TUBULAR WALKWAY. Through the transparent walls of the
    tube I can see the murky depths of the ocean. The walkway stretches EAST.
  DESC
  self.short_desc = "Large Tubular Walkway."

  item(:brief_case, 'briefcase', 'case') do
    self.openable   = true
    self.short_desc = "A briefcase."
    self.presence   = "Briefcase"

    #TODO Open briefcase doesn't work as the game does, moving items to parent
    item(:documents, 'documents') do
      self.desc = <<-DESC
      oo TOP SECRET TELEX MESSAGE oo
      We have captured another sub but
      all other personel have had to
      leave due to a strange epidemic.
      I have managed to neutralize the
      disease but still feel very ill.
      I have left the central computer
      in control of the base in case I
      don't make it. The missile aimed
      at the British base will fire as
      planned. MESSAGE ENDS - SPY BASE
      DESC
      self.short_desc = "Documents"
      self.presence = "Documents"
    end
  end

  item(:dead_body, 'body') do
    self.fixed = true
    self.short_desc = "Dead body."
    self.presence   = "Dead body"
    self.desc = "No signs of life - perhaps his pockets..."
    self.script_get = <<-SCRIPT
      puts "Thanks-but NO THANKS!"
      return false
    SCRIPT
    self.script_examine = <<-SCRIPT
        get_root.move(:pockets, parent, false)
        return true
    SCRIPT
  end

  player
end

room(:warhead) do
  self.short_desc = "warhead"
  self.desc = <<-DESC
    I am sitting on top of the WARHEAD.
    If the missile fired now I'd get home a bit quicker than I'd planned!
    A ladder leads DOWN.
  DESC

  self.exit_down = :warhead_platform
end

room(:warhead_platform) do
  self.short_desc = "platform"
  self.desc = <<-DESC
    I am now high up on the WARHEAD PLATFORM.
    A small ladder leads UP & the LAUNCH PAD
    is quite a long JUMP below.
  DESC

  self.exit_up   = :warhead
  self.exit_down = :launch_pad

  self.script_jump = :launch_pad

  # Items
  scenery(:beam_of_light, "beam") do
    self.presence = "Thin beam of light"
    self.desc = "On reflection, I'd rather not.."

    self.script_reflect = <<-SCRIPT
      puts "THE BEAM IS REFLECTED BACK BY THE FOIL AND GOES OUT!!"
      get_root.move(:beam_of_light, :void)
      get_root.find(:nuclear_missile).active = false
    SCRIPT
  end
end

room(:electronic_workshop) do
  self.exit_south = :corridor3
  self.desc = "This is the ELECTRIC WORKSHOP. The only exit is SOUTH from here."
  self.short_desc = "Workshop."

  item(:tape_player, 'player') do
    self.presence = "Tape player."
    self.short_desc = "Tape player."
    self.desc = <<-DESC
      Mitsu-tachi recorder - Insert cassette
    DESC

    self.playing = false
  end
end

end