# frozen_string_literal: true

class AddUseNewDesignToSplashpages < ActiveRecord::Migration[7.0]
  def change
    add_column :splashpages, :use_new_design, :boolean, default: false
  end
end
