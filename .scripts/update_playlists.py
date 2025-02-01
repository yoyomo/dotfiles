# Requirements:
# Sign in to your Soundiiz account in Chrome
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from subprocess import Popen

chrome = Popen(["/Applications/Google Chrome.app/Contents/MacOS/Google Chrome", "--remote-debugging-port=9222"])

# Attach to running Chrome session
options = webdriver.ChromeOptions()
options.debugger_address = "127.0.0.1:9222"  # Connect to the open browser

driver = webdriver.Chrome(options=options)

driver.get("https://soundiiz.com/webapp/scheduleds")  # Change this to your target site

driver.implicitly_wait(0.5)

WebDriverWait(driver, 10).until(
    EC.presence_of_element_located((By.CSS_SELECTOR, ".main-line"))
)

# Minimize the window (so it runs in the background)
driver.minimize_window()
print("Chrome is running in the background...")

# TODO: Implement the update_syncs.js code in Python selenium

# Filter by last exec
headers = driver.find_elements(by=By.CSS_SELECTOR, value=".filter-order-by-list-header")
last_exec_filter = next(header for header in headers if header.text == "Last exec")
last_exec_filter.click()

# TODO: Filter in search bar by " | "
search_input = driver.find_element(by=By.CSS_SELECTOR, value=".search-input")
search_input.send_keys(" | ")


driver.quit()
# chrome.terminate()