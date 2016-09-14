require 'puppet/parameter/boolean'
require 'puppet/type'

Puppet::Type.newtype(:rhsm_register) do
  @doc = ""

  ensurable do

    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end

    def insync?(is)

      @should.each do |should|
        case should
        when :present
          return true if is == :present
        when :absent
          return true if is == :absent
        end
      end
      return false
    end
    defaultto :present
  end

  newparam(:server_hostname, :namevar => true) do
    desc "The rhsm server hostname."
  end

  newparam(:server_insecure, :boolean => true, :parent => Puppet::Parameter::Boolean) do
    desc "Should an insecure https connection be used."
    defaultto false
  end

  newparam(:server_prefix) do
    desc "The prefix used for registration queries sent to the rhsm server"
  end

  newparam(:rhsm_baseurl) do
    desc "Specify a CDN baseurl to use"
  end

  newparam(:rhsm_cacert) do
    desc "CA certificate for the repository and the issued client certs"
  end

  newparam(:username) do
    desc "The username to use when registering the system"
  end

  newparam(:password) do
    desc "The password to use when registering the system"
  end

  newparam(:activationkeys) do
    desc "The activation key to use when registering the system (cannot be used with username and password)"
  end

  newproperty(:pool) do
    desc "The license pool to attach to after registering the system"
  end

  newparam(:environment) do
    desc "The environment to subscribe to in the case of using katello."
  end

  newparam(:autosubscribe, :boolean => true, :parent => Puppet::Parameter::Boolean) do
    desc "Automatically attach this system to compatible subscriptions."
    defaultto false
  end

  newparam(:force, :boolean => true, :parent => Puppet::Parameter::Boolean) do
    desc "Should the registration be forced. Use this option with caution,
          setting it true will cause the subscription-manager command to be run
          every time runs."
    defaultto false
  end

  newparam(:org) do
    desc "The organization the system should be assigned to."

    validate do |value|
      if value.empty?
        raise ArgumentError,
          "org paramater may not be empty"
      end
    end
  end

end
