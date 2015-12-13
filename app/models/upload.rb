class Upload < ActiveRecord::Base
  belongs_to :task
  has_attached_file :file
  validates :file, presence: true
  validates_attachment :file, content_type: { content_type: %w(image/jpg image/jpeg image/gif image/png)}
end
