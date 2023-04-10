# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :bigint
#  answer_choice_id :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Response < ApplicationRecord
    validates :answer_choice_id, :user_id, presence:true
    validate :not_duplicate_response
    validate :not_original_author

    belongs_to(
        :respondent,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User
    )

    belongs_to(
        :answer_choice,
        primary_key: :id,
        foreign_key: :answer_choice_id,
        class_name: :AnswerChoice
    )

    has_one(
        :question,
        through: :answer_choice,
        source: :question
    )

    has_one(
        :poll,
        through: :question,
        source: :poll
    )

    def sibling_responses
        self.question
            .responses
            .where.not(id: self.id)
    end

    def respondent_already_answered?
        all_sibling_responses = self.sibling_responses
                                    .includes(:respondent)
        all_sibling_responses.each do |response|
            return true if response.respondent.id == self.user_id
        end
        false
    end

    private
    def not_duplicate_response
        if respondent_already_answered?
            errors.add(:user_id, 'can''t respond the same question twice')
        end
    end

    def not_original_author
        # original_poll = self.poll.includes(:author)
        if self.poll.author.id == self.user_id
            errors.add(:user_id, 'can''t respond to their own poll')
        end
    end
end
