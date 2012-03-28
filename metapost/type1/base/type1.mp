%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%% 
%%%% The original file name: fontbase.mp
%%%% was adapted to MTYPE13 package.
%%%%
%%%% THIS FILE BELONGS TO THE METATYPE1 PACKAGE
%%%%
%%%% It is a basic set of macros for generating Type 1 fonts
%% \raggedbottom
%% \--------------------------------------------------------------------
%% \centering\bf A \MP{}-to-Type 1 converter:\break
%% BASIC MACROS ver. 0.44
%% \-
%% \centering\bf Konwerter \MP{}$\;\rightarrow\;$Type 1:\break
%% MAKRA PODSTAWOWE wer. 0.44
%% \--------------------------------------------------------------------
if known fontbase_ver: expandafter endinput else: fontbase_ver:=0.44; fi
% ---
%%%% WB: line
%%%% input plain_ex.mp;
%%%% WB: changed to:
input plain-ex.mp;
% ---
% define somehow |use_eps|, if epsincl.mp is not used (commented out),
% i.e., if stencils are definitely not to be used
vardef use_eps(expr dummy) = nullpicture enddef;
input epsincl.mp;
% ---
vardef enc_file = jobname & ".enc" enddef;
vardef map_file = jobname & ".map" enddef;
vardef kpx_file = jobname & ".kpx" enddef;
vardef pfi_file = jobname & ".pfi" enddef;
vardef pic_file = "piclist" enddef;
%%%% WB: added macros
vardef tex_pic_file = pic_file & ".tex" enddef;
vardef shell_pic_file = pic_file & ".sh" enddef;
def shell_command(expr charcode) =
  "epsincl " & jobname & "." & decimal(charcode)
  & " > epsincl." & decimal(charcode) & " ; "
  & "mv epsincl." & decimal(charcode) & " " & jobname & "." & decimal(charcode)
enddef;
%%%%
vardef dim_file = jobname & ".dim" enddef;
% ---
defaultfont:="cmr10"; defaultscale:=magstep 5;
errorstopmode; warningcheck:=-1;
ignore:=whatever; process:=0; utilize:=1; store:=2; % constants for introducing
let semicolon_=; ; % stores original meaning of a semicolon
newinternal tracingdimens; % if |tracingdimens>0| then |dim_file| is generated
% ---
def write_special = % additional info to be processed by AWK
 special "%GLYNFO: " &
enddef;
%% \--------------------------------------------------------------------
%% \descriptioncomments
% Macros |write_tex| and |write_commands| provide contact with the
% outer world. The former macro contains the information about EPSes that is
% used for proofing and assembling the font; must be consistent with
% the definitions contained in the files `mpform.sty' and `mp2pf.awk'.
% The latter macro provides a DOS-batch interface to the `epscinl'
% package which is used for including background bitmaps
% (in EPS form), i.e., stencils, into the resulting EPSes.
%% \-
%% \descriptioncomments
% Makra |write_tex| i~|write_commands| zapewniaj/a kontakt ze /swiatem
% zewn/etrznym. Pierwsze z~nich zawiera informacj/e o~p[likach EPS
% wykorzystywan/a przy tworzeniu dokumentacji i~zestawianiu fontu;
% musi by/c zgodne z~definicjami w plikach ,mpform.sty' i ,mp2pf.awk'.
% Drugie przygotowuje DOS-owy plik wsadowy wykorzystuj/acy pakiet ,epscinl'
% wykorzystywany przy umieszczaniu w~tle wygenerowanego EPS-a mapy bitowej
% (tak/ze w~postaci EPS-owej) jako podk/ladu ({\it stencil\/}).
%% \--------------------------------------------------------------------
vardef write_tex(expr name, num) =
 write "\EPSNAMEandNUMBER{" & name & "}{" & decimal(num) & "}"
%%%% WB: line
%%%% WB:  to pic_file & ".tex"
%%%% WB: changed to:
  to tex_pic_file
enddef;
vardef write_commands(expr num) =
%%%% WB: line
%%%% WB:  write "call epsincl " & jobname & "." & decimal(num) to pic_file & ".bat";
%%%% WB: changed to:
  write shell_command(num) to shell_pic_file
enddef;
%% \--------------------------------------------------------------------
%% The following macros are related to the operation of slanting.
%% In particular, they enable to keep a fixed width of a stem
%% after slanting.
%% \-
%% Poni/zsze makra s/a zwi/azane z operacj/a pochylania. Mi/edzy innymi
%% pozwalaj/a one na zachowanie zadanej grubo/sci stem/ow (/lody/zek?)
%% po pochyleniu.
%% \--------------------------------------------------------------------
vardef slant_ang = % should be rather called ``local_slant_angle''
 slang \\ if known glyph_slanting.glyph_name: * glyph_slanting.glyph_name fi
enddef;
vardef slant_val = tand(slant_ang) enddef;
vardef slant_preadjust(expr slope, slang) =
% |if sind(angle(slope))=0: 1 else:|
% | abs(sind(angle(slope))/sind(angle(cotd(angle(slope))+tand(slang),1)))|
% |fi|
% Correction of stem size taking into account its slope and a slant angle;
% nice formula, isn't it? Much simpler than the previous one, yet equivalent:
 length(unitvector(slope) slanted tand(slang))
enddef;
% ---
vardef stem_corr (expr slope) = slant_preadjust(slope, slant_ang) enddef;
% ---
def italicized = % fairly complex operation
 if slang<>0:
  if known glyph_slanting.glyph_name:
   if glyph_slanting.glyph_name=0: shifted (math_axis*tand(slang),0) fi
  fi
  shifted (italic_shift*tand(slang),0) % re-positioning
  slanted slant_val % and slanting
 fi
enddef;
% ---
primarydef b || c =
 whatever*b + c*stem_corr(b)*unitvector(b rotated 90)
enddef;
% ---
primarydef c /\ b =
% A variant of the |leg| procedure that iteratively counteracts slant
% deformation; as with |leg|, given: |c| -- hypotenuse (vector) of
% a right-angled triangle, |b| -- the length of one of its legs;
% result: the other leg of the triangle (vector),
 if slant_ang=0: (c leg b)
 else:
  begingroup save b_, b__, n_; b_:=b__:=b; n_:=10;
   forever:
    b_:=b*stem_corr(c leg b_);
    exitif (abs(b_-b__)<.01) or (n_<=0);
    b__:=b_; n_:=n_-1;
   endfor
   if (abs(b_-b__)>=.01):
    errmessage "GLYPH " & str glyph_name & ": iteration hasn't converged";
   fi
   c leg b_
  endgroup
 fi
enddef;
% ---
% Obsolete?
vardef rib(expr t,p,r) text u = % |u| is either empty or a vector
 save k_; pair k_; for i_:=u: k_:=u; endfor
 if unknown k_: k_=((udir t of p) rotated 90); fi
 (point t of p) + r * k_ * stem_corr(k_ rotated 90)
enddef;
%% \--------------------------------------------------------------------
%% The operation {\it compose_path\/} is useful in \MP{} programs
%% automatically generated from PFB sources (pf2mt1 utility). Suffixes
%% $a$ and $b$ of control nodes stand for `after' and `before', respectively;
%% The operation {\it compose_path\/} makes use of the operation
%% {\it compose_segment\/} that serves for constructing non-cyclic
%% paths.
%% \-
%% Operacja {\it compose_path\/} jest przydatna w~programach \MP{}-owych
%% automatycznie wygenerowanych z~plik/ow PFB (narz/edzie pf2mt1). Przyrostki
%% $a$ i~$b$ naci/ag/ow mnemonicznie mo/zna kojarzy/c z~angielskimi
%% okre/sleniami ,,after'' i~,,before''; operacja {\it compose_path\/}
%% wykorzystuje operacj/e {\it compose_segment\/} pozwalaj/ac/a konstruowa/c
%% /scie/zki niecykliczne.
%% \--------------------------------------------------------------------
vardef compose_segment@#(expr m,n) = % |m<=n|, not checked
 if unknown generating: if show_labels_>0:
  for i_:=m upto n:
   if known @#[i_]: just_label(str @#[i_], @#[i_]); fi
   % |if known @#[i_]a: just_label(str @#[i_]a, @#[i_]a); fi|
   % |if known @#[i_+1]b: just_label(str @#[i_+1]b, @#[i_+1]b); fi|
  endfor
 fi fi
 for i_:=m upto n-1:
  @#[i_] .. controls
   @#[i_] if known @#[i_]a: a fi and @#[i_+1] if known @#[i_+1]b: b fi ..
 endfor
 @#[n]
enddef;
vardef compose_path@#(expr n) =
 compose_segment@#(0,n) if @#0=@#[n]: & else: -- fi \\ cycle
enddef;
%% \--------------------------------------------------------------------
%% Automatically generated \MP{} programs often has improper
%% path directions. The macro {\it correct_path_directions\/}
%% fixes the problem (in most cases).
%% \-
%% Automatycznie generowane programy \MP{}-owe maj/a cz/estokro/c
%% nieprawid/lowe kierunki /scie/zek. Makro {\it correct_path_directions\/}
%% leczy problem (w~wi/ekszo/sci wypadk/ow).
%% \--------------------------------------------------------------------
tertiarydef a inside b =
% |a inside b| returns true if the bounding box of |a| is inside
% the bounding box of |b|, which may be misleading (think of
% |fullcircle inside unitsquare shifted (-1/2,-1/2) scaled .9 rotated 45|);
% for most curves occuring in fonts, however, one can safely infere
% that if |a inside b| holds, then |a| is inside |b|.
  (xpart llcorner b < xpart llcorner a) and
  (xpart urcorner b > xpart urcorner a) and
  (ypart llcorner b < ypart llcorner a) and
  (ypart urcorner b > ypart urcorner a)
enddef;

def correct_path_directions(text t)(suffix s) =
 begingroup
  save s_, s__, i_, j_, idx_; path s_[];
  if not path s0: scantokens("path " & generisize(str s0)); fi
  if not numeric s.num: scantokens("numeric " & generisize(str s.num)); fi
  s.num:=0;
  for s__:=t: s_[s.num]:=s__; idx_[s.num]:=0; s.num:=s.num+1; endfor;
  for i_:=0 upto s.num-1:
   for j_:=i_+1 upto s.num-1:
    if s_[i_] inside s_[j_]: idx_[i_]:=idx_[i_]+1; fi
    if s_[j_] inside s_[i_]: idx_[j_]:=idx_[j_]+1; fi
   endfor
  endfor
  for i_:=0 upto s.num-1:
   if odd idx_[i_]: s[i_]:=if turningnumber s_[i_]>0: reverse fi s_[i_];
   else: s[i_]:=if turningnumber s_[i_]<0: reverse fi s_[i_];
   fi
  endfor
 endgroup
enddef;
%% \--------------------------------------------------------------------
%% In general, all objects are supposed to be drawn by the
%% {\bf endglyph} macro, i.e., all drawing operations are deferred.
%% The same concerns labelling, which necessitates redefinition
%% of labelling macros.
%% \-
%% Zak/lada si/e, /ze wszelkie operacje rysowania s/a ,,odraczane''
%% i~realizowane dopiero przez makro {\bf endglyph}. To samo dotyczy
%% etykietowania, sk/ad konieczno/s/c przedefiniowania makr etykietuj/acych.
%% \--------------------------------------------------------------------
newinternal path_label_len; path_label_len:=1;
vardef path_labels@#(text suffix_list) text label_length =
 save s_;
 for l_:=label_length: interim path_label_len:=l_; endfor
 forsuffixes l_:=suffix_list:
  string s_; s_=str l_;
  if (known l_) and (path l_):
   for t_:=0 upto length(l_) if cycle l_: -1 fi: dot_label@#(
     decimal(t_) & substring (length(s_)-path_label_len,length(s_)) of s_,
    point t_ of l_);
   endfor
  fi
 endfor
enddef;
% ---
vardef just_labels@#(text t) =
 forsuffixes $=t: if known z$: just_label@#(str$,z$); fi endfor
enddef;
%
vardef just_label@#(expr s,z) = label_(@#)(s,z)(false); enddef;
%
vardef dot_labels@#(text t) =
 forsuffixes $=t: if known z$: dot_label@#(str$,z$); fi endfor
enddef;
%
vardef dot_label@#(expr s,z) = label_(@#)(s,z)(true); enddef;
%
def label_(suffix pos)(expr s,z, dot_or_not) =
% should be more complex if overlapping labels are to be avoided
 if unknown generating: if show_labels_>0:
  label_list[incr label_list.num]:=thelabel.pos(s,z italicized);
  if dot_or_not: label_list.dot[label_list.num]:=z italicized; fi
 fi fi
enddef;
% ---
def local_drawoptions (text t) = % to be used within a group
%% \begingroup \def\\#1{{\it#1}}% local: no underscore hacks
 save _op_; drawoptions(t);
%% \endgroup
enddef;
%% \--------------------------------------------------------------------
%% Basic macros for building character glyphs:
%% \-
%% Podstawowe makra do tworzenia obrys/ow znak/ow:
%% \--------------------------------------------------------------------
def good_path = enddef; % Obsolete, to be removed
%
vardef round_node_values(expr p) =
 for t_=0 upto length(p)-1:
  if round(point t_ of p)=round(point t_+1 of p):
   hide(message "GLYPH " & str glyph_name & ": degenerated bezier " &
   ", length=" & decimal(length(p)) & " " & ", time=" & decimal(t_) & " ";
   show p)
  else:
   round(point t_ of p)..
   if is_line(subpath (t_,t_+1) of p):
    controls round(point t_ of p) and round(point t_+1 of p)
   else:
    controls round(postcontrol t_ of p) and round(precontrol t_+1 of p)
   fi
   ..
  fi
 endfor
 round(point length(p) of p) \\ if cycle p: & cycle fi
enddef;
% ---
primarydef a start b =
 if cycle a:
  if b=default: default_start_(a)
  else: ((subpath (b,length(a)+b) of a) & cycle) fi
 else: a fi
enddef;
%
newinternal default; default:=infinity;
vardef default_start_(expr p) =
 save i_,j_,pi_,pj_; pair pi_,pj_;
 j_:=0; pj_:=point j_ of p;
 for i_=1 upto length(p):
  pi_:=point i_ of p;
  if (xpart(pi_)>xpart(pj_)) or
   (xpart(pi_)=xpart(pj_)) and (ypart(pi_)<ypart(pj_)):
   j_:=i_; pj_:=point j_ of p;
  fi
 endfor
 (subpath (j_, length(p)+j_) of p) & cycle
enddef;
% ---
def Fill text glist =
 begingroup
  save h_; path h_;
  for g_:=glist:
   h_:=g_ start.default; % JMN's suggestion
   if turningnumber h_<>1:
    errhelp "The result is likely to be weird.";
    errmessage "GLYPH " & str glyph_name & ": strange turning number in Fill, " &
     decimal(turningnumber h_);
   fi
   if glyph_usage div store = 1: % storing
    glyph_stored.glyph_name[incr glyph_stored.glyph_name.num]=h_;
   fi
   glyph_list[incr glyph_list.num]:=round_node_values(h_ italicized);
   update_glyph_bb(glyph_list[glyph_list.num]);
  endfor;
 endgroup
enddef;
%
def unFill text glist =
 begingroup
  save h_; path h_;
  for g_:=glist:
   h_:=g_ start.default; % JMN's suggestion
   if turningnumber h_<>-1:
    errhelp "The result is likely to be weird.";
    errmessage "GLYPH " & str glyph_name & ": strange turning number in unFill, " &
     decimal(turningnumber h_);
   fi
   if glyph_usage div store = 1: % storing
    glyph_stored.glyph_name[incr glyph_stored.glyph_name.num]=h_;
   fi
   glyph_list[incr glyph_list.num]:=round_node_values(h_ italicized);
  endfor;
 endgroup
enddef;
% ---
def fix_hsbw (expr xr,ml,mr) =
 glyph_shift:=round(ml); % shift = left margin
 glyph_width:=round(xr+ml+mr); % declared width plus margins
 if glyph_usage div store = 1: % storing
  glyph_shift.glyph_name:=glyph_shift; glyph_width.glyph_name:=glyph_width;
 fi
enddef;
% ---
def fix_exact_hsbw(expr xr,ml,mr) =
 glyph_shift:=round(ml); % shift = left margin
 glyph_width:=xr+ml+mr; % declared width plus margins
 if glyph_usage div store = 1: % storing
  glyph_shift.glyph_name:=glyph_shift; glyph_width.glyph_name:=glyph_width;
 fi
enddef;
% ---
def sym_hsbw (expr wd_fig, wd_gl) = % abbreviation
 fix_hsbw(wd_gl,1/2(wd_fig-wd_gl),1/2(wd_fig-wd_gl));
enddef;
% ---
vardef is_stored(text name) =
 known glyph_stored.uni_name(name).num
enddef;
%% \--------------------------------------------------------------------
%% The procedure {\it fix\_tfm\_data\/} computes and stores basic TFM data
%% for a given character ({\it wd}, {\it ht}, {\it dp}, and {\it ic\/}). If
%% ${\it fontmaking}=1$, the character dimensions will be written to the
%% TFM file (the {\it charcode\/} parameter is supposed to be appropriately
%% set); otherwise, they can be written out to the {\it dim\_file}, provided
%% ${\it tracingdimens}>0$. The parameters {\it tipx\/} and {\it tipy\/}
%% are used for heuristic computing the italic correction for the
%% character (see \MF{\/}book, p.~105); they are simply coordinates of the
%% the upper-right corner of the glyph (for italic font they refer to the
%% slanted glyph). It should be emphasized, however, that character
%% dimensions should be given explicitly, if possible. After all, a font
%% designer is expected to know them better than \MP{}\dots
%% \-
%% Procedura {\it fix\_tfm\_data\/} wyznacza i~zapami/etuje
%% podstawowe dane metryczne znaku ({\it wd}, {\it ht}, {\it dp}
%% i~{\it ic\/}). Je/sli ${\it fontmaking}=1$, wyznaczone warto/sci zostan/a
%% zapisane w~pliku TFM (zak/lada si/e, /ze parametr {\it charcode\/} ma
%% stosownie nadan/a warto/s/c); w~przeciwnym razie dane te mog/a zosta/c
%% zapisane do pliku {\it dim\_file}, o~ile ${\it tracingdimens}>0$.
%% Parametry {\it tipx\/} i~{\it tipy\/} s/a wykorzystywane do do
%% heurystycznego wyznaczenia korekty kursywy (por.~\MF{\/}book, p.~105);
%% oznaczaj/a one po prostu wsp/o/lrz/edne prawego
%% g/ornego naro/znika prostok/ata ograniczaj/acego obrys znaku
%% (w~kursywie odnosz/a si/e do obrysu po pochyleniu). Nale/zy jednak/ze
%% podkre/sli/c, /ze dane metryczne powinny by/c w~miar/e mo/zno/sci
%% podane jawnie. W~ko/ncu projektant fontu powinien lepiej si/e
%% orientowa/c w~tej materii ni/z \MP{}\dots
%% \--------------------------------------------------------------------
def fix_tfm_data(expr tipx, tipy) = % to improve or not to improve?
 if unknown ht.glyph_name:
  ht.glyph_name:=if known glyph_ury: glyph_ury else: 0 fi;
 fi
 if unknown dp.glyph_name:
  dp.glyph_name:=if known glyph_lly: glyph_lly else: 0 fi;
  if dp.glyph_name>0: dp.glyph_name:=0; fi
 fi
 charwd:=tfm_units(glyph_width);
 charht:=tfm_units(ht.glyph_name);
 chardp:=tfm_units(-dp.glyph_name); % reverse Polish convention
 % |tipx| and |tipy| are also valid for slanted font.
 if unknown ic.glyph_name:
  if known tipx and known tipy:
   ic.glyph_name:=round(tipx-glyph_width+1000/36);
   if ic.glyph_name<=2: % PSt's obstinacy
    ic.glyph_name:=0;
   fi
  else: ic.glyph_name:=0; fi
 fi
 charic:=tfm_units(ic.glyph_name);
 if tracingdimens>0:
  write "wd." & str glyph_name & ":=" & decimal glyph_width & "; " &
   "ht." & str glyph_name & ":=" & decimal ht.glyph_name & "; " &
   "dp." & str glyph_name & ":=" & decimal dp.glyph_name & "; " &
   "ic." & str glyph_name & ":=" & decimal ic.glyph_name & ";" to dim_file;
 fi
enddef;
%
%% \--------------------------------------------------------------------
%% Macros below set PostScript and \TeX{} units; a trick with `\#'
%% in {\it tfm\_units\/} proves useful in achieving compatibility
%% with the Knuthian fonts (e.g., it is employed in {\it logo\/} font).
%% Old versions of {\it tfm\_units\/} and {\it ps\_units\/} are less
%% accurate, but are kept because of backward compatibility reasons.
%% \-
%% Poni/zsze makra definiuj/a postscriptowe i~\TeX-/owe jednostki; trick
%% z~symbolem~,,\#'' w~{\it tfm\_units\/} jest u/zyteczny dla uzyskania
%% kompatybilno/sci z~Knuthowymi fontami (np.~wykorzystany zosta/l
%% w~foncie {\it logo\/}). Stare wersje makr {\it tfm\_units\/}
%% i~{\it ps\_units\/} s/a mniej dok/ladne, ale zosta/ly zachowane
%% ze~wzgl/edu na kompatybilno/s/c wstecz.
%% \--------------------------------------------------------------------
vardef tfm_units(text x) =
 save #; if known (x#): x# else: x/(1000/designsize) fi
enddef;
vardef old_tfm_units(text x) =
 save #; if known (x#): x# else: x/1000*designsize fi
enddef;
%
vardef ps_units(expr x) = x*(1000/designsize) enddef;
vardef old_ps_units(expr x) = x/designsize*1000 enddef;
%
def define_ps_units(text t) =
 forsuffixes $:=t: $:=ps_units($.#); endfor
enddef;
def define_whole_ps_units(text t) =
 forsuffixes $:=t: $:=round(ps_units($.#)); endfor
enddef;
def define_even_ps_units(text t) =
 forsuffixes $:=t: $:=2round(1/2ps_units($.#)); endfor
enddef;
%% \--------------------------------------------------------------------
%% Kerns and ligatures: you need to be careful if you don't want to produce
%% a malformed TFM:
%% \-
%% Podci/ecia i ligatury: nale/zy zachowa/c ostro/zno/s/c, /zeby nie powsta/l
%% nieopoprawny TFM
%% \--------------------------------------------------------------------
def start_or_cont =
% we postpone starting |ligtable| until a legal pair is encountered
 if unknown already_started: already_started:=1; ligtable LK_code: else: , fi
enddef;
%
def skip_LK =
 let ; = end_skip_LK \\ semicolon_
 let KL = fi \\ semicolon_
 if false:
enddef;
%
def end_skip_LK =
 let ; = semicolon_ semicolon_
 let KL = relax;
enddef;
%
def LK(text name) = % start ligature-kern table
 numeric LK_code,code,code',already_started; string LK_name;
 code:=name_to_code(name);
 if name_used(name): let next_to_do = relax;
 else: let next_to_do = skip_LK; fi
 next_to_do \\ LK_code:=code; LK_name:=glyph_ps_name.uni_name(name);
enddef;
%
def LP(text name_a, name_b) = % ligature pair
 if name_used(name_a) and name_used(name_b):
  if fontmaking=1:
   hide(code:=name_to_code(name_a); code':=name_to_code(name_b))
   start_or_cont \\ code=:(code') % braces are crucial for delimiting suffix
  else:
   out_lig(LK_name,
    glyph_ps_name.uni_name(name_a), glyph_ps_name.uni_name(name_b));
  fi
 fi
enddef;
%
def KP(text name)(text kern_val) = % kern pair
 if name_used(name):
  if fontmaking=1:
   hide(code:=name_to_code(name))
   start_or_cont \\ code kern tfm_units(kern_val)
  else:
   out_kpx(LK_name,glyph_ps_name.uni_name(name),kern_val);
  fi
 fi
enddef;
let KL = relax;
% ---
def out_kpx (expr l, r, v) =
 write "KPX " & l & " " & r & " " & decimal(v) to kpx_file
enddef;
% ---
def out_lig (expr l, r, s) =
 write "L " & l & " " & r & " " & s to kpx_file
enddef;
%% \--------------------------------------------------------------------
%% Macros for handling hints:
%% \-
%% Makra do wyznaczania ,,hint/ow'':
%% \--------------------------------------------------------------------
vardef feasible_node(text apart)(expr t, p)(text constraints)=
 clearxy; save a_,b_; transform a_;
 % |constraints| are not italicized, while |p| is, hence anti-italicizing;
 % actually, |constraints| are not rounded while the nodes of |p| are,
 % but this seems unimportant.
 a_ italicized=identity; z.it=point t of p; z=z.it transformed a_;
 boolean b_; b_:=true;
 for c_:=constraints: b_:=b_ and c_; endfor % |constraints| can be empty
 if b_: % for non-cyclic path, end-points are always considered OK
  % check the situation earlier than |t|
  (if origin<>predir t of p: apart(predir t of p)=0
   else: (apart(point t-1 of p)=apart(point t of p))
%   |and (apart(postcontrol t-1 of p)=apart(point t of p))| % shouldn't occur
   fi
  )
  or
  % check the situation later than |t|
  (if origin<>postdir t of p: apart(postdir t of p)=0
   else: (apart(point t+1 of p)=apart(point t of p))
%   |and (apart(precontrol t+1 of p)=apart(point t of p))| % shouldn't occur
   fi
  )
 else: false fi
enddef;
% ---
vardef covering@#(expr s,ds) =
 save res_; res_=0;
 for i_:=1 upto @#num:
  if (xpart(@#[i_])+ypart(@#[i_])>=s) and (xpart(@#[i_])<=s+ds):
   if res_=0: res_:=3; fi
   if (xpart(@#[i_])=s) or (xpart(@#[i_])+ypart(@#[i_])=s+ds): res_:=2; fi
   if (xpart(@#[i_])=s) and (ypart(@#[i_])=ds): res_:=1; fi
  fi
  exitif res_=1;
 endfor
% 0 -- no overlapping, 1 -- exact overlapping, 2 -- overlapping edges,
% 3 -- general overlapping
 res_
enddef;
% ---
def add_to_stem_list(expr stem_kind, base, delta) =
 begingroup
% |base| and |delta| are expected to be integers
  save stem_list_, stem_stored_, covering_;
  if stem_kind = "hstem":
   def stem_list_ = hstem_list enddef; def stem_stored_ = hstem_stored enddef;
  fi
  if stem_kind = "vstem":
   def stem_list_ = vstem_list enddef; def stem_stored_ = vstem_stored enddef;
  fi
  covering_:=covering.stem_list_(base,delta);
  if (covering_<>1) and ((covering_<>2) or (delta<>20)):
   stem_list_[incr stem_list_.num]:=(base,delta);
   if glyph_usage div store = 1: % storing
    stem_stored_.glyph_name[incr stem_stored_.glyph_name.num]:=(base,delta);
   fi
   if covering_>=2:
    stem_list_.cov:=1;
    if known overlapping_info: % a sort of debugging
     message "GLYPH " & str glyph_name & ": overlapping " & stem_kind &
      " (base=" & decimal(base) & ", delta=" & decimal(delta) & ").";
    fi
   fi
  fi
 endgroup
enddef;
% ---
def fix_stem(expr stem_kind)(expr delta)(text path_list) text constraints =
 begingroup
  save apart_, stem_tab_, base_, delta_, p__; path p__;
  if stem_kind="hstem": let apart_=ypart; fi
  if stem_kind="vstem": let apart_=xpart; fi
  delta_:=round(delta);
  for p_:=path_list: p__:=round_node_values(p_ italicized);
   for t_:=0 upto length(p__):
    if feasible_node(apart_)(t_, p__)(constraints):
     base_:=apart_(point t_ of p__);
     if unknown stem_tab_[base_]: stem_tab_[base_]:=1; fi
     if known stem_tab_[base_+delta_]:
      if stem_tab_[base_]=1:
        stem_tab_[base_]:=2;
        add_to_stem_list(stem_kind, base_, delta_);
      fi
     fi
     if known stem_tab_[base_-delta_]:
      if stem_tab_[base_-delta_]=1:
        stem_tab_[base_-delta_]:=2;
        add_to_stem_list(stem_kind, base_-delta_, delta_);
      fi
     fi
    fi
   endfor
  endfor
 endgroup
enddef;
% ---
%% \--------------------------------------------------------------------
%% \descriptioncomments
% Macro |set_stem| allows for forcing user-defined stem positions.
% The macro can be invoked in one of the three forms:
%    |set_stem (stem_kind) (a,b), (c,d), ... ;| (``low-level'' call)
%    |set_stem (stem_kind) px, (a,b), (c,d), ... ;|
%    |set_stem (stem_kind) px, py, (a,b), (c,d), ... ;|
% In~the~first~case, pairs |(a,b)|, |(c,d)|, etc., are expected to be
% the rounded coordinates (anyway, rounding is performed) of edges of
% a stem (left and right for vstem and top and bottom for hstem;
% order does not matter); in the second and third cases. |px| and
% |py| are paths, and the following pairs denote ordering numbers
% of nodes of the respective paths. Relevant coordinates of the
% nodes are taken into account (i.e., |x| for |stem_kind="vstem"|
% and |y| for |stem_kind="hstem"|). Path are subjected to the
% operation |italicizes| and |round_node_values| prior to processing.
%
%% \-
%% \descriptioncomments
% Makro |set_stem| pozwala na zadawanie warto/sci ,,hint/ow'' w~spos/ob
% kontrolowany przez u/zytkownika.
% Makro to mo/ze by/c wywo/lywane na trzy sposoby:
%  |set_stem (stem_kind) (a,b), (c,d), ...;|
%  (wywo/lanie ,,niskiego poziomu'')
%  |set_stem (stem_kind) px, (a,b), (c,d), ...; |
%  |set_stem (stem_kind) px, py, (a,b), (c,d), ...; |
% W~pierwszym przypadku wsp/o/lrz/edne poszczeg/olnych par oznaczaj/a
% po/lo/zenie lewej i~prawej b/ad/x g/ornej i~dolnej kraw/edzi ,,hintu''
% (warto/sci powinny by/c zaokr/aglone, ale wszelki wypadek zaokr/aglanie
% jest i~tak wykonywane; kolejno/s/c nie gra roli), podczas gdy
% w~przypadku drugim i~trzecim s/a to numery w/ez/l/ow /scie/zek |px| i~|py|.
% Do oblicze/n brane s/a wsp/o/lrz/edne tych w/ez/l/ow (|x| je/sli
% |stem_kind="vstem"|, |y| je/sli |stem_kind="hstem"|), przy czym
% /scie/zki poddawane s/a uprzednio operacji |italicized|
% i~|round_node_values|.
%% \--------------------------------------------------------------------
def set_stem(expr stem_kind) text hint_data =
 begingroup
  save p_, i_; path p_[];
  i_:=0;
  for h_:=hint_data:
   i_:=i_+1;
   if (path h_):
    if i_=1: p_1=round_node_values(h_ italicized); fi
    if i_=2: p_2=round_node_values(h_ italicized); fi
   fi
  endfor
  if known p_1:
   if unknown p_2: p_2=p_1; fi
   save q_; pair q_;
   for h_:=hint_data:
    if pair h_:
     if stem_kind="hstem":
      q_:=(ypart(point xpart(h_) of p_1), ypart(point ypart(h_) of p_2));
     fi
     if stem_kind="vstem":
      q_:=(xpart(point xpart(h_) of p_1), xpart(point ypart(h_) of p_2));
     fi
     % a single-level recursion below makes the code a bit simpler:
     set_stem(stem_kind) q_;
    fi
   endfor
  else:
   pair i_;
   for h_:=hint_data:
    i_:=round(h_); % just in case...
    if ypart(i_)>xpart(i_):
     add_to_stem_list(stem_kind, xpart(i_), ypart(i_)-xpart(i_));
    else:
     add_to_stem_list(stem_kind, ypart(i_), xpart(i_)-ypart(i_));
    fi
  endfor
  fi
 endgroup
enddef;
% ---
def fix_hstem = fix_stem("hstem") enddef;
def fix_vstem = fix_stem("vstem") enddef;
def set_hstem = set_stem("hstem") enddef;
def set_vstem = set_stem("vstem") enddef;
% ---
newinternal candidate_precision;
vardef candidate_list(text xy)(text cand_list) = % useful in constraints
 false for l_=cand_list: or (abs(xy-l_)<=candidate_precision) endfor
enddef;
% ---
def ghost_stem text t = % |t=bot| or |t=top|
 begingroup
  save top, bot; if unknown glyph.ghost_no: glyph.ghost_no:=0; fi
  % little trickery:
  def top suffix s_ = if str s_="": -infinity else: s_-eps fi enddef;
  def bot suffix s_ = if str s_="": +infinity else: s_+eps fi enddef;
  % deferred action:
  for s_:=t: glyph.ghost[incr glyph.ghost_no]:=s_; endfor
 endgroup
enddef;
%
def fix_ghost =
 begingroup
  if known glyph.ghost_no:
   save start_;
   for i:=1 upto glyph.ghost_no:
    start_:=glyph.ghost[i];
    start_:=round(
     if start_=-infinity: glyph_ury-20
     elseif start_=+infinity: glyph_lly
     elseif start_<round(start_): start_-20
     else: start_
    fi);
    add_to_stem_list("hstem", start_, 20);
   endfor
  fi
 endgroup
enddef;
% ---
def use_stems(text name) text offset =
 begingroup
  save offset_; pair offset_; offset_=(0,0);
  for t_:=offset: % syntactic sugar
   if pair t_: offset_:=round(t_); fi
   if numeric t_: offset_:=(round(t_),0); fi
  endfor
  for i_:=1 upto hstem_stored.uni_name(name).num:
   add_to_stem_list("hstem",
    round(xpart(hstem_stored.uni_name(name)[i_])+ypart(offset_)),
     ypart(hstem_stored.uni_name(name)[i_]));
  endfor
  for i_:=1 upto vstem_stored.uni_name(name).num:
   add_to_stem_list("vstem",
    round(xpart(vstem_stored.uni_name(name)[i_])+xpart(offset_ slanted slant_val)),
    % if |use_stems| is invoked from |use_accent|, the argument of |round|
    % is (nearly) rounded
    ypart(vstem_stored.uni_name(name)[i_]));
  endfor
 endgroup
enddef;
%% \--------------------------------------------------------------------
%% If the {\it project\/} variable is assigned value greater than~0,
%% proofing mode is assumed; the following macros display then
%% the details of the construction of glyphs for proofing purposes.
%% The larger value of the variable {\it project}, the more details
%% are visualised.
%% \-
%% Je/sli zmienna {\it project\/} ma warto/s/c wi/eksz/a ni/z~0, zak/lada
%% si/e, /ze przetwarzanie zwi/azane jest z~przygotowywaniem dokumentacji.
%% Poni/zsze makra uwidoczniaj/a w/owczas szczeg/o/ly konstrukcji
%% obrys/ow w~celach dokumentacyjnych. Im wy/zsza warto/s/c zmiennej
%% {\it project}, tym wi/ecej szczeg/o/l/ow zawieraj/a ilustracje.
%% \--------------------------------------------------------------------
def draw_controls (expr p) =
 begingroup
  save c_,d_,e_,f_; path c_,d_,e_,f_;
  c_=unitsquare shifted (-1/2,-1/2) rotated 45 scaled 5bp; % control point
  d_=fullcircle scaled 8bp; % node
  e_=triangle shifted (-1/6sqrt(3),0) yscaled 1/2 scaled 9bp; % edge
  f_=triangle scaled 12bp; % first node
  local_drawoptions (withcolor blue);
  for t_=0 upto length(p) if cycle p: -1 fi:
   if arclength(subpath (t_,t_+1) of p)>5xpart((point 1 of e_)-(point 0 of e_)):
    draw e_ rotated angle(direction t_+1/2 of p) shifted point t_+1/2 of p;
   fi
   if t_>0: fill d_ shifted point t_ of p; fi
   if (point t_ of p)<>(precontrol t_ of p):
    draw (point t_ of p) -- (precontrol t_ of p) dashed evenly;
    fill c_ rotated angle(predir t_ of p) shifted precontrol t_ of p
     withcolor white;
    draw c_ rotated angle(predir t_ of p) shifted precontrol t_ of p
     withpen pencircle scaled .3bp;
   fi
   if (postcontrol t_ of p)<>(point t_ of p):
    draw (postcontrol t_ of p) -- (point t_ of p) dashed evenly;
    fill c_ rotated angle(postdir t_ of p) shifted postcontrol t_ of p
     withcolor white;
    draw c_ rotated angle(postdir t_ of p) shifted postcontrol t_ of p
     withpen pencircle scaled .3bp;
   fi
  endfor
  fill f_ rotated
   if (point 0 of p)<>(postcontrol 0 of p): angle(postdir 0 of p)
   else: angle((point 1 of p)-(point 0 of p)) fi
   shifted point 0 of p withcolor red;
 endgroup
enddef;
% ---
color stem_color; stem_color=1/10[white,1/2red+1/2green];
def replstem_spec =
 withpen pencircle scaled 1 dashed withdots withcolor red
enddef;
def fontdim_spec = withpen pencircle scaled 2 withcolor magenta enddef;
def fontmath_spec = withpen pencircle scaled 2 withcolor cyan enddef;
def chardim_spec = withpen pencircle scaled 2 withcolor 3/4green enddef;
% ---
vardef draw_vhint@#(expr a,b) =
 if str @#="cov":
  draw (a,bot_line)--(a,top_line) replstem_spec;
  draw (a+b,bot_line)--(a+b,top_line) replstem_spec;
 else:
  fill (a,bot_line)--(a+b,bot_line)--(a+b,top_line)--(a,top_line)--cycle
   withcolor stem_color;
 fi;
enddef;
% ---
vardef draw_hhint@#(expr a,b) =
 if str @#="cov":
  draw (0,a)--(glyph_width,a) replstem_spec;
  draw (0,a+b)--(glyph_width,a+b) replstem_spec;
 else:
  fill (0,a)--(glyph_width,a)--(glyph_width,a+b)--(0,a+b)--cycle
   withcolor stem_color;
 fi
enddef;
def do_show_hints =
 if show_stems_>0:
  for h_:=1 upto hstem_list.num:
   draw_hhint(xpart(hstem_list[h_]), ypart(hstem_list[h_]));
  endfor
  if hstem_list.cov=1:
   for h_:=1 upto hstem_list.num:
    draw_hhint.cov(xpart(hstem_list[h_]), ypart(hstem_list[h_]));
   endfor
  fi
  for v_:=1 upto vstem_list.num:
   draw_vhint(xpart(vstem_list[v_])+glyph_shift, ypart(vstem_list[v_]));
  endfor
  if vstem_list.cov=1:
   for v_:=1 upto vstem_list.num:
    draw_vhint.cov(xpart(vstem_list[v_])+glyph_shift, ypart(vstem_list[v_]));
   endfor
  fi
 fi
enddef;
def ship_vhints =
 for v_:=1 upto vstem_list.num:
  write_special "VHINT " & decimal(xpart(vstem_list[v_])+glyph_shift) &
   " " & decimal(ypart(vstem_list[v_]));
 endfor
enddef;
def ship_hhints =
 for h_:=1 upto hstem_list.num:
  write_special "HHINT " & decimal(xpart(hstem_list[h_])) &
   " " & decimal(ypart(hstem_list[h_]));
 endfor
enddef;
def update_glyph_bb(expr p) =
 if unknown glyph_llx:
  glyph_llx:=xpart(llcorner(p)); glyph_lly:=ypart(llcorner(p));
  glyph_urx:=xpart(urcorner(p)); glyph_ury:=ypart(urcorner(p));
 else:
  if xpart(llcorner(p))<glyph_llx: glyph_llx:=xpart(llcorner(p)); fi
  if ypart(llcorner(p))<glyph_lly: glyph_lly:=ypart(llcorner(p)); fi
  if xpart(urcorner(p))>glyph_urx: glyph_urx:=xpart(urcorner(p)); fi
  if ypart(urcorner(p))>glyph_ury: glyph_ury:=ypart(urcorner(p)); fi
 fi
enddef;
def do_show_stencils =
 begingroup
  if show_stencils_>0:
   if known glyph_stencil.glyph_name and
    (known bitmap_scale or known glyph_llx):
    save s_; picture s_;
    s_:=use_eps(if known stencil_dir: stencil_dir & fi
     glyph_stencil.glyph_name);
    if length s_ > 0: % |use_eps| returns |nullpicture| in the case of emergency
     draw (s_ if known bitmap_scale: scaled bitmap_scale
      else: yxscaledto (glyph_ury-glyph_lly) fi)
     if known absolute_stencils:
      if known bitmap_offset: shifted (bitmap_offset+(glyph_shift,0))
      else: llshiftedto (glyph_llx+glyph_shift,glyph_lly) fi
     else:
      ccshiftedto
       (1/2[glyph_llx,glyph_urx]+glyph_shift, 1/2[glyph_lly,glyph_ury])
       if known bitmap_offset: shifted (bitmap_offset) fi
     fi;
    fi
   fi
  fi
 endgroup
enddef;
string stencil_dir;
def ship_glyphs =
 begingroup
  local_drawoptions();
  for g_:=1 upto glyph_list.num:
   if turningnumber glyph_list[g_]>0: fill else: unfill fi
    glyph_list[g_] shifted (glyph_shift,0);
  endfor
 endgroup
enddef;
def do_show_glyphs =
 begingroup
  save p_; path p_;
  for g_:=1 upto glyph_list.num:
   p_:=glyph_list[g_] shifted (glyph_shift,0);
   if show_fills_>0: if turningnumber p_>0: fill else: unfill fi p_; fi
   if show_strokes_>0:
    draw p_ if show_strokes_>1: withpen pencircle scaled 5 withcolor red fi;
   fi
   if show_paths_>0: draw_controls(p_); fi
  endfor
 endgroup
enddef;
def do_show_labels =
 for l_:=1 upto label_list.num:
  draw label_list[l_] shifted (glyph_shift,0);
  if known label_list.dot[l_]:
   fill fullcircle scaled 5bp shifted label_list.dot[l_] shifted (glyph_shift,0);
  fi
 endfor
enddef;
def do_show_boxes =
 if show_boxes_>0:
  draw (0,bot_line)--(glyph_width,bot_line)--
   (glyph_width,top_line)--(0,top_line)--cycle;
  draw (0,0)--(glyph_width,0) dashed evenly;
  if known glyph_axis.glyph_name:
   draw ((glyph_axis.glyph_name+glyph_shift,bot_line)--
    (glyph_axis.glyph_name+glyph_shift,top_line)) italicized dashed evenly;
  fi
  draw (0,uc_height)--(glyph_width,uc_height) fontdim_spec;
  draw (0,lc_height)--(glyph_width,lc_height) fontdim_spec;
  draw (0,depth)--(glyph_width,depth) fontdim_spec;
  if known math_axis:
    draw (0,math_axis)--(glyph_width,math_axis) fontmath_spec;
  fi
  if known ht.glyph_name:
   draw (0,ht.glyph_name)--(glyph_width,ht.glyph_name) chardim_spec;
  fi
  if known dp.glyph_name:
   draw (0,dp.glyph_name)--(glyph_width,dp.glyph_name) chardim_spec;
  fi
  if known ic.glyph_name:
   draw (glyph_width+ic.glyph_name,top_line)--
    (glyph_width+ic.glyph_name,top_line-250) chardim_spec;
  elseif known glyph_urx:
   save ital_corr; ital_corr:=glyph_urx+glyph_shift-glyph_width+1000/36;
   if ital_corr>0:
    draw (glyph_width+ital_corr,top_line)--(glyph_width+ital_corr,top_line-250)
     chardim_spec dashed evenly;
   fi
  fi
 fi
enddef;
def force_bbox =
 begingroup
 % circumventing the fragility of dvips prologues and inaccuracy of epsf:
 save corr_; corr_:=if glyph_width<100: 1/2(100-glyph_width) else: 0 fi;
 setbounds currentpicture to
  (glyph_width+corr_,bot_line)--(0,top_line)--(-corr_,bot_line)--cycle;
 endgroup;
enddef;
%% \--------------------------------------------------------------------
%% Begin and end of the definitions of a character glyph:
%% \-
%% Rozpocz/ecie i zako/nczenie definicji obrysu znaku:
%% \--------------------------------------------------------------------
def begin_skip =
 let endglyph = fi;
 let ; = end_skip semicolon_
 if false:
enddef;
def end_skip =
 let ; = semicolon_ semicolon_
 let endglyph = endglyph_;
enddef;

def uni_name(text name) = % name is either a suffix or a string expression
 if is_suffix(name): name else: scantokens("_" & name) fi
enddef;

def glyph_name_ext = enddef;

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
  glyph_list.num:=label_list.num:=0;
 pair hstem_list[\\], vstem_list[\\];
 numeric glyph_llx, glyph_lly, glyph_urx, glyph_ury;
 path glyph_list[\\];
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
% ---
picture endglyph_picture;
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
   draw endglyph_picture; do_show_labels; force_bbox;
  fi
  endfig;
 else:
  endgroup; % ends figure without shipping it out
 fi
enddef;
let endglyph_=endglyph;
string extra_beginglyph, extra_endglyph; extra_beginglyph=extra_endglyph="";
%% \--------------------------------------------------------------------
%% Additional macros:
%% \-
%% Makra dodatkowe:
%% \--------------------------------------------------------------------
vardef fix_name_list text t =
 string name_list[]; numeric name_list.num; name_list.num:=0;
 save , ; let , = fix_name_list_; fix_name_list_ t
enddef;
def fix_name_list_ suffix name =
 ; % important semicolon!
 if str name<>"": fix_name_list_s_ name else: fix_name_list_e_ "_" & fi
enddef;
def fix_name_list_s_ suffix s_name = fix_name_list_e_ (str s_name) enddef;
def fix_name_list_e_ expr e_name = % name is expected to be of the string type
 name_list[incr name_list.num]=e_name
enddef;

newinternal uc_accent_drop; % zero by default
newinternal ht_accent_limit;
ht_accent_limit:=50; % supposedly bottom accent |ht.acc < ht_accent_limit|
def use_accent(text name_char_acc) text offsets =
 begingroup
  save name_char_, name_acc_; save name_list; fix_name_list name_char_acc;
  def name_char_ = scantokens(name_list[1]) enddef;
  def name_acc_ = scantokens(name_list[2]) enddef;
  save off_acc_, off_char_; pair off_acc_, off_char_;
  off_char_:=off_acc_:=(0,0);
  for t_:=offsets: % syntactic sugar
   if pair t_: off_acc_:=round(t_); fi
   if numeric t_: off_char_:=(round(t_), 0); fi
   if color t_: off_char_:=round((redpart t_, greenpart t_)); fi
  endfor
  if (is_stored(name_acc_)) and (is_stored(name_char_)):
   if known glyph_axis.name_char_:
    glyph_axis.glyph_name=glyph_axis.name_char_;
   fi
   off_acc_:=off_acc_+
    (if known glyph_axis.name_char_: glyph_axis.name_char_
     else: 1/2wd.name_char_ fi
     -if known glyph_axis.name_acc_: glyph_axis.name_acc_
     else: 1/2wd.name_acc_ fi, 0) +
    (0,if ht.name_acc_>ht_accent_limit:
        ht.name_char_-lc_height if ht.name_char_-lc_height>0: -uc_accent_drop fi
      else: -dp.name_char_ fi);
   off_acc_:=round(off_acc_ slanted slant_val) slanted -slant_val;
   glyph_shift:=glyph_shift.name_char_;
   glyph_width:=glyph_width.name_char_; % can be overwritten in |fix_hsbw|
   for g_:=1 upto glyph_stored.name_char_.num:
    if turningnumber glyph_stored.name_char_[g_]>0: Fill else: unFill fi
     glyph_stored.name_char_[g_] shifted off_char_;
   endfor;
   for g_:=1 upto glyph_stored.name_acc_.num:
    if turningnumber glyph_stored.name_acc_[g_]>0: Fill else: unFill fi
     glyph_stored.name_acc_[g_] shifted off_acc_;
   endfor;
   write_special("ACC " & decimal(glyph_stored.name_char_.num+1));
   use_stems(name_char_) off_char_; use_stems(name_acc_) off_acc_;
  else:
   message "GLYPH " & str glyph_name & ": attempt to use not stored glyph " &
    str name_acc_ & " or " & str name_char_;
  fi
 endgroup
enddef;

def use_dimens(text name) =
 wd.glyph_name:=wd.uni_name(name);
 ht.glyph_name:=ht.uni_name(name);
 dp.glyph_name:=dp.uni_name(name);
 ic.glyph_name:=ic.uni_name(name);
enddef;

def use_glyph(text name) text offset =
 begingroup
  save gly_off_; pair gly_off_; gly_off_:=(0,0);
  for t_:=offset: % syntactic sugar
   if pair t_: gly_off_:=round(t_); fi
   if numeric t_: gly_off_:=(round(t_),0); fi
  endfor
  if is_stored(name):
   glyph_shift:=glyph_shift.uni_name(name);
   glyph_width:=glyph_width.uni_name(name); % can be overwritten in |fix_hsbw|
   for g_:=1 upto glyph_stored.uni_name(name).num:
    if turningnumber glyph_stored.uni_name(name)[g_]>0: Fill else: unFill fi
     glyph_stored.uni_name(name)[g_] shifted gly_off_;
   endfor;
   use_stems(name) gly_off_;
  else:
   message "GLYPH " & str glyph_name & ": attempt to use not stored glyph " &
    str uni_name(name);
  fi
 endgroup
enddef;

def reset_selected = save process_selected; save ignore_selected; enddef;
def introduce_selected text t =
 begingroup
  save name_list; fix_name_list t;
  process_selected:=1; % multi-step selection is legal
  for i_:=1 upto name_list.num:
   if known process_selected.scantokens(name_list[i_]):
    errhelp "Proceed, I'll just ignore the repeated selection.";
    errmessage "Character `" & (substring(1, infinity) of name_list[i_])
     & "' introduced again";
   else: process_selected.scantokens(name_list[i_])=1; fi
  endfor;
 endgroup
enddef;
def exclude_selected text t =
 begingroup
  save name_list; fix_name_list t;
  for i_:=1 upto name_list.num:
   if known ignore_selected.scantokens(name_list[i_]):
    errhelp "Proceed, I'll just ignore the repeated exclusion.";
    errmessage "Character `" & (substring(1, infinity) of name_list[i_])
     & "' excluded again";
   else: ignore_selected.scantokens(name_list[i_])=1; fi
  endfor;
 endgroup
enddef;

def introduce suffix name =
 if str name="": introduce_
 elseif (substring (0,1) of str name)<>"_": introduce_ name
 else: introduce__ name fi
enddef;
def introduce_ expr name = % name is expected to be a string expression
 introduce__ scantokens("_" & name)
enddef;
vardef introduce__@#(expr usage, slanting)(text stencil) =
 if (unknown process_selected or known process_selected@#)
  and known usage and unknown ignore_selected@#:
  glyph_usage@#:=usage; % |ignore=whatever|, |process=0|, |utilize=1|, |store=2|
  if unknown glyph_ps_name@#: % set default:
   assign_name @# (substring (1,infinity) of (str @#));
  fi
  glyph_slanting@#:=slanting; % ignore |slant_ang| if |0|; use |slant_ang| otherwise
  % |stencil| can be either string (recommended) or suffix (with default
  % extension |".eps"| -- obsolete), hence some trickery below
  save r_; string r_;
  for i_:=stencil: if string i_: r_:=i_; fi endfor
  if unknown r_:
   forsuffixes i_:=stencil: r_:= str i_; endfor
   if r_<>"": r_:=r_ & ".eps"; fi
  fi
  if r_<>"":
   if not string glyph_stencil@#:
    scantokens("string " & generisize(str glyph_stencil@#));
   fi
   glyph_stencil@# = r_;
  fi
 fi
enddef;
% ---
vardef assign_name@#(expr ps_name) =
 if not string glyph_ps_name @#:
  scantokens("string " & generisize(str glyph_ps_name@#));
 fi
 glyph_ps_name@#:=ps_name;
enddef;
% ---
def standard_introduce(expr name) =
 introduce name (utilize+store)(1)();
enddef;
% ---
def standard_hsbw(expr name) =
 fix_hsbw(wd.scantokens("_" & name),0,0);
enddef;
% ---
def standard_exact_hsbw(expr name) =
 fix_exact_hsbw(wd.scantokens("_" & name),0,0);
enddef;
% ---
vardef name_to_code(text name) =
 save res_, name_; string name_;
 name_:=substring (1,infinity) of str uni_name(name); res_=-1;
 for i:=0 upto 255: % 1-to-1 coding presumed
  if known code_to_name_[i]: if code_to_name_[i]=name_: res_:=i; fi fi
  exitif res_>-1;
 endfor
 res_
enddef;
newinternal select_encoded;
def encode(text name)(expr glyph_code)=
 if (glyph_code<0) or (glyph_code>255):
  errmessage "Improper code " & decimal(glyph_code);
 elseif known code_to_name_[glyph_code]:
  errmessage "Repeated code for " & code_to_name_[glyph_code] &
    " (" & decimal(glyph_code) & ")";
 else:
  code_to_name_[glyph_code]:=substring (1,infinity) of str uni_name(name);
 fi
 if select_encoded>0: introduce_selected uni_name(name); fi
enddef;
def uncode(expr glyph_code)=
 if (glyph_code<0) or (glyph_code>255):
  errmessage "Improper code " & decimal(glyph_code);
 else:
  code_to_name_[glyph_code]:=gen_whatever(string);
 fi
enddef;
string code_to_name_[\\];
% ---
vardef name_used(text name) =
 save res_, name_; boolean res_; string name_;
 name_:=substring (1,infinity) of str uni_name(name); res_:=false;
 for i:=1 upto max_name_used: res_:=(name_used_[i]=name_); exitif res_; endfor
 res_
enddef;
def mark_name_used(text name)=
 name_used_[incr max_name_used]:=substring (1,infinity) of str uni_name(name);
enddef;
string name_used_[\\]; newinternal max_name_used;

% ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===  ===
vardef string_date =
 if day<10: "0" & fi decimal(day) & "." &
 if month<10: "0" & fi decimal(month) & "." &
 decimal(year)
enddef;
% ---
def set_pfi (suffix kind) (expr val) =
 if known val:
  if not numeric val:
    if (string val) and (not string pf_info_set.kind):
      scantokens ("string " & generisize(str pf_info_set.kind));
    elseif (boolean val) and (not boolean pf_info_set.kind):
      scantokens ("boolean " & generisize(str pf_info_set.kind));
    fi
  fi
  pf_info_set.kind:=val;
  write str kind & " : " &
   if string val: val
   elseif numeric val: decimal(val)
   elseif boolean val: if val: "true" else: "false" fi
   else: "???"
   fi
   to pfi_file
 fi
enddef;
% ---
def pf_info_version expr v = set_pfi(VERSION,v); enddef;
%
def pf_info_creationdate text t =
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1; set_pfi(CREATION_DATE, t_); exitif k_=1; endfor
  if k_=0: set_pfi(CREATION_DATE, string_date); fi
 endgroup
enddef;
%
def pf_info_fontname text t =
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1;
   if k_=1: set_pfi(FONT_NAME, t_); fi
   if k_=2: set_pfi(FULL_NAME, t_); fi
   exitif k_=2;
  endfor
  if k_=1: set_pfi(FULL_NAME, pf_info_set.FONT_NAME); fi
 endgroup
enddef;
%
% useful short-cuts:
vardef family_name = pf_info_set.FAMILY_NAME enddef;
vardef font_name = pf_info_set.FONT_NAME enddef;
vardef full_name = pf_info_set.FULL_NAME enddef;
%
def pf_info_author expr v = set_pfi(AUTHOR,v); enddef;
%% \--------------------------------------------------------------------
%% There is `much ado about nothing,' i.e., about the sign of descender:
%% in a PFB file in an `ADL' comment, descender is positive, while in an AFM
%% in a `Descender' comment -- negative; we will distinguish between
%% the two, the more so as `ADL' comment is not mentioned in
%% in the Adobe documentation {\it Adobe Type~1 Font Format}.
%% \-
%% ,,Wiele ha/lasu o~nic'' jest spowodowane dwoma konwencjami ustalania
%% znaku parametru, descender': w~pliku PFB w~komentarzu, ADL' jego warto/s/c
%% jest dodatnia, natomiast w~pliku AFM w~komentarzu, Descender' -- ujemna.
%% Zdecydowali/smy si/e na odr/o/znienie tych dw/och przypadk/ow
%% tum bardziej, /ze komentarz, ADL' nie jest wzmiankowany
%% w~dokumentacji pt.~{\it Adobe Type~1 Font Format}.
%% \--------------------------------------------------------------------

def pf_info_ascender expr v = ascender:=v; set_pfi(ASCENDER,v); enddef;
def pf_info_descender expr v = descender:=v; set_pfi(DESCENDER,v); enddef;

def pf_info_adl text t =
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1;
   if (k_=1) and known t_: adl_ascender:=t_; set_pfi(ADL_ASCENDER,t_); fi
   if (k_=2) and known t_: adl_descender:=t_; set_pfi(ADL_DESCENDER,t_); fi
   if (k_=3) and known t_: adl_lineskip:=t_; set_pfi(ADL_LINESKIP,t_); fi
   exitif k_=3;
  endfor
 endgroup
enddef;
%
def pf_info_underline text t =
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1;
   if k_=1: set_pfi(UNDERLINE_POSITION,t_); fi
   if k_=2: set_pfi(UNDERLINE_THICKNESS,t_); fi
   exitif k_=2;
  endfor
 endgroup
enddef;
%
def pf_info_pfm text t = % name, bold (0 or 1), italic (0 or 1)
 begingroup
  save k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) and known t_ endfor and (k_=3):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if k_=1: set_pfi(PFM_NAME,t_); fi
    if k_=2: set_pfi(PFM_BOLD,t_); fi
    if k_=3: set_pfi(PFM_ITALIC,t_); fi
   endfor
  else:
   errhelp "Proceed, I'll just ignore PFM settings.";
   errmessage "Invalid PFM data";
  fi
 endgroup
enddef;
%
def pf_info_fixedpitch expr v = set_pfi(FIXED_PITCH,v); enddef;
def pf_info_capheight expr v = uc_height:=v; set_pfi(CAPHEIGHT,v); enddef;
def pf_info_weight expr v = set_pfi(WEIGHT,v); enddef;
def pf_info_stdvstem expr v = set_pfi(STDVW,v); enddef;
def pf_info_stdhstem expr v = set_pfi(STDHW,v); enddef;
def pf_info_forcebold expr v = set_pfi(FORCE_BOLD,v); enddef;

% TeX-related font info (fontdimens and headerbytes):
def pf_info_fontdimen text t = % exceptionally, TFM units expected
 begingroup
  save i_, k_;
  k_:=0;
  if true for t_:=t: hide(k_:=k_+1) and known t_ endfor and (k_<=3):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if k_=1: i_:=t_; fi
    if k_=2: set_pfi(FONT_DIMEN[i_],t_); fontdimen i_: t_; fi
    if k_=3: set_pfi(DIMEN_NAME[i_],t_); fi
   endfor
   if k_=2: set_pfi(DIMEN_NAME[i_],"(default)"); fi
  else:
   errhelp "Proceed, I'll just ignore TFM fontdimen settings.";
   errmessage "Invalid TFM fontdimen data";
  fi
 endgroup
enddef;
def pf_info_headerbyte text t =
 begingroup
  save i_, k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) and known t_ endfor and (k_=2):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if k_=1: i_:=t_; fi
    if k_=2:
     set_pfi(HEADER_BYTE[i_],if numeric t_: decimal(t_) else: t_ fi);
     if i_=9: % encoding scheme, e.g., |"TEX TEXT"|
      headerbyte 9: BCPL_string(t_,40); fi
     if i_=49: % font family, e.g., |"CMR"|
      headerbyte 49: BCPL_string(t_,20); fi
     if i_=72: % family member number, which should be between 0 and 255
      headerbyte 72: t_; fi
    fi
   endfor
  else:
   errhelp "Proceed, I'll just ignore TFM headerbyte settings.";
   errmessage "Invalid TFM headerbyte data";
  fi
 endgroup
enddef;
def pf_info_designsize expr v = % |designsize| is special
 designsize:=v; set_pfi(DESIGN_SIZE,decimal(v) & " (in points)");
enddef;
def pf_info_italicangle expr v =
 begingroup
  save tfm_units; vardef tfm_units(text x) = c enddef;
  slang:=v; set_pfi(ITALIC_ANGLE,-v);
  pf_info_fontdimen 1, if known slant: slant else: tand(slang) fi;
 endgroup
enddef;
def pf_info_space text t = % three in one
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1;
   if (designsize<>0) and known t_:
    if k_=1:
     space:=t_; pf_info_fontdimen 2, tfm_units(space);
    elseif k_=2:
     space_stretch:=t_; pf_info_fontdimen 3, tfm_units(space_stretch);
    elseif k_=3:
     space_shrink:=t_; pf_info_fontdimen 4, tfm_units(space_shrink);
    fi
   fi
   exitif k_=3;
  endfor
 endgroup
enddef;
def pf_info_normal_space text t =
 begingroup
  save k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) endfor and (k_<=2):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if (k_=1) and known t_: space:=t_; fi
    if (k_=2) and known t_: % |t_| is expected to be in TFM units
     pf_info_fontdimen 2, t_;
    fi
   endfor
   if (k_=1) and (designsize<>0) and known space:
    pf_info_fontdimen 2, tfm_units(space);
   fi
  fi
 endgroup
enddef;
def pf_info_space_stretch text t =
 begingroup
  save k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) endfor and (k_<=2):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if (k_=1) and known t_: space_stretch:=t_; fi
    if (k_=2) and known t_: % |t_| is expected to be in TFM units
     pf_info_fontdimen 3, t_;
    fi
   endfor
   if (k_=1) and (designsize<>0) and known space_stretch:
    pf_info_fontdimen 3, tfm_units(space_stretch);
   fi
  fi
 endgroup
enddef;
def pf_info_space_shrink text t =
 begingroup
  save k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) endfor and (k_<=2):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if (k_=1) and known t_: space_shrink:=t_; fi
    if (k_=2) and known t_: % |t_| is expected to be in TFM units
     pf_info_fontdimen 4, t_;
    fi
   endfor
   if (k_=1) and (designsize<>0) and known space_shrink:
    pf_info_fontdimen 4, tfm_units(space_shrink);
   fi
  fi
 endgroup
enddef;
def pf_info_xheight text t =
 begingroup
  save k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) endfor and (k_<=2):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if (k_=1) and known t_: lc_height:=t_; set_pfi(XHEIGHT, t_); fi
    if (k_=2) and known t_: % |t_| is expected to be in TFM units
     pf_info_fontdimen 5, t_;
    fi
   endfor
   if (k_=1) and (designsize<>0) and known lc_height:
    pf_info_fontdimen 5, tfm_units(lc_height);
   fi
  fi
 endgroup
enddef;
def pf_info_quad text t =
 begingroup
  save k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) endfor and (k_<=2):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if (k_=1) and known t_: quad:=t_; fi
    if (k_=2) and known t_: % |t_| is expected to be in TFM units
     pf_info_fontdimen 6, t_;
    fi
   endfor
   if (k_=1) and (designsize<>0) and known quad:
    pf_info_fontdimen 6, tfm_units(quad);
   fi
  fi
 endgroup
enddef;
def pf_info_extra_space text t =
 begingroup
  save k_; k_:=0;
  if true for t_:=t: hide(k_:=k_+1) endfor and (k_<=2):
   k_:=0;
   for t_:=t: k_:=k_+1;
    if (k_=1) and known t_: extra_space:=t_; fi
    if (k_=2) and known t_: % |t_| is expected to be in TFM units
     pf_info_fontdimen 7, t_;
    fi
   endfor
   if (k_=1) and (designsize<>0) and known extra_space:
    pf_info_fontdimen 7, tfm_units(extra_space);
   fi
  fi
 endgroup
enddef;
def pf_info_encoding text t =
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1;
   if k_=1: set_pfi(ENCODING_SCHEME, t_); fi
   if k_=2: pf_info_headerbyte 9, t_; fi
   exitif k_=2;
  endfor
  if k_=1: pf_info_headerbyte 9, pf_info_set.ENCODING_SCHEME; fi
 endgroup
enddef;
def pf_info_familyname text t =
 begingroup
  save k_; k_:=0;
  for t_:=t: k_:=k_+1;
   if k_=1: set_pfi(FAMILY_NAME, t_); fi
   if k_=2: pf_info_headerbyte 49, t_; fi
   exitif k_=2;
  endfor
  if k_=1: pf_info_headerbyte 49, pf_info_set.FAMILY_NAME; fi
 endgroup
enddef;
%
% bluezz forever...
newinternal blue_fuzz, blue_scale, blue_shift;
blue_fuzz:=0; % Adobe Type 1 Font Format, p. 41
blue_scale:=0.0454545;
blue_shift:=7;
%
def pf_info_overshoots text t =
 begingroup
  save i_, j_, b_, c_, r_; pair b_[\\], c_[\\];
  i_:=0; j_:=0;
  for t_:=t:
   if (xpart t_=0) and (ypart t_<0): b_[incr i_]=(ypart t_, xpart t_); fi
  endfor
  if i_=0:
   errhelp "No blue values will be written.";
   errmessage "Wrong overshoot info: no baseline ``blue value'' found";
  else:
   if i_>1:
    message "Improper overshoot info: multiple baseline ``blue values'' found";
    i_:=1;
   fi
   for t_:=t: if ypart t_>0: ins_blue(i_, t_, b_); fi endfor
   for t_:=t:
    if (xpart t_<>0) and (ypart t_<0): ins_other_blue(i_, j_, t_, b_, c_); fi
   endfor
  fi
  %
  flush_blues(BLUE_VALUES, min(7, i_), b_); % not more than 14 blue values
  if j_>0: % other blues are optional, while blue values are obligatory
   flush_blues(OTHER_BLUES, min(5, j_), c_); % not more than 10 other blues
  fi
  set_pfi(BLUE_FUZZ, blue_fuzz);
  set_pfi(BLUE_SCALE, blue_scale);
  set_pfi(BLUE_SHIFT, blue_shift);
 endgroup
enddef;
%
def ins_blue (suffix m) (expr p) (suffix b) =
 begingroup
  save p_, bad; boolean bad; pair p_;
  bad:=false; p_=(xpart p, xpart p+ypart p);
  for i_:=1 upto m: bad:=infeasible_blue(b[i_],p_); exitif bad; endfor
  if not bad: b[incr m]=p_;
  else:
   message "Improper overshoot info: ``blue value'' (" &
    decimal(xpart p) & "," & decimal(ypart p) & ") ignored.";
  fi
 endgroup
enddef;
%
def ins_other_blue (suffix m,n) (expr p) (suffix b,c) =
 begingroup
  save p_, bad; boolean bad; pair p_;
  bad:=false; p_=(xpart p+ypart p,xpart p);
  for i_:=1 upto m: bad:=infeasible_blue(b[i_], p_); exitif bad; endfor
  if not bad:
   for i_:=1 upto n: bad:=infeasible_blue(c[i_], p_); exitif bad; endfor
   if not bad: c[incr n]=p_; fi
  fi
  if bad:
   message "Improper overshoot info: ``other blue'' (" &
    decimal(xpart p) & "," & decimal(ypart p) & ") ignored.";
  fi
 endgroup
enddef;
%
def flush_blues (suffix kind) (expr n) (suffix v) =
 begingroup
  save r_; string r_; r_:="";
  if n>0:
   r_:=decimal(xpart v[1]) & " " & decimal(ypart v[1]);
   for i_:=2 upto n:
    r_:=r_ & " " & decimal(xpart v[i_]) & " " & decimal(ypart v[i_]);
   endfor
  fi
  set_pfi(kind, r_);
 endgroup
enddef;
%
vardef infeasible_blue(expr p,q) = % Adobe Type 1 Font Format, p. 41, Note
 ((ypart p + 2blue_fuzz+1)>=xpart q) and ((ypart q + 2blue_fuzz+1)>=xpart p)
enddef;

% it is advisable to avoid typso whenever possible:
def show_fills    expr x = show_fills_    :=x; enddef;
def show_strokes  expr x = show_strokes_  :=x; enddef;
def show_paths    expr x = show_paths_    :=x; enddef;
def show_labels   expr x = show_labels_   :=x; enddef;
def show_boxes    expr x = show_boxes_    :=x; enddef;
def show_stems    expr x = show_stems_    :=x; enddef;
def show_stencils expr x = show_stencils_ :=x; enddef;

string extra_beginfont, extra_endfont; extra_beginfont=extra_endfont="";

def beginfont =
 min_glyph_code=max_glyph_code=0;
 if known generating:
  if generating<>0: fontmaking:=1; fi
 else:
  if unknown show_fills_: show_fills(0); fi
  if unknown show_strokes_: show_strokes(1); fi
  if unknown show_paths_: show_paths(1); fi
  if unknown show_labels_: show_labels(1); fi
  if unknown show_boxes_: show_boxes(1); fi
  if unknown show_stems_: show_stems(1); fi
  if unknown show_stencils_: show_stencils(0); fi
 fi
 if designsize=0: designsize:=10; fi
 if unknown space: space:=333; fi
 if unknown space_stretch: space_stretch:=round(1/2space); fi
 if unknown space_shrink: space_shrink:=round(1/3space); fi
 if unknown extra_space: extra_space:=round(1/3space); fi
 if unknown quad: quad:=1000; fi
 if unknown slang:
  if known slant: % compatibility with the Old Tradition...
   slang:=angle(1, slant);
  else: slang:=0; fi
 fi
 if unknown uc_height: uc_height:=750; fi
 if unknown lc_height: lc_height:=400; fi
 if unknown math_axis: math_axis:=250; fi
 if unknown math_rule: math_rule:=40; fi
 if unknown italic_shift: italic_shift:=-100; fi
 if unknown depth: depth:=-250; fi
 if unknown ascender: ascender:=uc_height; fi
 if unknown descender: descender:=depth; fi
 if unknown adl_ascender: adl_ascender:=uc_height; fi
 if unknown adl_descender: adl_descender:=-depth; fi
 if unknown adl_lineskip: adl_lineskip:=0; fi
 if unknown top_line: top_line:=adl_ascender+1/2adl_lineskip; fi
 if unknown bot_line: bot_line:=-(adl_descender+1/2adl_lineskip); fi
 scantokens extra_beginfont;
enddef;
% ---
def endfont =
 scantokens extra_endfont;
 complete_pf_info;
 if fontmaking=1: write_dvips_info; fi
 complete_tfm_info;
 scantokens "end";
enddef;
% ---
def complete_pf_info =
 if unknown pf_info_set.DESIGN_SIZE: pf_info_designsize designsize; fi
 if unknown pf_info_set.VERSION: pf_info_version "0.000"; fi
 if unknown pf_info_set.AUTHOR: pf_info_author "Sam Body"; fi
 if unknown pf_info_set.CREATION_DATE: pf_info_creationdate; fi
 if unknown pf_info_set.FAMILY_NAME: pf_info_familyname "FontAnna"; fi
 if unknown pf_info_set.FONT_NAME: pf_info_fontname "FontAnna"; fi
 if unknown pf_info_set.ASCENDER: pf_info_ascender ascender; fi
 if unknown pf_info_set.DESCENDER: pf_info_descender descender; fi
 if unknown pf_info_set.ADL_ASCENDER:
  pf_info_adl adl_ascender, whatever, whatever;
 fi
 if unknown pf_info_set.ADL_DESCENDER:
  pf_info_adl whatever, adl_descender, whatever;
 fi
 if unknown pf_info_set.ADL_LINESKIP:
  pf_info_adl whatever, whatever, adl_lineskip;
 fi
 if unknown pf_info_set.UNDERLINE_POSITION: pf_info_underline -200, whatever; fi
 if unknown pf_info_set.UNDERLINE_THICKNESS: pf_info_underline whatever, math_rule; fi
 if unknown pf_info_set.ITALIC_ANGLE: pf_info_italicangle slang; fi
 if unknown pf_info_set.FIXED_PITCH: pf_info_fixedpitch false; fi
 if unknown pf_info_set.CAPHEIGHT: pf_info_capheight uc_height; fi
 if unknown pf_info_set.XHEIGHT: pf_info_xheight lc_height; fi
 if unknown pf_info_set.WEIGHT: pf_info_weight "Normal"; fi
 if unknown pf_info_set.STDVW: fi % just ignore
 if unknown pf_info_set.STDHW: fi % just ignore
 if unknown pf_info_set.FORCE_BOLD: pf_info_forcebold false; fi
 if unknown pf_info_set.ENCODING_SCHEME: pf_info_encoding "FontSpecific"; fi
 if unknown pf_info_set.BLUE_VALUES: set_pfi(BLUE_VALUES, ""); fi
 if unknown pf_info_set.OTHER_BLUES: fi % just ignore
 if unknown pf_info_set.BLUE_FUZZ: set_pfi(BLUE_FUZZ, blue_fuzz); fi
 if unknown pf_info_set.BLUE_SCALE: set_pfi(BLUE_SCALE, blue_scale); fi
 if unknown pf_info_set.BLUE_SHIFT: set_pfi(BLUE_SHIFT, blue_shift); fi
 % is `space' obligatory?
 if not name_used("space"):
  if unknown glyph_usage._space: introduce _space (utilize)(0)(); fi;
  if (name_to_code("space")<0) and (unknown code_to_name_32):
   encode("space") (32);
  fi
  beginglyph(_space) fix_hsbw(space,0,0); endglyph;
 fi
 % is `nbspace' obligatory? Let's assume it is, but not in TeX...
 if (if known generating: generating=0 else: true fi):
  if not name_used("nbspace"):
   if unknown glyph_usage._nbspace: introduce _nbspace (utilize)(0)(); fi;
   beginglyph(_nbspace) fix_hsbw(space,0,0); endglyph; % normal space width
  fi
 fi
enddef;
% ---
def complete_tfm_info =
 % complete fontdimen info:
 % |designsize| is expected to be known
 % |slant| dimen has already been set; |xheight| dimen -- not necessarily,
 % but |pf_info_set.XHEIGHT| is known:
 if unknown pf_info_set.FONT_DIMEN5:
  pf_info_xheight whatever,
   if known lc_height#: lc_height# else: tfm_units(pf_info_set.XHEIGHT) fi;
 fi
 pf_info_normal_space space if known space#: , space# fi;
 pf_info_space_stretch space_stretch
  if known space_stretch#: , space_stretch# fi;
 pf_info_space_shrink space_shrink if known space_shrink#: , space_shrink# fi;
 pf_info_quad quad if known quad#: , quad# fi;
 pf_info_extra_space extra_space if known extra_space#: , extra_space# fi;
 %
 % Non-standard, can be neutralized, if needed
 font_math_rule math_rule;
 font_math_axis math_axis;
 %
 % complete header info:
 pf_info_headerbyte 72, max(0, 254 - round 2designsize);
enddef;
% ---
def font_math_rule text x =
 begingroup save #; % cf. the definition of |tfm_units|
  if (known x#) or ((designsize<>0) and known x):
   pf_info_fontdimen 8, tfm_units(x), "(math rule)";
  fi
 endgroup
enddef;
def font_math_axis text x =
 begingroup save #; % cf. the definition of |tfm_units|
  if (known x#) or ((designsize<>0) and known x):
   pf_info_fontdimen 22, tfm_units(x), "(math axis)";
  fi
 endgroup
enddef;
%
def BCPL_string(expr s,n)= % string |s| becomes an |n|-byte BCPL string
 for l:=if length(s)>=n: n-1 else: length(s) fi: l
  for k:=1 upto l: , substring (k-1,k) of s endfor
  for k:=l+2 upto n: , 0 endfor endfor
enddef;
%
def write_dvips_info = % this macro is invoked only if |fontmaking=1|
 begingroup
  save enc_name_; string enc_name_; enc_name_:="enc" & jobname;
  write "/" & enc_name_ & "[" to enc_file;
  for i_:=0 upto 255:
   write "/" &
     if unknown code_to_name_[i_]
       if known rigorous_encoding: or not charexists i_ fi:
      ".notdef"
     else:
      % |glyph_ps_name.uni_name(begingroup code_to_name_[i_] endgroup))|
      % may be undefined (it is an undefined numeric then) if a character
      % is encoded but not introduced; allowing this may be useful at the
      % initial stage of a font development (if one starts with a complete
      % encoding); the construction |begingroup|\dots|endgroup| is essential:
      if known glyph_ps_name.uni_name(begingroup code_to_name_[i_] endgroup):
       glyph_ps_name.uni_name(begingroup code_to_name_[i_] endgroup)
      else:
       ".notdef"
      fi
     fi
    to enc_file;
  endfor
  write "] def" to enc_file;
  write jobname & " " & pf_info_set.FONT_NAME & " " &
   ditto & enc_name_ & " ReEncodeFont" & ditto &
   " <" & enc_file & " <" & jobname & ".pfb" to map_file;
 endgroup
enddef;
% ---
% The Old Tradition...
def font_size expr x = designsize:=x enddef;
def font_slant expr x = fontdimen 1: x enddef;
def font_normal_space expr x = fontdimen 2: x enddef;
def font_normal_stretch expr x = fontdimen 3: x enddef;
def font_normal_shrink expr x = fontdimen 4: x enddef;
def font_x_height expr x = fontdimen 5: x enddef;
def font_quad expr x = fontdimen 6: x enddef;
def font_extra_space expr x = fontdimen 7: x enddef;
endinput
%%\end

