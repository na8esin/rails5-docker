require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.register_driver :remote_chrome do |app|
    url = "http://chrome:4444/wd/hub"
    caps = ::Selenium::WebDriver::Remote::Capabilities.chrome(
      "goog:chromeOptions" => {
        "args" => [
          "no-sandbox",
          "headless",
          "disable-gpu",
          "window-size=1680,1050"
        ]
      }
    )
    Capybara::Selenium::Driver.new(app, browser: :remote, url: url, desired_capabilities: caps)
  end

  driven_by :remote_chrome

  def setup
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    Capybara.server_port = 4444
    Capybara.app_host = "http://web:#{Capybara.server_port}"

    super
  end
end
