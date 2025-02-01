# Requirements:
# Sign in to your Soundiiz account in Chrome
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import NoSuchElementException
from subprocess import Popen
from constants import playlists
import time

chrome = Popen(["/Applications/Google Chrome.app/Contents/MacOS/Google Chrome", "--remote-debugging-port=9222"])

# Attach to running Chrome session
options = webdriver.ChromeOptions()
options.debugger_address = "127.0.0.1:9222"  # Connect to the open browser

driver = webdriver.Chrome(options=options)

driver.get("https://soundiiz.com/webapp/scheduleds")  # Change this to your target site

driver.implicitly_wait(0.5)

WebDriverWait(driver, 10).until(
    EC.text_to_be_present_in_element((By.CSS_SELECTOR, ".main-line"), "My synchronizations")
)

# Minimize the window (so it runs in the background)
driver.minimize_window()
print("Chrome is running in the background...")

# Filter by last exec
headers = driver.find_elements(by=By.CSS_SELECTOR, value=".filter-order-by-list-header")
last_exec_filter = next(header for header in headers if header.text == "Last exec")
last_exec_filter.click()

search_input = driver.find_element(by=By.CSS_SELECTOR, value=".search-input")
# Search all playlists
for playlist in playlists:
    search_input.send_keys(playlist['name'])
    playlist_el = driver.find_element(by=By.CSS_SELECTOR, value=".list-row")
    print(f"Syncing playlist {playlist['name']}...")

    playlist_el.click() # open playlist

    # wait until page loads
    WebDriverWait(driver, 10).until(
        EC.text_to_be_present_in_element((By.CSS_SELECTOR, ".main-line"), "Synchronization details")
    )
    driver.find_element(by=By.CSS_SELECTOR, value=".schedule-starter").click() # click run now
    # wait until sync starts
    WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.CSS_SELECTOR, 'span[title="Running"]'))
    )
    # wait until sync finishes
    while True:
        try:
            driver.find_element(by=By.CSS_SELECTOR, value='span[title="Running"]')
            time.sleep(1)
            continue
        except NoSuchElementException:
            break

    driver.find_element(by=By.CSS_SELECTOR, value='button[title="Back"]').click() # close playlist

    # wait until page closes
    WebDriverWait(driver, 10).until(
        EC.text_to_be_present_in_element((By.CSS_SELECTOR, ".main-line"), "My synchronizations")
    )

    print(f"Sync finished for {playlist["name"]}")

driver.quit()
chrome.terminate()