%%%%
%%%%  $Revison:$
%%%%  $Date: 2004/08/23 09:35:44 $
%%%%

%% \input xanthi-format
%% \title{Base macros for Xanthi font}

if known included_xanthi_base: expandafter endinput
else: included_xanthi_base:=1; fi

% Asymmetric version of |penpos|

vardef mpenpos@#(expr b,d,m) =
 (x@#r-x@#l,y@#r-y@#l)=(b,0) rotated d;
 x@#=m[x@#l,x@#r]; y@#=m[y@#l,y@#r] enddef;

%% Convenient shorthands.

vardef expand_stroke@#(text opts)(expr p)=
 if str @#="": save r_; fi
 pen_stroke(opts;)(p)(if str @#="": r_ else: @# fi);
 if str @#="": r_ fi
enddef;

def butt_end(text nodes) = cut(rel 90)(nodes) enddef;

def fill_outlines suffix s =
  for i:=1 upto s.num:
   if turningnumber s[i] > 0: Fill else: unFill fi \\ s[i];
  endfor
enddef;

pair NE, NW, SE, SW;
NE=dir 45; NW=dir 135; SE=dir -45; SW=dir -135;

%% These are borrowed form ``The METAFONTbook''.

vardef super_half(suffix i,j,k) =
 z.i{0,y.j-y.i}
 ... (.8[x.j,x.i],.8[y.i,y.j]){z.j-z.i}
 ... z.j{x.k-x.i,0}
 ... (.8[x.j,x.k],.8[y.k,y.j]){z.k-z.j}
 ... z.k{0,y.k-y.j}
enddef;

vardef super_crescent(suffix i,j,k) =
 z.i{x.j-x.i,0}
 ... (.8[x.i,x.j],.8[y.j,y.i]){z.j-z.i}
 ... z.j{0,y.k-y.i}
 ... (.8[x.k,x.j],.8[y.j,y.k]){z.k-z.j}
 ... z.k{x.k-x.j,0}
enddef;

%% These macros are used to set width, height and depth of each glyph.

def set_wht(text names)(expr width, height, depth) =
  for $=names: set_wht_($)(width, height, depth); endfor
enddef;

def set_wht_(text name)(expr width, height, depth) =
  def glyph_name = uni_name(name) enddef;
  wd.glyph_name:=width;
  ht.glyph_name:=height;
  dp.glyph_name:=depth;
enddef;

%% These set left and right sidebearings.

def set_sb(text names)(expr ls, rs) =
  for $=names: set_sb_($)(ls, rs); endfor
enddef;

def set_sb_(text name)(expr ls, rs) =
  def glyph_name = uni_name(name) enddef;
  lft_sidebearing.glyph_name:=ls;
  rt_sidebearing.glyph_name:=rs;  
enddef;

%% I like Knuth's |beginchar| macro, so I extended |beginglyph|
%% a little to use its conventions.

def begin_glyph(text name) =
  beginglyph(name);
  % define the following variables: width, height and depth of glyph
  numeric w, h, d;
  % and left and right sidebearings -- these could be changed
  numeric lfts, rts;
  w:=wd.glyph_name;
  h:=ht.glyph_name;
  d:=dp.glyph_name;
  % this variables are used in every glyph
  save glyph, p; path glyph, p[];
  % unknown sideabearings are set to zero
  if known lft_sidebearing.glyph_name:
    lfts:=lft_sidebearing.glyph_name;
  else:
    lfts:=0;
  fi
  if known rt_sidebearing.glyph_name:
    rts:=rt_sidebearing.glyph_name;
  else:
    rts:=0;
  fi
  % this is the default pen used in xanthi
  pickup pencircle xscaled px yscaled py;
enddef;

def end_glyph =
  fix_hsbw(w,lfts,rts);
  wd.glyph_name:=w;
  ht.glyph_name:=h;
  dp.glyph_name:=d;
  % this is necessary;
  % otherwise the pen picked above will be used in proofs
  pickup pencircle scaled .5bp;
  endglyph;
enddef;

%%
%% Now proofs could contain paths (wb)
%%

def beginglyph(text name) =
 %
 def glyph_name = uni_name(name) glyph_name_ext enddef; % to use in |endglyph|
 numeric glyph_usage; glyph_usage:=glyph_usage.glyph_name;
 if unknown glyph_usage: expandafter begin_skip fi
 string ps_name; ps_name:=glyph_ps_name.glyph_name;
 if (fontmaking=1) and (name_to_code(glyph_name)<0):
  glyph_usage:=glyph_usage-glyph_usage mod store;
 fi
 if unknown ps_name:
  errmessage "PS name not assigned to " & str glyph_name;
 fi
 if name_used(glyph_name):
  errmessage "Double output: name " & (str glyph_name);
 fi
 if glyph_usage mod store = 1: % utilizing
  mark_name_used(glyph_name);
 fi
 numeric glyph_code, glyph_num; glyph_code:=name_to_code(glyph_name);
 if fontmaking=0:
  if glyph_code<0: glyph_num:=500-decr(min_glyph_code); else:
   glyph_num:=100+glyph_code;
   if glyph_code>max_glyph_code: max_glyph_code:=glyph_code; fi
  fi
 else:
  glyph_num:=glyph_code-256;
 fi
 %
 beginfig(glyph_num)
 if glyph_usage mod store = 1: % utilizing
  write_special "NAME " & ps_name & " " & decimal(glyph_code);
  if (if known generating: generating=0 else: true fi):
   % mpform.sty and mp2pf.awk interface
%  |write_tex(glyph_name, glyph_num);|
   write_tex(ps_name, glyph_num);
  fi
  if unknown generating:
   if show_stencils_>0: if known glyph_stencil.glyph_name:
    % `epsincl' interface
    write_commands(glyph_num);
   fi fi
  fi
 fi;
 hstem_list.num:=vstem_list.num:=hstem_list.cov:=vstem_list.cov:=
  glyph_list.num:=label_list.num:=path_list.num:=0;
 pair hstem_list[\\], vstem_list[\\];
 numeric glyph_llx, glyph_lly, glyph_urx, glyph_ury;
 path glyph_list[\\];
 path path_list[\\];
 picture label_list[\\]; pair label_list.dot[\\];
 numeric bitmap_scale; pair bitmap_offset;
 numeric glyph_shift, glyph_width, glyph_axis;
 save glyph;
 if glyph_usage div store = 1: % storing
  if not path glyph_stored.glyph_name[0]:
   scantokens("path " & generisize(str glyph_stored.glyph_name) & "[]");
  fi
  glyph_stored.glyph_name.num:=0;
  if not pair hstem_stored.glyph_name[0]:
   scantokens("pair " & generisize(str hstem_stored.glyph_name) & "[]");
  fi
  hstem_stored.glyph_name.num:=0;
  if not pair vstem_stored.glyph_name[0]:
   scantokens("pair " & generisize(str vstem_stored.glyph_name) & "[]");
  fi
  vstem_stored.glyph_name.num:=0;
 fi
 scantokens extra_beginglyph;
enddef;

def endglyph =
 scantokens extra_endglyph;
 % usually, |currentpicture=nullpicture|, but if not (i.e., some
 % extra objects have been drawn), the picture must be shifted:
 endglyph_picture:=currentpicture shifted (glyph_shift,0);
 currentpicture:=nullpicture;
 if fontmaking=0: fix_ghost; fi
 if known glyph_axis: % actually, used only with stored chars
  glyph_axis.glyph_name:=glyph_axis;
 fi
% fix char dimensions and write them to TFM and/or |dim_file|
% independently of |glyph_usage| (|dim_file|)
 fix_tfm_data(glyph_urx+glyph_shift, glyph_ury);
 if glyph_usage mod store = 1: % utilizing
  if known generating:
   if generating=0:
    write_special "HSBW * " & decimal(glyph_width);
    ship_hhints; ship_vhints;
    write_special "BEGINCHAR";
    ship_glyphs;
   else: % |fontmaking=1|
    message "{" & ps_name & " " & decimal(glyph_code) & "}";
   fi
  else:
   do_show_hints; do_show_stencils; do_show_boxes; do_show_glyphs;
   do_show_paths;
   draw endglyph_picture; do_show_labels; force_bbox;
  fi
  endfig;
 else:
  endgroup; % ends figure without shipping it out
 fi
enddef;

def do_show_paths =
 begingroup
  save p_; path p_;
  for g_:=1 upto path_list.num:
   p_:=path_list[g_] shifted (glyph_shift,0);
   draw p_ withpen pencircle scaled 2 withcolor red;
  endfor
 endgroup
enddef;

vardef just_paths(text t) =
  forsuffixes $=t:
    if known $: just_path($); fi
  endfor
enddef;

vardef just_path(expr s) =
  if unknown generating:
    if show_labels_>0: path_list[incr path_list.num]:=s; fi
  fi
enddef;

endinput

%% \end
