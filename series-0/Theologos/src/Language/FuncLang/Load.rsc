module Language::FuncLang::Load

import Language::FuncLang::Syntax;
import Language::FuncLang::AST;
import Language::FuncLang::Parse;

import ParseTree;

// =============================================
// Load the Abstract Syntax Tree

/**
 * Rather than manually writing conversion rules from Func parse trees to
 * Func abstract syntax trees we use our secret weapon: 
 * Rascal:implode that performs the mapping for us.
 */
public Language::FuncLang::AST::Prog implode(Language::FuncLang::Syntax::Prog p) = 
    implode(#Language::FuncLang::AST::Prog, p);
    
public Language::FuncLang::AST::Prog load(loc l) = implode(parse(l));
public Language::FuncLang::AST::Prog load(str s) = implode(parse(s));