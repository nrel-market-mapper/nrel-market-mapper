class County < ActiveRecord::Base
  belongs_to :state
  has_many :zipcodes
  validates_presence_of :name

  def installs
    number_of_installs = zipcodes.pluck(:total_installs).compact.reduce(&:+)
    number_of_installs.nil? ? 0 : number_of_installs
  end
end
