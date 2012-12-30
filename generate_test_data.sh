#!/bin/bash

./generator.rb counter=1,first_name,last_name,street_address,city,state,zip,phone 10000 > Students.table
./generator.rb counter=1,randfloat=4=2,randint=5=1 10000 > GPA.table
./generator.rb counter=1,major,bool=Yes=No,bool=Yes=No 10000 > Scholarships.table
