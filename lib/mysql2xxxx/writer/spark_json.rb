require 'Oj' # This causes multi_json to use the "Oj" JSON library. We need this to cause BigDecimal numbers to be output properly
require 'multi_json'

module Mysql2xxxx
  class SparkJSON < Writer
    def to_file(f)
      client.query(last_statement, :stream => true, :cache_rows => false).each do |hsh|
        next if hsh.nil?
        # :bigdecimal_as_decimal is an Oj-specific option
        f.write ::MultiJson.dump(hsh,{:bigdecimal_as_decimal => true})
        f.write "\n"
      end
      nil
    end
  end
end
