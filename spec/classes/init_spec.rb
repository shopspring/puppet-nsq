require 'spec_helper'

describe 'nsq' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "nsq class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          #it { is_expected.to contain_class('nsq::params') }
          it { is_expected.to contain_class('nsq::service')}
          it { is_expected.to contain_class('nsq::install')}

          #it { is_expected.to contain_service('nsq') }
        end
      end
    end
  end
end
