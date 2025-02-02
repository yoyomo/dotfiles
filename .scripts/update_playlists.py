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

chrome = Popen(["/Applications/Google Chrome.app/Contents/MacOS/Google Chrome",
                "--remote-debugging-port=9222"])

# Attach to running Chrome session
options = webdriver.ChromeOptions()
options.debugger_address = "127.0.0.1:9222"
driver = webdriver.Chrome(options=options)

driver.get("https://soundiiz.com/webapp/scheduleds")

driver.implicitly_wait(0.5)

wait = WebDriverWait(driver, 10)
wait.until(
    EC.text_to_be_present_in_element((By.CSS_SELECTOR, ".main-line"), "My synchronizations")
)

# Minimize the window (so it runs in the background)
driver.minimize_window()
print("Chrome is running in the background...")

search_input = driver.find_element(by=By.CSS_SELECTOR, value=".search-input")
# Search all playlists
for playlist in playlists:
    print(f"Syncing playlist {playlist['name']}...")
    search_input.send_keys(playlist['name'])
    playlist_elements = driver.find_elements(by=By.CSS_SELECTOR, value=".list-row")
    for i in range(len(playlist_elements)):
        # elements go stale after page reload
        playlist_el = driver.find_elements(by=By.CSS_SELECTOR, value=".list-row")[i]

        playlist_el.click() # open playlist

        wait.until(
            EC.text_to_be_present_in_element((By.CSS_SELECTOR, ".main-line"), "Synchronization details")
        )
        driver.find_element(by=By.CSS_SELECTOR, value=".schedule-starter").click() # click run now
        wait.until(
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

        wait.until(
            EC.text_to_be_present_in_element((By.CSS_SELECTOR, ".main-line"), "My synchronizations")
        )

    print(f"Sync finished for {playlist['name']}")

driver.quit()
chrome.terminate()