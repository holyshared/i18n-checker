require 'forwardable'

module I18nChecker
  module Cache
    class Files
      attr_reader :caches

      def initialize(caches = {})
        @caches = caches
      end

      def read(file)
        return caches[file] if caches.key?(file)
        caches[file] = Lines::of(::File.read(file))
        caches[file]
      end
    end

    class Lines
      extend Forwardable

      include Enumerable

      attr_reader :lines

      def_delegators :lines, :size, :each

      class << self
        def of(source)
          lines = {}
          source.split("\n").each_with_index do |content, i|
            line_number = i + 1
            lines[line_number] = Line.new(line_number, content)
          end
          last_key = lines.keys.last
          lines.delete last_key if lines[last_key] == ''
          new(lines)
        end
      end

      def initialize(lines = {})
        @lines = lines
      end

      def line_of(line_number)
        lines[line_number]
      end

      def lines_of(range)
        results = {}
        raise StandardError, "invalid line number #{range.first}" if range.first <= 0
        raise StandardError, "invalid line number #{range.last}" if lines.size < range.last
        range.each do |i|
          results[i] = lines[i]
        end
        self.class.new(results)
      end
    end

    class Line
      attr_reader :line, :content

      def initialize(line_number, content)
        @line = line_number
        @content = content
      end
    end
  end
end
