##Zendesk ticket CSV append
This will take a downloaded CSV report from Zendesk and create a new file with this "-with-comments.csv" append to the file name. The tickets' description and comments are appeneded to the row in the new file. The new file isn't technically comma separated value file because instead of using commas the pipe symbol '|' is used. This is to deal with the issue of commas and quotes used in ticket comments. Each comment will be predicated with the author name and a colon. A exmaple 

>>"1"|"4"|"matthew"|"4128378"|""|""|""|"matthew"|"matthew"|"Support"|"testing new email format"|"email"|"Closed"|"Low"|"Web form"|"Task"|"2009-09-01 19:02"|"2009-09-07 21:30"|"2009-09-01 19:02"|""|"2009-09-04 12:00"|"2009-09-01 19:02"|"2009-09-03 21:07"|"50"|"Not Offered"|""|""|""|""|""|""|""|""|""|""|""|""|""|""|"-"|"-"|"-"|"-"|"-"|"-"|"-"|"-"|"-"|"-"|"-"|"matthew:  This is a email test matthew:  testing email again matthew:  I think this one will work."




require 'rubygems'  
[require 'httparty'](http://httparty.rubyforge.org/)  
require 'FileUtils'  
[require 'nokogiri'](http://nokogiri.org/)  
[require 'crack'](https://github.com/jnunemaker/crack)  
require 'uri'  
require 'json'  
[require 'faster_csv'](http://fastercsv.rubyforge.org/files/INSTALL.html)

In order to get nokogiri to work on the mac you need to have [GCC](https://github.com/kennethreitz/osx-gcc-installer/downloads) installed. 

##How to Run
1. Download the file into a directory 
2. Download the CSV from your Zendesk which is located under Manage -> Reporting -> Export tab 
3.  run the following command line.
` $ruby faster-csv-pull.rb your@email.com YourPassword the-csv-file-you-downloaded.csv`