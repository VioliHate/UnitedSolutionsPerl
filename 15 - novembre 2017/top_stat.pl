#controlli su ARGV
die "troppi argomenti\n" if ($#ARGV>0);
my $opzione = shift || "-c";
die "argomento $opzione non valido, utilizzare -c o -m" if ($opzione ne "-c" && $opzione ne "-m");
#imposto variabili
my $index=8;
if($opzione eq "-m"){
	$index=9;
}
my @result= qx{top -n 1 -b | tail -n +7};
my %consumi;
#inizio script
foreach(@result){
	@colonna = split(' ',$_);
	if($colonna[1] =~ /USER/){
		print "$colonna[1] --- $colonna[$index]\n";
		open(LOG,">>top_stat.log") || die "impossibile aprire file";
		print LOG "$colonna[1] --- $colonna[$index]\n";
		close(LOG) || die "impossibile chiudere file";
		next;
	}
	#print "$colonna[1] --- $colonna[$index]\n";
	$consumi{$colonna[1]}+=$colonna[$index];
}
open(LOG,">>top_stat.log") || die "impossibil aprire file";
foreach( sort { ($consumi{$b}<=>$consumi{$a}) || ($a cmp $b)} keys %consumi){
	print "$_ --- $consumi{$_}% \n";
	print LOG "$_ --- $consumi{$_}% \n";
}
print LOG "#"x20;
print LOG "\n";
close(LOG) || die "impossibile chiudere file";
