class Identify < Klaviyo::Client
  # Used for identifying customers and managing profile properties
  #
  # @kwarg :id [String] the customer or profile id
  # @kwarg :email [String] the customer or profile email
  # @kwarg :properties [Hash] properties of the profile to add or update
  def self.identify(kwargs = {})
    defaults = {:id => nil, :email => nil, :properties => {}}
    kwargs = defaults.merge(kwargs)

    if !check_email_or_id_exists(kwargs)
      return
    end

    properties = kwargs[:properties]
    properties[:email] = kwargs[:email] unless kwargs[:email].to_s.empty?
    properties[:id] = kwargs[:id] unless kwargs[:id].to_s.empty?

    params = {
      :token => Klaviyo.public_api_key,
      :properties => properties
    }

    public_request(HTTP_GET, 'identify', params)
  end
end
