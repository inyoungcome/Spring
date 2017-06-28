#!/usr/bin/ruby 
# -*- coding : utf-8 -*-
require 'ruby-pinyin'
require 'digest/md5'


#IO.foreach("user"){|block| p = PinYin.of_string(block) p.pack("a100a100a100")}
users = IO.readlines("user")

users.each{|item| PinYin.of_string(item)}



# return ['jie', 'cao']

#name = PinYin.of_string('盛中华').pack("a10a10a10")
while users.size != 0 do
    zhname=users.shift
    name = PinYin.of_string(zhname).join()
    #passwd= Digest::MD5.hexdigest(name)
    passwd= name.crypt('A@')
    puts "#{name}=#{passwd}" 
end



#item = "#{name}=#{passwd}"
#
#aFile = File.new("passwd", "r+")
#if aFile
#       aFile.syswrite(item)
#else
#       puts "Unable to open file!"
#end

