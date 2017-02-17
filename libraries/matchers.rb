if defined?(ChefSpec)
  ChefSpec.define_matcher :google_cloud_sdk_install

  def create_google_cloud_sdk_install(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:google_cloud_sdk_install, :create, resource_name)
  end

  def delete_google_cloud_sdk_install(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:google_cloud_sdk_install, :delete, resource_name)
  end
end
