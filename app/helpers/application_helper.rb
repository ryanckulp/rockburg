module ApplicationHelper
  def as_game_currency(number)
    number_to_currency(number, precision: 0, unit: '§')
  end
end
