require 'test_helper'

class NotificationModificatedMailerTest < ActionMailer::TestCase
  test "when_modificated" do
    mail = NotificationModificatedMailer.when_modificated
    assert_equal "When modificated", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
