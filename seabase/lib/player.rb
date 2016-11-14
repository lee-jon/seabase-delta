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

    if get_room.find(:milk) && get_room.find(:flour) && get_room.find(:bowl) && get_room.find(:egg)
      puts "Dolup, Slop, Slush!"
      get_root.move(:milk, :void)
      get_root.move(:bowl, :void)
      get_root.move(:flour, :void)
      get_root.move(:egg, :void)
      get_root.move(:bowl_of_mixture, parent, false)
    else
      puts "Its not possible to do that" #TODO: Make this canonical
      return
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
end
