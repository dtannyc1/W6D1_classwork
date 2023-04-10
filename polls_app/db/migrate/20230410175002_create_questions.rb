class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
        t.string :text
        t.bigint :poll_id
      t.timestamps
    end

    add_foreign_key(:questions, :polls, column: :poll_id)
  end
end
