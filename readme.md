This map holds solution for the exercise for applying to a Perl Developer.

The exercise reads a table from 2 separate mysql databases and displays the differences to stdout in json.

Environment: 
 - ubuntu 16.04LTS
 - Perl 5 (v5.22.1) with mysql and json support.
 - mysql (Server version: 5.7.22-0ubuntu0.16.04.1 (Ubuntu))
   - databases (test_db, prod_db)

Available files:
 - TestDB.sql       holds table creation and data for the test database.
 - ProductionDB.sql holds table creation and data for the production database.
 - diff_db.pl       perl script for reading the database and produces the differences in son format.
                    ex run: perl diff_db.pl test_db localhost user1 pwd1 prod_db localhost user2 pwd2
 - exercise.pdf     The interview assignment for Perl Developer.
