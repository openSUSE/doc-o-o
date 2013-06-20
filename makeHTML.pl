#!/usr/bin/perl

use warnings;
use strict;
use FileHandle;

# files to make
my $files = {
              'index.html'     => { title => 'doc.opensuse.org - Documentation Guides &amp; Manuals' },
              'opensuse.html'  => { title => 'doc.opensuse.org - Documentation for Previous openSUSE Versions'}
            };

my $template_file='main.html.template';
open(TFH, "<", $template_file) or die $@;
my $file;
my $myline;
my $myfh;

foreach $file (keys %{$files})
{
  $files->{$file}->{writeFH} = FileHandle->new($file, 'w') or die $@;
  $files->{$file}->{readFH} = FileHandle->new($file.'.content', 'r') or die $@;
}

foreach my $line (<TFH>)
{
  foreach $file (keys %{$files})
  {
    $myline = $line;
    if ($myline =~ /<%CONTENT%>/)
    {
      my $rfh = $files->{$file}->{readFH};
      $myline = eval { local $/; <$rfh> };
    }
    $myline =~ s/<%TITLE%>/$files->{$file}->{title}/;
    $myfh = $files->{$file}->{writeFH};
    print $myfh $myline;
  }
}

# close all file handles
foreach $file (keys %{$files})
{
  close ($files->{$file}->{writeFH});
  close ($files->{$file}->{readFH});
}
close TFH;
