class CreatePolls < ActiveRecord::Migration[7.0]
  def change
    create_table :polls do |t|
        t.string :title
        t.bigint :author_id
      t.timestamps
    end

    add_foreign_key(:polls, :users, column: :author_id)
  end
end
