%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%%%% Type 3 fonts used by iching-000.tex (iching_c -- commented out)

mode_def iching_a = message "MODE: I-Ching-a00";
  final_;
  font_name "I-Ching-a00";
  font_version "1.0a";
  font_identifier:="ICHING A00";
  vardef yin_color = (.3+uniformdeviate .7)*blue enddef;
  vardef yang_color = (.3+uniformdeviate .7)*red enddef;
enddef;


mode_def iching_b = message "MODE: I-Ching-b00";
  final_;
  font_name "I-Ching-b00";
  font_version "1.0b";
  font_identifier:="ICHING B00";

  interelement_gap:=15;

  rect_gap:=20;
  3rect_hsize+2rect_gap=hexagram_width;
  
  vardef yin_yang_color = (0,.6+uniformdeviate .4,1) enddef;

  vardef yin_yang_element = unitsquare
    xscaled rect_hsize yscaled element_height
  enddef;
    
  vardef yang = initialize(iching_pic);
    addto iching_pic contour yin_yang_element
      withcolor yin_yang_color;
    addto iching_pic contour yin_yang_element
      shifted ((rect_hsize+rect_gap)*right)
      withcolor yin_yang_color;
    addto iching_pic contour yin_yang_element
      shifted (2(rect_hsize+rect_gap)*right)
      withcolor yin_yang_color;
    iching_pic
  enddef;

  vardef yin = initialize(iching_pic);
    addto iching_pic contour yin_yang_element
      withcolor yin_yang_color;
    addto iching_pic contour yin_yang_element
      shifted (2(rect_hsize+rect_gap)*right)
      withcolor yin_yang_color;
    iching_pic
  enddef;

enddef;


mode_def iching_d = message "MODE: I-Ching-d00";
  final_;
  font_name "I-Ching-d00";
  font_version "1.0d";
  font_identifier:="ICHING D00";

  path yang_diamond, yin_diamond;

  pair A, B, C, D; numeric triangle_height;
  triangle_height=sqrt(3)/6;
  A=(0,0); B=(1/3,0); C=(1/2,triangle_height); D=(1/6,triangle_height);

  yang_diamond=A--B--C--D--cycle;
  yin_diamond=B--C--D--cycle;
  
  vardef yin = initialize(yin_pic);
    addto yin_pic contour yin_diamond
      scaled hexagram_width withcolor yin_color;
    yin_pic
  enddef;
  vardef yang = initialize(yang_pic);
    addto yang_pic contour yang_diamond scaled
      hexagram_width withcolor yang_color;
    yang_pic
  enddef;

  def hexagram(text arg_list) = set_initial_position;
    for $=arg_list:
      draw $ rotated 60position
        shifted (1/2hexagram_width,1/2hexagram_height*(1-3/2triangle_height));
      incr_position;
    endfor
  enddef;

enddef;


mode_def iching_e = message "MODE: I-Ching-e00";
  final_;
  font_name "I-Ching-e00";
  font_version "1.0e";
  font_identifier:="ICHING E00";
  vardef yin_color = (.6+uniformdeviate .2)*blue enddef;
  vardef yang_color = (.8+uniformdeviate .2,0,.55) enddef;
enddef;


%% \end
