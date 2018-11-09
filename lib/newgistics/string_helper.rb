module Newgistics
  class StringHelper
    CAMEL_CASED_STRING_REGEX = /([a-z])([A-Z])/
    UNDERSCORED_STRING_REGEX = /([a-z\d]+)([A-Z]_|\z)/
    CAPITALIZED_STRING_REGEX = /\A[A-Z]/

    def self.camelize(string, upcase_first: true)
      string.to_s.dup.tap do |s|
        if upcase_first
          s.sub!(/^[a-z\d]*/) { |match| match.capitalize }
        else
          s.downcase!
        end
        s.gsub!(/(?:_|(\/))([a-z\d]*)/i) { $2.capitalize }
      end
    end

    def self.underscore(string)
      string.to_s.dup.tap do |s|
        s.gsub!(CAMEL_CASED_STRING_REGEX) { "#{$1}_#{$2}" }
        s.downcase!
      end
    end
  end
end
