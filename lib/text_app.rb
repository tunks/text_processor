require './lib/text_stream'

module TextProcessor 
  #main application class that will run the process instance
  #constructor parameters
  #argv => file argument inputs, stdin => standard input arguments
   class TextApp
      attr_accessor :text_streams
      def initialize(argv = nil, stdin = nil)
          create_text_streams(argv, stdin)
      end 
      #create text stream handlers
      def create_text_streams(argv, stdin)
          @text_streams ||= []
          #creates the file stream objects
          argv.each{|arg| @text_streams<< FileStream.new(arg)} unless argv.nil? or argv.empty?
          #creates the stdin stream object
          @text_streams << InputStream.new(stdin) unless stdin.nil? or stdin.tty?
      end
      #runs the text processor process 
      def run(processor = Processor.new)
          begin
             processor.run(@text_streams)
          rescue Exception => e
             puts "Failed to run the text processor #{e.message}"
          end
      end
   end
end
