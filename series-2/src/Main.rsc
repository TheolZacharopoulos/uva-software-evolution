module Main

import Configurations;
import IdenticalBlocks;

import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;

import Prelude;



void main()
{
    model = createM3FromEclipseProject(getTestProjectLocation());
    
    iprintln(findIdenticalMethods(model));
}