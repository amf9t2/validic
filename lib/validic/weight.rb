# encoding: utf-8

module Validic
  module Weight

    ##
    # Get Weight Activities base on `access_token`
    # Default data fetched is from yesterday
    #
    # @params :organization_id - for organization specific
    # @params :user_id - for user specific
    #
    # @params :start_date - optional for date range beyond yesterday
    # @params :end_date - optional
    # @params :access_token - override for default access_token
    # @params :source - optional - data per source (e.g 'fitbit')
    # @params :expanded - optional - will show the raw data
    #
    # @return [Hashie::Mash] with list of Weight
    def get_weight(params={})
      get_endpoint(:weight, params)
    end

    alias :get_weights :get_weight

    ##
    # Create Weight base on `access_token` and `authentication_token`
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @params :timestamp
    # @params :weight
    # @params :bmi
    # @params :fat_percent
    # @params :mass_weight
    # @params :free_mass
    # @params :source
    #
    # @return success
    def create_weight(user_id, activity_id, options={})
      options = {
        user_id: user_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id,
        weight: {
          activity_id: activity_id,
          timestamp: options[:timestamp] || DateTime.now.utc.to_s(:iso8601),
          utc_offset: options[:utc_offset],
          weight: options[:weight] || 0,
          height: options[:height],
          free_mass: options[:free_mass],
          fat_percent: options[:fat_percent],
          mass_weight: options[:mass_weight],
          bmi: options[:bmi],
          extras: options[:extras]
        }
      }

      response = post_to_validic('weight', options)
      response if response
    end

    ##
    # Update Weight measurement based on `access_token` and `authentication_token`
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @return success
    def update_weight(user_id, activity_id, options={})
      options = {
        user_id: user_id,
        activity_id: activity_id,
        organization_id: options[:organization_id] || Validic.organization_id,
        access_token: options[:access_token] || Validic.access_token,
        weight: {
          timestamp: options[:timestamp] || DateTime.now.utc.to_s(:iso8601),
          utc_offset: options[:utc_offset],
          weight: options[:weight] || 0,
          height: options[:height],
          free_mass: options[:free_mass],
          fat_percent: options[:fat_percent],
          mass_weight: options[:mass_weight],
          bmi: options[:bmi],
          extras: options[:extras]
        }
      }

      response = put_to_validic('weight', options)
      response if response
    end

    ##
    # Delete Biometric measurement
    #
    # @params :access_token - *required if not specified on your initializer / organization access_token
    # @params :authentication_token - *required / authentication_token of a specific user
    #
    # @return success
    def delete_weight(user_id, activity_id, options={})
      options = {
        user_id: user_id,
        activity_id: activity_id,
        access_token: options[:access_token] || Validic.access_token,
        organization_id: options[:organization_id] || Validic.organization_id
      }

      response = delete_to_validic('weight', options)
      response if response
    end
  end
end
