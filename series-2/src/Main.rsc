module Main

import Configurations;
import Strategy::Commons;

import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::m3::Core;

import Prelude;

void main()
{
    model = createAstsFromEclipseProject(getTestProjectLocation(), true);

    
}