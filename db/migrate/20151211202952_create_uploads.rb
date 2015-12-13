class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.integer :task_id
      t.has_attached_file :file
    end
  end
end
