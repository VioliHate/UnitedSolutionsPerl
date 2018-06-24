my $question;
open(QUIZ,"<quiz/$ARGV[0]/domande.txt");
foreach(<QUIZ>){
	if($_=~/$ARGV[1]/){
		if($_=~/([0-9]{1}):\s/){
			$question=$1;
			
		}
	}
}
close(QUIZ);
#print "$question\n";
if($question ne ""){
open(RISP,"<quiz/$ARGV[0]/risposte.txt");
foreach(<RISP>){
	if($_=~/$question/){
		print split(/$question: /,$_);
		print "\n";
	}
}
close(RISP);
}
else{
	print "domanda non trovata\n";
}
