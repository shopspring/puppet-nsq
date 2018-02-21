require 'spec_helper'

describe 'nsq::install' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end
        let(:pre_condition) { 'include ::nsq' }
        context "nsq class without any parameters" do
          it { is_expected.to compile.with_all_deps }
          #it { is_expected.to contain_class('nsq::params') }
          it { is_expected.to contain_class('wget')}
          it { is_expected.to contain_user('nsq')}
          it { 
            is_expected.to contain_file('/etc/nsq').with(
              'owner'   => 'nsq',
              'recurse' => true,
              'ensure'  => 'directory'
            ).that_requires('User[nsq]')
          }
          it { 
            is_expected.to contain_file('/var/log/nsq').with(
              'owner'   => 'nsq',
              'recurse' => true,
              'ensure'  => 'directory'
            ).that_requires('User[nsq]')
          }
          it { 
            is_expected.to contain_file('/var/lib/nsq').with(
              'owner'   => 'nsq',
              'recurse' => true,
              'ensure'  => 'directory'
            ).that_requires('User[nsq]')
          }
          it {is_expected.to contain_wget__fetch('https://s3.amazonaws.com/bitly-downloads/nsq/nsq-1.0.0-compat.linux-amd64.go1.8.tar.gz')}
        end
      end
    end
  end
end
