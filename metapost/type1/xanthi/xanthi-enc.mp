%%%%
%%%%  $Revison:$
%%%%  $Date: 2004/08/24 23:40:18 $
%%%%

%% \input xanthi-format
%% \title{Encoding of Xanthi font}

if known included_xanthi_enc:
  expandafter endinput
else:
  included_xanthi_enc:=1;
fi

encode("i")(105); standard_introduce("i");

encode("1")(49); standard_introduce("1");
encode("2")(50); standard_introduce("2");
encode("3")(51); standard_introduce("3");
encode("4")(52); standard_introduce("4");

encode("s")(115); standard_introduce("s");
encode("l")(108); standard_introduce("l");
encode("r")(114); standard_introduce("r");

encode("S")(83); standard_introduce("S");
encode("L")(76); standard_introduce("L");
encode("R")(82); standard_introduce("R");

encode("a")(97); standard_introduce("a");
encode("b")(98); standard_introduce("b");

encode("A")(65); standard_introduce("A");
encode("B")(66); standard_introduce("B");

encode("v")(118); standard_introduce("v");
encode("V")(86); standard_introduce("V");

encode("u")(117); standard_introduce("u");
encode("U")(85); standard_introduce("U");

encode("d")(100); standard_introduce("d");
encode("D")(68); standard_introduce("D");

encode("T")(84); standard_introduce("T");  % upper right corner

endinput

%% \end
