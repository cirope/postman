module TicketsHelper
  def categories
    Category.order 'name ASC'
  end

  def status
    Ticket::STATUS.map { |s| [t("tickets.status.#{s}"), s] }
  end

  def ticket_status ticket, pull_right: false
    text = t "tickets.status.#{ticket.status}"
    classes = ['label']

    classes << 'pull-right' if pull_right
    classes << (ticket.status == 'closed' ? 'label-error' : 'label-success')

    content_tag :span, text, class: classes.join(' ')
  end
end
