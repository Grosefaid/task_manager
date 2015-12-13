class Task < ActiveRecord::Base
  belongs_to :user
  has_many :uploads, :dependent => :destroy

  accepts_nested_attributes_for :uploads, :reject_if => lambda { |t| t['file'].nil? }, allow_destroy: true

  default_scope { order('id DESC') }

  validates :name, presence: true
  validates :description, presence: true

  state_machine :initial => :new do
    event(:start) { transition :new => :started }
    event(:finish) { transition :started => :finished }
  end
end
