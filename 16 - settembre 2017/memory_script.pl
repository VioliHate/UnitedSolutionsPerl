#!/usr/bin/perl
use strict;
use warnings;

my $t=shift || 2;
my $memFree=0;
my @inc;
my @dec;
my $volte=0;
while(1){
	sleep($t);
	my $line= qx{cat /proc/meminfo | grep ^MemFree:};
	chomp $line;
	#print "$line\n";
	$line=~s/MemFree:\s+//;
	$line=~s/kB//;
	#print "$line\n";
	my $diff=$memFree-$line;
	$memFree=$line;
	if($diff>0){
		print ">";
		push(@inc,$diff);
	}elsif($diff<0){
		print "<";
		push(@dec,$diff);
	}else{
		print "=";
	}
	print " $diff kB\n";
	$volte++;
	if($volte==5){
		open(LOG,">>mem_free.log") || die "impssibile aprire";
		print LOG "i\n";
		print LOG join(",",@inc),"\n";
		print LOG "d\n";
		print LOG join(",",@dec),"\n";
		print LOG "-"x10,"\n";
		close LOG;
		@inc=();
		@dec=();
		$volte=0;
	}

}
