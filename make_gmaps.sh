#!/bin/bash

# Creates CSV files for each US region

echo "northeast"
./prep_for_gmap.php Connecticut Maine Massachusetts "New Hampshire" "New Jersey" "New York"  Pennsylvania "Rhode Island" Vermont
mv gmap.csv northeast.csv
echo

echo "south"
./prep_for_gmap.php Alabama Arkansas Delaware "District of Columbia" Florida Georgia Kentucky Louisiana Maryland Mississippi "North Carolina" Oklahoma "South Carolina" Tennessee Texas Virginia "West Virginia"
mv gmap.csv south.csv
echo

echo "midwest"
./prep_for_gmap.php Illinois Indiana Michigan Ohio Wisconsin Iowa Kansas Minnesota Missouri Nebraska "North Dakota" "South Dakota"
mv gmap.csv midwest.csv
echo

echo "west"
./prep_for_gmap.php Arizona Colorado Idaho Montana Nevada "New Mexico" Utah Wyoming Alaska California Hawaii Oregon Washington
mv gmap.csv west.csv
