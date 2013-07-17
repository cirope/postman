json.array!(@tenants) do |tenant|
  json.extract! tenant, :name, :subdomain
  json.url tenant_url(tenant, format: :json)
end
