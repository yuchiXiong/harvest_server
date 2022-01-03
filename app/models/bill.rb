class Bill < ApplicationRecord
  paginates_per 100
  belongs_to :user
end
