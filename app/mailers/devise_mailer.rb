class DeviseMailer < Devise::Mailer
  helper :application # gives access to application helpers
  include Devise::Controllers::UrlHelpers # gives access to `confirmation_url`, etc.
  default template_path: 'devise/mailer' # use Devise mailer templates
end
