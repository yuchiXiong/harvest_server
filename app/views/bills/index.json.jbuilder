# frozen_string_literal: true

json.data do
  json.cache! ['v1', @bills.ids] do
    json.recorded_at_by_month @start_at
    json.bills do
      json.partial! 'bills/bill', collection: @bills, as: :bill
    end
  end
end
