$: << "lib"

require 'rake/clean'
require 'slide'
require 'example'

task :default => "project.html"

slides = File.readlines("order.txt").reject { |s| s =~ /^#/ }.collect { |s| Slide.new(s) }

CLEAN.include("project.markdown")
CLEAN.include("project.html")
CLEAN.include("project.css")
CLEAN.include("project.svg")
CLEAN.include("s6")

file "project.markdown" => ["project.info", slides, "order.txt", "Rakefile"].flatten do
    puts "Creating new project at project.markdown"
    File.open("project.markdown", "w") do |fh|
        fh.print File.read("project.info")

        slides.each do |slide|
            fh.print slide.text
        end
    end
end

file "project.html" => "project.markdown" do
    puts "Compiling presentation"

    output = %x{slideshow -t s6.txt project.markdown}
    if $? != 0
        puts output
        raise "Failed to create presentation"
    end
end
