my @intervallo=split(/-/,$ARGV[1]);
#print @intervallo;
my @dialoghi;
my $yes=0;
my $row;
if($intervallo[0]>=60 || $intervallo[1]>=60){
	print "error - max intervallo 59\n";
	exit 0;
}
if($intervallo[0]>$intervallo[1]){
	print "error - first set > second set\n";
	exit 0;
}
open(FILE,"$ARGV[0]");
foreach (<FILE>){
	if($_=~ /([0-9]{2}):([0-9]{2}):([0-9]{2}),([0-9]{3})\s-->\s([0-9]{2}):([0-9]{2}):([0-9]{2}),([0-9]{3})/){
		if($2>=$intervallo[0] && $6<$intervallo[1]){
			$yes=1;
		}
		else{
			$yes=0;
		}
	}
	if($yes){
		if($_=~/\w{3,15}/){
			if($_!~/[0-9]{1}\n/ && $_!~/[0-9]{2}:/){
				push @dialoghi,$_;
			}
		}
	}
}
close(FILE);
$ARGV[0]=~ s/.srt/_/; #sostituisco .srt con _
open(NF,">$ARGV[0]$ARGV[1].srt");
foreach(@dialoghi){
	$_=~ s/^\s+//; #ideone delle 00:24 così stampa su file senza spazi a sinistra
	print NF "$_";
}
close(NF);
