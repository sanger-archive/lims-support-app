/* seeds */
INSERT INTO `labellables` VALUES (1, '1234567890', 'resource'),(2, '123456789', 'resource'),(3, '12345678', 'resource');
INSERT INTO `labels` VALUES (1, 1, 'sanger-barcode', 'sanger', 'ND0288261C'), (2, 1, 'ean13-barcode', 'ean13', '3820288261675'), (3, 2, 'sanger-barcode', 'sanger', 'ND288261C'), (4, 2, 'ean13-barcode', 'ean13', '3820288261675');
INSERT INTO `barcodes` VALUES (1, 'tube_rack', 'stock', 'DNA', '3820288261675'), (2, 'tube_rack', 'stock', 'DNA', '3820288261675');