module MessagesHelper
  def show_sent_at owner
    if owner.sent_at
      content_tag :span, nil, class: 'glyphicon glyphicon-ok text-success', title: l(owner.sent_at)
    else
      content_tag :span, nil, class: 'glyphicon glyphicon-time text-muted'
    end
  end
end
