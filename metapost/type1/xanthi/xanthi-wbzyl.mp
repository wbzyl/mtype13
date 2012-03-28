%%%%
%%%%  $Revison:$
%%%%  $Date: 2004/08/24 23:40:18 $
%%%%

%% \input xanthi-format
%% \title{Xanthi font}

input xanthi-driver;

beginfont

%% \-----------
%% \PICT{xanthi_square}
%% \-----------

assign_name._i("xanthi_square");
begin_glyph("i");
  z1=(0,0); z2=(w,0); z3=(w,h); z4=(0,h);
  p1=z1--z2--z3--z4--cycle;  

  expand_stroke.p2()(p1 shifted square_offset);
  h:=h+ypart square_offset;
  Fill p2r; unFill p2l;

  just_labels(1,2,3,4);
end_glyph;

%% \eject
%% \-----------
%% \PICT{xanthi_snail_1}
%% \-----------

assign_name._1("xanthi_snail_1");
begin_glyph("1");
  z1=(0,h); z2=(w,h); z3=(w,0); z4=(0,0);
  z5=(0,2/3h); z6=(2/3w,2/3h); z7=(2/3w,1/3h); z8=(1/3w,1/3w);
  snail=z1--z2--z3--z4--z5--z6--z7--z8;  
  
  p1=expand_stroke()(snail shifted snail_offset);
  h:=h+ypart snail_offset;
  Fill p1;

  just_labels(1,2,3,4,5,6,7,8);
end_glyph;

%%%% \eject
%%%% \-----------
%%%% \PICT{xanthi_snail_2}
%%%% \-----------

assign_name._2("xanthi_snail_2");
begin_glyph("2");
  p1=expand_stroke()(snail rotatedaround(center,-90) shifted snail_offset);
  h:=h+ypart snail_offset;
  Fill p1;
end_glyph;

assign_name._3("xanthi_snail_3");
begin_glyph("3");
  p1=expand_stroke()(snail rotatedaround(center,-180) shifted snail_offset);
  h:=h+ypart snail_offset;
  Fill p1;
end_glyph;

assign_name._4("xanthi_snail_4");
begin_glyph("4");
  p1=expand_stroke()(snail rotatedaround(center,-270) shifted snail_offset);
  h:=h+ypart snail_offset;
  Fill p1;
end_glyph;

%% \-----------
%% \PICT{xanthi_snake_1}
%% \-----------

assign_name._s("xanthi_snake_1");
begin_glyph("s");
  z1=(1/2w,1/2h); z2=(1/2w,3/4h); z3=(0,3/4h);
  z4=(0,0); z5=(w,0); z6=(w,h); z7=(2w,h);
  z8=(2w,1/4h); z9=(3/2w,1/4h); z10=(3/2w,1/2h);
  
  snake=z1--z2--z3--z4--z5--z6--z7--z8--z9--z10;
  p1=expand_stroke()(snake);
  Fill p1;

  just_labels(1,2,3,4,5,6,7,8,9,10);
end_glyph;

%% \-----------
%% \PICT{xanthi_snake_2}
%% \-----------

assign_name._S("xanthi_snake_2");
begin_glyph("S");
  p1=expand_stroke()(snake reflectedabout((0,1/2h),(1,1/2h)));
  Fill p1;
end_glyph;

%% \eject
%% \-----------
%% \PICT{xanthi_plug_1_right}
%% \-----------

assign_name._r("xanthi_plug_1_right");
begin_glyph("r");
  z1=(w,h); z2=(w,0); z3=(0,0);
  z4=(0,3/4h); z5=(1/2w,3/4h); z6=(1/2w,1/2h);

  plug.r=z1--z2--z3--z4--z5--z6;
  plug.l=plug.r rotatedaround(center,-180);

  p1=expand_stroke()(plug.r);
  Fill p1;

  just_labels(1,2,3,4,5,6);
end_glyph;

%% \-----------
%% \PICT{xanthi_plug_1_left}
%% \-----------

assign_name._l("xanthi_plug_1_left");
begin_glyph("l");
  p1=expand_stroke()(plug.l);
  Fill p1;
end_glyph;

%% \eject
%% \-----------
%% \PICT{xanthi_plug_2_right}
%% \-----------

assign_name._R("xanthi_plug_2_right");
begin_glyph("R");
  p1=expand_stroke()(plug.r reflectedabout((0,h/2),(1,h/2)));
  Fill p1;
end_glyph;

%% \-----------
%% \PICT{xanthi_plug_2_left}
%% \-----------

assign_name._L("xanthi_plug_2_left");
begin_glyph("L");
  p1=expand_stroke()(plug.l reflectedabout((0,h/2),(1,h/2)));
  Fill p1;
end_glyph;

%% \eject
%% \-----------
%% \PICT{xanthi_rule_segment_above}
%% \-----------

assign_name._a("xanthi_rule_segment_above");
begin_glyph("a");
  p0=origin--(w,0);
  p1=expand_stroke()(p0 shifted rule_offset);
  h:=h+ypart rule_offset+1/2py;
  Fill p1;
end_glyph;

%% \-----------
%% \PICT{xanthi_rule_segment_below}
%% \-----------

assign_name._b("xanthi_rule_segment_below");
begin_glyph("b");
  p0=origin--(w,0);
  p1=expand_stroke()(p0 shifted -rule_offset);
  d:=d-ypart rule_offset-1/2py;
  Fill p1;
end_glyph;

%% \eject
%% \-----------
%% \PICT{xanthi_doublerule_segment_above}
%% \-----------

assign_name._A("xanthi_doublerule_segment_above");
begin_glyph("A");
  p1=origin--(w,0);
  p2=expand_stroke()(p1 shifted rule_offset);
  p3=expand_stroke()(p1 shifted (rule_offset+2py*up));  
  h:=h+ypart rule_offset+2py+1/2py;
  Fill p2, p3;
end_glyph;

%%%% \-----------
%%%% \PICT{xanthi_doublerule_segment_below}
%%%% \-----------

assign_name._B("xanthi_doublerule_segment_below");
begin_glyph("B");
  p1=origin--(w,0);
  p2=expand_stroke()(p1 shifted -rule_offset);
  p3=expand_stroke()(p1 shifted (-rule_offset-2py*up));  
  d:=d-ypart rule_offset-2py-1/2py;
  Fill p2, p3;
end_glyph;


%% \eject
%% \-----------
%% \PICT{xanthi_vertical_segment_1}
%% \-----------

assign_name._v("xanthi_vertical_segment_1");
begin_glyph("v");
  z1=(1/2w,2/5h); z2=(3/4w,2/5h);
  z3=(3/4w,4/5h); z4=(0,4/5h); z5=(0,0); z6=(w,0); 
  z7=(w,-4/5h); z8=(1/4w,-4/5h);
  z9=(1/4w,-2/5h); z10=(1/2w,-2/5h);
  p1=z1--z2--z3--z4--z5--z6--z7--z8--z9--z10;
  p2=expand_stroke()(p1);
  Fill p2;
end_glyph;


%%%% \-----------
%%%% \PICT{xanthi_vertical_segment_2}
%%%% \-----------


%% \eject
%% \-----------
%% \PICT{xanthi_vertical_plug_1_up}
%% \-----------

assign_name._u("xanthi_vertical_plug_1_up");
begin_glyph("u");
  plug.u=plug.r rotatedaround(center,90);
  plug.d=plug.r rotatedaround(center,-90);
  p2=expand_stroke()(plug.u shifted (0,-h));
  Fill p2;
  h:=0; 
end_glyph;


%%%% \-----------
%%%% \PICT{xanthi_vertical_plug_2_up}
%%%% \-----------


%% \eject
%% \-----------
%% \PICT{xanthi_vertical_plug_1_down}
%% \-----------

assign_name._d("xanthi_vertical_plug_1_down");
begin_glyph("d");
  p2=expand_stroke()(plug.d);
  Fill p2;
end_glyph;


%%%% \-----------
%%%% \PICT{xanthi_vertical_plug_2_down}
%%%% \-----------


%% \eject
%% \-----------
%% \PICT{xanthi_ul_corner}
%% \-----------

assign_name._T("xanthi_ul_corner");
begin_glyph("T");
  z1=(1/2w,1/4h); z2=(1/4w,1/4h); z3=(1/4w,3/4h);
  z4=(w,3/4h); z5=(w,-h); z6=(1/4w,-h);
  z7=(1/4w,-1/2h); z8=(1/2w,-1/2h);
  p1=z1--z2--z3--z4--z5--z6--z7--z8;
  p2=expand_stroke()(p1);
  Fill p2;

  z10=(1/2w,1/2h); z11=(3/4w,1/2h); z12=(3/4w,0);
  z13=(0,0); z14=(0,h); z15=(2w,h);
  z16=(2w,1/4h); z17=(3/2w,1/4h); z18=(3/2w,1/2h);
  p3=z10--z11--z12--z13--z14--z15--z16--z17--z18;
  p4=expand_stroke()(p3);
  Fill p4;
end_glyph;


%%%% \-----------
%%%% \PICT{xanthi_vertical_plug_2_down}
%%%% \-----------


endfont

endinput

%% \end
