home = ENV['HOME']
pwd = Dir.pwd
path_map = 
  {
    'vim' => home+"/.vim",
    'vim/vimrc' => home+'/.vimrc',
    'tmux/tmux.conf' => home+'/.tmux.conf',
    'zsh/zshrc' => home+'/.zshrc',
    'git/gitconfig' => home + '/.gitconfig',
    'tmuxinator' => home + '/.tmuxinator'
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

task :submodules do
  puts "Updating git submodules"
  system('git submodule init')
  system('git submodule update')
  system('(cd vim && git submodule init && git submodule update)')
end
