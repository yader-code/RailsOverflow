# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user_mail) do
    User.create(name: 'Jhader', keywords: ['Testing'], email: 'testing_mailer@test.com', password: 'qwerty123')
  end

  let(:post_created) do
    Post.create(title: 'Testing', content: 'this is a test for schedule email notification', user: user_mail)
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

  describe 'post creation notification email' do
    it 'email enqueued successfully ' do
      emails = %w[test1@test.com test2@test.com]
      expect do
        perform_enqueued_jobs do
          UserMailer.with(post_created:, emails:).post_creation_notification_email.deliver_later
        end
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end
  end
end
