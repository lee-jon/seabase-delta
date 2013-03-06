class Player < Node
  def do_fasten(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('fastern')
  end
  def do_unfasten beltn(*words)
    item = get_room.find(words)
    return if item.nil?
    item.script('unfastern')
  end
end
