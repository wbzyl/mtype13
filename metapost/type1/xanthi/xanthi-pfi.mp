%%%%
%%%%  $Revison:$
%%%%  $Date: 2004/08/23 09:35:44 $
%%%%

%% \input xanthi-format
%% \title{Postscript and {\TeX} data of Xanthi font}

if known included_xanthi_pfi: expandafter endinput
else: included_xanthi_pfi:=1; fi

pf_info_designsize 10pt#;
pf_info_familyname "Archaic";
pf_info_fontname "Xanthi-Regular";
pf_info_weight "Normal";
%%%%pf_info_version "$Revision: 1.1.1.1 $";
pf_info_version "1.4";
pf_info_author "Wlodek Bzyl 2004";
%%%%pf_info_creationdate "$Date: 2004/08/23 09:35:44 $";
pf_info_creationdate "1-August-2004";
pf_info_fixedpitch false;

pf_info_encoding "font specific";

u = 180; % unit width: $4*u=720$
o = 1;  % overshoot

pf_info_quad 720;
pf_info_space 333, 333, 111;
pf_info_overshoots (0,-o), (720, o);

pf_info_capheight 720;
pf_info_xheight 720;

pf_info_adl 720, 280, 0;

endinput

%% \end
