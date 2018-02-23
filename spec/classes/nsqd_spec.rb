require 'spec_helper'

describe 'nsq::nsqd' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        let(:pre_condition) { 'include ::nsq' }
        context "nsqd class without any parameters" do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('nsq::nsqd::config') }
          it { is_expected.to contain_file('/etc/systemd/system/nsqd.service') }
          it { 
            is_expected.to contain_service('nsqd').with(
              'ensure' => nil
            )
          }
        end
        context "nsqd with service ensure set" do
          let(:params) do {
            'service_ensure' => 'running'
          }
          end
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('nsq::nsqd::config') }
          it { is_expected.to contain_file('/etc/systemd/system/nsqd.service') }
          it { 
            is_expected.to contain_service('nsqd').with(
              'ensure' => 'running', 
              'enable' => true
            )
          }
        end
      end
    end
  end
end
