#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://www.zenrows.com/blog/scrapy-splash#steps-to-integrate-scrapy-splash

# add sudo to get the web permission
sudo docker run -it -p 8050:8050 --rm scrapinghub/splash
# visit:
# http://0.0.0.0:8050

pip install scrapy-splash
pip install scrapy

# modify settings.py, then:

scrapy genspider scraping_club https://scrapingclub.com/exercise/list_infinite_scroll/

scrapy crawl scraping_club
# 2024-05-12 21:52:26 [scrapy.core.scraper] DEBUG: Scraped from <200 https://scrapingclub.com/exercise/list_infinite_scroll/>
# {'url': '/exercise/list_basic_detail/93926-C/', 'image': '/static/img/93926-C.jpg', 'name': 'Short Chiffon Dress', 'price': '$49.99'}
# 2024-05-12 21:52:26 [scrapy.core.scraper] DEBUG: Scraped from <200 https://scrapingclub.com/exercise/list_infinite_scroll/>
# {'url': '/exercise/list_basic_detail/93756-B/', 'image': '/static/img/93756-B.jpg', 'name': 'V-neck Top', 'price': '$24.99'}
# 2024-05-12 21:52:26 [scrapy.core.scraper] DEBUG: Scraped from <200 https://scrapingclub.com/exercise/list_infinite_scroll/>
# {'url': '/exercise/list_basic_detail/93756-D/', 'image': '/static/img/93756-D.jpg', 'name': 'V-neck Top', 'price': '$24.99'}
