require 'mixlib/cli'

module Mysql2xxxx
  class Cli
    include ::Mixlib::CLI
    %w{ user password host Port database }.each do |o|
      option o.downcase.to_sym,
        :short => "-#{o[0,1]} #{o.upcase}",
        :long  => "--#{o.downcase}=#{o.upcase}",
        :description => "Set MySQL #{o.downcase}"
    end
    option :spark,
       :short => '-s',
       :long => '--spark',
       :description => "Output is one JSON object per line, for example to input into Spark and Hadoop",
       :required => false
    option :execute,
           :short => '-e EXECUTE',
           :long  => '--execute=EXECUTE',
           :description => 'The SQL statement to execute'
    option :execute_file,
           :short => '-f EXECUTE_FILE',
           :long  => '--execute-file=EXECUTE_FILE',
           :description => 'File containing the SQL statement to execute'
    option :help,
      :long => "--help",
      :description => "Show this message",
      :on => :tail,
      :boolean => true,
      :show_options => true,
      :exit => 0
  end
end
