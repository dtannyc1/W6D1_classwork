# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ApplicationRecord.transaction do
    # destroy all tables
    puts 'Destroying all tables'
    User.destroy_all
    Poll.destroy_all
    Question.destroy_all
    AnswerChoice.destroy_all
    Response.destroy_all

    # reset primary keys
    puts 'Resetting primary keys'
    %w(users polls questions answer_choices responses).each do |table_name|
        ApplicationRecord.connection.reset_pk_sequence!(table_name)
    end

    # create seed data
    puts 'Creating Seed Data...'
    u1 = User.create!(username: 'Abed')
    u2 = User.create!(username: 'Bob')
    u3 = User.create!(username: 'Carl')

    p1 = Poll.create!(title: 'Ants Poll', author_id: u1.id)
        q1 = Question.create!(text: 'Would you eat ants?', poll_id: p1.id)
            a1a = AnswerChoice.create!(text: "Of course!", question_id: q1.id)
            a1b = AnswerChoice.create!(text: "Ew, no", question_id: q1.id)
            a1c = AnswerChoice.create!(text: "Depends on the size", question_id: q1.id)

            r1a = Response.create!(answer_choice_id: a1a.id, user_id: u2.id)
            r1b = Response.create!(answer_choice_id: a1c.id, user_id: u3.id)
            # r1c = Response.create!(answer_choice_id: a1c.id, user_id: u1.id)
        q2 = Question.create!(text: 'Would you own an ant farm?', poll_id: p1.id)
            a2a = AnswerChoice.create!(text: "Yes please!", question_id: q2.id)
            a2b = AnswerChoice.create!(text: "NO, bugs are gross", question_id: q2.id)
            a2c = AnswerChoice.create!(text: "Only a specific kind", question_id: q2.id)

            r2a = Response.create!(answer_choice_id: a2a.id, user_id: u3.id)
            r2b = Response.create!(answer_choice_id: a2c.id, user_id: u2.id)

    p2 = Poll.create!(title: 'Banana Poll', author_id: u1.id)

    p3 = Poll.create!(title: 'Cats Poll', author_id: u2.id)



    puts 'Done!'
end
