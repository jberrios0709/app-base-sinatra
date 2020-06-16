module Services
  class Utils
    class << self
      def generate_string(length )
        Array.new(length){[*"A".."Z", *"a".."z", *"0".."9"].sample}.join
      end
    end
  end
end