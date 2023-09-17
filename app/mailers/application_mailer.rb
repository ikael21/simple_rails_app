# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'ikael.fess@gmail.com'
  layout 'mailer'
end
