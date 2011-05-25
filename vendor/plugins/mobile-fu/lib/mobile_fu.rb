module MobileFu
  class DeviceInfo
    attr_reader :operating_system, :version

    def initialize(os, ver)
      @operating_system = os
      @version = ver
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
    base.send(:class_inheritable_accessor, :supported_devices)
    base.supported_devices = {:android => Range.new(0,3.0)}

  end
  
  module ClassMethods
    # Add this to one of your controllers to use MobileFu.  
    #
    #    class ApplicationController < ActionController::Base 
    #      has_mobile_fu
    #    end
    #
    # You can also force mobile mode by passing in 'true'
    #
    #    class ApplicationController < ActionController::Base 
    #      has_mobile_fu(true)
    #    end
      
    def has_mobile_fu(test_mode = false)
      include MobileFu::InstanceMethods

      if test_mode 
        before_filter :force_mobile_format
      else
        before_filter :set_mobile_format
      end

      helper_method :is_mobile_device?
      helper_method :in_mobile_view?
      helper_method :is_device?
    end
    
    def is_mobile_device?
      @@is_mobile_device
    end

    def in_mobile_view?
      @@in_mobile_view
    end

    def is_device?(type)
      @@is_device
    end
  end
  
  module InstanceMethods
    
    # Forces the request format to be :mobile
    
    def force_mobile_format
      request.format = :mobile
      session[:mobile_view] = true if session[:mobile_view].nil?
    end
    
    # Determines the request format based on whether the device is mobile or if
    # the user has opted to use either the 'Standard' view or 'Mobile' view.
    
    def set_mobile_format
      logger.debug "Mobile_Fu :::: #{is_mobile_device?}"
      if is_mobile_device? && !request.xhr?
        request.format = session[:mobile_view] == false ? :html : :mobile
        session[:mobile_view] = true if session[:mobile_view].nil?
      end
    end
    
    # Returns either true or false depending on whether or not the format of the
    # request is either :mobile or not.
    
    def in_mobile_view?
      request.format.to_sym == :mobile
    end
    
    # Returns either true or false depending on whether or not the user agent of
    # the device making the request is matched to a device in our regex.
    
    def is_mobile_device?
      self.class.supported_devices.any? do |os, version_range|        
        mobile_device_info.operating_system == os &&
          version_range.member?(mobile_device_info.version)
      end
    end

    # Can check for a specific user agent
    # e.g., is_device?('iphone') or is_device?('mobileexplorer')
    
    def is_device?(type)
      request.user_agent.to_s.downcase.include?(type.to_s.downcase)
    end

    def mobile_device_info
      @mobile_device_info ||= extract_device_info
    end

    protected
    def extract_device_info
      ua = request.user_agent.to_s
      if match = ua.match(/Android ([\d\.]+)/)
        DeviceInfo.new(:android, match[1].to_f)
      elsif match = ua.match(/iPhone OS (\d_\d+)/)
        DeviceInfo.new(:iphone, match[1].gsub(/_/, ".").to_f)
      elsif match = ua.match(/BlackBerry.*AppleWebKit.*Version\/(\d\.\d)/)
        DeviceInfo.new(:blackberry, match[1].to_f)
      elsif match = ua.match(/webOS\/([\d\.]+)/)
        DeviceInfo.new(:webos, match[1].to_f)
      else
        DeviceInfo.new(:unknown, nil)
      end
    end
  end
end

if defined?(ActionController::Base)
  ActionController::Base.send(:include, MobileFu)
end
