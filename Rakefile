home = ENV['HOME']
pwd = Dir.pwd
path_map = 
  {
    'vim' => home+"/.vim",
    'vim/vimrc' => home+'/.vimrc',
    'tmux/tmux.conf' => home+'/.tmux.conf'
  }
task :default do
  path_map.each do |key, dest|
    key = pwd + '/' + key
    begin
      existing = File.readlink dest
      if(existing == key)
        puts "#{dest} is correct"
      else
        puts "backing up " + dest + " to " + dest + '.bak'
        `mv #{dest} #{dest}.bak`
        puts "adding symbolic link from " + key + " to " + dest
        File.symlink(key, dest)
      end
    rescue
      puts "not a symbolic link"
      puts File.exists? dest
      if(File.exists? dest) 
        puts "backing up " + dest + " to " + dest + '.bak'
        `mv #{dest} #{dest}.bak`
      end
      puts "adding symbolic link from " + key + " to " + dest
      File.symlink(key, dest)
    end
  end
end
