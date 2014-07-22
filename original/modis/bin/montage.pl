#!/usr/bin/perl -w

use strict;

if ( $#ARGV < 5 ) {
   die "Usage: montage.pl <columns> <rows> <xres> <yres> <input_files>\n";
}

my $cols=shift;
my $rows=shift;
my $xres=shift;
my $yres=shift;

open(OUTFILE, ">map.rgb") || die "Unable to open output.rgb";

while(@ARGV) {

   my @filehandles;

   foreach(1..$cols) {
      local *FILE;
      my $filename = shift;
      if (!defined $filename){
	 # print STDERR "At end of filenames available to process, breaking!";
	  last;	    
      }
  #    print STDOUT "FILENAME : $filename\n";
      open(FILE, "$filename") || die "Unable to open $filename";
      binmode FILE;
      push(@filehandles, *FILE);
   }

   foreach my $y (1..$yres) {      
      foreach my $colnum (1..$cols) {
         my $bytedata;
         if (!$filehandles[$colnum-1]) {
            next;
         }
         my $result = read($filehandles[$colnum-1], $bytedata, (3*$xres));
         print OUTFILE $bytedata;
      }
   }
}
