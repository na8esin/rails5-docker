# うまくいかない

from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

options = webdriver.ChromeOptions()
options.add_argument('--headless')
options.add_argument('--no-sandbox')
options.add_argument('--remote-debugging-pipe')
options.add_argument("--window-size=1600,1024")

driver = webdriver.Remote(
   command_executor='http://chrome:4444/wd/hub',
#   desired_capabilities=DesiredCapabilities.CHROME,
   options = options
)

try:
   driver.get('https://www.selenium.dev/ja/documentation/')

   driver.save_screenshot('sample.png')
finally:
   driver.quit()
