# coding: utf-8   
 
Unsupported_formats = [".gif",".png",".jpg",".jpeg",".ttf",".otf"] 

def edit_file(file) 
  file_text = File.readlines(file)
  file_text.each {|f| f.gsub!(@oldChar,@newChar)} 
  File.open(file, 'w') {|f| f.puts file_text}  
end      


def replace_tabs_in_file(file) 
  extension = File.extname(file) 
  unless Unsupported_formats.include?(extension)
    if @selected_formats.length == 1 && @selected_formats.first == '.'
      edit_file(file) 
    else
      if @selected_formats.include?(extension)
      edit_file(file) 
      end 
    end  
  end   
end 

def replace_tabs_in_folder(folder) 
  Dir.chdir(folder) do
    files = Dir.glob('*') 
    files.each do |x|
      unless x == '.' || x == '..'  
        replace_tabs_in_file(x) unless File.directory? x 
        replace_tabs_in_folder(x) if File.directory? x 
      end
    end
  end  
end   

def ask_questions
  p "What is the character, that you want to remove?"
  @oldChar = STDIN.gets.chomp
  p "What is the character, that you want instead of old one?"
  @newChar = STDIN.gets.chomp   
  p "Please select file formats, that you want to edit (rb,js,html,haml... etc)."
  p "And press ENTER 2 times."  
  @selected_formats = []

  format = ''
  while format != '.' do
  format = '.' + STDIN.gets.chomp.gsub('.','').to_s
  @selected_formats << format
  end
end 

def edit_documents
  ARGV.each do |a|
    replace_tabs_in_folder(a) if File.directory? a
    replace_tabs_in_file(a) unless File.directory? a
  end 
end 

def say_good_bye 
  p 'Done! Thank you for using this programm.' 
  p 'Good luck!'
end



ask_questions
edit_documents
say_good_bye





