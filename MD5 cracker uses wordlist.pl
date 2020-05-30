#!/usr/bin/perl -w
use strict;
use warnings;

use Digest::MD5 qw(md5_hex); #Import hex based hash into app

my @hashes;
my $i = 0;
my @plain;
my $file = "passes.txt";

   #open pass file
   open(PLAIN, "$file") || die "File $file Doesn't Exist";
   
 #Read pass file into array
  @plain = <PLAIN>;           

   my $hashfile = "hash.txt";

   #open hash file
   open(HASH, "$hashfile") || die "File $hashfile does not exist";
   
   #read hash into scalar
   my $hash = <HASH>;

 
 
  #Convert Passes in array and compare there hash against hash in hash.txt
 
  foreach (@plain) {             
    $hashes[$i] = md5_hex($plain[$i]);
   
      #If hash in hash.txt equals the passes hash in pass.txt write pass to hit.txt
     
   if  (($hashes[$i]) eq ($hash)) {
         open(HIT, ">hit.txt");
         print HIT "$plain[$i]";
         exit(0);
       }
       
       $i++;
  }