#!/usr/bin/perl
use strict;
use warnings;

my @type=("0.2_0.2");
#my @rec = ("0.0001","1.0e-05","1.0e-06");
my @rec = ("1.0e-06");
my $u = 0.01;
my $s = 0.001;
my @sap=("enhancing","weakening");

my $infile;

foreach my $rec (@rec){
###output files without ectopic recombination
#my $outfile1="Freq_Modifer_0_0.2_".$u."_".$s."_".$rec."_10000";
#my $outfile="Freq_Modifier_each_replicate_trajectory_0_0.2_".$u."_".$s."_".$rec."_10000";
#my $outfile1="TE_num_".$u."_".$s."_".$rec."_10000";
#my $outfile="TE_num_each_replicate_trajectory_".$u."_".$s."_".$rec."_10000";
#my $outfile1="Mean_fitness_".$u."_".$s."_".$rec."_10000";
#my $outfile="Mean_fitness_each_replicate_trajectory_".$u."_".$s."_".$rec."_10000";

###output files with ectopic recombination
#my $outfile1="Freq_Modifer_".$u."_".$s."_".$rec."_10000_withEE_0.001_5";
#my $outfile="Freq_Modifier_each_replicate_trajectory_".$u."_".$s."_".$rec."_10000_withEE_0.001_5";
my $outfile1="TE_num_".$u."_".$s."_".$rec."_10000_withEE_0.001_5";
my $outfile="TE_num_each_replicate_trajectory_".$u."_".$s."_".$rec."_10000_withEE_0.001_5";
#my $outfile1="Mean_fitness_".$u."_".$s."_".$rec."_10000_withEE_0.001_5";
#my $outfile="Mean_fitness_each_replicate_trajectory_".$u."_".$s."_".$rec."_10000_withEE_0.001_5";

open(OUT1, ">$outfile1");
open(OUT, ">$outfile");

foreach my $type (@type){
foreach my $sap (@sap){
my %sum_TE;my %rep;
my $gen=0; my $focal=0; my $tot=0;
my @par = split("_",$type);

#$infile="invade_".$sap."_Magnitude_TE_additive_".$u."_".$par[0]."_".$s."_".$par[1]."_".$rec;
$infile="invade_".$sap."_Magnitude_TE_additive_with_ectopic_recombination_".$u."_".$par[0]."_".$s."_".$par[1]."_".$rec."_0.001_5";
open(FILE,"<", "$infile")||die"$!";
while(my $sig = <FILE>){
	chomp($sig);
	my @a = split(" ", $sig);
        if($sig =~ m/mean_fitness/){
        }elsif($sig =~ m/modifier_Freq/){
        }else{
        $gen=$a[0];
        $focal = $a[1]; #$a[1] for TE_num and fitness; $a[2] for variance; for modifier freq use the if loop below
        #if (@a==5){
        #$focal =$a[2];
        #}else{
        #$focal = 0;
        #}

        	if (exists $sum_TE{$gen}){
        $sum_TE{$gen}=$sum_TE{$gen}."\t".$focal;
                }else{
        $sum_TE{$gen}=$focal;
                }
        if ($gen > 5002){
        print OUT "$sap\t","$gen\t","$focal\t","$a[-1]\t","$type","$rec\n";
        #print OUT "$rec\t","$gen\t","$focal\t","$a[-1]\t","$type\n";
        }
}
}

        my $sum_sq=0;
        for (my $j=5003; $j<$gen; $j+=1){
        $sum_sq=0;
        my @b= split("\t", $sum_TE{$j});
        my @sorted_b = sort { $a <=> $b } @b;
        my $avg_TE=mean(@b);
         my $rep = scalar(@b);
          for (my $k=0; $k<@b; $k++){
                $sum_sq+=($b[$k]-$avg_TE)**2;
        }
        my $sd = ($sum_sq/$rep)**0.5;

        print OUT1 "$sap\t","$j\t","$avg_TE\t","$sd\t","$sorted_b[0]\t","$sorted_b[-1]\t","$rep\t","$type","$rec\n";
        #print OUT1 "$rec\t","$j\t","$avg_TE\t","$sd\t","$sorted_b[0]\t","$sorted_b[-1]\t","$rep\t","$type\n";
        }
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

