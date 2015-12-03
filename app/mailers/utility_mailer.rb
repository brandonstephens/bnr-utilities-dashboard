class UtilityMailer < ActionMailer::Base
  default from: 'utilites-dashboard@bignerdranch.com'

  def sharing_notification(privilege, sharer)
    @sharer = sharer
    @utility = privilege.utility
    subject = "#{sharer.email} shared a utility with you"

    mail to: privilege.user.email, subject: subject
  end

  def unsharing_notification(privilege, sharer)
    @sharer = sharer
    @utility = privilege.utility
    subject = "#{sharer.email} un-shared a utility with you"

    mail to: privilege.user.email, subject: subject
  end

  # def newbill_notification(bill)
  #   @bill = bill
  #   people = bill.utility.privileges
  #   subject = "A new bill was added to #{bill.utility.name}"
    
    
  #   people.each do |person| {
  #     person.user.email
  #   }

  #   mail to: , subject: subject
  # end
end
