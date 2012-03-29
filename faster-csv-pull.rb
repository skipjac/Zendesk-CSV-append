require 'rubygems'
require 'faster_csv'
require 'httparty'
require 'FileUtils'
require 'nokogiri'
require 'crack'
require 'uri'
require 'json'

login = ARGV[0]
password = ARGV[1]
infile = ARGV[2]
outfile = infile.split(".").first

def is_a_number?(s)
  s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true 
end

class Zenbody
  include JSON
  def self.email(data)
    newJSON = JSON.parse(data)
    if newJSON.length > 0
      return newJSON['name']
    else
      return 'none found
      '
    end
  end
  def comments(data)
    login = ARGV[0]
    password = ARGV[1]
    a = Zenuser.new(login, password)
    newJSON = JSON.parse(data.body)
    totalComment = ''
    newJSON['comments'].each do |comment|
      name = a.requester(comment['author_id'])
      totalComment << Zenbody.email(name) + ":  " + comment['value'] + "\r\n"
    end
    return totalComment
  end
end

class Zenuser
  include HTTParty
  base_uri 'http://skipjack.zendesk.com'
  headers 'content-type'  => 'application/json'
  def initialize(u, p)
      @auth = {:username => u, :password => p}
    end
  def tickets(ticket_number)
    options = {:basic_auth => @auth}
    self.class.get('/tickets/' + ticket_number +'.json', options)
  end
  def requester(user_id)
    options = {:basic_auth => @auth}
    json = JSON 'name' =>'System User'
    results = self.class.get('/api/v2/users/' + user_id.to_s, options)
    if results.headers['status'] == '200 OK'
      return results.body
    else
      return json
    end
  end
end

x = Zenuser.new(login, password)
y = Zenbody.new()

 
arr_of_arrs = FasterCSV.read(infile)  

FasterCSV.open(outfile + '-with-comments.csv', 'w', :force_quotes => true, :col_sep =>'|') do |csv|
  arr_of_arrs.each do |row|
    if is_a_number?(row[1])
      ticketComment = y.comments(x.tickets(row[1]))
      row.push(ticketComment)
    end
  csv << row 
  end
end