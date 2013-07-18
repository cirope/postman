module TenantsHelper
  def link_to_tickets tenant
    icon = content_tag :span, nil, class: 'glyphicon glyphicon-exclamation-sign'

    link_to icon, tenant_tickets_path(tenant), title: t('tenants.show_tickets'), class: 'icon'
  end
end
