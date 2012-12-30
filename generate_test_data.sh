#!/bin/bash

ruby ./generator.rb counter=0,first_name,last_name,street_address,city,state,zip,phone 1000 > Students.csv
ruby ./generator.rb counter=0,randfloat=4=2,randint=5=1 1000 > GPA.csv
ruby ./generator.rb counter=0,major,bool=true=false,bool=true=false 1000 > Scholarships.csv
