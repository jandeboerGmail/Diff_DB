#!/usr/bin/perl
#**********************************************************************
# Filename : diff_db.pl
#
# Description :
#     Displays the differences between the dqtransactionb table from 2 mysql databases
#     and shows them.
#
# Author : jan de Boer           DATE : June 2018
#
# Parameters: <db1> <host1> <user1> <passwd1> <db2> <host2> <user2> <passwd2>
#
# Result : differences in JSON on stdout  
#
# VERSION DATE       WHO   DETAIL
# 1.0     07.06.2018 JDB   Initial release
#
#**********************************************************************
use strict;
use warnings;
use Switch;
use DBI;
use JSON::XS;

my ($testDB, $testHost, $testUser, $testPasswd, $prodDB, $prodHost, $prodUser, $prodPasswd) = @ARGV;
my $nbrParms = $#ARGV + 1;
my $errstr = "ERROR   : connection details to test en production database needed on command line." ;

if ($nbrParms != 8) {
  print  "$errstr\n" ;
  print "Example : <program> <testdb> <hostname> <user> <passwd>";
  print " <proddb> <hostname> <user> <passwd\n>";
  exit;
}

# Connect to the database.
my $dbt = DBI->connect("DBI:mysql:database=$testDB;host=$testHost", $testUser,$testPasswd ,{'RaiseError' => 1});
my $dbp = DBI->connect("DBI:mysql:database=$prodDB;host=$prodHost", $prodUser,$prodPasswd ,{'RaiseError' => 1});

my @db1;
my @db2;
my $coder = JSON::XS->new->utf8->pretty;
my @ojson;

#read data from databases
@db1 = read_db($dbt);
#display_db_data(@db1);

@db2 = read_db($dbp);
#display_db_data(@db2);

compare_databases();

#output json
print $coder->encode(\@ojson);

# Disconnect from the databases.
$dbt->disconnect();
$dbp->disconnect();
# ----------------------------------------------
# read the dgtransactions table from the database
sub read_db {
  my ($db) = @_;

  my @db_data;
  my $i = 0;

  # now retrieve data from the table.
  my $sth = $db->prepare("SELECT * FROM `dqtranslations` ORDER by name, language");
  $sth->execute();
  while (my @row = $sth->fetchrow_array) { 
    $db_data[$i][0] = $row[0]; 
    $db_data[$i][1] = $row[1]; 
    $db_data[$i][2] = $row[2]; 
    $i++;
  }
  return (@db_data);
}
 
# display the database values from the  variable
sub display_db_data {
  my (@db_data) = @_;
 
  print "DB Data\n";
  for my $ref (@db_data) {
    print @$ref[0]." ";
    print @$ref[1]." ";
    print @$ref[2]."\n";
  }
}

# compare the values and set the result in the array
sub compare_databases {

  my $i = 0; 
  my $j = 0; 
  my $maxj = 0;
  my $found = 'F';
  my $result = 'M' ; # Default Missing

  my @same;
  my @different;
  my @missing; 

  for my $d1 (@db1) {
     $j = 0;
     $maxj = $#db2;
     $found = 'F'; 
     $result = 'M'; # missing

     while ($j  <= $maxj && $found eq 'F') {
  
	my $compare1 = compare_value (@$d1[0],$db2[$j][0]);
	my $compare2 = compare_value (@$d1[1],$db2[$j][1]);
	my $compare3 = compare_value (@$d1[2],$db2[$j][2]);

        if ($compare1 eq 'T' && $compare2 eq 'T'  &&  $compare3 eq 'T') {
          $result = 'S' ; # Same
          $found = 'T';
        }
        else {
          if ($compare1 eq 'T' && $compare2 eq 'T')   {
            $result = 'D'; # Different
            $found = 'T';
          }
        }
        $j++;
     }
     $j--;
     # results to json
     switch($result) {
       case 'S'	{ push @same, {name => @$d1[0], language => @$d1[1], value => @$d1[2] } }
       case 'D'	{ push @different, {name => @$d1[0], language => @$d1[1], valueInTest => @$d1[2], valueInProduction => $db2[$j][2] } }
       case 'M'	{ push @missing, {name => @$d1[0], language => @$d1[1], valueInTest => @$d1[2], valueInProduction => $db2[$j][2] } }
       else     { print "Error"}
     }
     $i++;
  }
 
  # create master json
  push @ojson, {same => \@same };
  push @ojson, {different => \@different };
  push @ojson, {missing => \@missing };

} 
sub compare_value {
    my($value1,$value2) = @_;
    my $result = 'F';
   
    if ($value1 eq $value2) {
        $result = 'T';
    } 
    return ($result);
}
