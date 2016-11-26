require 'spec_helper'

describe 'subscription_manager' do
  on_supported_os.each do |os, facts|
    context "with defaults on #{os}" do
      let(:facts) do
        facts.merge({:puppetmaster => 'localhost.localdomain'})
      end
      let(:params) { { :version => 'installed' } }
      it { should compile.with_all_deps }
      it { should contain_class('subscription_manager') }
    end
  end
end
