require "test_helper"

class ContactFormTest < ActionDispatch::IntegrationTest
  test "valid submission creates a ContactMessage and emails the admin" do
    assert_difference -> { ContactMessage.count } => 1 do
      assert_emails 1 do
        post contact_messages_path, params: {
          contact_message: {
            name: "Jane Buyer",
            email: "Jane@Example.com",
            subject: "How do I list?",
            body: "I'd like to learn about getting our AI company listed on the directory."
          }
        }
      end
    end
    assert_redirected_to contact_path
    follow_redirect!
    assert_match(/Thanks/, flash[:notice].to_s)

    msg = ContactMessage.last
    assert_equal "jane@example.com", msg.email, "email is normalized"
    assert_not_nil msg.ip_address
  end

  test "honeypot blocks bot submissions silently" do
    assert_no_difference -> { ContactMessage.count } do
      assert_no_emails do
        post contact_messages_path, params: {
          contact_message: {
            name: "Bot",
            email: "bot@example.com",
            subject: "spam",
            body: "viagra etc viagra etc viagra etc"
          },
          company_url: "https://bot-filled-this.example"
        }
      end
    end
    assert_redirected_to contact_path
  end

  test "rejects body shorter than minimum" do
    assert_no_difference -> { ContactMessage.count } do
      post contact_messages_path, params: {
        contact_message: {
          name: "Test",
          email: "test@example.com",
          body: "too short"
        }
      }
    end
    assert_response :unprocessable_entity
    assert_match(/Body is too short/i, response.body)
  end

  test "rejects invalid email" do
    assert_no_difference -> { ContactMessage.count } do
      post contact_messages_path, params: {
        contact_message: {
          name: "Test",
          email: "not-an-email",
          body: "This body is long enough to clear the minimum length validator."
        }
      }
    end
    assert_response :unprocessable_entity
  end
end
