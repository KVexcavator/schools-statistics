require 'json'
require 'rexml/document'
include REXML

def create_stat_file
  # create statistics file
  storage = "/tmp/statdata"
  sd = File.open(storage, "w")

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
  
  # add data from school3.xml 
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
  storage
  # out comment to test
  # puts(File.read(storage))
end

  
class Statistics

  def initialize storage 
    @stat_data = File.readlines(storage)
  end

  def print_result 
    # puts @stat_data
    puts "==============="
    puts "Average Scores:"
    puts "math: #{average(0)}, russian: #{average(3)}, phys: #{average(-2)}"
    puts "Bad-learning students percentage: #{bad_learning_students_percentage}%"
  end 

  # poss = position in line
  def average poss
    '%.2f' % ( @stat_data.map{|n| n[poss].to_f}.reduce(:+) / @stat_data.length )
  end

  def bad_learning_students_percentage 
    count_bad_student = 0
    @stat_data.each do |l|
      if l.match(/[123]/)
        count_bad_student += 1
      end
    end
    '%.2f' % (count_bad_student.to_f * 100 / @stat_data.length.to_f)
  end
end

repoirt = Statistics.new (create_stat_file)
repoirt.print_result
