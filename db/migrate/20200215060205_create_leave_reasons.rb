class CreateLeaveReasons < ActiveRecord::Migration[5.2]
  def change
    create_table :leave_reasons do |t|
      t.string :content

      t.timestamps
    end
  end
end
