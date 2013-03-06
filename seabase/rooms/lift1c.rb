room(:lift1c) do
  self.short_desc = "lift1c"
  self.desc = <<-DESC    
  DESC
  
  self.script_enter = <<-ENTER
    puts "Bottom floor"
    return false
  ENTER
end