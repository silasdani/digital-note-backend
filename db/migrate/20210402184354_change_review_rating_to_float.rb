# frozen_string_literal: true

class ChangeReviewRatingToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :reviews, :rating, :float
  end
end
