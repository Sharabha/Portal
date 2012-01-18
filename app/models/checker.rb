class Checker < ActiveRecord::Base

  belongs_to :problem
  has_many :checker_datas

  def check_solution(solution)
    score = 0
    test_id=0
    wynik = File.open("checker/result/"+problem.id.to_s+"-"+test_id.to_s+".txt", "rb") {|io| io.read}
    puts "Ocenia:"+problem.id.to_s+" na:"+wynik
    return wynik.to_i
    #for cd in self.checker_datas
      #score += self.check_one(solution, cd)
    #end
    #returns % of passed tests
    #len = self.checker_datas.length
    #return 0 unless len > 0
    #score / len
  end

  def check_one(solution, checker_data)
    #should return 1 or 0
    #depending if solution has passed test
    #we stub response with 1
    1
  end

end
