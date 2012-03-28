%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%% \def\bitem{\par\leavevmode\hangindent 2em
%%    \hbox to 2em{\quad$\bullet$\hfil}\ignorespaces}

%% \title{GLYPH AND FONT ADMINISTRATION}

%% Each glyph is build between $\2{beginpic}\ldots\2{endpic}$.
%% The $\2{beginpic}$ was designed after plain $\2{beginchar}$ macro. 
%% Each $\2{beginpic}$ begins a group, which end at the next $\2{endpic}$.
%% Then the given glyph code is stored and character box dimensions
%% in {\tt mpost} internal variables \\{charwd}, \\{charht},
%% \\{chardp} and it sets box dimensions $w$, $h$, and $d$.
%% Finally it clears the $z$ variables, the current picture, and the
%% current pen.
%% {\TeX} needs to know the size of each characters's ``bounding box''.
%% A total of four dimensions is given for each character:
%% \bitem \\{charwd}, the width of the bounding box
%% \bitem \\{charht}, the height above baseline of the bounding box
%% \bitem \\{chardp}, the depth below baseline of the bounding box
%% \bitem \\{charic}, the character ``italis's correction''.
%%
%% The {\tt mpost} records the value of its internal quantities, and
%% writes them onto {\tt tfm} file, at the time of $\2{shipit}$ command.


%% A method, entangled a bit, of testing whether a parameter is a suffix.

vardef is_suffix(text suffix_or_not_suffix) =
 save the_suffix_; string the_suffix_; is_suffix_ suffix_or_not_suffix;
 the_suffix_<>""
enddef;
def killtext text t = enddef; % absent from older versions of plain.mf
def is_suffix_ suffix $ = the_suffix_:= str $; killtext enddef;

newinternal sidebearing; sidebearing:=0; % extra space added to all sidebars

def # = /(grid_size/designsize) enddef;

def beginpic(expr c, width, height, depth) = \\ % character code $c$
  begingroup
  if known c: charcode:=byte c; else: charcode:=0; fi
  w:=width; h:=height; d:=depth;
  charic:=0; clearxy; clearit; clearpen;
  interim xoffset:=sidebearing;
  drawoptions();
  picproof_:=nullpicture;
  scantokens extra_beginpic;
enddef;

def italcorr expr x = if x>0: charic:=x fi enddef;

%%%%? Support for EPSes and `background images' ({\it stencils}).
%% Support for `background images' ({\it stencils}).
%% Included stencils are handled by B.~Jackowski {\tt epsincl.mp}
%% macros. The MetaPost output is postprocessed by {\tt espincl}
%% shell script.

newinternal write_commands_, show_stencils_;
%%%%? newinternal show_eps_;

vardef tex_pic_file = jobname & ".lst" enddef;
vardef write_tex(suffix name)(expr code) =
  write "\EPSNAMEandNUMBER{" &
      substring (1,infinity) of (str name)  & "}{" & decimal code & "}"
    to tex_pic_file
enddef;

%%%%? vardef show_eps = write_commands_:=1;
%%%%?   scantokens "input epsincl";
%%%%?   show_eps_:=1
%%%%? enddef;

string stencil_directory;

def use_stencils(expr directory) = write_commands_:=1; show_stencils_:=1;
  scantokens "input epsincl";
  stencil_directory:=directory
enddef;

%% Macro $\\{do\_eps}$ provide contact with the outer world.

vardef sh_file = jobname & ".sh" enddef;

def write_epsincl_command =
 write "epsincl " & jobname & "." & decimal(charcode)
  & " > epsincl." & decimal(charcode) & " ; "
  & "mv epsincl." & decimal(charcode) & " " & jobname & "." & decimal(charcode)
 to sh_file
enddef;

string directory_separator; directory_separator:="/";

vardef do_eps(text name) =
  save s_; picture s_; s_:=nullpicture;
  s_:=use_eps(stencil_directory & directory_separator & name);
  if length s_>0:
    if write_commands_>0:
      write_epsincl_command;
      interim write_commands_:=0;
    fi
  fi
  s_
enddef;

%% Define $\\{use\_eps}$, in case {\tt epsincl.mp} had not been input.
%% Note that $\\{use\_eps}$ returns $\2{nullpicture}$ in the case of emergency.

vardef use_eps(expr dummy) = nullpicture enddef;

def insert_stencil(text name) =
  if (show_stencils_>0) and (proofing>1):
    addto currentpicture also do_eps(name)
  else:
    draw nullpicture
  fi
enddef;

%%%%? vardef insert_eps(text name) =
%%%%?   if show_eps_>0: do_eps(name) else: nullpicture fi
%%%%? enddef;

newinternal proofscale; proofscale:=1;

%% Glyph widths are written onto file named \meta{jobname}.pcw.
%% These widths are read by {\tt mptot3} script which uses them
%% as parameters to the PostScript {\tt setcharwidth} operator.

vardef pcw_file = jobname & ".pcw" enddef;
  % `{\it pcw}' --- PostScript Character Widths

def endpic = scantokens extra_endpic;
  write decimal charcode & ":" & decimal w to pcw_file;
%%%%  special "%%setcharwidth " & decimal w & " 0";
  charwd:=w#; charht:=h#; chardp:=d#;
  if proofing>0: makebox(proofrule);
    currentpicture:=currentpicture scaled proofscale;
    addto currentpicture also picproof_ scaled proofscale;
  fi
  w:=sidebearing+w+sidebearing;
  if charic<>0: charic:=charic#; fi
  shipit;
  endgroup
enddef;

def shipit = if proofing>=0:
  shipout currentpicture \\ t_ \\ transformed (identity shifted (xoffset,yoffset)) fi
enddef;
newinternal xoffset, yoffset;

string extra_beginpic, extra_endpic;
extra_beginpic=extra_endpic="";

%% The \\{designsize} of a font is another internal quantity that is
%% output to {\tt tfm} file. When a {\TeX} user asks for a font
%% `{\tt at}' a certain size, the font is scaled by the ratio between
%% the ``at size'' and the ``design size''.
%%
%% The \\{designsize} must be at least $1\,$pt and must be less than
%% $2048\,$pt and every dimension of the font should be less than 16
%% times the design size in absolute value.
%%
%% The ``design size'' is an imprecise notion, because there need be no
%% connection between the design size and any specific measurement in a
%% font. It is something like dress size or shoe sizes.
%% {\bf For Type~3 fonts we set the design size to 100$\,$bp},
%% which seems to be a good compromise between the accuracy of
%% the {\tt mpost} calculations and the maximum size of a grid.

designsize:=100;

%% It is suggested that fonts use a 1000-unit grid.
%% This is the default grid size used in Type~1 fonts programs.

newinternal grid_size; grid_size:=1000;

%% The other type information that appears in {\tt tfm} file applies to
%% a font as a whole. These include numeric data specified in
%% ``fontdimen'' commands.
%% Note that math symbols fonts are required to have at least 22
%% fontdimen parameters and math extensions at least 13.

def set_tfm_parameter(suffix kind)(expr no, val) =
  if string val: expandafter string
  elseif numeric val: expandafter numeric
  fi
  tfm_parameter.kind;
  tfm_parameter.kind:=val;
  fontdimen no: tfm_parameter.kind
enddef;

%%%%def font_slant expr x = fontdimen 1: x enddef; % no hash here!
%%%%def font_normal_space expr x = fontdimen 2: x# enddef;
%%%%def font_normal_stretch expr x = fontdimen 3: x# enddef;
%%%%def font_normal_shrink expr x = fontdimen 4: x# enddef;
%%%%def font_x_height expr x = fontdimen 5: x# enddef;
%%%%def font_quad expr x = fontdimen 6: x# enddef;
%%%%def font_extra_space expr x = fontdimen 7: x# enddef;

def font_slant expr $ = set_tfm_parameter(Slant,1,$) enddef; % no hash here!

def font_normal_space expr $ = set_tfm_parameter(normalSpace,2,$)# enddef;
def font_normal_stretch expr $ = set_tfm_parameter(normalStretch,3,$)# enddef;
def font_normal_shrink expr $ = set_tfm_parameter(normalShrink,4,$)# enddef;
def font_x_height expr $ = set_tfm_parameter(xHeight,5,$)# enddef;
def font_quad expr $ = set_tfm_parameter(Quad,6,$)# enddef;
def font_extra_space expr $ = set_tfm_parameter(extraSpace,7,$)# enddef;

def set_missing_tfm_parameters =
  if unknown tfm_parameter.normalSpace: font_normal_space designsize; fi
  if unknown tfm_parameter.normalStretch: font_normal_stretch 0; fi
  if unknown tfm_parameter.normalShrink: font_normal_shrink 0; fi
  if unknown tfm_parameter.xHeight: font_x_height designsize; fi
  if unknown tfm_parameter.Quad: font_quad designsize; fi
  if unknown tfm_parameter.extraSpace: font_extra_space 0; fi
enddef;

def font_identifier expr x = font_identifier_:=x enddef;
def font_coding_scheme expr x = font_coding_scheme_:=x enddef;

string font_identifier_, font_coding_scheme_;
font_identifier_=font_coding_scheme_="UNSPECIFIED";

%% Here is the macro that is used to convert font identifier
%% and font coding scheme into the format required by TFM files
%% ({\it The METAFONTbook}, p.~320).

def BCPL_string(expr s,n)= % string |s| becomes an |n|-byte BCPL string
 for l:=if length(s)>=n: n-1 else: length(s) fi: l
  for k:=1 upto l: , substring (k-1,k) of s endfor
  for k:=l+2 upto n: , 0 endfor endfor
enddef;

%% {\TeX} relies on lots of parameters when it typesets math formulas.
%% He will not typeset a math formula unless symbol fonts contain
%% at least 22 fontdimen parameters.

%%%%def font_num_a expr x = fontdimen 8: x# enddef;
%%%%def font_num_b expr x = fontdimen 9: x# enddef;
%%%%def font_num_c expr x = fontdimen 10: x# enddef;
vardef font_num@# expr x = if \\ (@#<1) or (@#>3):
    errmessage "Wrong suffix to font_num: " & decimal @#
  else: fontdimen 7+@#: x# fi
enddef;

%%%%def font_denom_a expr x = fontdimen 11: x# enddef;
%%%%def font_denom_b expr x = fontdimen 12: x# enddef;
vardef font_denom@# expr x = if \\ (@#<1) or (@#>2):
    errmessage "Wrong suffix to font_denom" & decimal @#
  else: fontdimen 10+@#: x# fi
enddef;

%%%%def font_sup_a expr x = fontdimen 13: x# enddef;
%%%%def font_sup_b expr x = fontdimen 14: x# enddef;
%%%%def font_sup_c expr x = fontdimen 15: x# enddef;
vardef font_sup@# expr x = if \\ (@#<1) or (@#>3):
    errmessage "Wrong suffix to font_sup" & decimal @#
  else: fontdimen 12+@#: x# fi
enddef;

%%%%def font_sub_a expr x = fontdimen 16: x# enddef;
%%%%def font_sub_b expr x = fontdimen 17: x# enddef;
vardef font_sub@# expr x = if \\ (@#<1) or (@#>2):
    errmessage "Wrong suffix to font_sub" & decimal @#
  else: fontdimen 15+@#: x# fi
enddef;

def font_sup_drop expr x = fontdimen 18: x# enddef;
def font_sub_drop expr x = fontdimen 19: x# enddef;

%%%%def font_delim_a expr x = fontdimen 20: x# enddef;
%%%%def font_delim_b expr x = fontdimen 21: x# enddef;
vardef font_delim@# expr x = if \\ (@#<1) or (@#>2):
    errmessage "Wrong suffix to font_delim" & decimal @#
  else: fontdimen 19+@#: x# fi
enddef;

def font_axis_height expr x = fontdimen 22: x# enddef;

%% Extension fonts should contain at least 13 fontdimen parameters.

def font_default_rule_thickness expr x = fontdimen 8: x# enddef;

%%%%def font_big_op_spacing_a expr x = fontdimen 9: x# enddef;
%%%%def font_big_op_spacing_b expr x = fontdimen 10: x# enddef;
%%%%def font_big_op_spacing_c expr x = fontdimen 11: x# enddef;
%%%%def font_big_op_spacing_d expr x = fontdimen 12: x# enddef;
%%%%def font_big_op_spacing_e expr x = fontdimen 13: x# enddef;
vardef font_big_op_spacing@# expr x = if \\ (@#<1) or (@#>5):
    errmessage "Wrong suffix to font_big_op_spacing" & decimal @#
  else: fontdimen 8+@#: x# fi
enddef;

def endfont =
  set_missing_postscript_parameters;
  if fontmaking=1:
    headerbyte 49: BCPL_string(font_identifier_,20);
    headerbyte 9: BCPL_string(font_coding_scheme_,40);
    set_missing_tfm_parameters;
  fi
  scantokens "end";
enddef;

%% Ligtables.

newinternal kern_unit; kern_unit:=0;

numeric kern_step[];

vardef set_kern_steps text step_list =
  save i; numeric i; i:=0;
  for $=step_list: kern_step[incr i]:=$; endfor
enddef;

vardef get_glyph_code(suffix name) =
  if known glyph.shipped.name: glyph.code.name else: -1 fi
enddef;

def LK(suffix name) =
  numeric LK_code, KP_code, LP_code_a, LP_code_b, already_started;
  already_started:=0;
  LK_code:=get_glyph_code(name);
  if LK_code>=0:
    let next_to_do=relax;
  else:
    hide(message "Warning: undefined glyph: " & str name)
    let next_to_do=skip_LK;
  fi
  next_to_do 
enddef;

let KL=relax;

let semicolon_=; ; % stores original meaning of semicolon

def skip_LK =
  let ;=end_skip_LK semicolon_
  let KL=fi semicolon_
  if false:
enddef;

def end_skip_LK =
 let ;=semicolon_ semicolon_
 let KL=relax;
enddef;

%% Postpone starting $\2{ligtable}$ until a legal pair is encountered.

def start_or_cont =
  if already_started=0: already_started:=1;
    ligtable LK_code:
  else: ,
  fi
enddef;

vardef tfm_units(expr $) = $*designsize/grid_size enddef;

def KP(suffix name)(expr step_number) =
  hide(KP_code:=get_glyph_code(name))
  if KP_code>=0:
    if (fontmaking=1) and (known kern_step[abs(step_number)]):
      start_or_cont KP_code kern if step_number<0: - fi
          tfm_units(kern_step[abs(step_number)]*kern_unit)
      if tracingligtable>0: hide(if already_started=1: message "KERN "
          & glyph.literal[LK_code] & ": " & glyph.literal[KP_code] & " "
          & decimal (if step_number<0: - fi
              kern_step[abs(step_number)]*kern_unit); fi)
      fi
    fi
  else:
    hide(message "Warning: undefined glyph: " & str name)
  fi
enddef;

def LP(suffix name_a, name_b) = % ligature pair
  hide(LP_code_a:=get_glyph_code(name_a); LP_code_b:=get_glyph_code(name_b))
  if (fontmaking=1) and (LP_code_a>=0) and (LP_code_b>=0):
    start_or_cont
        LP_code_a=:(LP_code_b) % braces are crucial for delimiting suffix
        if tracingligtable>0: hide(if already_started=1: message "LIGATURE " 
              & glyph.literal[LK_code] & ": " & glyph.literal[LP_code_a]
              & " =: " & glyph.literal[LP_code_b]; fi)
        fi
  fi
enddef;

endinput

%% \end
