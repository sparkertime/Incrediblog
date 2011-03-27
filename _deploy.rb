Dir.glob('mnt/**/*').each do |entry|
  File.exists?(entry) ? File.delete(entry) : Dir.delete(entry)
end
