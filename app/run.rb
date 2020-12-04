require 'json'
require 'rexml/document'
include REXML

def create_stat_file
  # create statistics file
  sd = File.open("/tmp/statdata", "w")

  # add data from school1.json 
  path = File.join(File.dirname(__FILE__), "../data/school1.json")
  file = File.read(path)
  JSON.parse(file).each do |p|
    "#{p["math"]}  #{p["rus"]}  #{p["phys"]}\n".display(sd)
  end 
  
  # add data from school2.json 
  path = File.join(File.dirname(__FILE__), "../data/school2.json")
  file = File.read(path)
  ars, c = [], 0
  JSON.parse(file).each do |p|
    ar = []
    p[1].each do |i|
      ar << i["grade"]
    end 
    ars << ar 
  end 
  while c < ars[0].length
    "#{ars[0][c]}  #{ars[1][c]}  #{ars[2][c]}\n".display(sd)
    c += 1
  end
  
  # add data from each xml files
  path = File.join(File.dirname(__FILE__), "../data/school3.xml")
  file_data = File.read(path)
  xml = Document.new(file_data)
  array = []
  xml.elements.each("root/row/grades/score"){|e| array << e.text}
  array = array.each_slice(3).to_a
  array.each do |a|
    "#{a[0]}  #{a[1]}  #{a[2]}\n".display(sd)
  end

  sd.close
  # out comment to test
  puts(File.read("/tmp/statdata"))
end

  
class Statistics

  def initialize(file)

  end

  def average_math

  end

  def average_russan

  end

  def average_phys

  end

  def bad_learning_students_percentage

  end
end

create_stat_file
