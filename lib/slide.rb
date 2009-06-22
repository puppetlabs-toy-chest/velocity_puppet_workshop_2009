class Slide
    attr_accessor :name, :human_name

    def header
        "\n\n" + human_name + "\n" + ("=" * human_name.length) + "\n\n"
    end

    def initialize(name)
        @human_name = name

        name.chomp!
        @name = name.sub(/^\s+/, '').gsub(" ", "_") + ".markdown"

        unless FileTest.exist?(file)
            raise "Could not find slide %s" % file
        end
    end

    def file
        File.join("slides", name)
    end

    def mk_stub
        File.open(file, "w") do |f|
            f.puts "#{human_name}\n" + (human_name * "=")
        end
    end

    def text
        #header + ERB.new(File.read(file)).result(binding)
        header + File.read(file)
    end

    def to_s
        file
    end
end
