#!/usr/bin/perl

use Socket;

my $target = $ARGV[0];
my $dirlist = $ARGV[1];
my $hold = $ARGV[2];
die "usage: $0 <target> <inputfile> <secs>" if (!$ARGV[1]);

system('clear');

open(TXT, "$dirlist") || die "Error: couldn't open $dirlist\n";
@dirs = <TXT>;
close(TXT);

my $dircount = @dirs;
print "Loaded $dircount directory names\n\n";

print "Press Enter To Continue...\n";
<STDIN>;

foreach(@dirs) {
$iaddr = inet_aton($target);
$paddr = sockaddr_in('80', $iaddr);
$proto = getprotobyname('tcp');

socket(SOCK, PF_INET, SOCK_STREAM, $proto);
connect(SOCK, $paddr) || die "Error: Couldnt connect to socket\n";
send(SOCK, "GET /".$_."\n\n", 0) || die "Error: Couldnt send to socket\n";

@results = <SOCK>;

if (grep /301 Moved Permanently/i, @results ){
push(@valid, $_);
$count++;
print "VALID\t\t$_\n";   
}
   
else {
print "INVALID\t\t$_\n";
}
   
$scanned++;
sleep $hold;
}

if (!$count) {print "No valid directorys at $target\n"; exit}

print "\n $count valid dir(s) at $target\n\n";
print "x" x 50; print "\n\n";
 
foreach(@valid) {
print "$_\n"
}