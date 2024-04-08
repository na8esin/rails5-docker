# python3 sample.py で実行
# こっちは基本は動かない。エラーが出ることを確かめるためのコード

import time

from selenium import webdriver


driver = webdriver.Chrome('/usr/bin/chromedriver')

driver.get('http://www.google.com/');

time.sleep(5) # Let the user actually see something!

search_box = driver.find_element_by_name('q')

search_box.send_keys('ChromeDriver')

search_box.submit()

time.sleep(5) # Let the user actually see something!

driver.quit()