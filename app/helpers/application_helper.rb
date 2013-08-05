module ApplicationHelper
  def title
    [t('app_name'), title_with_count].compact.join(' | ')
  end

  def input_defaults
    { input_html: { class: 'form-control' } }
  end

  private

  def title_with_count
    [title_count, @title].compact.join(' ')
  end

  def title_count
    "(#{pending_tickets_count})" if pending_tickets_count.to_i > 0
  end
end
