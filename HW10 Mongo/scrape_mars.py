
from bs4 import BeautifulSoup
from splinter import Browser
import pandas as pd

mars_title_par = {}

def init_browser():

	executable_path = {'executable_path': '/usr/local/bin/chromedriver'}
	browser = Browser('chrome', executable_path="chromedriver", headless=True)

def scrape_data():

	browser = init_browser()
	url = "https://mars.nasa.gov/news/"
	browser.visit(url)
	html = browser.html
	soup = BeautifulSoup(html, 'html.parser')

	try: 
		latest_title = soup.find("div", class_='content_title').get_text()
		latest_par = soup.find("div", class_="article_teaser_body").get_text()
		
		mars_title_par['latest_title'] = latest_title
		mars_title_par['latest_par'] = latest_par

	except AttributeError:
		return None, None

	browser.quit()
    return mars_title_par

def scrape_image():

	browser = init_browser()
	start_url = "https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars"
	browser.visit(start_url)
	jpl_html = browser.html
	image_soup = BeautifulSoup(jpl_html, 'html.parser')

	try:
		image_part = image_soup.find("a", id="full_image")
		image_url = "/spaceimages/images/mediumsize/PIA08097_ip.jpg"
		full_url = ("https://jpl.nasa.gov" + image_url)

		mars_title_par['full_url'] = full_url

	except AttributeError:
		return None, None

	browser.quit()
	return mars_title_par

def scrape_weather():

	browser = init_browser()
	weather_url = "https://twitter.com/marswxreport?lang=en"
	browser.visit(weather_url)
	weather_html = browser.html
	weather_soup = BeautifulSoup(weather_html,"html.parser")

	try: 
		mars_temp = weather_soup.find('div', class_='tweet')
		mars_weather = mars_temp.find('p', class_='tweet-text').text

		mars_title_par['mars_weather'] = mars_weather

	except AttributeError:
		return None, None

	browser.quit()
	return mars_title_par

def scrape_facts():

	mars_facts_url = "http://space-facts.com/mars/"

	try:
		df_facts = pd.read_html(mars_facts_url)[0]
		facts_html = df_facts.to_html

		mars_title_par['facts_html'] = facts_html

	except AttributeError:
		return None, None

	return mars_title_par

def scrape_hemisphere():

	browser = init_browser()
	browser.visit(hemisphere_url)
	hemis_html = browser.html
	hemis_soup = BeautifulSoup(hemis_html, 'html.parser')

	try:

	hemis_url_title =[]
	
		for i in range (4):
		    #hemisphere = {}
		    images = browser.find_by_tag('h3')
		    #go through images
		    images[i].click()
		    hemis_html = browser.html
		    hemis_soup = BeautifulSoup(hemis_html, 'html.parser')
		    
		    #title
		    grab_title = hemis_soup.find('h2', class_='title').text
		    
		    #URL
		    url = hemis_soup.find('img', class_='wide-image')['src']
		    links_hemis = ("https://astrogeology.usgs.gov" + url)
		    create_dictionary = {'Sphere_Title' : grab_title, 'URL': url}
		    hemis_url_title.append(create_dictionary)

			mars_title_par['hemis_url_title'] = hemis_url_title

	    except AttributeError:
			return None, None

		return mars_title_par
