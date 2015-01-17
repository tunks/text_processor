#helper module containing methods that can be utilized by other class
module TextProcessor 
   module ProcessHelper
      def save_to_file(data, filename)
          begin
            File.open(filename, "w+") do |f|
                f.puts data.inspect
            end
          rescue Exception => e
            puts "Failed to save data to file #{e.message}"
          end
      end 
      
      def print_on_screen(data)
          if data.is_a?(Array) || data.is_a?(Hash)
              data.each { |d| $stdout.puts d.inspect }
          else
              puts data.inspect
          end
      end
        
      def sort_by_decending_value(items)
          items.sort_by { |_, value| value }.reverse
      end
       
      def sort_by_ascending_value(items)
          items.sort_by { |_, value| value }
      end
      
      def group_words(items)
          items.group_by{|v| v}.map{|i,m|[i, m.length]}
      end
   end  
end