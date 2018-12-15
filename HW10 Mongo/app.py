from flask import Flask, render_template
import pymongo
from pymongo import MongoClient
import scrape_mars

app = Flask(__name__)
app.config["MONGO_URI"] = "mongodb://localhost:27017/mars_app"
mongo = PyMongo(app)

@app.route("/")
def home(): 

    mars = mongo.db.mars.find_one()
    return render_template("index.html", mars=mars)

@app.route("/scrape")
def scrape(): 

	mars = mongo.db.mars
    mars_data = scrape_mars.scrape_data()
    mars_data = scrape_mars.scrape_image()
    mars_data = scrape_mars.scrape_weather()
    mars_data = scrape_mars.scrape_facts()
    mars_data = scrape_mars.scrape_hemisphere()
    mars.update({}, mars_data, upsert=True)
	return "Done Scraping"

if __name__ == "__main__":
    app.run()