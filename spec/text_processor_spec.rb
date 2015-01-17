require 'spec_helper'

describe TextProcessor do
  #shared context to count the number of occurrence of a specific word sequence
  #parameters includes the following
  #example, see below:
  #words => "call me when" is the word sequence, 
  #files => %w(texts/0 texts/1) is the array of files
  #expected_value => 1 is the expected value
  #it_should_behave_like "a counter", "call me when", %w(texts/0 texts/1), 1
   shared_context "a counter" do |words, files, expected_value|
      before(:each){
        @word_processor = TextProcessor::WordSequence.new
        TextProcessor::Processor.new(@word_processor).process_text_streams(text_streams)
      }

      let(:text_streams){
        files.map {|file| TextProcessor::FileStream.new(file) }
      } 

      let(:word_sequences){
        @word_processor.word_sequences[words]
      }
         
      it "to count the number of occurrence of \"#{words}\" in #{files} " do
        expect(word_sequences).to eql(expected_value)
      end
    end
    
    describe "word sequence " do
      context "appears in files texts/0, texts/1\n" do
        it_should_behave_like "a counter", "call me when", %w(texts/0 texts/1),2
      end
      
      context "does not appear in texts/2 texts/3\n" do
         it_should_behave_like "a counter", "call me when", %w(texts/2 texts/3),0
      end
      
      context "appears in big files texts/big.txt\n" do
         it_should_behave_like "a counter", "the united states", %w(texts/big.txt), 383
      end
    end
end
