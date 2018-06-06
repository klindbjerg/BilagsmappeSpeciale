%% Funktion til at læse MIKE11 tværnit.
% Funktionens input SKAL være et eksport af raw-data fra MIKE11 cross
% section filen med filnavnet ".xns".

function crosssection_return=read_mike_crosssec_file(raadata_sti)
    %Laes data:
    %raadata_read=tdfread(raadata_sti,'tab');
    fid = fopen(raadata_sti);
    %data_specifikation='%*s '
    %textscan_output = textscan(raadata_fil_id, data_specifikation)

    y = 1;
    novana_model_line = fgetl(fid);

    while ischar(novana_model_line)
       ID = fgetl(fid);
       
       Y = str2num(fgetl(fid));
       
       fgetl(fid); %Læser den enkelte linje i raw-filen for .xns
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       
       DATUM = str2num(fgetl(fid));
       
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       
       PROFILE=fgetl(fid);
       no_of_points = str2num(PROFILE(16:end));
       
       profile_points=zeros(no_of_points,2); %På denne linje, hvor mange gange sæt koordinater er der
       for i =1:no_of_points 
           point_str = fgetl(fid);
           point_str_selected = point_str(1:21);
           point = str2num(point_str_selected); %Hvert sæt af koordinater
           profile_points(i,1) = point(1);
           profile_points(i,2) = DATUM + point(2);
       end
       
       fgetl(fid);
       fgetl(fid);
       fgetl(fid);
       % Her laves struct med koordinaterne for hvert punkt i tværsnittet
       raw_data(y).ID = ID;
       raw_data(y).X = profile_points(:,1);
       raw_data(y).Y = Y;
       raw_data(y).Z = profile_points(:,2);
       y=y+1;
       
       tline = fgetl(fid);
       if tline == -1
           break
       end
    end
    
    fclose(fid);
    
    crosssection_return = raw_data;
    
end