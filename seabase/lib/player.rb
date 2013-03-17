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
end

