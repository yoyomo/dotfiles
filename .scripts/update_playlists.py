import re
from playwright.sync_api import Page, expect

def test_has_title(page: Page):
    page.goto("https://soundiiz.com/webapp/scheduleds")

    # TODO: sign in by google 😬
    expect(page).to_have_title(re.compile("Playwright"))

# TODO: Implement the update_syncs.js code in Python selenium