#!/usr/bin/perl
use strict;
use warnings;
my $table=shift;
my $fa1=shift;
my $fa2=shift;
my $dir=shift;
my $seq1 = &read_fasta($fa1);
my $seq2 = &read_fasta($fa2);
mkdir $dir . "/tmp";
open(IN,"<$table") or die "Can not open$!\n";
my $head = <IN>;
my @a = split(/\t/,$head);
my $id = 1;
while(<IN>){
	$_ =~ s/\r//g;
	chomp;
	next if /^\s*$/;
#	next if /^Orthogroup/;
	my @b = split("\t",$_);
	my $q1 = $dir . "/tmp/q1";
	my $q2 = $dir . "/tmp/q2";
	my $blast = $dir . "/" . $id . '.blast';
	my $r = $dir . "/tmp/*";
	&write_fasta($b[1],$seq1,$q1);
	&write_fasta($b[2],$seq2,$q2);
	`makeblastdb -in $q2 -dbtype prot -out $q2`;
	`blastp -query $q1 -db $q2 -out $blast -outfmt '6 qaccver saccver pident length mismatch gapopen qstart qend sstart send evalue bitscore' -num_threads 1 -max_target_seqs 1 -max_hsps 1`;
	`rm $r`;
	
	$id ++;
	#last;
}
close IN;

sub write_fasta(){
	my $list=shift;
	my $seq=shift;
	my $out_file=shift;
	open(WR,">$out_file") or die "Can not open$!\n";
	my @name = split(/, /,$list);
	foreach(@name){
		print WR ">" . $_ . "\n" . $seq->{$_} . "\n";
	}
	close WR;
}
sub read_fasta(){
	my $file = shift;
	open(RE,"<$file") or die "Can not open $!\n";
	my $id = "a";
	my $seq = {};
	while(<RE>){
		chomp;
		$_ =~ s/\r//g;
		next if /^\s*$/;
		if(/^>/){
			$_=~s/^>//;
			($id) = split(/\t/,$_);
			#print "$id\n";
			$seq->{$id} = "";
		}else{
			$seq->{$id} = $seq->{$id} . $_;
		}
	}
	close RE;
	return $seq;
}
