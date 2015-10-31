module Language::FuncLang::Parse

import Language::FuncLang::Syntax;
import ParseTree;

// =============================================
// The Parser

public Prog parse(loc l) = parse(#Prog, l);
public Prog parse(str s) = parse(#Prog, s);

// rascal>import demo::lang::Func::programs::F0;
// ok
// rascal>parse(F0);