#!/bin/bash

# Creates CSV files for each US region
# @see https://en.wikipedia.org/wiki/List_of_regions_of_the_United_States#Census_Bureau-designated_regions_and_divisions

echo "northeast new england"
./prep_for_gmap.php Connecticut Maine Massachusetts "New Hampshire" "Rhode Island" Vermont
mv gmap.csv northeast_new_england.csv
echo

echo "northeast mid-atlantic"
./prep_for_gmap.php "New Jersey" "New York"  Pennsylvania
mv gmap.csv northeast_mid_atlantic.csv
echo

echo "south south atlantic"
./prep_for_gmap.php Delaware "District of Columbia" Florida Georgia Maryland "North Carolina" "South Carolina" Virginia "West Virginia"
mv gmap.csv south_south_atlantic.csv
echo

echo "south east south central"
./prep_for_gmap.php Alabama Kentucky Mississippi Tennessee
mv gmap.csv south_east_south_central.csv
echo

echo "south west south central"
./prep_for_gmap.php Arkansas Louisiana Oklahoma Texas
mv gmap.csv south_west_south_central.csv
echo

echo "midwest east north central"
./prep_for_gmap.php Illinois Indiana Michigan Ohio Wisconsin
mv gmap.csv midwest_east_north_central.csv
echo

echo "midwest west north central"
./prep_for_gmap.php Iowa Kansas Minnesota Missouri Nebraska "North Dakota" "South Dakota"
mv gmap.csv midwest_west_north_central.csv
echo

echo "west mountain"
./prep_for_gmap.php Arizona Colorado Idaho Montana Nevada "New Mexico" Utah Wyoming
mv gmap.csv west_mountain.csv
echo

echo "west pacific"
./prep_for_gmap.php Alaska California Hawaii Oregon Washington
mv gmap.csv west_pacific.csv
echo
