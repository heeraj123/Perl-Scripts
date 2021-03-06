 #!/usr/bin/perl

use strict;
use warnings;
use Digest::MD5 qw(md5_hex);

sub usage(){

print "\n\t******** Splash Md5 cracker! *********\n\n";
print "\t  Usage: $0 <hash-file> <wordlist>\n\n";
print "\t**************************************\n\n";

}

my $hashplace=shift;
my $wlistplace=shift;

if(!$wlistplace){
   usage();
   exit;
}
   open(HASH,$hashplace) || die "Could not open hash: $!\n";
      chomp(my $hash=<HASH>);
   close(HASH);

if(length($hash)!=32){
   die "\t$hash is not a valid md5-hash!\n";
}
if($hash !~ /\d|[a-f]{32}/g){
   die "\t$hash is not a valid md5-hash!\n";
}
   open(WLIST,$wlistplace) || die "Could not open wordlist: $!\n";

while(<WLIST>){
   chomp($_);
   chomp(my $md5=md5_hex($_));
   print "$md5 != $hash\n";
   if($md5 eq $hash){
      die "\tHash successfully cracked!\n\n\t$hash == $_\n\n";
   }
}
close(WLIST);

print "Hash not found in wordlist\n"; 