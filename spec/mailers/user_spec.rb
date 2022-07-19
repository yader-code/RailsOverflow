# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user_mail) do
    User.create(name: 'Jhader', keywords: ['Testing'], email: 'testing_mailer@test.com', password: 'qwerty123')
  end

  describe 'send email verification' do
    it 'email enqueued successfully ' do
      expect do
        perform_enqueued_jobs do
          UserMailer.with(user: user_mail).send_verification_email.deliver_later
        end
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
  end
end
