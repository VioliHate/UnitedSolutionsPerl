
#/(m\d.eml)/; # Skip files matching pattern 
my @girone;
for my $cartella(qx(ls gironi/| grep girone)){
	chomp $cartella;
	push @girone,$cartella;
}
my $i=0;

foreach(@girone){
	my %puntiPerSquadra=();	
	open(RISULTATI,"<gironi/$_/risultati.txt");
	foreach(<RISULTATI>){
		if($_=~/([A-H]{1})\s\N\s([a-z]{3})\s([a-z]{3})\s([a-z]{3})\s([a-z]{3})/) {
			@puntiPerSquadra{$2,$3,$4,$5}=(0,0,0,0);
		}		
		if($_=~/([a-z]{3})\N([a-z]{3})\N(\d)\N(\d)/){
			#print "$1,$2,$3,$4\n";
			if($3>$4){
				 $puntiPerSquadra{$1}=3+$puntiPerSquadra{$1};	
			}
			elsif($3<$4){
				$puntiPerSquadra{$2}=3+$puntiPerSquadra{$2};
			}
			else{
				$puntiPerSquadra{$1}=1+$puntiPerSquadra{$1};
				$puntiPerSquadra{$2}=1+$puntiPerSquadra{$2};
			}
		}	
	}
	close RISULTATI;
	my @ordine;
	foreach $squadra (sort { $puntiPerSquadra{$b} <=> $puntiPerSquadra{$a} } keys %puntiPerSquadra){
		#print "$squadra - $puntiPerSquadra{$squadra}\n";
		push @ordine,$squadra;	 
        }
	#print %puntiPerSquadra;
        print "| @ordine[0,1] ";
	undef %puntiPerSquadra;
}
print "|\n";
