open(FILE,"<$ARGV[0]");
my %campionato;
my $primeDieci=0;
foreach(<FILE>){
	if($_=~ /(\w{1,15})-(\w{1,15})\s([0-9]{1})-([0-9]{1})/){
		if($primeDieci<10){
			#print "entro: $primeDieci\n";
			if($3>$4){
				@campionato{$1,$2}=(3,0);
			}
			elsif($3<$4){
				@campionato{$1,$2}=(0,3);	
			}
			else{
				@campionato{$1,$2}=(1,1);
			}
			$primeDieci++;	
		}
		else{
			#print "entro\n";
			if($3>$4){
				$campionato{$1}=$campionato{$1}+3;
			}
			elsif($3<$4){
				$campionato{$2}=$campionato{$2}+3;
			}
			else{
				$campionato{$1}=$campionato{$1}+1;
				$campionato{$2}=$campionato{$2}+1;
			}
		}
	}
}
close(FILE);
foreach $squadra (sort { $campionato{$b} <=> $campionato{$a} } keys %campionato){
		
		print "$squadra - $campionato{$squadra}\n";	 
}

