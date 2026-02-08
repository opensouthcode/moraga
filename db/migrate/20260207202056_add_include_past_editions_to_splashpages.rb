# frozen_string_literal: true

class AddIncludePastEditionsToSplashpages < ActiveRecord::Migration[7.0]
  def change
    add_column :splashpages, :include_past_editions, :boolean, default: false
  end
end
