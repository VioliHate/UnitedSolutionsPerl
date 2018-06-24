my @posti;
open(BUS,"<bus.txt");
foreach(<BUS>){
	if($_=~/(\W)\s/){
		push @posti,split(/\s/,$_);
	}
	elsif($_=~/(\W)\n/){
		push @posti,split(/\n/,$_);
	}
}
close(BUS);
my @furbetti;
open(PPL,"<passeggeri.txt");
foreach(<PPL>){
	if($_=~/([0-9]{1}|[0-9]{2})\s(\w{2})\s([0-9]{1}|[0-9]{2})\n/){
		if($2 eq "no"){
			if($3<=$ARGV[0]){
				push @furbetti,$1;
				$posti[$1-1]='_';
			}
			else{
				$posti[$1-1]='X';	
			}
		}
		if($3<=$ARGV[0]){
			$posti[$1-1]='_';
		}
	}
}
close(PPL);
print "Passeggeri furbi: @furbetti\n";
open(NBUS,">newBus.txt");
my $size=@posti;
for(my $i=0;$i<$size;$i++){
	if($i==24){
		print NBUS "            \n";
	}
	if($i==0 || $i==12 || $i==24 || $i==36){
		print NBUS "$posti[$i]";
	}
	elsif($i==11 || $i==23 || $i==35 || $i==47){
		print NBUS " $posti[$i]\n";
	}
	elsif($i%12>0 && i%12<11){
		print NBUS " $posti[$i]";
	}
}
close(NBUS);
