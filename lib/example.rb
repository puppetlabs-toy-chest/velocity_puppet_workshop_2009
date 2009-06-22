class Example
    attr_accessor :name

    def initialize(name)
        @name = name.sub("examples/", '').chomp

        unless FileTest.exist?(file)
            raise "Could not find example %s" % file
        end
    end

    def file
        File.join("examples", name)
    end

    def filetype
        case name
        when /\.pp/: "puppet"
        when /\.rb/: "ruby"
        when /\.mk/: "make"
        when /\.sh/: "bash"
        when /\.txt/: "text"
        else
            raise "Unknown File type for %s" %  file
        end
    end

    def output
        if filetype == "text"
            raise "Asked for the output of a text file"
        end

        unless respond_to?(filetype)
            raise "Cannot get output of %s files" % filetype
        end

        "<pre><code>" + send(filetype) + "</code></pre>"
    end

    def puppet
        %x{puppet #{file}}
    end

    def ruby
        %x{ruby #{file}}
    end

    def bash
        %x{bash #{file}}
    end

    def to_s
        name
    end
end

