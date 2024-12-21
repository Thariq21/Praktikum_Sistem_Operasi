#!/usr/local/bin/perl
use User::pwent;
use File::stat;

# Catatan: Skrip ini akan memeriksa UID dan akses direktori pengguna
while ($pwent = getpwent()) {
    # Pastikan kita menggunakan stat pada direktori asli, meskipun melalui symlink
    $dirinfo = stat($pwent->dir . "/.");
    unless (defined $dirinfo) {
        warn "Unable to stat " . $pwent->dir . ": $!\n";
        next;
    }

    # Memeriksa apakah UID direktori berbeda dengan UID pengguna
    warn $pwent->name . "`s homedir is not owned by the correct uid (" .
        $dirinfo->uid . " instead " . $pwent->uid . ")!\n"
        if ($dirinfo->uid != $pwent->uid);

    # Memeriksa apakah direktori dapat ditulis oleh dunia (world-writable)
    warn $pwent->name . "`s homedir is world-writable!\n"
        if ($dirinfo->mode & 022 and !($dirinfo->mode & 01000));
}

# Menutup file /etc/passwd setelah selesai
endpwent();

