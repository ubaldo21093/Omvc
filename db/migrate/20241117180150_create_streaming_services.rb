class CreateStreamingServices < ActiveRecord::Migration[7.0]
  def change
    create_table :streaming_services do |t|
      t.string :service_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
