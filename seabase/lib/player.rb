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

