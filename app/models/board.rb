class Board < ApplicationRecord

  validates :current_state, presence: true
  validates :initial_state, presence: true
  validates :generation, presence: true
  validates :alive_count, presence: true
  validates :dead_count, presence: true
  validates :current_stay_alive_count, presence: true
  validates :current_revive_count, presence: true
  validates :initial_stay_alive_count, presence: true
  validates :initial_revive_count, presence: true


end
