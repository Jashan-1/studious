# test_selectors.py
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait, Select
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service
import selenium_stealth
import time

# Setup Chrome
options = webdriver.ChromeOptions()
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
options.add_argument("--disable-blink-features=AutomationControlled")
options.add_argument("--window-size=1920,1080")
options.add_experimental_option("excludeSwitches", ["enable-automation"])
options.add_experimental_option('useAutomationExtension', False)

driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

# Apply stealth
selenium_stealth.stealth(driver,
    languages=["en-US", "en"],
    vendor="Google Inc.",
    platform="MacIntel",
    webgl_vendor="Intel Inc.",
    renderer="Intel Iris OpenGL Engine",
    fix_hairline=True,
)

wait = WebDriverWait(driver, 60)

try:
    print("Opening ePathshala...")
    driver.get("https://epathshala.nic.in/process.php?id=students&type=eTextbooks&ln=en")
    print("Page loaded. Waiting for iframe with src containing 'test.html'...")

    # Wait for iframe with src containing "test.html"
    iframe = wait.until(
        EC.presence_of_element_located(
            (By.XPATH, "//iframe[contains(@src, 'test.html')]")
        )
    )
    print(f"Found iframe: {iframe.get_attribute('id')} src={iframe.get_attribute('src')}")

    # Switch into iframe
    driver.switch_to.frame(iframe)
    print("Switched into iframe")

    # Now find dropdowns
    print("Waiting for Class dropdown (id='class')...")
    class_dropdown = wait.until(EC.presence_of_element_located((By.ID, "class")))
    print("Found dropdown!")

    Select(class_dropdown).select_by_visible_text("Class X")
    print("Selected Class X")

    time.sleep(3)
    subject_dropdown = wait.until(EC.presence_of_element_located((By.ID, "subject")))
    subjects = [opt.text.strip() for opt in Select(subject_dropdown).options if opt.text.strip() and "Select" not in opt.text]
    print(f"Subjects: {subjects}")

    print("\nALL TESTS PASSED!")

except Exception as e:
    print(f"ERROR: {e}")
    driver.save_screenshot("error_debug.png")
    print("Screenshot saved: error_debug.png")
    print("Check if iframe src is 'test.html' or 'initial.html'")
finally:
    driver.quit()