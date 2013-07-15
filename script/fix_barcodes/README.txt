This folder contains a script to fix the incorrect barcodes in the barcodes DB table.
If it finds incorrect barcoddes in the DB, then it is also creates a file,
which mappes the incorrect ean13 barcode with the coorect one. It also adds the
correct sanger barcode to an entry.

Here is an example of the outcome if you execute this script:

3820288261675           -> 3820288261682,           ND0288261D
incorrect ean13 barcode -> correct ean13 barcode,   correct sanger code


To run the script you have to execute the following file:

start_ean13_fixing.rb

with the following parameters:

-d <the connection string to your DB> for example: "sqlite:///Users/a1/test.db"
-f <the path of the mapping file to create> for example: ~/barcode_mapping.txt

Here is a full example:

bundle exec ruby script/fix_barcodes/start_ean13_fixing.rb 
    -d sqlite:///Users/a1/lims-support-app/test.db
    -f /Users/a1/lims-support-app/barcode_mapping.txt
