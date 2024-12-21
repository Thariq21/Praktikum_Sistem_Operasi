#!/usr/local/bin/perl
my $pwd = (getpwuid($<))[1];
system "stty-echo";
print "Password: ";
chomp(my $word = <STDIN>);
print "\n";
system "stty echo";
if (crypt($word, $pwd) ne $pwd) {
    die "Sorry...\n";
} else {
    print "ok\n";
}
