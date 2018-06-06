%% Funktion til at skrive SRgrd-fil til CASiMiR
% Input til funktionen skal være filnavn. crosssec_structs svarer til
% outputtet fra "reas_mike_crosssec_file"-funktionen. Se i øvrigt scriptet
% "CrossSectionsScript.m" hvor begge funktioner bruges til at skrive rådata
% fra MIKE11 om til geometri til CASiMiR.

function write_casimir_geometry_file(file_name, crosssec_structs)
    fid = fopen(file_name,'w');
    
    ID_LINE = strcat('[',crosssec_structs(1).ID,']');
    
    fwrite(fid,ID_LINE);
    fwrite(fid,[char(13) newline]);
    i=1;
    for i=1:length(crosssec_structs)
        fwrite(fid,['#' char(9)]);
        fwrite(fid,[char(13) newline]);
        fprintf(fid,'%.2f',i);
        fwrite(fid,[ char(9) char(13) newline]);
        for j=1:length(crosssec_structs(i).X)
            fprintf(fid,'%.2f',crosssec_structs(i).X(j));
            fwrite(fid,char(9));
            fprintf(fid,'%d',crosssec_structs(i).Y);
            fwrite(fid,char(9));
            fprintf(fid,'%.2f',crosssec_structs(i).Z(j));
            fwrite(fid,[char(9) '0' char(9) '0' char(9) '0' char(9) '0' char(9) '0' char(9) '0' char(9) '0' char(9) '0' char(9) '0' char(9) '0' char(9) '0' char(13) newline]);
        end
    end
       
    fclose(fid);
end