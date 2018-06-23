$dir= "/mnt/c/Users/zio-j/Desktop/Sistemi/perl/luglio2013/mailbox/*";
#/(m\d.eml)/; # Skip files matching pattern
my @mfiles = qx{ls $dir};
my @regole;
my $text=0;
open(REGOLE,"<regole.txt");

foreach(<REGOLE>){
	push @regole, $_;
}
close REGOLE;

#print @regole;

for my $m (@mfiles){
	chomp;
	if($m=~/(m\d.eml)/){
		open(FILE,"mailbox/$1");	
		for my $f(<FILE>){
			#print "$_\n";

			if($f=~/Subject:\s(.*)/){
			#	print"$1\n";
			}
			if($f=~/From:\s(.*)/){
			#	print"$1";
			}
			if($f=~/^\s+/){
				$text=1;			
			}
			if($text==1){
				#print " $f\n ";
				for my $i(@regole){
					chomp $i;
					print"$path\n";
					if($f=~/$i/){
						if($m=~/(m\d.eml)/){
							qx{mv mailbox/$1 SPAM/};
						}
					}
				}
			}

		}
	close(FILE);
	}
$text=0;
}

