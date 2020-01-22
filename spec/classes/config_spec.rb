require 'spec_helper'

describe 'nifi::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          'nifi_home' => '/opt/nifi/1.10.0',
          'user' => 'nifi',
          'group' => 'nifi',
          'bootstrap_conf' => { 'foo' => 'bar' },
          'nifi_properties' => { 'foo' => 'bar' },
        }
      end

      it { is_expected.to compile }
      it { is_expected.to contain_file('/opt/nifi/nifi-1.10.0/conf/nifi.properties') }
      it { is_expected.to contain_file('/opt/nifi/nifi-1.10.0/conf/bootstrap.conf') }
    end
  end
end
