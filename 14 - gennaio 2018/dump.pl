#!/usr/bin/perl

#gestione ARGV
die "troppi input ARGV" if ($#ARGV>2);
my $dumpfile = shift || die "need file";
my $S=shift || die "need start";
my $F=shift || die "need finish";

die "valori S e F non validi" if($S<0 || $S>$F || $F>=24 || $F<0);

#gestione dati

my %udp; #scalare per il file udp.log
my %flag; #scalare per il file flag.log

#inizio a leggere il file dump.log
open(DUMP,"<$dumpfile") || die "impposibile aprire file";
foreach(<DUMP>){
	chomp $_;
	if($_=~/(.*)\sIP\s(\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}(?:\.\d*))\s>\s(\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}(?:\.\d*)):\s(\w*).*/){
		#print "$1,$2,$3,$4\n";
		if((substr $1,0,2) >=$S && (substr $1,0,2)<=$F){
			if($4 eq "UDP"){
				$udp{$1}="$1 --> $2 > $3";
			}
			else{
				$flag{$1}="$1 --> $2 > $3";
			}
		} 	
	}
}
close(DUMP) || die "impossibile chiudere file";

#scrivo il file udp.log
open(UDP,">udp.log") || die "impossibile aprire file";
print UDP "$udp{$_}\n" for(sort{$a cmp $b}keys %udp);
print UDP "Totale: ",scalar keys %udp;
close(UDP) || die "impossibile chiudere file";
#scrivo il file flag.log
open(FLAG,">flag.log") || die "impossibile aprire file";
print FLAG "$flag{$_}\n" for(sort{$b cmp $a}keys %flag);
print FLAG "Totale: ",scalar keys %flag;
close(FLAG) || die "impossibile chiudere file";
