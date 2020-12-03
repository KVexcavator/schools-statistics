

def create_stat_file
  # create statistics file
  sd = File.open("/tmp/statdata", "w")
  # add data from each json files
  Dir.glob(File.join(File.dirname(__FILE__), "../data/*.json")) do |file|
    file_data = File.open(file, "r")
    file_data.display(sd)
  end 
  # add data from each xml files
  Dir.glob(File.join(File.dirname(__FILE__), "../data/*.xml")) do |file|
    file_data = File.open(file, "r")
    file_data.display(sd)
  end
  # "Barbambia".display(sd)
  sd.close
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
