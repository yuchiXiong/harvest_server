json.data do
  json.cache! ['v1', @bills.ids] do
    json.bills do
      json.partial! 'bills/bill', collection: @bills, as: :bill
    end
  end
end