#!/usr/local/bin/perl
my $minuid = 1000;
my $maxuid = 60000;
setpwent;
while (my ($name, $uid, $gid, $home) = (getpwent)[0,2,3,7]) {
next unless $uid >= $minuid && $uid <= $maxuid;
print "$name $uid $gid $home\n";
}
endpwent;
