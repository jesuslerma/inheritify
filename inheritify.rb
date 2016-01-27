require 'thor'
require 'erb'
require 'rspec_kickstarter'

class Inheritify < Thor
	include Thor::Actions
	desc "create CLASS_NAME CONTALINK_DIR" , "CLASS_NAME is the name of the new class extending 
		Contalink::Entries::Entry, CONTALINK_DIR is where contalink project is living"
	long_desc <<-LONGDESC
		`entry.rb inherit` will generate a inherit class of Contalink::Entries::Entry
		with the class name that you indicates stored in 
		~/path_to_contalink/lib/contalink/entries/ folder.
	LONGDESC
	option :template_file
	option :project_dir
	option :spec_dir
	def inherit(file_name)
		contalink_dir = options[:project_dir]
		template_file = options[:template_file]
		spec_dir = options[:spec_dir]
		file_path = "#{contalink_dir}/#{file_name}.rb"
		template = ERB.new File.new(template_file).read, nil, "%"
		@class_name = file_name.split('_').map{|word| word.capitalize}.join('')
		
		create_file file_path do
			template.result binding
		end
		generator = RSpecKickstarter::Generator.new(spec_dir)
    generator.write_spec(file_path, false, false)
	end
end

Inheritify.start(ARGV)