% Script til at omdanne rådata fra MIKE11 cross section-fil til inputfil til CASiMiR
% Af Kirsten 
clear; clc;
% raadata_binderup='BinderupAA/BinderupRaw.txt';
% binderupsec=crosssec(raadata_binderup)


raadata_fil_navn='Data til habitatmodeller/MIKE11 interpoleret svarende til opmålt/MikeInt';
raadata_mike=strcat(raadata_fil_navn,'.txt');
raadata_casimir=strcat(raadata_fil_navn,'.SRgrd');

crosssec_structs=read_mike_crosssec_file(raadata_mike)

write_casimir_geometry_file(raadata_casimir, crosssec_structs)