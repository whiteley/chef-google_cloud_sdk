# # encoding: utf-8

# Inspec test for recipe google_cloud_sdk::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('google-cloud-sdk') do
  it { should be_installed }
end
