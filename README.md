[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

# DEPRECATED
This package has been obsoleted and replacd by [ork-beer](https://github.com/AlexHowansky/ork-beer).

The maps linked here will no longer be updated.

# Beer
Tools to generate a portable database of brewery information.

# What does this do?
These scripts will pull data from brewersassociation.org for every brewery in
a given state or country, and format it into a CSV that is suitable for
general use.

# Why does this exist?
I was going on a road trip and wanted to visit some breweries. I located a
source of data, and whipped up this code to scrape it and get it into a format
I could import into Google My Maps. Also, because beer.

# Usage
To download data to CSV files:
* For one state: `state.sh "New York"`
* For all states: `all_states.sh`
* For one country: `country.sh Belgium`
* For all countries: `all_countries.sh`

See the `states` file for supported state names and the `countries` file for
supported country names.

# Data
These scripts will create files like `archive/United_States/New_York/New_York_YYYYMMDD.csv`.
If you run one of the single location scripts (`state.sh` or `country.sh`) and
any previous CSV files for that location exist, then you'll also get a diff
from the most recent version.

# Maps
The original intent of this project was to create Google My Maps of the
breweries. The CSV files in the archive directory are suitable for this
purpose, but the data could be cleaned up a bit before importing.

The `prep_for_gmap.php` script will find the most recent data file that has
been downloaded for each state, strip out breweries that have no address or are
in the "planning" stage, and then write the output to `gmap.csv`. It can take a
list of state names as command line parameters.

Since Google My Maps has a limit of 2000 points per map, the data has been
split into groups according to the US Census Bureau regions. the `make_gmaps.sh`
script will utilize the `prep_for_gmap.php` script to build CSV files for each
region:
* northeast_new_england.csv
* northeast_mid_atlantic.csv
* south_south_atlantic.csv
* south_east_south_central.csv
* south_west_south_central.csv
* midwest_east_north_central.csv
* midwest_west_north_central.csv
* west_mountain.csv
* west_pacific.csv

My latest maps can be found here:
* Northeast: https://goo.gl/I0Vh2n
* South: https://goo.gl/HsXgMp
* Midwest: https://goo.gl/UAr919
* West: https://goo.gl/cUwzpH
