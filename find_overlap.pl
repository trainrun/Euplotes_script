#!/usr/bin/perl
use strict;
use warnings;
my $h1 = &make_hash($ARGV[0]);
my $h2 = &make_hash($ARGV[1]);
my $h3 = &make_hash($ARGV[2]);
my $h4 = &make_hash($ARGV[3]);
my $d0 = &make_hash($ARGV[4]);
my $d1 = &make_hash($ARGV[5]);
my $d2 = &make_hash($ARGV[6]);
my $d3 = &make_hash($ARGV[7]);
my $d4 = &make_hash($ARGV[8]);
my %ha;
foreach(sort keys %ha){
	 if(defined $h1->{$_} && defined $h2->{$_} && defined $h3->{$_} && defined $h4->{$_} ){
		my $m0 = $_;
		my $m1 = $h1->{$_};
		my $m2 = $h2->{$_};
		my $m3 = $h3->{$_};
		my $m4 = $h4->{$_};
		my $s0 = defined $d0->{$m0} ? $d0->{$m0} : "";
		my $s1 = defined $d1->{$m1} ? $d1->{$m1} : "";
		my $s2 = defined $d2->{$m2} ? $d2->{$m2} : "";
		my $s3 = defined $d3->{$m3} ? $d3->{$m3} : "";
		my $s4 = defined $d4->{$m4} ? $d4->{$m4} : "";
		print "$m0\t$m1\t$m2\t$m3\t$m4\t$s0\t$s1\t$s2\t$s3\t$s4\n";
	}
}
sub make_hash(){
	my $file=shift;
	open(IN,"<$file") or die "1\n";
	my %hash;
	while(<IN>){
		$_=~s/\r//;
		chomp;
		next if /^###/;
		next if /^\s*$/;
		my($a,$b) = split(/\t/,$_);
		$hash{$a} = $b;
		$ha{$a} = 1;
	}
	return \%hash;
}
