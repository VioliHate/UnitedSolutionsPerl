#! /usr/bin/perl
my $cognome = $ARGV[1] || die "Cognome mancante\n";
my $comune = $ARGV[0] || die "Comune mancante\n";

open(FILE,"ComuniCosenza/$comune/elenco.txt") || die "Non ho trovato $comune/elenco.txt";

$trovato = 0;

while(<FILE>)

{
    {
      if( /^$cognome /i )
      {
           ($cognomeNome,$indirizzo,$numero) = split(/::/);
           print "utente $cognomeNome. Telefono $numero\n";
           $trovato = 1;
      }
       
    }
    
}
print "Nessuna utenza trovata.\n" unless $trovato;
close FILE;
