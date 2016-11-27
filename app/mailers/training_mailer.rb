class TrainingMailer < ApplicationMailer
  def cancellation(training)
    @training = training
    @members  = @training.members
    @members.each do |member|
      send_cancellation_email(member)
    end
  end

  private

  def send_cancellation_email(member)
    @member = member
    date = @training.date.strftime('%A %d %Y')
    mail(to: member.email, subject: 'Annulation de l\'entrainement du #{date}')
  end
end
