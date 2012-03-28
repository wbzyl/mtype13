% 8-point METAFONT//METAPOST logo
input type1.mp;
pf_info_designsize 8pt#;  % the "design size" of this font
ht#:=.8*6pt#;             % height of characters
xgap#:=.8*0.6pt#;         % horizontal adjustment
u#:=.82*4/9pt#;           % unit width
s#:=.2pt#;                % extra space at the left and the right
o#:=1/12pt#;              % overshoot
px#:=.8*2/3pt#;           % horizontal thickness of pen

if unknown pf_info_set.WEIGHT: pf_info_weight "Normal"; fi
if unknown pf_info_set.FONT_NAME: pf_info_fontname "MFMPlogo8-Regular"; fi
if unknown pf_info_set.PFM_NAME: pf_info_pfm "MFMPlogo08", 0, 0; fi

input logo.mp             % now generate the font
endfont;                  % and stop.
