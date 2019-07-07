@{%

import { map as classes, List } from "./types.js";

let fin = false;
const o = fn => ( result, ...args ) => fin ? fn( result, ...args ) : result;
const nil = () => null;
const keywords = [
    "null", "globals", "endglobals", "code", "handle", "integer", "real", "boolean", "string",
    "constant", "array", "true", "false", "native", "nothing", "takes", "returns", "function",
    "endfunction", "if", "then", "endif", "else", "elseif", "return", "loop", "endloop", "not"
];

const flat = ( arr, depth = Infinity ) => {

    if ( ! depth ) return arr.slice();
    if ( ! Array.isArray( arr ) ) return arr;
    return arr.reduce( ( acc, cur ) => {

        if ( Array.isArray( cur ) && ! ( cur instanceof List ) )
            acc.push( ...flat( cur, depth - 1 ) );
        else acc.push( cur );
        return acc;

    }, arr.constructor === Array ? [] : new arr.constructor() );

};

const reject = {};
const e = ( fn = data => data ) => {

    fn.index = index => e( data => ( fn( data ) || [] )[ index ] );
    fn.first = () => e( data => ( fn( data ) || [] )[ 0 ] );
    fn.second = () => e( data => fn( data )[ 1 ] );
    fn.map = fn2 => e( data => fn( data ).map( fn2 ) );
    fn.filter = fn2 => e( data => fn( data ).filter( fn2 ) );
    fn.clean = () => e( data => fn( data ).filter( v => v !== null && v !== undefined ) );
    fn.fn = fn2 => e( data => fn2( fn( data ) ) );
    fn.pick = ( ...args ) => e( data => {

        data = fn( data );
        if ( Array.isArray( data ) ) return data.map( ( v, i ) => {

            if ( typeof args[ i ] !== "function" ) return args[ i ] ? v : reject;
            return args[ i ]( v );

        } ).filter( v => v !== reject );

    } );
    fn.flat = ( depth = Infinity ) => e( data => flat( fn( data ), depth ) );
    fn.join = ( delim = "" ) => e( data => fn( data ).join( delim ) );
    fn.arr = () => e( data => [ fn( data ) ] );
    fn.obj = ( ...names ) => e( data => {

        data = fn( data ) || [];
        data = data.map( ( v, i ) => [ names[ i ], v ] );
        return Object.fromEntries( data );

    } );
    fn.assign = obj => e( data => Object.assign( fn( data ), obj ) );
    fn.kind = kind => {

        const klass = classes[ kind ];
        if ( klass ) return e( data => new klass( fn( data ) ) );
        return e( data => ( { kind, data: fn( data ) } ) );

    };
    fn.dev = tag => e( data => ( { kind: "dev", tag, data: fn( data ) } ) );
    fn.reorder = ( ...newPos ) => e( data => {

        data = fn( data );
        const arr = [];
        for ( let i = 0; i < newPos.length; i ++ )
            arr.push( data[ newPos[ i ] ] );
        return arr;

    } );
    fn.commentable = ( commentName = "comment" ) => e( data => {

        data = fn( data );
        if ( data && Array.isArray( data.data ) && data.data[ data.data.length - 1 ] )
            data[ commentName ] = data.data[ data.data.length - 1 ];
        return data;

    } );
    fn.lastAsComment = ( commentName = "comment" ) => e( data => {

        data = fn( data );
        if ( data && Array.isArray( data ) && data[ data.length - 2 ] && data[ data.length - 1 ] )
            data[ data.length - 2 ][ commentName ] = data[ data.length - 1 ];

        return data.slice( 0, - 1 );

    } );

    return fn;

};

const string = e().flat().join();

%}

# //----------------------------------------------------------------------
# // Global Declarations
# //----------------------------------------------------------------------

program                    -> program_blocks:+ _ fin                                                        {%o(e().flat().clean().kind('program'))%}

fin                        -> "fin"                                                                         {%() => (fin = true, null)%}

program_blocks             -> emptyline
                            | _program_block                                                                {%e().flat().reorder(1)%}

_program_block             -> _ globals_block
                            | _ native_func
                            | _ function_block
                            | _ type_declr

globals_block              -> "globals" newline globals_block_statements:? _ "endglobals" newline           {%e().flat().reorder(1, 2, 5).kind('globals')%}

globals_block_statements   -> _globals_block_statement:+                                                    {%e().flat().kind('statements')%}

_globals_block_statement   -> emptyline
                            | _ var_declr newline                                                           {%e().flat().reorder(1, 2).lastAsComment()%}
                            | _ globals_statement_constant newline                                          {%e().flat().reorder(1, 2).lastAsComment()%}

globals_statement_constant -> "constant" __ type __ name _ "=" _ expr                                       {%e().flat().reorder(2, 4, 8).kind('var').assign({constant: true})%}

native_func                -> "native" __ func_declr newline                                                {%e().flat().reorder(2, 3, 4, 5).kind('native').commentable()%}
                            | "constant" __ func_declr

func_declr                 -> name __ "takes" __ param_list __ "returns" __ func_return                     {%e().flat().reorder(0, 4, 8)%}

param_list                 -> param (_ "," _ param):*                                                       {%e().flat().filter((_, i) => i % 4 === 0).kind('params')%}
                            | "nothing"                                                                     {%nil%}

func_return                -> type
                            | "nothing"                                                                     {%nil%}
                 
function_block             -> "function" _ func_declr newline statements:? _ "endfunction" newline          {%e().flat().reorder(2, 3, 4, 5, 6, 9).kind('function').commentable('endComment')%}
                            | "constant function" _ func_declr newline statements:? _ "endfunction" newline {%e().flat().reorder(2, 3, 4, 5, 6, 9).kind('function').commentable('endComment').assign({constant: true})%}

type_declr                 -> "type" __ name __ "extends" __ name newline                                   {%e().flat().reorder(2, 6, 7).kind('type').commentable()%}


# //----------------------------------------------------------------------
# // Local Declarations
# //----------------------------------------------------------------------

var_declr                  -> type __ name (_ "=" _ expr):?                                                 {%e().flat().reorder(0, 2, 6).kind('var')%}
                            | type __ "array" __ name                                                       {%e().flat().reorder(0, 4).kind('var').assign({array: true})%}

param                      -> type __ name                                                                  {%e().flat().reorder(0, 2).kind('param')%}

local                      -> "local" __ var_declr                                                          {%e().flat().index(2)%}


# //----------------------------------------------------------------------
# // Statements
# //----------------------------------------------------------------------

statements                 -> _statement:+                                                                  {%e().flat().kind('statements')%}

_statement                 -> emptyline
                            | _ __statement newline                                                         {%e().flat().reorder(1, 2).fn(([statement, comment]) => comment ? Object.assign(statement, {comment}) : statement)%}
                 
__statement                -> local
                            | set
                            | call
                            | ifthenelse
                            | loop
                            | exitwhen
                            | return

set                        -> "set" __ name _ "=" _ expr                                                    {%e().flat().reorder(2, 6).kind('set')%}
                            | "set" __ name _ "[" _ expr _ "]" _ "=" _ expr                                 {%e().flat().reorder(2, 12, 6).kind('set')%}
                 
call                       -> "call" __ name _ "(" _ (args _):? ")"                                         {%e().flat().reorder(2, 6).kind('call').assign({statement: true})%}

args                       -> expr (_ "," _ expr):*                                                         {%e().flat().filter((_, i) => i%4 === 0).kind('args')%}

ifthenelse                 -> "if" _ expr _ "then" newline statements:? else_clauses:? _ "endif"            {%e().flat().reorder(2, 5, 6, 7).pick(1, 1, 1, e().fn(v => v && v.data)).kind('ifthenelse')%}

else_clauses               -> (_ else_clause):+                                                             {%e().first().map(v => v[1]).flat().kind('else_clauses')%}

else_clause                -> "else" newline statements:?                                                   {%e().flat().reorder(1, 2).kind('else')%}
                            | "elseif" _ expr _ "then" newline statements:?                                 {%e().flat().reorder(2, 5, 6).kind('elseif')%}

loop                       -> "loop" newline statements:? _ "endloop"                                       {%e().flat().reorder(1, 2).kind('loop')%}

# todo: combine statements and exitwhen into a rule for loop
exitwhen                   -> "exitwhen" _ expr                                                             {%e().flat().reorder(2).kind('exitwhen')%}

return                     -> "return" (_ expr):?                                                           {%e().flat().reorder(2).kind('return')%}

# //----------------------------------------------------------------------
# // Expressions
# //----------------------------------------------------------------------

expr                       -> logical_op
                 
_expr                      -> name                                                                          {%e().kind('name')%}
                            | const
                            | func_call
                            | parens
                            | unary_op
                            | array_ref
                            | func_ref

left_expr                  -> func_call
                            | parens
                            | array_ref
                            | left_unary_op
                            | string_const
                            | fourcc

right_expr                 -> parens
                            | string_const
                            | fourcc

left_right_expr            -> parens
                            | string_const
                            | fourcc

const                      -> number_const
                            | bool_const
                            | string_const
                            | "null"                                                                        {%nil%}

number_const               -> int_const
                            | real_const

int_const                  -> decimal
                            | octal
                            | hex
                            | fourcc

decimal                    -> "0"                                                                           {%() => 0%}
                            | [1-9] [0-9]:*                                                                 {%string.fn(v => parseInt(v))%}

octal                      -> "0" [0-7]:+                                                                   {%string.fn(v => parseInt(v, 8))%}

hex                        -> "$" [0-9a-fA-F]:+                                                             {%string.fn(v => parseInt(v.slice(1), 16))%}
                            | "0" [xX] [0-9a-fA-F]:+                                                        {%string.fn(v => parseInt(v.slice(2), 16))%}

fourcc                     -> "'" . . . . "'"                                                               {%string.fn(v => v.slice(1, -1)).kind('fourcc')%}

real_const                 -> [0-9]:+ "." [0-9]:*                                                           {%string.fn(v => parseFloat(v))%}
                            | "." [0-9]:+                                                                   {%string.fn(v => parseFloat(v))%}

bool_const                 -> "true"                                                                        {%e().fn(JSON.parse)%}
                            | "false"                                                                       {%e().fn(JSON.parse)%}

string_const               -> "\"" ([^"] | "\\\""):* "\""                                                   {%string.fn(v => v.slice(1, -1))%}
                            | "'" [^'] "'"                                                                  {%string.fn(v => v.slice(1, -1))%}

logical_op                 -> logical_op __ ("and"|"or") __ binary_op                                       {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | logical_op __ ("and"|"or") right_binary_op                                    {%e().flat().reorder(0, 2, 3).kind('binary_op')%}
                            | left_logical_op ("and"|"or") __ binary_op                                     {%e().flat().reorder(0, 1, 3).kind('binary_op')%} 
                            | left_logical_op ("and"|"or") right_binary_op                                  {%e().flat().reorder(0, 1, 2).kind('binary_op')%} 
                            | binary_op

# The left side of a logical op where there is no whitespace beween it and a keyword like "and" or "or"
# E.g., "(true)and true" or "foo[bar]and true"
left_logical_op            -> logical_op __ ("and"|"or") __ left_binary_op                                  {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | logical_op __ ("and"|"or") left_right_binary_op                               {%e().flat().reorder(0, 2, 3).kind('binary_op')%}
                            | left_logical_op ("and"|"or") __ left_binary_op                                {%e().flat().reorder(0, 1, 3).kind('binary_op')%} 
                            | left_logical_op ("and"|"or") left_right_binary_op                             {%e().flat().reorder(0, 1, 2).kind('binary_op')%} 
                            | left_binary_op

right_logical_op           -> right_logical_op __ ("and"|"or") __ binary_op                                 {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | right_logical_op __ ("and"|"or") right_binary_op                              {%e().flat().reorder(0, 2, 3).kind('binary_op')%}
                            | left_right_logical_op ("and"|"or") __ binary_op                               {%e().flat().reorder(0, 1, 3).kind('binary_op')%} 
                            | left_right_logical_op ("and"|"or") right_binary_op                            {%e().flat().reorder(0, 1, 2).kind('binary_op')%} 
                            | right_binary_op

left_right_logical_op      -> right_logical_op __ ("and"|"or") __ left_binary_op                            {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | right_logical_op __ ("and"|"or") left_right_binary_op                         {%e().flat().reorder(0, 2, 3).kind('binary_op')%}
                            | left_right_logical_op ("and"|"or") __ left_binary_op                          {%e().flat().reorder(0, 1, 3).kind('binary_op')%} 
                            | left_right_logical_op ("and"|"or") left_right_binary_op                       {%e().flat().reorder(0, 1, 2).kind('binary_op')%} 
                            | left_right_logical_op

binary_op                  -> binary_op _ ("<"|">"|"=="|"!="|">="|"<=") _ sum_op                            {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | sum_op

left_binary_op             -> binary_op _ ("<"|">"|"=="|"!="|">="|"<=") _ left_sum_op                       {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | left_sum_op

right_binary_op            -> right_binary_op _ ("<"|">"|"=="|"!="|">="|"<=") _ sum_op                      {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | right_sum_op

left_right_binary_op       -> right_binary_op _ ("<"|">"|"=="|"!="|">="|"<=") _ left_sum_op                 {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | left_right_sum_op

sum_op                     -> sum_op _ ("+"|"-") _ prod_op                                                  {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | prod_op

left_sum_op                -> sum_op _ ("+"|"-") _ left_prod_op                                             {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | left_prod_op

right_sum_op               -> right_sum_op _ ("+"|"-") _ prod_op                                            {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | right_prod_op

left_right_sum_op          -> right_sum_op _ ("+"|"-") _ left_prod_op                                       {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | left_right_prod_op

prod_op                    -> prod_op _ ("*"|"/") _ _expr                                                   {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | _expr

left_prod_op               -> prod_op _ ("*"|"/") _ left_expr                                               {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | left_expr

right_prod_op              -> right_prod_op _ ("*"|"/") _ _expr                                             {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | right_expr

left_right_prod_op         -> right_rod_op _ ("*"|"/") _ left_expr                                          {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                            | left_right_expr

unary_op                   -> _unary_op                                                                     {%e().flat().reorder(0, 2).kind('unary_op')%}
_unary_op                  -> ("+"|"-") _ _expr
                            | "not" __ _expr
                            | "not" left_expr

left_unary_op              -> _left_unary_op                                                                {%e().flat().reorder(0, 2).kind('unary_op')%}
_left_unary_op             -> ("+"|"-") _ left_expr
                            | "not" __ left_expr
                            | "not" left_right_expr

func_call                  -> name "(" _ (args _):? ")"                                                     {%e().flat().reorder(0, 3).kind('call')%}

parens                     -> "(" _ expr _ ")"                                                              {%e().flat().reorder(2).kind('parens')%}

array_ref                  -> name _ "[" _ expr _ "]"                                                       {%e().flat().reorder(0, 4).kind('array_ref')%}

func_ref                   -> "function" __ name                                                            {%e().flat().index(2).kind('func_ref')%}
                
# //----------------------------------------------------------------------
# // Base RegEx
# //----------------------------------------------------------------------

newline                    -> _ "\n"                                                                        {%nil%}
                            | _ comment                                                                     {%([whitespace, comment]) => comment || null%}

emptyline                  -> _ "\n"                                                                        {%e().index(1).kind('emptyline')%}
                            | _ comment                                                                     {%e().index(1)%}

type                       -> name
                            | "code"
                            | "handle"
                            | "integer"
                            | "real"
                            | "boolean"
                            | "string"

name                       -> [a-zA-Z] ([a-zA-Z0-9_]:* [a-zA-Z0-9]):?                                       {%( result, _, reject ) => {
                                                                                                                result = string( result );
                                                                                                                if ( keywords.includes( result ) ) return reject;
                                                                                                                return result;
                                                                                                            } %}

_                          -> __:?

__                         -> [ \t]:+                                                                       {%string%}

# todo: move the newline out of comment
comment                    -> "//" [^\n]:* "\n"                                                             {%string.fn(s => [s.slice(2, -1)]).kind('comment')%}
