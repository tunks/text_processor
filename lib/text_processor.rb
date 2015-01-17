require "./lib/text_helper"
#Text proccessor modoule
#contains Processor class, Word proce
module TextProcessor 
  #Processor class is the main class containing the context instance (using strategy pattern)
  #responsible for processing the different type of context instance  such as the WordSequence,
  #and more context classes can easily be extended
  #constructor parameters is the type of processor(default is WordSequence and the input text streams 
  #only include filename when the format option is save_to_file
  #output_type{ format:  [:print_on_screen, :save_to_file], filename: "name of file"}
                
    class Processor
        attr_reader :text_streams
        def initialize(context = WordSequence.new, output_type = {:format => :print_on_screen}, text_streams = nil)
            @context = context
            @output_type = output_type
            @text_streams = text_streams
        end 
        
        #runs the process instance
        def run(text_streams = nil)  
            set_text_streams(text_streams) unless text_streams.nil?
            process_text_streams(@text_streams)
            generate_text_streams
        end
        
        #generate the expected result,
        #different output can be printed on screen or save to file such as print by setting the output type
        def generate_text_streams(output_type = @output_type)
            output = @context.generate
            case output_type[:format] 
               when :print_on_screen
                 print_on_screen(output)
               when :save_to_file
                 filename = output_type[:filename] || Time.now.to_i.to_s
                 save_to_file(output , filename)
               else
                 print_on_screen(output)
            end
        end
        
        #processing the text streams 
        def process_text_streams(text_streams = @text_streams)
            unless text_streams.nil? or text_streams.empty?
              text_streams.each do|stream|
                 process_text_stream(stream)    
              end
            end
        end
        
        def process_text_stream(text_stream)
            @context.process(text_stream)
        end
        
        def set_text_streams(text_streams)
            @text_streams = text_streams
        end
        
        private 
        include ProcessHelper 
   end

   #Word sequence class
   #performs the count and generating the output word sequence count
   class WordSequence
         include ProcessHelper      
         attr_accessor :word_sequences
         REGEX = /\p{Alnum}+/ 
         
         def initialize(limit = 3, count = 3 )
             @count = count
             @limit = limit
             @word_sequences = Hash.new(0)
         end
          
         #performs a partial frequency count of the sequence words
         def process(text_stream)  
             begin
              text_stream.parse_text.each_line do|text|
                  sequence(text).each do |item|
                    key = item.join(" ")
                    @word_sequences[key] +=  1
                  end
              end
             rescue Exception =>e 
               raise "Error reading text #{e.message}"
             end
         end
         
         #generates the output of the frequency count of the sequence words
         def generate
             most_frequency_words
         end
         
         def most_frequency_words(limit = @limit)
             @descending ||= sort_by_decending_value(@word_sequences)
             @descending.first((limit > @word_sequences.size)? @word_sequences.size: limit )  
         end
        
         private
         def sequence(text)
             text.strip.downcase.scan(REGEX).each_cons(@count)
         end       
   end   
end
