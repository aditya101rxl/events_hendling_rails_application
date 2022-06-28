class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title, null: false, default: ""
      t.text :description, null: false, default: ""
      t.string :image, null: false, default: "https://manavrachna.edu.in/wp-content/uploads/2017/09/coding-ninja-image-1024x585.jpg"
      t.datetime :registration_start, :registration_end, null: false
      t.integer :fees, null: false, default: 0
      t.string :venue, null: false, default: ""
      t.string :event_type, null: false, default: ""
      t.timestamps null: false
    end
  end
end
