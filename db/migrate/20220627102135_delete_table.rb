class DeleteTable < ActiveRecord::Migration[7.0]
  def change
  end
  def up
    drop_table :admins
  end
end
