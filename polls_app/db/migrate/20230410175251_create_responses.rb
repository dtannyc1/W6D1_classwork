class CreateResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :responses do |t|
        t.bigint :user_id
        t.bigint :answer_choice_id
      t.timestamps
    end

    add_foreign_key(:responses, :users, column: :user_id)
    add_foreign_key(:responses, :answer_choices, column: :answer_choice_id)
  end
end
