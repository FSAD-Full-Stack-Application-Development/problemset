class Joke < ApplicationRecord
  validates :quote, presence: true, length: { minimum: 10, maximum: 500 }
  validates :author_name, presence: true, length: { maximum: 100 }
  validates :category, length: { maximum: 50 }
  
  # Scope to group by category
  scope :by_category, -> { order(:category, :author_name) }
  
  # Method to get distinct categories
  def self.distinct_categories
    where.not(category: [nil, '']).distinct.pluck(:category).sort
  end
end



