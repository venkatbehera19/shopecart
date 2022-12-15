# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Real Time - stimulus 1 -> rails g stimulus search-form
* Real Time - stimulus 2 -> rails  stimulus:manifest:update

* rails generate migration remove_COLUMNNAME_from_TABLENAME COLUMNNAME:DATATYPE
* eg- rails generate migration remove_access_level_from_users access_level:string
* eg- rails g migration remove_category_id_from_products category:references