require "email_interceptor"
ActionMailer::Base.register_interceptor(EmailInterceptor)