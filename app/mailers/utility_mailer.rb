class UtilityMailer < ActionMailer::Base
  default from: 'utilites-dashboard@bignerdranch.com'

  def sharing_notification(privilege, sharer)
    @sharer = sharer
    @utility = privilege.utility
    subject = "#{sharer.email} shared a utility with you"

    mail to: privilege.user.email, subject: subject
  end
end
