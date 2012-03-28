% 9-point METAFONT//METAPOST logo
input type1.mp;
pf_info_designsize 9pt#;  % the "design size" of this font
ht#:=.9*6pt#;             % height of characters
xgap#:=.9*0.6pt#;         % horizontal adjustment
u#:=.91*4/9pt#;           % unit width
s#:=.08pt#;               % extra space at the left and the right
o#:=1/10pt#;              % overshoot
px#:=.9*2/3pt#;           % horizontal thickness of pen

if unknown pf_info_set.WEIGHT: pf_info_weight "Normal"; fi
if unknown pf_info_set.FONT_NAME: pf_info_fontname "MFMPlogo9-Regular"; fi
if unknown pf_info_set.PFM_NAME: pf_info_pfm "MFMPlogo09", 0, 0; fi

input logo.mp             % now generate the font
endfont;                  % and stop.
