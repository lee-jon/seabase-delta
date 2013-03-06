class Player < Node
  def do_fastern(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('fastern')
  end
  def do_unfastern(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('unfastern')
  end
end
