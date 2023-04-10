# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  text       :string
#  poll_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
    validates :text, :poll_id, presence: true
    belongs_to(
        :poll,
        primary_key: :id,
        foreign_key: :poll_id,
        class_name: :Poll
    )

    has_many(
        :answer_choices,
        primary_key: :id,
        foreign_key: :question_id,
        class_name: :AnswerChoice,
        dependent: :destroy
    )

    has_many(
        :responses,
        through: :answer_choices,
        source: :responses,
        dependent: :destroy
    )

    def results
        # output = Hash.new(0)

        # # N+1 approach
        # all_choices = self.answer_choices
        # all_choices.each do |choice|
        #     output[choice.text] = choice.responses.count
        # end

        # # includes approach
        # all_choices = self.answer_choices.includes(:responses)
        # all_choices.each do |choice|
        #     output[choice.text] = choice.responses.length
        # end

        # using ActiveRecord queries
        all_results = answer_choices.left_outer_joins(:responses)
                .group("answer_choices.id")
                .select("answer_choices.text AS text, COUNT(responses.id) AS response_count")
        output = Hash.new(0)
        all_results.map do |result|
            output[result.text] = result.response_count
        end

        output
    end
end
