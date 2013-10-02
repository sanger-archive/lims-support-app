.PHONY: migrate_test serve
SUPPORT_APP_PATH = `bundle show lims-support-app | grep lims-support-app`
migrate_test_n:
	mysql -uroot -p -e "DROP DATABASE IF EXISTS test_lims_api; CREATE DATABASE test_lims_api DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
	bundle exec sequel -m $(SUPPORT_APP_PATH)/db/migrations -e test config/database.yml
migrate_dev_n:
	mysql -uroot -p -e "DROP DATABASE IF EXISTS development; CREATE DATABASE development DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
	bundle exec sequel -m $(SUPPORT_APP_PATH)/db/migrations -e development config/database.yml
migrate_dev_mysql:
	mysql -uroot -p -e "DROP DATABASE IF EXISTS support_development; CREATE DATABASE support_development DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
	bundle exec sequel -m $(SUPPORT_APP_PATH)/db/migrations -e development_mysql config/database.yml
	mysql -uroot -p -e "DROP DATABASE IF EXISTS sequencescape_development; CREATE DATABASE sequencescape_development DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
	bundle exec sequel -m $(SUPPORT_APP_PATH)/spec/db/sequencescape_migrations -e development config/sequencescape_database.yml
migrate_test:
	bundle exec sequel -m $(SUPPORT_APP_PATH)/db/migrations -e test config/database.yml
	mysql -uroot -p -e "DROP DATABASE IF EXISTS sequencescape_test; CREATE DATABASE sequencescape_test DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
	bundle exec sequel -m $(SUPPORT_APP_PATH)/spec/db/sequencescape_migrations -e test config/sequencescape_database.yml
	bundle exec sequel -m $(SUPPORT_APP_PATH)/spec/db/cap_migrations -e test config/cas_database.yml
migrate_test_ora:
	bundle exec sequel -m $(SUPPORT_APP_PATH)/db/migrations -e test config/database.yml
	mysql -uroot -p -e "DROP DATABASE IF EXISTS sequencescape_test; CREATE DATABASE sequencescape_test DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
	bundle exec sequel -m $(SUPPORT_APP_PATH)/spec/db/sequencescape_migrations -e test config/sequencescape_database.yml
migrate_dev_sqlite:
	bundle exec sequel -m $(SUPPORT_APP_PATH)/db/migrations -e development config/database.yml
serve:
	bundle exec rackup
dserve:
	bundle exec rackup -d


%: %.erb
	erb < $< > $@

APIARY_SOURCE_DIR= spec/requests/apiary
APIARY_SOURCES= $(shell find $(APIARY_SOURCE_DIR) )
APIARY_JSON_SOURCES= ${patsubst %.erb,%, ${APIARY_SOURCES}}

apiary.apib: script/generate_apiary.rb $(APIARY_SOURCE_DIR) $(APIARY_JSON_SOURCES)
	ruby script/generate_apiary.rb > $@

RSPEC_JSON_DIR = spec/requests
RSPEC_JSON_SOURCES = $(shell find $(RSPEC_JSON_DIR) -name '*.json')
generate_specs: script/generate_rspec.rb $(RSPEC_JSON_SOURCES)
	ruby script/generate_rspec.rb

