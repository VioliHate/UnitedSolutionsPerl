open(RICHIESTA,"<$ARGV[0]");
open(POSTI,"<posti.txt");
open(BIGLIETTO,">>biglietto.txt");
my %richieste;
foreach(<RICHIESTA>){

	if($_=~/(.):\s(.*)/){
		$richieste{$1}=$2;
		push @key, $1;
	}
}
my @c;

foreach(<POSTI>){
	@c=($_=~ /(\d+[A-Z])/g);
	for my $i(@key){
		foreach(@c){
			if($_ =~/(\d+)([A-Z])/){
				if($2==$i && $richieste{$2}>0){
					print BIGLIETTO "posto n°$1   di tipo $2 prenotato\n";
					$richieste{$2}--;
				}
			}
		}
	}
}
print BIGLIETTO qx(cat posti.txt);	
close(POSTI);
close(RICHIESTA);
