#!/usr/bin/perl

# Check dei parametri
$option = shift || die "Too few arguments - missing option ! $!";
$folder = shift || die "Too few arguments in input - missing folder ! $!" if ($option eq "--sync");
$filename = $option if ($option ne "--sync");
die "Too much parameters in input ! $!" if($#ARGV >= 0);

if ($option eq "--sync") {
    @file_list = qx{ls -aR $folder};

#    $checkIfExist = qx{file database.db};
#    if (! ($checkIfExist =~ m/No such file or directory/)) {

    # if (-e "path/file") è una shortcut per chiedere a perl se un file esiste oppure no
    if (-e "database.db") {
        open($fh, "<", "database.db") || die "Cannot open file in read mode ! $!";
        @arrayFile = <$fh>;
        close $fh;
    }
    open($fh, ">", "database.db") || die "Cannot open file in write mode ! $!";
    foreach (@arrayFile) {
        # Se $folder fosse uguale alla directory "." si dovrebbe controllare l'attuale path della directory di lavoro (comando pwd)
        # per semplicità ignoriamo questo caso particolare
        print $fh $_ unless (m/$folder/);
    }
    foreach (@file_list) {
        chomp;
        if (m/^($folder.*)\s*:/) {
            $location = $1;
            next;
        }
        print $fh "$location --> $_\n" if (m/[^\.]/);
    }
    close $fh;
}
else {
    open($fh, "<", "database.db") || die "Cannot open file in read mode ! $!";
    
    while (<$fh>) {
        print "$1/$2\n" if (m/(.*)\s-->\s($filename.*)/);
    }
    close $fh;
}