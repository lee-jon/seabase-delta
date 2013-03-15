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


# Compiled 2013-03-15 20:20:56 +0000

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
  
  def do_blow(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('blow')
  end
  
  def do_short(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('short')
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
end


Node.root do
self.title = "seabase"
self.intro = "Seabase delta, classic 1984 game by Firebird software"
self.help  = "Use your 'ed Ed, & always EXAMINE things."
room(:airlock) do
  self.desc = "I am in the AIRLOCK."
  self.short_desc = "Airlock."
  item(:wheel, 'wheel') do
    self.presence = "Wheel"
  end
  item(:sign, 'sign') do
    self.presence = "Sign"
  end
end
room(:at_long_table) do
  self.exit_west = :food_farm
  self.short_desc ="Long Table"
  self.script_enter = <<-SCRIPT
      puts "WHEEEEEE!!!"
      puts "You slide majestically across the room on the seaweed."
      puts "Feet won't grip!"
      puts ""
      puts "What's that on the TABLE?"
      puts "You slide past the table back to the entrance of the room.."
      puts ""

      return false
  SCRIPT
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
    self.desc = "There's a hose fitted"
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
      puts "In case of ELEVATOR breakdown contact MISS. ISLES on 199"
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
    dimly lit alcove to the south.
  DESC
  
  self.exit_west  = :corridor3
  self.exit_east  = :corridor1
  self.exit_south = :lift1
  
  scenery(:chute, 'chute') do
    fixed = true
    presence = "Large metal chute (sloping up)"
    
    self.desc = <<-DESC
      Nasty smell of rubbish
    DESC
    self.script_enter do
      puts "You slide back down. It's too steep."
      return false
    end
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
room(:dinning_room) do
  self.short_desc = "dining_room"
  self.desc = <<-DESC
    The DINNING ROOM AREA. Walkways lead NORTH EAST and WEST.
  DESC
  
  self.exit_north = :fcorridor2
  self.exit_east  = :kitchen
  self.exit_west  = :laundry
  
  item(:flippers, 'flippers', 'sure-grip') do
    self.presence = "Pair of \"Sure Grip\" Flippers"
    self.desc = <<-DESC
    DESC
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
      #TODO - when you wear suit it checks for air and says
      # "Not until you have some AIR matey!"
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
  self.short_desc = "fcorridor2"
  self.desc = <<-DESC
    As the CORRIDOR continues EAST/WEST, I begin to with I was still on the
    SUB'. At least the gangwaus were straight!
    There are also compartments to the north and south.
  DESC
  
  self.exit_south = :dinning_room
  self.exit_north = :surgery
  self.exit_east  = :fcorridor3
  self.exit_west  = :fcorridor1
  
  # Logic
  
  # Items
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
    self.presence = "switch"
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
      self.desc = "It is asleep"
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
    A brightly lit passage leads off NORTH
  DESC
  
  self.exit_north = :fcorridor4
  
  item(:auto_clerk, 'auto-clerk') do
    self.presence = "auto-clerk"
    self.desc = ""
    
    item(:officeslot, 'slot') do
      self.fixed = true
      self.short_desc = "small slot"
      self.presence = "small slot"
    end
  end
end
room(:kitchen) do
  self.short_desc = "kitchen"
  self.desc = <<-DESC
    I am in a well ised KITCHEN. Exit is WEST.
  DESC
  
  self.exit_west = :dinning_room
  
  item(:shelves, 'shelves') do
    self.presence = "Shelves"
    self.script_examine = <<-SCRIPT
      #examining shows bag of flour
    SCRIPT
  end
  item(:hotplate, 'hotplate') do
    self.presence = "Hotplate"
  end
  item(:fridge, 'fridge') do
    self.presence = "Fridge"
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
  end
  
  item(:washing_line, 'line') do
    self.presence = "Washing line"
    self.desc = "It's LONG....but not that STRONG.."
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
    puts "Shhh doors close. Lift ascends."
    puts "Doors open."
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

  self.exit_down = :lift1b

  self.script_enter = <<-SCRIPT
    puts "PING! OH BLOW! button keeps popping out!
    puts "I need something to STICK it.."
    return false
  SCRIPT
end

room(:lift2) do
  self.short_desc = "Lift 2"
  self.desc = <<-DESC
    Sea-Base Lift Number >2<. The EXIT is to the NORTH.
  DESC
  
  self.exit_north = :corridor2

  item(:floor_panel, 'panel') do
    fixed = true
    self.desc = "It can be OPENED but It's LOCKED!"
    self.presence = "Floor panel"
    #TODO: This is openable but doesn't have the script
  end

  item(:lift2_buttons, 'buttons') do
    fixed = true
    self.presence = "Row of buttons"    
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
      self.desc = "Smooth sheet of Aluminium cooking foil."
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
room(:station_alpha) do
  self.destination = :station_beta
  self.desc = <<-DESC
    I am on a platform at STATION "ALPHA"
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
  item(:hatch, 'hatch') do
    self.openable = true
    self.script_enter = <<-SCRIPT
      puts "Bang! Hatch slams shut!"
      get_root.move(:player, :airlock)
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
    I am on a platform at STATION "FOXTROT"
  DESC

  self.destination = :station_alpha

  item(:screwdriver, 'screwdriver') do
    self.short_desc = "Screwdriver"
    self.presence = "Screwdriver"
  end
end
room(:surgery) do
  self.short_desc = "surgery"
  self.desc = <<-DESC
    I'm in the doctors surgery. Exit is South
  DESC
  
  self.exit_south = :fcorridor2
  
  item(:thermometer, 'thermometer') do
    self.presence   = "thermometer"
    self.short_desc = "thermometer"
    self.desc = <<-DESC
      104 degrees! Wow! This adventure must have really fired
      your imagination!
    DESC
  end
end
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
        elsif args[0].tag != :smallslot
          puts "You can't put that there."

          return false
        elsif get_room.open
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
      SCRIPT
    end
  end
  
  scenery(:melted_metal, 'metal') do
    self.presence = "melted metal fork"
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
  end
end
end