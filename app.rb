#!/usr/bin/env ruby
require './lib/text_app'
require './lib/text_processor'

#initialize Text app class with ARGVS and stdin parameters
app = TextProcessor::TextApp.new(ARGV,$stdin)
#instantiate the processor class 
processor = TextProcessor::Processor.new(TextProcessor::WordSequence.new(100))
#app instance runs the processor object
app.run(processor)
