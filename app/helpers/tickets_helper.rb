module TicketsHelper
  def categories
    Category.order 'name ASC'
  end
end
