require 'stringio'
#testing TextApp class
describe TextProcessor::TextApp do
   before(:each) do
       @processor = TextProcessor::Processor.new(context,output_type_as)
       text_app.run(@processor)
   end
   #set the limit
   let(:limit){
     100
   }
  
   let(:context) {
     TextProcessor::WordSequence.new(limit)      
   }
  
   let(:text_app){
       TextProcessor::TextApp.new(argv,stdin)
   }
     
   let(:stdin){
       StringIO.new("Please come to the terminal, 
                   \nand make a call to your girl friend telling him are not coming for the Christmas\n
                    and make A caLL! to your family and then a suprise trip your parent's house#")
     }
   
   let(:argv){
     %w(texts/0)
   }
   
   let(:output_type_as){
       {:format => :save_to_file,
        :filename => "outputs/output_#{text_app.object_id}"
        }
      }
   #stdin input such as cat texts/0 | ./solution.rb
   context "stdin input" do  
     it "it expects a stdin input and determines that the text stream object is created" do
      expect(@processor.text_streams).not_to be_empty
     end
   end
   #generate and save the data to an out put file
   context "generate the output to file" do    
        it "its save generated output to file" do
            expect(File.exist?(output_type_as[:filename])).to eql(true)
        end
   end
end

