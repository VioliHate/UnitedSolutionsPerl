#!/usr/bin/perl
 use strict;
 use warnings;
 my $line=1;
 my $conta=0;
foreach(glob("$ARGV[0]/*.txt")){
	open my $f, "<", $_ or die "cant open";
	print "il file $_ contiene errori nelle righe: ";
	foreach(<$f>){
		if($_=~/[\.]\s([a-z])/){
			if($conta==0){
				print "$line";
			}
			else{
				print ",$line";
			}
			$conta++;
		}
		$line++;
	}
	close($f);
	$conta=0;
	$line=1;
	print "\n";	
}
