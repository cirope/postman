module TicketsHelper
  def categories
    Category.order 'name ASC'
  end

  def users
    User.order 'name ASC'
  end

  def status
    Ticket::STATUS.map { |s| [t("tickets.status.#{s}"), s] }
  end

  def tickets_group_by_tenant
    if @tenant
      [[@tenant, @tickets]]
    else
      @tickets.group_by(&:tenant_id).map do |tenant_id, tickets|
        [Tenant.find(tenant_id), tickets]
      end
    end
  end

  def ticket_status ticket, pull_right: false
    text = t "tickets.status.#{ticket.status}"
    classes = ['label']

    classes << 'pull-right' if pull_right
    classes << (ticket.status == 'closed' ? 'label-error' : 'label-success')

    content_tag :span, text, class: classes.join(' ')
  end

  def ticket_class ticket
    if ticket.user
      ticket.open? ? 'warning' : 'active'
    end
  end

  def feedbacks_label ticket
    [
      t('navigation.show'),
      Feedback.model_name.human(count: ticket.feedbacks.count).downcase
    ].join(' ')
  end

  def feedbacks_count ticket
    content_tag :span, ticket.feedbacks.count, class: 'label'
  end
end
