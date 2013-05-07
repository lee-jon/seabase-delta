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
    
    if get_room.find(:milk) && get_room.find(:flour) && get_room.find(:bowl)
      puts "Dolup, Slop, Slush!"
      get_root.move(:milk, :void)
      get_root.move(:bowl, :void)
      get_root.move(:flour, :void)
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
end

