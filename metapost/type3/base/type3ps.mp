%%%%
%%%% This file belongs to MTYPE13 package by Wlodek Bzyl <matwb@univ.gda.pl>
%%%%

%% \title{POSTSCRIPT SPECIFIC ITEMS}

%% One of required entries in each font dictionary is the array
%% $\2{FontMatrix}$. This array is used by a PostScript interpreter to
%% transform {\it glyph coordinate system\/} into the user system
%% coordinate system. 
%% This matrix maps font characters to one-unit coordinate
%% space, which enables PostScript interpreter to scale font
%% characters properly.
%% It is suggested that fonts use a 1000-unit grid. This implies
%% the following $\2{FontMatrix}$:
%% $$\2{FontMatrix}\,\,[\, .001\, 0\, 0\, .001\, 0\, 0\,]\,\,\2{def}$$
%% But what matrix is used is up to user, as long as the $\2{FontMatrix}$
%% would be adjusted accordingly.
%% The $\2{FontMatrix}$ will be read from a file named \meta{jobname}.par.
%% The parameters written to this file are read by the {\tt mptot3} script.

%% A two dimensional transformation is described in math as
%% $2\times 3$ matrix
%% $$\left[\matrix{a&b&t_x\cr c&d&t_x\cr}\right]$$
%% In the PostScript language, this matrix is represented as a
%% six-element array object
%% $$[\,a\,\,b\,\,c\,\,d\,\,t_x\,t_y\,]$$
%% For example, scaling by the factor $s_x$ in the $x$ dimension and
%% $s_y$ in the $y$ dimension is accomplished by the matrix:
%% $$\left[\matrix{s_x&0&0\cr 0&s_y&0\cr}\right]$$
%% or by an array object:
%% $$[\,s_x\,\,0\,\,0\,\,s_y\,\,0\,0\,]$$

vardef par_file = jobname & ".par" enddef; % here we write the font parameters

def font_matrix(expr a, b, c, d, tx, ty) =
  string postscript_parameter.FontMatrix;
  postscript_parameter.FontMatrix:= "FontMatrix [ " &
    decimal a & " " & decimal b & " " & decimal c & " " & decimal d &
    " " & decimal tx & " " & decimal ty & " ]";
  write postscript_parameter.FontMatrix to par_file
enddef;

%% Each PostScript font has a name and belongs to some family, has
%% attached version etc. These parameters are written onto
%% \\{jobname.par} file too. 

%%%%def font_name expr name = write "FontName " & name to par_file enddef;
%%%%def family_name expr name = write "FamilyName " & name to par_file enddef;
%%%%def font_version expr x = write "FontVersion " & x to par_file enddef;
%%%%def is_fixed_pitch expr b = write "isFixedPitch " &
%%%%  if b: "true" else: "false" fi to par_file
%%%%enddef;

def set_postscript_parameter(suffix kind)(expr val) =
  if string val: expandafter string
  elseif numeric val: expandafter numeric
  elseif boolean val: expandafter boolean
  fi
  postscript_parameter.kind;
  postscript_parameter.kind:=val;
  write str kind & " " &
    if string val: val
    elseif numeric val: decimal(val)
    elseif boolean val: if val: "true" else: "false" fi
    else: "???"
    fi
    to par_file
enddef;

def font_name expr $ = set_postscript_parameter(FontName,$) enddef;
def family_name expr $ = set_postscript_parameter(FamilyName,$) enddef;
def font_version expr $ = set_postscript_parameter(FontVersion,$) enddef;
def is_fixed_pitch expr $ = set_postscript_parameter(isFixedPitch,$) enddef;

def set_missing_postscript_parameters =
  if unknown postscript_parameter.FontName: font_name "Type3-Font"; fi
  if unknown postscript_parameter.FamilyName: family_name "Type3"; fi
  if unknown postscript_parameter.FontVersion: font_version "0.0alpha"; fi
  if unknown postscript_parameter.isFixedPitch: is_fixed_pitch false; fi
  if unknown postscript_parameter.FontMatrix:
    font_matrix(1/1000,0,0,1/1000,0,0);
  fi
enddef;

endinput

%% \end
