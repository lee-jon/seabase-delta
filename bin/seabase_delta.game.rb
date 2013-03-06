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


# Compiled 2013-03-06 17:58:42 +0000

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

Node.root do
self.intro = "Seabase delta, classic 1984 game by Firebird software"
self.help = "Use your 'ed Ed, & always EXAMINE things."
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
    self.presence   = "Briefcase."

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
    self.presence   = "Dead body."
    self.desc = "No signs of life - perhaps his pockets..."
    self.script_take = <<-SCRIPT
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
end