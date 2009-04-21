require 'open-uri'
instance_type(open('http://169.254.169.254/latest/meta-data/instance-type').gets) unless attribute?('instance_type')

if instance_type == 'm1.xlarge'
  #Add attributes specific to a m1.xlarge instance here
end