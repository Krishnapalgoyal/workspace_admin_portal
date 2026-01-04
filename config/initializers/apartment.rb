Apartment.configure do |config|
  config.excluded_models = %w[
    User
    Organization
    OrganizationMembership
    GoogleWorkspace
  ]

  config.use_schemas = true
end
