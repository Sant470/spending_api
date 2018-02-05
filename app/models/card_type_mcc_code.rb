class CardTypeMccCode < ApplicationRecord
  belongs_to :mcc_code
  belongs_to :card_type
end
