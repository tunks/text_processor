# TextProcessor
Simple Anagram text processor

1. Implemented  text stream classes(FileStream and InputStream) to handle and parse file and stdin texts respectively.
   Text is read line by line(avoid loading entire file or text into memory at once)

2. Implemented a Processor class using Strategy pattern: responsible for managing different context classes such as WordSequence and other context instances

3. WordSequence: a class that performs the word count sequence

   Algorithm:

         1.(Hash approach) 
           1.1. use a regex to split the line of text read from a text stream

           1.2. use the Enumerator each_cons(number) method to group the words into 3 word-sequence
              alternative: 

               1.2.1. without each_cons(number) method
                  h = Hash.new(0)
                 (words.length-number - 1).times do | i|
                   key = words[i..(i+number-1)].join(" ") 
                   h[key] =+ 1 
                  end

           1.3. iterator through the sequences and map each sequence word as hash-key and the occurrence as value 

        2. Other types of  algorithms and data structure can be used such as (suffix ,Markev  Chainng probability)

        3. We could use map/reduce  approach either using Hadoop libraries for distributed large or data set
                     
4. More context classes can be add and extended easily  
    Example:   
     class NewContextClass
          
          def process(stream)
          end
        
          def generate
          end
           ....
     end

     TextProcessor::Processor.new(new NewContextClass.new())

5. To run 
   5.1 chmod +x app.rb 

   5.2  The app.rb can be executed  in the following ways below:
        ./app.rb texts/0 text/4
        cat texts/0  texts/1 | ./app.rb
        cat texts/0  texts/1 | ./app.rb texts/0 text/4

   5.3 test cases
       run rspec  

## Contributing

1. Fork it ( https://github.com/[my-github-username]/text_processor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
