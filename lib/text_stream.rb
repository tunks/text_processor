#text stream class
#acts as a handler for the text files and the stdin input string stream
module TextProcessor 
   #stdin input stream class
   class InputStream
     def initialize(stdin)
        @stdin = stdin
     end
    
     def parse_text
         parse_stdin
     end
     #load text from stdin
     def parse_stdin
         begin
           @stdin
         rescue Exception=>e
           raise "Error parsing stdin"
         end
     end
   end
   
   #file stream class
   class FileStream
    def initialize(file)
       @filename = file
    end
    
    def parse_text
        parse_file(@filename)
    end
      
    #load data from file
    def parse_file(file_name)
        begin
          open(file_name) 
        rescue Exception => e
          puts "Error parsing file: #{e.message}"
        end
    end
  end
end