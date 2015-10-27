module Language::FuncLang::Eval

import Language::FuncLang::AST;
import List;

// Maps strings to Addresses.
alias Env = map[str, Address];

// A map from names to functions. 
// Such maps are used to represent the function definitions in the program.
alias PEnv = map[str, Func];

// A pair of an environment and an integer value. All evaluator functions 
// are changed from returning an integer (the result of evaluation) 
// to Result (the result of evaluation and the local side effects).
alias Result = tuple[Mem, int];

alias Address = int;
alias Mem = list[int];

public Result eval2(str main, list[int] args, Prog prog) {
  penv = ( f.name: f | f <- prog.funcs );
  f = penv[main];
  env = ( f.formals[i] : args[i] | i <- index(f.formals) ); 
  return eval2(f.body, env, penv);
}

public Result eval2(nat(int nat), Env env, PEnv penv) = <env, nat>;
 
public Result eval2(var(str name), Env env, PEnv penv) = <env, env[name]>;       

// The environment produced by the left operand ahs to be passed as argument 
// to the right operand of the multiplication. 
// This is needed, to propagate any side effects caused by the left 
// operand to propagate to the right one.
public Result eval2(mul(Exp lhs, Exp rhs), Env env, PEnv penv) {  
  <env, x> = eval2(lhs, env, penv);
  <env, y> = eval2(rhs, env, penv);
  return <env, x * y>;
} 
      
public Result eval2(div(Exp lhs, Exp rhs), Env env, PEnv penv) {
  <env, x> = eval2(lhs, env, penv);
  <env, y> = eval2(rhs, env, penv);
  return <env, x / y>;
} 
      
public Result eval2(add(Exp lhs, Exp rhs), Env env, PEnv penv)  {
  <env, x> = eval2(lhs, env, penv);
  <env, y> = eval2(rhs, env, penv);
  return <env, x + y>;
}

public Result eval2(sub(Exp lhs, Exp rhs), Env env, PEnv penv)  {
  <env, x> = eval2(lhs, env, penv);
  <env, y> = eval2(rhs, env, penv);
  return <env, x - y>;
} 
      
public Result eval2(gt(Exp lhs, Exp rhs), Env env, PEnv penv)  {
  <env, x> = eval2(lhs, env, penv);
  <env, y> = eval2(rhs, env, penv);
  return <env, (x > y) ? 1 : 0>;
} 
      
public Result eval2(lt(Exp lhs, Exp rhs), Env env, PEnv penv)  {
  <env, x> = eval2(lhs, env, penv);
  <env, y> = eval2(rhs, env, penv);
  return <env, (x < y) ? 1 : 0>;
} 
      
public Result eval2(geq(Exp lhs, Exp rhs), Env env, PEnv penv)  {
  <env, x> = eval2(lhs, env, penv);
  <env, y> = eval2(rhs, env, penv);
  return <env, (x >= y) ? 1 : 0>;
} 
      
public Result eval2(leq(Exp lhs, Exp rhs), Env env, PEnv penv)  {
  <env, x> = eval2(lhs, env, penv);
  <env, y> = eval2(rhs, env, penv);
  return <env, (x <= y) ? 1 : 0>;
} 
  
public Result eval2(cond(Exp cond, Exp then, Exp otherwise), Env env, PEnv penv)  {
  <env, c> = eval2(cond, env, penv);
  return (c != 0) ? eval2(then, env, penv) : eval2(otherwise, env, penv);
}
      
public Result eval2(call(str name, list[Exp] args), Env env, PEnv penv)  {
   f = penv[name];
   for (i <- index(f.formals)) {
     <env, v> = eval2(args[i], env, penv);
     env[f.formals[i]] = v;
   }
   return eval2(f.body, env, penv);
}
         
public Result eval2(let(list[Binding] bindings, Exp exp), Env env, PEnv penv)  {
   for (b <- bindings) {
     <env, x> = eval2(b.exp, env, penv);
     env[b.var] = x;
   }
   return eval2(exp, env, penv);
} 
    
public Result eval2(assign(var(str name), Exp exp), Env env, PEnv penv)  { 
  <env, v> = eval2(exp, env, penv);
  env[name] = v;
  return <env, v>;
}

public Result eval2(seq(Exp lhs, Exp rhs), Env env, PEnv penv)  {  
  <env, _> = eval2(lhs, env, penv);
  return eval2(rhs, env, penv);
}