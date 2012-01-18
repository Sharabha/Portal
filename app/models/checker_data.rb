class CheckerData < ActiveRecord::Base
  belongs_to :checker
  after_create :save_file

  private
    def save_file
      CheckerFile.save_checker_data(self)
    end
end
