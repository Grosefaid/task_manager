class Task < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :description, presence: true

  state_machine :initial => :new do
    event(:start) { transition :new => :started }
    event(:finish) { transition :started => :finished }
  end
end
