class Purchase < ApplicationRecord
  include Payable

  belongs_to :user
end
