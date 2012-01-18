class CheckerFile
  # moduł do poprawy / naprawy / wymiany :)

  def self.save(path, data)
    f = File.new("#{Rails.root}/checker#{path}", "w")
    f.write(data)
    f.close
  end

  def self.save_solution(solution)
    FileUtils.cp("#{Rails.root}/public/system/codes/#{solution.id}/original/#{solution.code_file_name}",
              "#{Rails.root}/checker/source/#{solution.id}.c")
  end

  def self.save_checker_data(checker_data)
    self.save("/input/#{checker_data.id}.txt", checker_data.input)
    self.save("/output/#{checker_data.id}.txt", checker_data.output)
  end
end
