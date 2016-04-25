class County < ActiveRecord::Base
  belongs_to :state
  has_many :zipcodes
  validates_presence_of :name

  def installs
    zipcodes.pluck(:total_installs).reduce(&:+)
  end
end
