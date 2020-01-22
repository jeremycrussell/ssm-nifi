require 'spec_helper'

describe 'nifi::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          nifi_home: '/test/nifi-1.0.0',
          user: 'nifi',
          limit_nofile: 123,
          limit_nproc: 234,
        }
      end

      it { is_expected.to compile }
    end
  end
end
