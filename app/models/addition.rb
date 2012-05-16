class Addition < ActiveRecord::Base
  attr_accessible :amount, :budget_id, :description, :name, :tag_list
  
  validates :name, :presence => true
  validates :amount, :presence => true
  validates :budget_id, :presence => true
  validates :user_id, :presence => true

  validates :amount, :numericality => true

  acts_as_taggable
  
  belongs_to :budget
  belongs_to :user
end