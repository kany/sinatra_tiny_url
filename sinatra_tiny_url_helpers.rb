require 'facets'

module SinatraTinyUrlHelpers

  include Rack::Utils
  alias_method :h, :escape_html

  VALID_CHARACTERS = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'

  BAD_WORDS = %w{
    foo
    bar
  }

  def get_new_code(length)
    string_proc = string_generator(length)

    code = random_string(length, &string_proc)

    is_valid?(code) ? code : get_new_code(length)
  end

  private

  def is_valid?( code = nil )
    !code.nil? &&
    !Redis.new.keys.include?( "links:#{code}" ) &&
     Redis.new.keys.collect{|k| k.gsub('links:','')}.
      select{|k| k if k.similarity( code ) > 0.80 }.compact.empty? &&
    BAD_WORDS.select{ |word| word if code =~ /#{word}/ }.empty?
  end

  def random_string(length, &block)
    yield length if block_given?
  end

  def string_generator(length)
    Proc.new do|length|
      Array.new(length) {
        VALID_CHARACTERS[
          rand( VALID_CHARACTERS.length )
        ].chr
      }.join
    end
  end
end
