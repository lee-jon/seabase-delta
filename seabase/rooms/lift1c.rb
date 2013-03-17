room(:lift1c) do
  self.short_desc = "lift1c"
  self.desc = <<-DESC    
  DESC
  
  #TODO This shoud be removed
  self.script_enter = <<-ENTER
    puts "Bottom floor\n"
    return false
  ENTER
end