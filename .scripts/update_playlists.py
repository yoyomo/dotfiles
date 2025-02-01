# run this in your terminal 
# /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222
# and sign in to your Soundiiz account
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

# Wait for an element to appear (like Playwright's wait_for_selector)
wait = WebDriverWait(driver, 10)

# Minimize the window (so it runs in the background)
driver.minimize_window()
print("Chrome is running in the background...")

# TODO: Implement the update_syncs.js code in Python selenium

chrome.terminate()