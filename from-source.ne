# //----------------------------------------------------------------------
# // Global Declarations
# //----------------------------------------------------------------------

program         -> file:+

#file            -> newline:? (declr newline):* func:*
file            -> newline:? (declr newline):*

#declr           -> typedef | globals | native_func
declr           -> globals

# typedef         -> "type" id "extends" ("handle" | id) 

#globals         -> "globals" newline global_var_list "endglobals" 
globals         -> "globals" newline "endglobals" 

# global_var_list -> ("constant" type id "=" expr newline 
#                    | var_declr newline):*

# native_func     -> "constant":? "native" func_declr

# func_declr      -> id "takes" ("nothing" | param_list) 
#                    "returns" (type | "nothing")

# param_list      -> type id ("," type id):*

# func            -> "constant":? "function" func_declr newline 
#                    local_var_list statement_list "endfunction" newline

# //----------------------------------------------------------------------
# // Local Declarations
# //----------------------------------------------------------------------

# local_var_list  -> ("local" var_declr newline):*

# var_declr       -> type id ("=" expr):? | type "array" id 

# //----------------------------------------------------------------------
# // Statements
# //----------------------------------------------------------------------

# statement_list  ->  (statement newline):*

# statement       -> set | call | ifthenelse | loop | exitwhen | return 
#                    | debug

# set             -> "set" id "=" expr | "set" id "[" expr "]" "=" expr 

# call            -> "call" id "(" args:? ")"

# args            -> expr ("," expr):*

# ifthenelse      -> "if" expr "then" newline statement_list 
#                    else_clause:? "endif" 

# else_clause     -> "else" newline statement_list 
#                    | "elseif" expr "then" newline statement_list else_clause:?

# loop            -> "loop" newline statement_list "endloop"

# exitwhen        -> "exitwhen" expr 
#                 # // must appear in a loop

# return          -> "return" expr:?

# debug           -> "debug" (set | call | ifthenelse | loop)

# //----------------------------------------------------------------------
# // Expressions
# //----------------------------------------------------------------------

# expr            -> binary_op | unary_op | func_call | array_ref | func_ref 
#                    | id | const | parens

# binary_op       -> expr ([*+-/<>]|"=="|"!="|">="|"<="|"and"|"or") expr

# unary_op        -> ("+"|"-"|"not") expr
#                 # // expr must be integer or real when used with unary "+"

# func_call       -> id "(" args:? ")"

# array_ref       -> id "[" expr "]"

# func_ref        -> "function" id

const           -> int_const | real_const | bool_const | string_const | "null"

int_const       -> decimal | octal | hex | fourcc

decimal         -> "0" | [1-9] [0-9]:*

octal           -> "0" [0-7]:*

hex             -> "$" [0-9a-fA-F]:+ | "0" [xX] [0-9a-fA-F]:+

fourcc          -> "'" . . . . "'"

real_const      -> [0-9]:+ "." [0-9]:* | "." [0-9]:+

bool_const      -> "true" | "false"

string_const    -> "\"" .:* "\""
                # // any double-quotes in the string must be escaped with \

# parens          -> "(" expr ")"

# //----------------------------------------------------------------------
# // Base RegEx
# //----------------------------------------------------------------------

type            -> id | "code" | "handle" | "integer" | "real" | "boolean" 
                   | "string"

id              -> [a-zA-Z] ([a-zA-Z0-9_]:* [a-zA-Z0-9]):? {%(result,_,reject) => {
	result = result.flat(Infinity).join('');
	if (["null"].includes(result)) return reject;
	return result;
} %}

newline         -> "\n":+

_               -> __:?

__              -> [\s]:+     {% function(d) {return null } %}