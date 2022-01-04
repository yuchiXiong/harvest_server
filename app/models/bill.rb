class Bill < ApplicationRecord
  paginates_per 100
  belongs_to :user
  default_scope -> { order('recorded_at desc') }

end
