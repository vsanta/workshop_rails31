class CommentsNotifier < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comments_notifier.to_post_author.subject
  #
  def to_post_author
    @greeting = "Hi"

    mail :to => "to@example.org"
  end
end
