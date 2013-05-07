room(:computer_room) do
  self.desc = <<-DESC
    
  DESC
  
  self.exit_south = :tcorridor3
  
  self.script_enter = <<-SCRIPT
    if get_root.find(:tv_camera).covered == true
      return true
    else
      return false
    end
  SCRIPT
end