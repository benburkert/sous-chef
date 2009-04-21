require 'open-uri'
instance_type(open('http://169.254.169.254/latest/meta-data/instance-type').gets) unless attribute?('instance_type')

if instance_type == 'c1.medium'
  #Add attributes specific to c1.medium instance here
end