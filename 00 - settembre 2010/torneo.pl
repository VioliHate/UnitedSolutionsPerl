
#/(m\d.eml)/; # Skip files matching pattern 
my @girone=("gironi/gironeA","gironi/gironeB","gironi/gironeC","gironi/gironeD",
	    "gironi/gironeE","gironi/gironeF","gironi/gironeG","gironi/gironeH");

my $i=0;

foreach(@girone){
	my %puntiPerSquadra=();	
	open(RISULTATI,"<$_/risultati.txt");
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
	foreach $squadra (sort { $puntiPerSquadra{$a} <=> $puntiPerSquadra{$b} } keys %puntiPerSquadra){
		#print "$squadra - $puntiPerSquadra{$squadra}\n";
		push @ordine,$squadra;	 
        }
	#print %puntiPerSquadra;
        print "| @ordine[3,2] ";
	undef %puntiPerSquadra;
}
