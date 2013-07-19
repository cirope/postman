json.array!(@tenants) do |tenant|
  json.extract! tenant, :name, :email, :subdomain
  json.url tenant_url(tenant, format: :json)
end
