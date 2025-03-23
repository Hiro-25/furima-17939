module ItemsHelper
  def display_price(price)
    number_to_currency(price, unit: '¥', precision: 0)
  end
end
