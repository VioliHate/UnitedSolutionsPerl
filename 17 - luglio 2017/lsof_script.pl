#!/usr/bin/perl
use strict;
use warnings;
die "troppi argomenti\n" if($#ARGV>0);
my $user=shift || qx{whoami}; #prendo parametro da ria di comando oppure immetto lo standard da traccia;
chomp $user;
my @comando=qx{lsof -a -cbash -u$user -Ftn};
my @righe;
#print "@comando\n";
foreach(@comando){
	if($_=~/^p(.+)/){
		print "$1\n";
	}elsif($_=~/^t(.+)/){
		print ":$1:";
	}elsif($_=~/n(.+)/){
		print "$1\n";
	}
}
