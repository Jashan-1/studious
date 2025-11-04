
# #!/usr/bin/env python3
# """
# ePathshala Class-10 English Chapter Embed-URL Scraper
# FIXED VERSION - Enhanced iframe detection and error handling
# """

# import re
# import time
# import logging
# import pandas as pd
# from pathlib import Path
# from typing import List, Dict, Optional

# from selenium import webdriver
# from selenium.webdriver.common.by import By
# from selenium.webdriver.support.ui import WebDriverWait, Select
# from selenium.webdriver.support import expected_conditions as EC
# from selenium.common.exceptions import (
#     TimeoutException,
#     StaleElementReferenceException,
#     WebDriverException,
#     NoSuchElementException
# )

# from webdriver_manager.chrome import ChromeDriverManager
# from selenium.webdriver.chrome.service import Service
# from selenium.webdriver.chrome.options import Options

# try:
#     import selenium_stealth
#     STEALTH_AVAILABLE = True
# except ImportError:
#     STEALTH_AVAILABLE = False
#     print("selenium-stealth not installed. Running without stealth mode.")

# # --------------------------------------------------------------------------- #
# # Logging
# # --------------------------------------------------------------------------- #
# logging.basicConfig(
#     level=logging.INFO,
#     format="%(asctime)s - %(levelname)s - %(message)s",
#     handlers=[
#         logging.FileHandler("epathshala_scraper.log", encoding="utf-8"),
#         logging.StreamHandler(),
#     ],
# )
# log = logging.getLogger(__name__)

# # --------------------------------------------------------------------------- #
# # Main Scraper Class
# # --------------------------------------------------------------------------- #
# class EPathshalaScraper:
#     BASE_URL = "https://epathshala.nic.in/process.php?id=students&type=eTextbooks&ln=en"

#     def __init__(self, headless: bool = False):
#         self.headless = headless
#         self.driver = None
#         self.wait = None
#         self.results: List[Dict] = []

#     def setup_driver(self):
#         log.info("Setting up Chrome WebDriver...")
#         opts = Options()
#         if self.headless:
#             opts.add_argument("--headless=new")
#         opts.add_argument("--no-sandbox")
#         opts.add_argument("--disable-dev-shm-usage")
#         opts.add_argument("--disable-blink-features=AutomationControlled")
#         opts.add_argument("--window-size=1920,1080")
#         opts.add_experimental_option("excludeSwitches", ["enable-automation"])
#         opts.add_experimental_option('useAutomationExtension', False)

#         service = Service(ChromeDriverManager().install())
#         self.driver = webdriver.Chrome(service=service, options=opts)
#         self.driver.set_page_load_timeout(300) 
#         self.driver.implicitly_wait(10)

#         # Stealth (optional)
#         if STEALTH_AVAILABLE:
#             try:
#                 selenium_stealth.stealth(
#                     self.driver,
#                     languages=["en-US", "en"],
#                     vendor="Google Inc.",
#                     platform="MacIntel",
#                     webgl_vendor="Intel Inc.",
#                     renderer="Intel Iris OpenGL Engine",
#                     fix_hairline=True,
#                 )
#             except:
#                 log.warning("Stealth mode failed, continuing without it")

#         self.wait = WebDriverWait(self.driver, 60)
#         log.info("WebDriver ready")

#     def quit(self):
#         if self.driver:
#             self.driver.quit()
#             log.info("WebDriver closed")

#     def wait_located(self, by, locator, timeout=60):
#         return WebDriverWait(self.driver, timeout).until(
#             EC.presence_of_element_located((by, locator))
#         )

#     def wait_clickable(self, by, locator, timeout=60):
#         return WebDriverWait(self.driver, timeout).until(
#             EC.element_to_be_clickable((by, locator))
#         )

#     @staticmethod
#     def retry_on_stale(max_attempts: int = 3):
#         def decorator(func):
#             def wrapper(*args, **kwargs):
#                 attempt = 0
#                 while attempt < max_attempts:
#                     try:
#                         return func(*args, **kwargs)
#                     except StaleElementReferenceException:
#                         attempt += 1
#                         log.warning(f"Stale element, retry {attempt}/{max_attempts}")
#                         time.sleep(1)
#                 raise
#             return wrapper
#         return decorator

#     # ------------------------------------------------------------------- #
#     # FIXED: Enhanced Iframe Handling
#     # ------------------------------------------------------------------- #
#     def switch_to_main_iframe(self):
#         """Switch to the main test.html iframe"""
#         try:
#             iframe = self.wait.until(
#                 EC.presence_of_element_located(
#                     (By.XPATH, "//iframe[contains(@src, 'test.html') or contains(@src, 'initial.html')]")
#                 )
#             )
#             src = iframe.get_attribute("src")
#             self.driver.switch_to.frame(iframe)
#             log.info(f"✓ Switched to main iframe: {src}")
#             time.sleep(2)
#         except Exception as e:
#             log.error(f"Failed to switch to main iframe: {e}")
#             raise

#     def switch_to_flipbook_iframe(self):
#         """FIXED: Handle nested iframe structure - test.html contains another iframe"""
#         log.info("Attempting to find flipbook iframe (nested structure)...")
        
#         try:
#             time.sleep(8)  # Give it extra time to load
            
#             # STEP 1: First switch to test.html iframe if we're at top level
#             try:
#                 test_iframe = self.driver.find_element(
#                     By.XPATH, "//iframe[contains(@src, 'test.html')]"
#                 )
#                 self.driver.switch_to.frame(test_iframe)
#                 log.info("✓ Switched to test.html wrapper iframe")
#                 time.sleep(3)
#             except:
#                 log.info("Already inside an iframe or test.html not found")
            
#             # STEP 2: Now find the actual flipbook iframe INSIDE test.html
#             iframe_selectors = [
#                 (By.XPATH, "//iframe[contains(@src, 'flipbook')]"),
#                 (By.XPATH, "//iframe[contains(@src, 'Class')]"),
#                 (By.XPATH, "//iframe[contains(@src, 'wp-content')]"),
#                 (By.XPATH, "//iframe[contains(@src, '/index.html')]"),
#                 (By.XPATH, "//iframe[not(contains(@src, 'test.html'))]"),
#                 (By.TAG_NAME, "iframe"),
#             ]
            
#             iframe = None
#             for by, selector in iframe_selectors:
#                 try:
#                     iframes = self.driver.find_elements(by, selector)
#                     # Filter out test.html iframes
#                     for potential_iframe in iframes:
#                         src = potential_iframe.get_attribute("src") or ""
#                         if "test.html" not in src and src:  # Skip test.html
#                             iframe = potential_iframe
#                             log.info(f"✓ Found flipbook iframe: {src[:100]}")
#                             break
#                     if iframe:
#                         break
#                 except Exception as e:
#                     log.debug(f"Selector '{selector}' failed: {e}")
#                     continue
            
#             if not iframe:
#                 log.error("No nested flipbook iframe found!")
#                 log.info(f"Current URL: {self.driver.current_url}")
                
#                 # Debug: List all iframes
#                 all_iframes = self.driver.find_elements(By.TAG_NAME, "iframe")
#                 log.info(f"Total iframes found: {len(all_iframes)}")
#                 for i, ifr in enumerate(all_iframes):
#                     src = ifr.get_attribute("src") or "no-src"
#                     log.info(f"  Iframe {i+1}: {src[:100]}")
                
#                 self.driver.save_screenshot("no_flipbook_iframe.png")
                
#                 # DON'T raise error - maybe chapters are in current frame
#                 log.warning("Continuing without switching to nested iframe...")
#                 return
            
#             # Switch to the actual flipbook iframe
#             self.driver.switch_to.frame(iframe)
#             log.info("✓ Successfully switched to flipbook content iframe")
#             time.sleep(4)
            
#             # Verify we're in the right place
#             try:
#                 body = self.driver.find_element(By.TAG_NAME, "body")
#                 log.info("✓ Flipbook body confirmed")
#             except:
#                 log.warning("Could not confirm flipbook body")
                
#         except Exception as e:
#             log.error(f"Failed to switch to flipbook iframe: {e}")
#             self.driver.save_screenshot("iframe_switch_failed.png")
#             # Don't raise - try to continue anyway
#             log.warning("Continuing despite iframe switch failure...")

#     def switch_to_default(self):
#         self.driver.switch_to.default_content()
#         log.info("↩ Back to top-level content")

#     # ------------------------------------------------------------------- #
#     # Dropdown Selection
#     # ------------------------------------------------------------------- #
#     @retry_on_stale()
#     def select_by_text(self, select_element, text: str):
#         Select(select_element).select_by_visible_text(text)
#         log.info(f"Selected: {text}")
#         time.sleep(2.5)

#     # ------------------------------------------------------------------- #
#     # Discover Books (WITH RETRY)
#     # ------------------------------------------------------------------- #
#     def discover_class10_books(self) -> List[tuple]:
#         max_retries = 3
#         for attempt in range(max_retries):
#             try:
#                 log.info(f"Discovering Class-10 books... (Attempt {attempt + 1}/{max_retries})")
#                 self.driver.get(self.BASE_URL)
#                 self.wait.until(EC.presence_of_element_located((By.TAG_NAME, "body")))
#                 log.info("Page loaded")

#                 self.switch_to_main_iframe()

#                 class_sel = self.wait_located(By.ID, "class")
#                 self.select_by_text(class_sel, "Class X")

#                 subject_sel = self.wait_located(By.ID, "subject")
#                 subjects = [
#                     opt.text.strip()
#                     for opt in Select(subject_sel).options
#                     if opt.text.strip() and "Select" not in opt.text
#                 ]

#                 books = []
#                 for subj in subjects:
#                     log.info(f"Loading books for: {subj}")
#                     self.select_by_text(subject_sel, subj)
#                     time.sleep(3)

#                     book_sel = self.wait_located(By.ID, "book")
#                     book_opts = [
#                         opt.text.strip()
#                         for opt in Select(book_sel).options
#                         if opt.text.strip() and "Select" not in opt.text
#                     ]
#                     for b in book_opts:
#                         books.append((subj, b))

#                 log.info(f"✓ Found {len(books)} books total")
#                 self.switch_to_default()
#                 return books

#             except Exception as e:
#                 log.warning(f"Attempt {attempt + 1} failed: {e}")
#                 if attempt == max_retries - 1:
#                     raise
#                 time.sleep(10)
#                 try:
#                     self.driver.refresh()
#                 except:
#                     pass

#     # ------------------------------------------------------------------- #
#     # FIXED: Open Book Flipbook (WITH BETTER ERROR HANDLING)
#     # ------------------------------------------------------------------- #
#     def open_book_flipbook(self, class_name: str, subject: str, book: str):
#         max_retries = 3
#         for attempt in range(max_retries):
#             try:
#                 log.info(f"Opening book: {book} (Attempt {attempt + 1}/{max_retries})")
#                 self.driver.get(self.BASE_URL)
#                 self.wait.until(EC.presence_of_element_located((By.TAG_NAME, "body")))
#                 time.sleep(3)

#                 self.switch_to_main_iframe()

#                 self.select_by_text(self.wait_located(By.ID, "class"), class_name)
#                 self.select_by_text(self.wait_located(By.ID, "subject"), subject)
#                 self.select_by_text(self.wait_located(By.ID, "book"), book)

#                 go_btn = self.wait_clickable(By.XPATH, "//input[@value='Go']")
#                 go_btn.click()
#                 log.info("✓ Clicked Go button")

#                 self.switch_to_default()
                
#                 # EXTRA WAIT: Give the flipbook page time to load
#                 log.info("Waiting for flipbook to load...")
#                 time.sleep(8)  # Increased wait time
                
#                 self.switch_to_flipbook_iframe()
#                 return

#             except Exception as e:
#                 log.warning(f"Failed to open book (attempt {attempt + 1}): {e}")
#                 if attempt == max_retries - 1:
#                     log.error(f"All attempts failed for book: {book}")
#                     raise
#                 time.sleep(10)
#                 self.switch_to_default()

#     # ------------------------------------------------------------------- #
#     # ENHANCED: Extract Chapters with Better Detection
#     # ------------------------------------------------------------------- #
#     def get_chapters(self) -> List[Dict]:
#         chapters = []
#         log.info("Searching for chapter links...")
        
#         # Wait for page to fully render
#         time.sleep(5)
        
#         # DEBUG: Log what we can see
#         try:
#             page_title = self.driver.title
#             current_url = self.driver.current_url
#             log.info(f"Current page title: {page_title}")
#             log.info(f"Current URL: {current_url}")
#         except:
#             pass
        
#         # Based on the screenshot, chapters appear as simple links with text like "Chapter 1", "Chapter 2", etc.
#         # They're in the left sidebar
        
#         selectors = [
#             # Try text-based matching first (what we see in the sidebar)
#             "//a[contains(text(), 'Chapter')]",
#             "//a[contains(text(), 'Prelims')]",
#             "//a[contains(text(), 'Appendix')]",
#             "//a[contains(text(), 'Answers')]",
#             # Try structure-based
#             "//a[starts-with(text(), '» ')]",  # Links starting with »
#             "//*[contains(@class, 'sidebar')]//a",
#             "//*[contains(@class, 'menu')]//a",
#             "//nav//a",
#             # Try all links as last resort
#             "//a[@href]",
#         ]

#         links = []
#         for sel in selectors:
#             try:
#                 found = self.driver.find_elements(By.XPATH, sel)
#                 # Filter to only chapter-like links
#                 chapter_links = []
#                 for link in found:
#                     text = link.text.strip()
#                     if any(keyword in text for keyword in ['Chapter', 'Prelims', 'Appendix', 'Answers', 'Unit']):
#                         chapter_links.append(link)
                
#                 if chapter_links:
#                     links = chapter_links
#                     log.info(f"✓ Found {len(links)} chapter links with selector: {sel}")
#                     break
#             except Exception as e:
#                 log.debug(f"Selector failed: {e}")
#                 continue

#         if not links:
#             log.warning("No chapter links found! Trying to list all links for debugging...")
#             # Try to find ANY links for debugging
#             try:
#                 all_links = self.driver.find_elements(By.TAG_NAME, "a")
#                 log.info(f"Total <a> tags found: {len(all_links)}")
                
#                 for i, link in enumerate(all_links[:20]):  # Show first 20
#                     try:
#                         text = link.text.strip()
#                         href = link.get_attribute("href") or ""
#                         onclick = link.get_attribute("onclick") or ""
#                         if text:  # Only show links with text
#                             log.info(f"  Link {i+1}: '{text}' | href: {href[:60]} | onclick: {onclick[:60]}")
#                     except:
#                         pass
#             except:
#                 pass
            
#             log.info("Saving debug files...")
#             try:
#                 with open("page_source_debug.html", "w", encoding="utf-8") as f:
#                     f.write(self.driver.page_source)
#                 log.info("✓ Page source saved: page_source_debug.html")
#             except:
#                 pass
#             self.driver.save_screenshot("no_chapters_found.png")
#             log.info("✓ Screenshot saved: no_chapters_found.png")
#             return []

#         # Process found chapter links
#         log.info(f"Processing {len(links)} chapter links...")
#         for i, a in enumerate(links):
#             try:
#                 name = a.text.strip()
#                 if not name or len(name) < 2:
#                     continue
                
#                 # Skip utility links
#                 skip_keywords = ["Download complete", "Rationalised Content"]
#                 if any(keyword in name for keyword in skip_keywords):
#                     continue
                
#                 # Get the link's onclick or href
#                 onclick = a.get_attribute("onclick") or ""
#                 href = a.get_attribute("href") or ""
                
#                 log.info(f"  Processing: '{name}' | onclick: {onclick[:50]} | href: {href[:50]}")
                
#                 # Strategy 1: Extract from onclick
#                 chap_id = None
#                 if onclick:
#                     # Look for patterns like: loadChapter('ch1'), openContent('xyz'), etc.
#                     patterns = [
#                         r"loadChapter\(['\"]([^'\"]+)['\"]\)",
#                         r"openContent\(['\"]([^'\"]+)['\"]\)",
#                         r"showPage\(['\"]([^'\"]+)['\"]\)",
#                         r"\(['\"]([^'\"]+)['\"]\)",  # Any function with string parameter
#                     ]
#                     for pattern in patterns:
#                         m = re.search(pattern, onclick)
#                         if m:
#                             chap_id = m.group(1)
#                             break
                
#                 # Strategy 2: If onclick has JavaScript, use the link text as ID
#                 if not chap_id and "javascript:" in href:
#                     # Create ID from chapter name
#                     chap_id = re.sub(r'[^\w\s-]', '', name).replace(' ', '_').lower()
                
#                 # Strategy 3: Extract from direct href
#                 if not chap_id and href and "http" in href:
#                     chap_id = href.split('/')[-1].replace('.html', '').replace('.htm', '')
                
#                 # Strategy 4: Last resort - use position and name
#                 if not chap_id:
#                     chap_id = f"chapter_{i+1}_{re.sub(r'[^\w\s-]', '', name)[:20].replace(' ', '_').lower()}"
                
#                 if chap_id:
#                     # Build URL
#                     current_url = self.driver.current_url
#                     base_url = current_url.split('?')[0].rsplit('/', 1)[0] if '?' in current_url else current_url.rsplit('/', 1)[0]
#                     url = f"{base_url}/{chap_id}" if not href.startswith('http') else href
                    
#                     chapters.append({
#                         "name": name,
#                         "id": chap_id,
#                         "url": url,
#                         "onclick": onclick,
#                         "element": a  # Store element reference for clicking
#                     })
#                     log.info(f"    ✓ Added: {name} (ID: {chap_id})")
                    
#             except StaleElementReferenceException:
#                 log.warning(f"  Stale element at index {i}")
#                 continue
#             except Exception as e:
#                 log.debug(f"  Error processing link {i}: {e}")
#                 continue

#         log.info(f"✓ Successfully extracted {len(chapters)} chapters")
#         return chapters

#     # ------------------------------------------------------------------- #
#     # Extract Embed URL
#     # ------------------------------------------------------------------- #
#     def extract_embed_url(self, chapter_info: dict) -> Optional[str]:
#         """Extract embed URL for a chapter"""
#         try:
#             chapter_name = chapter_info['name']
#             chapter_id = chapter_info['id']
#             onclick = chapter_info.get('onclick', '')
            
#             log.info(f"Loading chapter: {chapter_name}")
            
#             # Strategy 1: Use onclick if available
#             if onclick:
#                 try:
#                     self.driver.execute_script(onclick)
#                     log.info(f"✓ Executed onclick: {onclick[:50]}")
#                     time.sleep(5)
#                 except Exception as e:
#                     log.warning(f"Failed to execute onclick: {e}")
            
#             # Strategy 2: Try loadChapter function
#             elif 'loadChapter' in str(chapter_id):
#                 try:
#                     self.driver.execute_script(f"loadChapter('{chapter_id}');")
#                     log.info(f"✓ Executed loadChapter('{chapter_id}')")
#                     time.sleep(5)
#                 except Exception as e:
#                     log.warning(f"loadChapter failed: {e}")
            
#             # Strategy 3: Click the link directly
#             else:
#                 try:
#                     element = chapter_info.get('element')
#                     if element:
#                         # Re-find element to avoid stale reference
#                         chapter_links = self.driver.find_elements(
#                             By.XPATH, f"//a[contains(text(), '{chapter_name}')]"
#                         )
#                         if chapter_links:
#                             chapter_links[0].click()
#                             log.info(f"✓ Clicked chapter link: {chapter_name}")
#                             time.sleep(5)
#                 except Exception as e:
#                     log.warning(f"Failed to click chapter: {e}")
            
#             # Now try to find and click Share button
#             share_selectors = [
#                 "//i[normalize-space()='share']",
#                 "//button[contains(@class, 'share')]",
#                 "//button[contains(text(), 'Share')]",
#                 "//a[contains(text(), 'Share')]",
#                 "//*[contains(@title, 'Share')]",
#                 "//*[@data-original-title='Share']",
#                 "//button[contains(@aria-label, 'share')]"
#             ]
            
#             share_btn = None
#             for selector in share_selectors:
#                 try:
#                     share_btn = WebDriverWait(self.driver, 10).until(
#                         EC.element_to_be_clickable((By.XPATH, selector))
#                     )
#                     if share_btn:
#                         log.info(f"✓ Found Share button with: {selector}")
#                         break
#                 except:
#                     continue
            
#             if not share_btn:
#                 log.warning(f"⚠ Share button not found for: {chapter_name}")
#                 self.driver.save_screenshot(f"no_share_btn_{chapter_id}.png")
#                 return None
            
#             # Click Share button
#             try:
#                 share_btn.click()
#                 log.info("✓ Clicked Share button")
#                 time.sleep(3)
#             except Exception as e:
#                 log.warning(f"Failed to click share: {e}")
#                 # Try JavaScript click
#                 try:
#                     self.driver.execute_script("arguments[0].click();", share_btn)
#                     log.info("✓ Clicked Share button via JavaScript")
#                     time.sleep(3)
#                 except:
#                     return None

#             # Extract embed URL from dialog
#             input_selectors = [
#                 "//input[contains(@value, 'iframe')]",
#                 "//textarea[contains(., 'iframe')]",
#                 "//input[contains(@value, 'epathshala')]",
#                 "//textarea[contains(., 'epathshala')]",
#                 "//input[contains(@value, 'http')]",
#                 "//textarea[contains(., 'http')]",
#                 "//*[@id='embedCode']",
#                 "//*[contains(@class, 'embed')]//input",
#                 "//*[contains(@class, 'embed')]//textarea"
#             ]
            
#             embed_url = None
#             for selector in input_selectors:
#                 try:
#                     input_el = WebDriverWait(self.driver, 8).until(
#                         EC.presence_of_element_located((By.XPATH, selector))
#                     )
#                     raw = input_el.get_attribute("value") or input_el.text or ""
                    
#                     if raw:
#                         # Try to extract URL from iframe code
#                         m = re.search(r'src=["\']([^"\']+)["\']', raw)
#                         if m:
#                             embed_url = m.group(1)
#                             log.info(f"✓ Found embed URL: {embed_url[:80]}...")
#                             break
#                         # If no iframe tag, might be direct URL
#                         elif 'epathshala' in raw or 'http' in raw:
#                             embed_url = raw
#                             log.info(f"✓ Found direct URL: {embed_url[:80]}...")
#                             break
#                 except:
#                     continue
            
#             if not embed_url:
#                 log.warning(f"⚠ Embed URL not found in Share dialog for: {chapter_name}")
#                 self.driver.save_screenshot(f"no_embed_{chapter_id}.png")
            
#             # Try to close the dialog
#             try:
#                 close_selectors = [
#                     "//button[contains(@class, 'close')]",
#                     "//button[contains(text(), 'Close')]",
#                     "//*[@aria-label='Close']"
#                 ]
#                 for selector in close_selectors:
#                     try:
#                         close_btn = self.driver.find_element(By.XPATH, selector)
#                         close_btn.click()
#                         break
#                     except:
#                         continue
#             except:
#                 pass
            
#             return embed_url
            
#         except Exception as e:
#             log.error(f"✗ Failed to extract embed for {chapter_info['name']}: {e}")
#             return None

#     # ------------------------------------------------------------------- #
#     # Scrape One Book
#     # ------------------------------------------------------------------- #
#     def scrape_book(self, subject: str, book: str):
#         log.info(f"\n{'='*70}")
#         log.info(f"SCRAPING: {subject} - {book}")
#         log.info(f"{'='*70}")
        
#         try:
#             self.open_book_flipbook("Class X", subject, book)
#             chapters = self.get_chapters()

#             if not chapters:
#                 log.warning(f"⚠ No chapters found for {book}")
#                 self.switch_to_default()
#                 return

#             log.info(f"Found {len(chapters)} chapters to process")
            
#             for i, chap in enumerate(chapters, 1):
#                 log.info(f"\n[{i}/{len(chapters)}] Processing: {chap['name']}")
#                 embed = self.extract_embed_url(chap)
                
#                 self.results.append({
#                     "class": "10",
#                     "subject": subject,
#                     "language": "English",
#                     "book_title": book,
#                     "chapter": chap["name"],
#                     "chapter_url": chap["url"],
#                     "embed_url": embed,
#                 })
                
#                 # Small delay between chapters
#                 time.sleep(2)

#             log.info(f"✓ Completed {book}: {len(chapters)} chapters processed\n")
#             self.switch_to_default()
            
#         except Exception as e:
#             log.error(f"✗ Failed to scrape {book}: {e}")
#             import traceback
#             log.error(traceback.format_exc())
#             self.switch_to_default()

#     # ------------------------------------------------------------------- #
#     # Run
#     # ------------------------------------------------------------------- #
#     def run(self):
#         try:
#             self.setup_driver()
#             books = self.discover_class10_books()

#             log.info(f"\n{'='*70}")
#             log.info(f"STARTING SCRAPE: {len(books)} books found")
#             log.info(f"{'='*70}\n")

#             for i, (subj, book) in enumerate(books, 1):
#                 log.info(f"\n[{i}/{len(books)}] {subj} → {book}")
#                 self.scrape_book(subj, book)
#                 time.sleep(5)  # Delay between books

#             self.save_results()
            
#         except KeyboardInterrupt:
#             log.warning("\n\n⚠ Scraping interrupted by user")
#             self.save_results()
#         except Exception as e:
#             log.exception(f"✗ Fatal error: {e}")
#             self.driver.save_screenshot("FATAL_ERROR.png")
#             log.info("Screenshot saved: FATAL_ERROR.png")
#         finally:
#             self.quit()

#     # ------------------------------------------------------------------- #
#     # Save Results
#     # ------------------------------------------------------------------- #
#     def save_results(self):
#         if not self.results:
#             log.warning("No results to save")
#             return
            
#         df = pd.DataFrame(self.results)
#         file = Path(f"epathshala_class10_english_{time.strftime('%Y%m%d_%H%M%S')}.csv")
#         df.to_csv(file, index=False, encoding="utf-8-sig")
        
#         print("\n" + "="*70)
#         print(" SCRAPING COMPLETE ".center(70))
#         print("="*70)
#         print(f"{'Total chapters':<30}: {len(df)}")
#         print(f"{'Books processed':<30}: {df['book_title'].nunique()}")
#         print(f"{'Chapters with embed URL':<30}: {df['embed_url'].notna().sum()}")
#         print(f"{'Output file':<30}: {file}")
#         print("="*70 + "\n")
        
#         log.info(f"✓ Results saved: {file}")


# # --------------------------------------------------------------------------- #
# # Run
# # --------------------------------------------------------------------------- #
# if __name__ == "__main__":
#     print("\n" + "="*70)
#     print(" ePathshala Class-10 Scraper ".center(70))
#     print("="*70 + "\n")
    
#     scraper = EPathshalaScraper(headless=False)  # Set True for headless mode
#     scraper.run()



#!/usr/bin/env python3
"""
ePathshala Class-10 Chapter URL Scraper
Extracts chapter URLs for all Class 10 English-medium textbooks
"""

import re
import time
import logging
import pandas as pd
from pathlib import Path
from typing import List, Dict

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait, Select
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import StaleElementReferenceException

from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options

try:
    import selenium_stealth
    STEALTH_AVAILABLE = True
except ImportError:
    STEALTH_AVAILABLE = False

# --------------------------------------------------------------------------- #
# Logging
# --------------------------------------------------------------------------- #
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler("epathshala_scraper.log", encoding="utf-8"),
        logging.StreamHandler(),
    ],
)
log = logging.getLogger(__name__)

# --------------------------------------------------------------------------- #
# Main Scraper Class
# --------------------------------------------------------------------------- #
class EPathshalaScraper:
    BASE_URL = "https://epathshala.nic.in/process.php?id=students&type=eTextbooks&ln=en"

    def __init__(self, headless: bool = False):
        self.headless = headless
        self.driver = None
        self.wait = None
        self.results: List[Dict] = []

    def setup_driver(self):
        log.info("Setting up Chrome WebDriver...")
        opts = Options()
        if self.headless:
            opts.add_argument("--headless=new")
        opts.add_argument("--no-sandbox")
        opts.add_argument("--disable-dev-shm-usage")
        opts.add_argument("--disable-blink-features=AutomationControlled")
        opts.add_argument("--window-size=1920,1080")
        opts.add_experimental_option("excludeSwitches", ["enable-automation"])
        opts.add_experimental_option('useAutomationExtension', False)

        service = Service(ChromeDriverManager().install())
        self.driver = webdriver.Chrome(service=service, options=opts)
        self.driver.set_page_load_timeout(300)
        self.driver.implicitly_wait(10)

        if STEALTH_AVAILABLE:
            try:
                selenium_stealth.stealth(
                    self.driver,
                    languages=["en-US", "en"],
                    vendor="Google Inc.",
                    platform="MacIntel",
                    webgl_vendor="Intel Inc.",
                    renderer="Intel Iris OpenGL Engine",
                    fix_hairline=True,
                )
            except:
                pass

        self.wait = WebDriverWait(self.driver, 60)
        log.info("✓ WebDriver ready")

    def quit(self):
        if self.driver:
            self.driver.quit()
            log.info("WebDriver closed")

    def wait_located(self, by, locator, timeout=60):
        return WebDriverWait(self.driver, timeout).until(
            EC.presence_of_element_located((by, locator))
        )

    @staticmethod
    def retry_on_stale(max_attempts: int = 3):
        def decorator(func):
            def wrapper(*args, **kwargs):
                attempt = 0
                while attempt < max_attempts:
                    try:
                        return func(*args, **kwargs)
                    except StaleElementReferenceException:
                        attempt += 1
                        log.warning(f"Stale element, retry {attempt}/{max_attempts}")
                        time.sleep(1)
                raise
            return wrapper
        return decorator

    # ------------------------------------------------------------------- #
    # Iframe Handling
    # ------------------------------------------------------------------- #
    def switch_to_main_iframe(self):
        """Switch to the main test.html iframe"""
        try:
            iframe = self.wait.until(
                EC.presence_of_element_located(
                    (By.XPATH, "//iframe[contains(@src, 'test.html') or contains(@src, 'initial.html')]")
                )
            )
            self.driver.switch_to.frame(iframe)
            log.info("✓ Switched to main iframe")
            time.sleep(2)
        except Exception as e:
            log.error(f"Failed to switch to main iframe: {e}")
            raise

    def switch_to_flipbook_iframe(self):
        """Switch to nested flipbook iframe"""
        log.info("Looking for flipbook iframe...")
        
        try:
            time.sleep(8)
            
            # First ensure we're in test.html iframe
            try:
                test_iframe = self.driver.find_element(
                    By.XPATH, "//iframe[contains(@src, 'test.html')]"
                )
                self.driver.switch_to.frame(test_iframe)
                log.info("✓ In test.html wrapper")
                time.sleep(3)
            except:
                pass
            
            # Find nested flipbook iframe
            iframe_selectors = [
                (By.XPATH, "//iframe[contains(@src, 'flipbook')]"),
                (By.XPATH, "//iframe[contains(@src, 'Class')]"),
                (By.XPATH, "//iframe[contains(@src, 'index.html')]"),
                (By.TAG_NAME, "iframe"),
            ]
            
            iframe = None
            for by, selector in iframe_selectors:
                try:
                    iframes = self.driver.find_elements(by, selector)
                    for potential_iframe in iframes:
                        src = potential_iframe.get_attribute("src") or ""
                        if "test.html" not in src and src:
                            iframe = potential_iframe
                            log.info(f"✓ Found flipbook iframe: {src[:80]}")
                            break
                    if iframe:
                        break
                except:
                    continue
            
            if iframe:
                self.driver.switch_to.frame(iframe)
                log.info("✓ Switched to flipbook iframe")
                time.sleep(4)
            else:
                log.warning("Flipbook iframe not found, continuing in current context")
                
        except Exception as e:
            log.warning(f"Iframe switch issue (continuing anyway): {e}")

    def switch_to_default(self):
        self.driver.switch_to.default_content()

    # ------------------------------------------------------------------- #
    # Dropdown Selection
    # ------------------------------------------------------------------- #
    @retry_on_stale()
    def select_by_text(self, select_element, text: str):
        Select(select_element).select_by_visible_text(text)
        log.info(f"Selected: {text}")
        time.sleep(2.5)

    # ------------------------------------------------------------------- #
    # Discover Books
    # ------------------------------------------------------------------- #
    def discover_class10_books(self) -> List[tuple]:
        max_retries = 3
        for attempt in range(max_retries):
            try:
                log.info(f"Discovering Class 10 books (attempt {attempt + 1}/{max_retries})...")
                self.driver.get(self.BASE_URL)
                self.wait.until(EC.presence_of_element_located((By.TAG_NAME, "body")))

                self.switch_to_main_iframe()

                class_sel = self.wait_located(By.ID, "class")
                self.select_by_text(class_sel, "Class X")

                subject_sel = self.wait_located(By.ID, "subject")
                subjects = [
                    opt.text.strip()
                    for opt in Select(subject_sel).options
                    if opt.text.strip() and "Select" not in opt.text
                ]

                books = []
                for subj in subjects:
                    log.info(f"Loading books for: {subj}")
                    self.select_by_text(subject_sel, subj)
                    time.sleep(3)

                    book_sel = self.wait_located(By.ID, "book")
                    book_opts = [
                        opt.text.strip()
                        for opt in Select(book_sel).options
                        if opt.text.strip() and "Select" not in opt.text
                    ]
                    for b in book_opts:
                        books.append((subj, b))

                log.info(f"✓ Found {len(books)} books total")
                self.switch_to_default()
                return books

            except Exception as e:
                log.warning(f"Attempt {attempt + 1} failed: {e}")
                if attempt == max_retries - 1:
                    raise
                time.sleep(10)

    # ------------------------------------------------------------------- #
    # Open Book Flipbook
    # ------------------------------------------------------------------- #
    def open_book_flipbook(self, class_name: str, subject: str, book: str):
        max_retries = 3
        for attempt in range(max_retries):
            try:
                log.info(f"Opening: {book} (attempt {attempt + 1}/{max_retries})")
                self.driver.get(self.BASE_URL)
                self.wait.until(EC.presence_of_element_located((By.TAG_NAME, "body")))
                time.sleep(3)

                self.switch_to_main_iframe()

                self.select_by_text(self.wait_located(By.ID, "class"), class_name)
                self.select_by_text(self.wait_located(By.ID, "subject"), subject)
                self.select_by_text(self.wait_located(By.ID, "book"), book)

                go_btn = WebDriverWait(self.driver, 60).until(
                    EC.element_to_be_clickable((By.XPATH, "//input[@value='Go']"))
                )
                go_btn.click()
                log.info("✓ Clicked Go")

                self.switch_to_default()
                self.switch_to_flipbook_iframe()
                return

            except Exception as e:
                log.warning(f"Failed (attempt {attempt + 1}): {e}")
                if attempt == max_retries - 1:
                    raise
                time.sleep(10)
                self.switch_to_default()

    # ------------------------------------------------------------------- #
    # Extract Chapters (Simplified)
    # ------------------------------------------------------------------- #
    def get_chapters(self) -> List[Dict]:
        chapters = []
        log.info("Extracting chapter links...")
        
        time.sleep(5)
        
        try:
            current_url = self.driver.current_url
            log.info(f"Current URL: {current_url}")
        except:
            pass
        
        # Find chapter links
        selectors = [
            "//a[contains(text(), 'Chapter')]",
            "//a[contains(text(), 'Prelims')]",
            "//a[contains(text(), 'Appendix')]",
            "//a[contains(text(), 'Answers')]",
            "//a[starts-with(text(), '» ')]",
        ]

        links = []
        for sel in selectors:
            try:
                found = self.driver.find_elements(By.XPATH, sel)
                chapter_links = []
                for link in found:
                    text = link.text.strip()
                    if any(kw in text for kw in ['Chapter', 'Prelims', 'Appendix', 'Answers', 'Unit']):
                        chapter_links.append(link)
                
                if chapter_links:
                    links = chapter_links
                    log.info(f"✓ Found {len(links)} chapters with: {sel}")
                    break
            except:
                continue

        if not links:
            log.warning("No chapters found!")
            self.driver.save_screenshot("no_chapters.png")
            return []

        # Extract chapter info
        base_url = self.driver.current_url.split('?')[0].rsplit('/', 1)[0]
        
        for i, link in enumerate(links):
            try:
                name = link.text.strip()
                if not name or len(name) < 2:
                    continue
                
                # Skip utility links
                if any(kw in name for kw in ["Download complete", "Rationalised Content"]):
                    continue
                
                href = link.get_attribute("href") or ""
                onclick = link.get_attribute("onclick") or ""
                
                # Build chapter URL
                chapter_url = None
                
                # Try to get from href
                if href and "http" in href:
                    chapter_url = href
                
                # Try to extract from onclick
                elif onclick:
                    patterns = [
                        r"loadChapter\(['\"]([^'\"]+)['\"]\)",
                        r"openContent\(['\"]([^'\"]+)['\"]\)",
                        r"\(['\"]([^'\"]+)['\"]\)"
                    ]
                    for pattern in patterns:
                        m = re.search(pattern, onclick)
                        if m:
                            chapter_id = m.group(1)
                            chapter_url = f"{base_url}/{chapter_id}"
                            break
                
                # Fallback: construct from base URL
                if not chapter_url:
                    safe_name = re.sub(r'[^\w\s-]', '', name).replace(' ', '_').lower()
                    chapter_url = f"{base_url}/{safe_name}"
                
                chapters.append({
                    "name": name,
                    "url": chapter_url,
                })
                log.info(f"  ✓ {name}")
                
            except Exception as e:
                log.debug(f"Error processing link {i}: {e}")
                continue

        log.info(f"✓ Extracted {len(chapters)} chapters")
        return chapters

    # ------------------------------------------------------------------- #
    # Scrape One Book
    # ------------------------------------------------------------------- #
    def scrape_book(self, subject: str, book: str):
        log.info(f"\n{'='*70}")
        log.info(f"SCRAPING: {subject} → {book}")
        log.info(f"{'='*70}")
        
        try:
            self.open_book_flipbook("Class X", subject, book)
            chapters = self.get_chapters()

            if not chapters:
                log.warning(f"⚠ No chapters found for {book}")
                self.switch_to_default()
                return

            for i, chap in enumerate(chapters, 1):
                log.info(f"[{i}/{len(chapters)}] {chap['name']}")
                
                self.results.append({
                    "class": "10",
                    "subject": subject,
                    "language": "English",
                    "book_title": book,
                    "chapter": chap["name"],
                    "chapter_url": chap["url"],
                })

            log.info(f"✓ Completed: {len(chapters)} chapters\n")
            self.switch_to_default()
            
        except Exception as e:
            log.error(f"✗ Failed: {e}")
            self.switch_to_default()

    # ------------------------------------------------------------------- #
    # Run
    # ------------------------------------------------------------------- #
    def run(self):
        try:
            self.setup_driver()
            books = self.discover_class10_books()

            log.info(f"\n{'='*70}")
            log.info(f"STARTING: {len(books)} books to scrape")
            log.info(f"{'='*70}\n")

            for i, (subj, book) in enumerate(books, 1):
                log.info(f"\n📚 [{i}/{len(books)}] {subj} → {book}")
                self.scrape_book(subj, book)
                time.sleep(3)

            self.save_results()
            
        except KeyboardInterrupt:
            log.warning("\n⚠ Interrupted by user")
            self.save_results()
        except Exception as e:
            log.exception(f"✗ Fatal error: {e}")
            self.driver.save_screenshot("fatal_error.png")
        finally:
            self.quit()

    # ------------------------------------------------------------------- #
    # Save Results
    # ------------------------------------------------------------------- #
    def save_results(self):
        if not self.results:
            log.warning("No results to save")
            return
            
        df = pd.DataFrame(self.results)
        file = Path(f"epathshala_class10_{time.strftime('%Y%m%d_%H%M%S')}.csv")
        df.to_csv(file, index=False, encoding="utf-8-sig")
        
        print("\n" + "="*70)
        print(" SCRAPING COMPLETE ".center(70, "="))
        print("="*70)
        print(f"{'Total chapters extracted':<30}: {len(df)}")
        print(f"{'Books processed':<30}: {df['book_title'].nunique()}")
        print(f"{'Subjects covered':<30}: {df['subject'].nunique()}")
        print(f"{'Output file':<30}: {file}")
        print("="*70 + "\n")
        
        # Show sample
        print("Sample data:")
        print(df.head(10).to_string(index=False))
        print(f"\n... and {len(df) - 10} more rows\n")
        
        log.info(f"✓ Saved to: {file}")


# --------------------------------------------------------------------------- #
# Main
# --------------------------------------------------------------------------- #
if __name__ == "__main__":
    print("\n" + "="*70)
    print(" ePathshala Class 10 Chapter URL Scraper ".center(70))
    print("="*70)
    print("\nExtracting chapter URLs for all Class 10 textbooks...")
    print("Set headless=True to run without browser window\n")
    
    scraper = EPathshalaScraper(headless=False)
    scraper.run()