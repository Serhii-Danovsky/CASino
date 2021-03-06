require 'active_support/configurable'
require 'casino/engine'

module CASino
  include ActiveSupport::Configurable

  defaults = {
    authenticators: HashWithIndifferentAccess.new,
    authenticator_context_builder: ->(params, request) {},
    require_service_rules: false,
    allow_remember_me: true,
    allow_forgot_password: true,
    allow_change_password: true,
    logger: Rails.logger,
    frontend: HashWithIndifferentAccess.new(
      sso_name: 'CASino',
      footer_text: 'Powered by <a href="http://rbcas.com/">CASino</a>'
    ),
    implementors: HashWithIndifferentAccess.new(
      login_ticket: nil,
      proxy_granting_ticket: nil,
      proxy_ticket: nil,
      service_rule: nil,
      service_ticket: nil,
      ticket_granting_ticket: nil,
      two_factor_authenticator: nil,
      user: nil
    ),
    auth_token_ticket: {
      lifetime: 60
    },
    passwords: {
      forgot_retry_interval: 120,
      forgot_email_from: false,
      forgot_token_lifetime: 1800,
      all_users_related_info: nil
    },
    login_ticket: {
      lifetime: 600
    },
    ticket_granting_ticket: {
      lifetime: 86400,
      lifetime_long_term: 864000
    },
    service_ticket: {
      lifetime_unconsumed: 300,
      lifetime_consumed: 86400,
      single_sign_out_notification: {
        timeout: 5
      }
    },
    proxy_ticket: {
      lifetime_unconsumed: 300,
      lifetime_consumed: 86400
    },
    two_factor_authenticator: {
      timeout: 180,
      lifetime_inactive: 300,
      drift: 30
    }
  }

  self.config.merge! defaults.deep_dup

  def self.logger
    config.logger
  end
end
