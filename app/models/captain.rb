class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
    
  end

  def self.sailors
    self.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboat_operators
    # includes(boats: :classifications).where(classifications: {name: "Motorboat"})
    self.includes(boats: :classifications).where(classifications: {name: "Motorboat" })

  end

  def self.talented_seafarers
    # where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
    self.where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    self.where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
