# Small RakeFile that builds a single game file

task :default do
  puts "No default task - use rake build to create the file"
end

task :build do
  puts "Creating new file"
  game_file = File.new("bin/seabase_delta.game.rb", "w+")

  puts "Adding custom verbs"
  game_file << File.read('seabase/lib/header.rb')+ "\n"
  game_file << "\# Compiled #{Time.now}\n\n"
  game_file << File.read('seabase/lib/player.rb')+ "\n"

  puts "Creating root node"
  game_file << "Node.root do" + "\n"
  game_file << File.read('seabase/lib/root.rb') + "\n"
  
  puts "  Adding rooms"
  rooms = FileList['seabase/rooms/*.rb']
  rooms.each do |r|
    puts "    adding #{(r.gsub('.rb', ''))}"
    game_file << File.read(r) + "\n"
  end
  
  puts "  Rooms Finished"
  puts "Closing root node"
  game_file << "end"
  game_file.close
end