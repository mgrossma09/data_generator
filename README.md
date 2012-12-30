data_generator
==============

very simple tool to generate random data for testing

### Usage

~~~
Usage: ./generator.rb [--help|-h] [--separator|-s=<separator>] field_string count

      field_string consists of comma-separated values of:
            counter=START
            randint=RANGE=PLUS
            randfloat=RANGE=PRECISION
            bool=STRING1=STRING2
            prefix
            first_name
            last_name
            suffix
            street_address
            city
            zip
            state
            phone
            major

      --separator ....... separator for output fields, default = ,

Example: ./generator.rb first_name,city,major 10
~~~

### Example

~~~
./generator.rb counter=2,first_name,last_name,street_address,city,state,zip,phone,randint=10=1,randfloat=4=2,bool=Yes=No,major 10
2,Sheri,Gaines,8810 Hill St,Carson City,Nevada,23030,(110) 810 9008,7,3.02,Yes,Humanities
3,Rene,Richard,3068 Reese Pl,Cape Coral,Florida,41928,(952) 134 3577,3,1.3,Yes,Energy Systems Technology
4,Kristine,Davis,9894 Tran Blvd,Mesa,Arizona,60088,(968) 429 4091,4,1.87,Yes,Photography
5,Viola,Galloway,188 Ingram Ave,Aurora,Colorado,78980,(501) 084 2547,3,1.88,Yes,Electrical Technology
6,Bobby,Carroll,8972 Chapman St,Sierra Vista,Arizona,33353,(656) 876 5987,5,0.17,No,Psychology
7,Muriel,Nichols,5610 Sharpe St,Columbus,Georgia,38368,(897) 263 1160,7,1.41,No,Military Technology Leadership
8,Tiffany,Webster,754 Mccray Blvd,Columbia,South Carolina,31619,(630) 800 9926,6,2.92,Yes,Military Technology Leadership
9,Cheryl,Witt,2683 Baxter Ave,Lincoln,Nebraska,31388,(392) 079 1375,3,3.22,No,Personal Fitness Training
10,Kirk,Barrett,2002 Woodward St,Henderson,Nevada,68626,(640) 938 5370,6,3.91,No,Accounting
11,Joann,Bryant,9167 Maxwell Blvd,Nashville,Tennessee,28608,(432) 736 1747,2,0.46,No,Political Science
~~~

### Notes

- the generated data is random, zip codes, area codes and phone numbers don't necessarily match with location
- syntax for randint, randfloat, ... is ugly, will improve that soon
