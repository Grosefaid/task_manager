require 'spec_helper'

describe Upload do

  context 'validation' do
    it { should have_attached_file(:file) }
    it { should validate_attachment_presence(:file) }
    it { should validate_attachment_content_type(:file).allowing('image/jpg', 'image/jpeg', 'image/gif', 'image/png') }
  end

  context 'associations' do
    it { should belong_to(:task) }
  end

end