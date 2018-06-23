$parcheggi = $ARGV[0];
$condomini = $ARGV[1];

open(FILE1,"< $parcheggi");
open(FILE2,"< $condomini");

my @parcheggi;

foreach(<FILE1>){
	if($_=~ /(.+?)\|(.+?)\|(.+?)\|(.+?)\|(.+?)\|/){
          push @parcheggi, $1;
          push @parcheggi, $2;
	  push @parcheggi, $3;
          push @parcheggi, $4;
	  push @parcheggi, $5;
	}
}
my %condomini;
foreach(<FILE2>){
	if($_=~ /(int\d\d):(.*)/){
		$condomini{$1}=$2;
	}
} 

my @abusivi;
$s= scalar@parcheggi;
for(my $i=0;$i<$s;$i++){
	if($condomini{$parcheggi[$i]}!=($i+1) && $parcheggi[$i]!~/_____/){
	push @abusivi, $parcheggi[$i];
	}

}
foreach(@abusivi){
print "$_\n";
}

close(FILE2);
close(FILE1);
