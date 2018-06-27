my $data = shift || qx(date +%d-%m);
chomp $data;
my @oggi;
open(FILE,"<eventi.txt");

foreach(<FILE>){
	$_=~s/\r//;
	if($_=~/([0-9]{1,2}-[0-9]{1,2}):(.*)/){
#		print "$1;$2\n";
			push @oggi,$2 if($1 eq $data);
	}
}
if(@oggi){
	print "il giorno $data ricorda: ".join (",",@oggi),"\n";
}else{
	print "Non hai eventi memorizzati in data $data.\n";
}
close(FILE);
undef @eventiOdierni;
undef @data;
undef %mesi;
