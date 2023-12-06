#!/usr/bin/perl
use strict;
use warnings;

my @sap=("0.01","0.001","0.0001");

my @parameter=("0_0","0_0.2","0_2","0_20","0.2_0","0.2_0.2");
my $infile;
foreach my $par (@parameter){

my $outfile1="TE_num_mean_sd_among_replicates_NoModifer_0.01_1.0e-07_".$par."_10000";
my $outfile="TE_num_trajectory_NoModifer_0.01_1.0e-07_".$par."_10000";
open(OUT1, ">$outfile1");
open(OUT, ">$outfile");

foreach my $sap (@sap){
my %sum_TE;my %rep;
my $gen=0; my $focal=0; my $tot=0;

        print "$par\n";
my @par = split("_",$par);

$infile="_0.01_".$par[0]."_".$sap."_".$par[1]."_1.0e-07_10000_10";
#$infile="_0.0001_".$par[0]."_0.0001_".$par[1]."_1.0e-06_10000_".$sap;
open(FILE,"<", "$infile")||die"$!";
while(my $sig = <FILE>){
	chomp($sig);
	my @a = split(" ", $sig);
        if($sig =~ m/mean_fitness/){
        }else{        
        $gen=$a[0];
        $focal =$a[1];
        #if ($a[-1]<=4){
        	if (exists $sum_TE{$gen}){
        $sum_TE{$gen}=$sum_TE{$gen}."\t".$focal;
                }else{
        $sum_TE{$gen}=$focal;
                }
                if (@a==5){
        #print OUT "-0.0001\t","$a[0]\t","$a[1]\t","$a[2]\t","$a[3]\t","$sap","$a[4]\n";
        print OUT "$sap\t","$a[0]\t","$a[1]\t","$a[2]\t","$a[3]\t","$a[4]\t","$par\n";
        #print OUT "$a[0]\t","$a[1]\t","$a[2]\t","$a[3]\t","$a[4]\t","$par\n";
}else{
                #print OUT "-0.0001\t","$a[0]\t","$a[1]\t","$a[2]\t","0.0\t","$sap","$a[3]\n";
        print OUT "$sap\t","$a[0]\t","0\t","$a[1]\t","$a[2]\t","$a[3]\t","$par\n";
        #print OUT "$a[0]\t","0\t","$a[1]\t","$a[2]\t","$a[3]\t","$par\n";
}}}
        my $sum_sq=0;
      for (my $j=2; $j<$gen; $j+=10){
        $sum_sq=0;
        my @b= split("\t", $sum_TE{$j});
        my $avg_TE=mean(@b);
         my $rep = scalar(@b);
          for (my $k=0; $k<@b; $k++){
                $sum_sq+=($b[$k]-$avg_TE)**2;
        }
        my $sd = ($sum_sq/$rep)**0.5;

        print OUT1 "$sap\t","$j\t","$avg_TE\t","$sd\t","$rep\t","$par\n";
        #print OUT1 "$j\t","$avg_TE\t","$sd\t","$rep\t","$par\n";
}
}
}

sub mean {
my @array = @_; # save the array passed to this function
my $sum; # create a variable to hold the sum of the array's values
foreach (@array) { $sum += $_; } # add each element of the array
# to the sum
return $sum/@array; # divide sum by the number of elements in the
# array to find the mean
}

