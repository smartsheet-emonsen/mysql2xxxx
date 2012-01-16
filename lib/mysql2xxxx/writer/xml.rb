module Mysql2xxxx
  class XML < Writer
    def escaped_keys
      @escaped_keys ||= keys.map { |k| k.to_xs }
    end
    
    # sabshere 2/10/11 dkastner pointed out that this doesn't include metadata like later versions of mysql do
    # this matches the xml generated by "mysql --xml"
    # i tried to use builder, but the String#to_xs nonsense got in the way
    def to_file(f)
      f.write %{<?xml version="1.0" encoding="utf-8" ?>}
      f.write %{<resultset statement="#{config.execute.to_xs}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">}
      stream_arrays do |ary|
        f.write %{<row>}
        ary.each_with_index do |v, i|
          f.write %{<field name="#{escaped_keys[i]}"#{' xsi:nil="true"' if v.nil?}>#{v.to_s.to_xs}</field>}
        end
        f.write %{</row>}
      end
      f.write %{</resultset>}
      nil
    end
  end
end