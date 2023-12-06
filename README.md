# TE_silencing_simulations
I. study the TE dynamics under different parameter combinations for additive, multiplicative, and synergistic fitness models
  slim -d replicat= <<1 to 20>> $SLiM_file
  where $SLiM_file can be: 
    TE_dynamics_additive_models.txt
    TE_dynamics_multiplicative_models.txt
    TE_dynamics_synergistic_models.txt

II. study the dynamics of modifier alleles that enhance or weaken TE silencing after populations reach equilibrium states
  a. without ectopic recombination
    slim -d replicat= <<1 to 20>> TE_dynamics_additive_models.txt      ##allowing populations reach equilibriums
    slim -d replicat= <<1 to 20>> modifier_allele_invasion_TE_silencing.txt     ##simluating the invasion of modifier alleles
  b. with ectopic recombination
    slim -d replicat= <<1 to 20>> TE_dynamics_additive_models_with_ectopic_recombination.txt     ##allowing populations reach equilibriums
    slim -d replicat= <<1 to 20>> modifier_allele_invasion_TE_silencing_with_ectopic_recombination.txt     ##simluating the invasion of modifier alleles

III. TE copy number trajectory from part I simulation can be extracted using
    perl TE_copy_number_trajectory_no_modifier.pl
    Modifier frequency, TE copy number, and mean population fitness from part II can be extracted using
    perl Epi_Modifier_freq_trajectory_TE_num_Mean_fitness.pl
    R script plots_generations.R can be used to visualize the trajectory and make figures.
