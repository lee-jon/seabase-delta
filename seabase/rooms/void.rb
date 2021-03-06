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
