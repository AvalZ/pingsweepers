#!/usr/bin/ruby

require 'ipaddr'

unless ARGV[0] then
  puts "A simple Ruby ping scanner."
  puts "Usage: #{$0} ip_range"
  puts "\tNOTE: ip_range should be in CIDR notation (192.168.1.1/24)"
  exit(0)
end 

ips = IPAddr.new(ARGV[0]).to_range

threads = ips.map do |ip|
  Thread.new do
    status = system("ping -q -W 1 -c 1 #{ip}", [:err, :out] => "/dev/null")
    Thread.current[:result] = ip.to_s if status
  end
end

threads.each do |t|
  t.join
end

threads.each do |t|
  next unless t[:result]
  puts t[:result]
end
