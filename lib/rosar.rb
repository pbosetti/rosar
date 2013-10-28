#!/usr/bin/env ruby
#
# Created by Paolo Bosetti on 2008-05-22.
# Copyright (c) 2008 University of Trento. All rights 
# reserved.
require 'singleton'
require 'rubygems'
require "rubyosa"

=begin rdoc
  Adds a to_r method to standara Arrays, which returns a String representation
  of the equivalent R array object.
=end
class Array
  def to_r
    "c(#{self * ','})"
  end
end

class Hash
  def to_r
    str = []
    self.each_pair do |k,v|
      case v
      when String
        str << "#{k}=#{v}"
      when Array
        str << "#{k}=#{v.to_r}"
      else
        str << "#{k}=#{v}"
      end
    end
    str * ", "
  end
end

=begin rdoc
  Usage example:
    r=ROSAR.instance
    a=[1,2,3]
    b=[4,5,6]
    r.transfer :a=>a, :b=>b
    r.plot :x=>:a, :y=>:b, :typ=>"'l'"
    r.grid  

  Example based on dataframes:
    df = {
      :x => [1,2,3,4],
      :y => [7,2,5.5,8]
    }
    r.data_frame :df, df
    r.attach :df
    r.plot :x=>:x, :y=>"y/2", :typ=>"'b'", :xlab=>"'Time (s)'"
    r.grid
    r.abline :h=>[2.5,3.5]
    r.detach :df
=end
class ROSAR
  include Singleton
  EXCHANGE = "rosar.exc"
  attr_reader :r, :console
  
  @@r = "" # command line to launch R
  def self.r= r_com
    @@r = r_com
  end
  
  def initialize(r="R")
    
    r = @@r unless @@r.empty?
    begin
      @r = OSA.app r
    rescue
      raise "Specify a valid command line to launch R-lang"
      exit
    end
    
    self.sync_dir
    self.activate
    # @console = @r.windows.select {|w| w.name =="R Console"}[0]
  end
  
  def minimize
    @console.miniaturized = true
  end
  
  def maximize
    @console.miniaturized = false
  end
  
=begin rdoc
  Sets the R's working directory to the current dir of the calling script.
=end
  def sync_dir(dir=Dir.getwd)
    @r.cmd "setwd('#{dir}')"
  end

=begin rdoc
  Brings R windows to foreground.
=end    
  def activate
    @r.activate
  end

=begin rdoc
  Transfers an Hash of Arrays to the R workspace. R object names are the 
  Hash symbols.
=end
  def transfer(vars)
    raise "Expecting a Hash" unless vars.class == Hash
    vars.each_pair do |k,v|
      @r.cmd "#{k.to_s}<-#{v.to_r}" if v.class == Array
    end
  end
  
=begin rdoc
  Transfers the Hash of Arrays +df+ to a dataframe named +name+. Uses a FIFO
  to move values around.
=end
  def data_frame(name, df, keep=false)
    File.open("#{EXCHANGE}", "w") do |f|
      f.puts df.keys*"\t"
      df[df.keys[0]].size.times do |i|
        df.each_key do |k|
          f.print "#{df[k][i] || 'NA'}\t"
        end
        f.puts
      end
    end
    @r.cmd "#{name}<-read.table('#{EXCHANGE}', h=T)"
    @r.cmd "unlink(\"#{EXCHANGE}\")" unless keep
  end
  
  def raw(cmd)
    @r.cmd(cmd)
  end
  
=begin rdoc
  Redirects +method+ to the underlaying OSA object.
=end
  def method_missing(method, *args)
    case args[0]
    when Hash
      @r.cmd("#{method}(#{args[0].to_r})")
    when Symbol
      @r.cmd("#{method}(#{args[0]})")
    when String
      @r.cmd("#{method}(#{args[0]})")
    when nil
      @r.cmd("#{method}()")
    end
  end
end
