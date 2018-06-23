my @schedina;
my $time;
$ARGV[0]=~/([0-9]{2}):([0-9]{2})/;
if($1>22 || $1<"01"){
	exit 0;
}
elsif($1<"08" || $1=="22"){
	$time=8;
}
else{
	$time=$1+1;
	print "$time\n";
}
$time=$time.".txt";

print "$time\n";

open(SCHEDA,"<winforlife/schedina.txt");
foreach(<SCHEDA>){
	push @schedina,split(/\s/,$_);

}
close(SCHEDA);
print "@schedina\n";
my @numeri;
open(PLAY,"<winforlife/estrazioni/$time");
foreach(<PLAY>){
	
        @numeri=split(/\s/,$_);
        
}
close(PLAY);
print "@numeri\n";
my $contatore=0;
foreach(@numeri){
	if($schedina[$_-1]=="x"){
		$contatore++;
	}
}

#print "$contatore\n";

if($contatore>=7){
	print "la giocata è vincente\n";
}
else{
	print "la giocata è perdente\n";
}
