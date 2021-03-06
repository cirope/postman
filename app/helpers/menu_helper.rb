module MenuHelper
  def menu_item_for model: model, path: path, append_to_label: nil
    label = model.model_name.human(count: 0)
    label << " #{append_to_label}" unless append_to_label.blank?

    link = link_to label.html_safe, path
    active = model.model_name.route_key == controller_name

    content_tag :li, link, (active ? { class: 'active' } : {})
  end

  def pending_tickets_badge
    classes = ['label']
    classes << (pending_tickets_count > 0 ? 'label-danger' : 'label-default')

    content_tag :span, pending_tickets_count, class: classes.join(' '), id: 'ticket-count'
  end
end
