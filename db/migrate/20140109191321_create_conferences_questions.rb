# frozen_string_literal: true

class CreateConferencesQuestions < ActiveRecord::Migration[4.2]
  def change
    create_table :conferences_questions, id: false do |t|
      t.references :conference
      t.references :question
    end
  end
end
