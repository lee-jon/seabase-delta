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
    if item.script('chew')
      puts "Sorry Ed, it's not possible to do that"
    end
  end
  
  def do_blow(*words)
    item = get_room.find(words)
    return if item.nil?
    if item.script('blow')
      return
    end
  end
end
