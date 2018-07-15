#!/usr/bin/perl
# Check dei parametri

$option = shift;
my @file;
open(FILE,"<history.log");
foreach(<FILE>){
	chomp $_;
        push (@file,$_);
}
close(FILE);
#se il parametro è vuoto allora stampo il file
if ($option eq ""){
	foreach(@file){
		print "$_\n";
	}
}
#se il parametro è --sort stampo il file in ordine
if($option eq "--sort"){
	die "troppi parametri in input ! $!" if($#ARGV >= 0);
	print "$_\n" for sort @file;
}
#se il parametro è --stat stampo le statistiche
if($option eq "--stat"){
	die "troppi parametri in input ! $!" if($#ARGV >= 0);
	my @noDupli;
	my %look;
	foreach(@file){
		$_=~/(^\w{2,6})/;
		if(!$look{$1}){
			push @noDupli,$1;
			$look{$1}=1;
		}
	}
#	elimino i duplicati e li memorizzo in un vettore per procedere con la conta degli utilizzi
#	print "@noDupli\n";
	foreach(@noDupli){
		$comando=$_;
		$utilizzi=0;
		foreach(@file){
			if($_=~/$comando/){
				$utilizzi++;
			}
		}
		print "$comando --> $utilizzi\n";
	}
}
#se il parametro è -f argomento allora stampo i match nel file
if($option eq "-f"){
	$par=shift || die "manca parametro";
	die "troppi parametri in input ! $!" if($#ARGV >= 0);
	foreach(@file){
		if($_=~/$par/){
			print "$_\n";
		}
	}
}
else{
	die "parametro non consentito"; 
}
