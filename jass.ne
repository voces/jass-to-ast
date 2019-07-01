@{%
const nil = () => null;
const keywords = [
	"null","globals","endglobals","code","handle","integer","real","boolean","string",
	"constant","array","true","false","native","nothing","takes","returns","function",
	"endfunction","if","then","endif","else","elseif"
];

class Node {
	constructor(data) {
		Object.defineProperty(this, 'data', {value: data});
		if (this.constructor.map) {
			const map = this.constructor.map;
			for (let i = 0; i < map.length; i++)
				if (data[i] !== null && data[i] !== undefined)
					this[map[i]] = data[i];
		}
	}
}

class List extends Array {
	constructor(arr) {
		if (arr) super(...arr);
		else super();
	}
}
class Block extends List {}
class Keyword extends Node {}
class SingleProp extends Node {}

class Param extends Node{static get map() {return ['type', 'name']}}
const classes = {
	program: class Program extends Block {},
	globals: class Globals extends Block {},
	var: class Variable extends Node {static get map() {return ['type', 'name', 'value']}},
	comment: class Comment extends SingleProp {static get map() {return ['text']}},
    param: Param,
    params: class Params extends List {},
	args: class Args extends List {},
	native: class Native extends Node {static get map() {return ['name', 'params', 'returns']}},
	call: class Call extends Node {static get map() {return ['name', 'args']}},
	name: class Name extends Keyword {},
	function: class Function extends Node {static get map() {return ['name', 'params', 'returns', 'comment', 'statements']}},
	statements: class Statements extends Block {},
	binary_op: class BinaryOp extends Node {static get map() {return ['left', 'operator', 'right']}},
	parens: class Parens extends SingleProp {},
	ifthenelse: class IfThenElse extends Node {static get map() {return ['condition', 'comment', 'then', 'elses']}},
	else: class Else extends Node {static get map() {return ['comment', 'statements']}},
	elseif: class ElseIf extends Node {static get map() {return ['condition', 'comment', 'statements']}},
	boolean: class Boolean extends Keyword {},
	set: class Set extends Node {static get map() {return ['name', 'value', 'prop']}},
	string: class String extends Keyword {},
};

const flat = (arr, depth = Infinity) => {
	if (!depth) return arr.slice();
	if (!Array.isArray(arr)) return arr;
	return arr.reduce((acc, cur) => {
		if (Array.isArray(cur) && !(cur instanceof List))
			acc.push(...flat(cur, depth - 1));
		else acc.push(cur);
		return acc;
	}, arr.constructor === Array ? [] : new arr.constructor());
};

const reject = {};
const e = (fn = data => data) => {
	fn.annotate = annotation => e(data => [annotation, ...fn(data)]);
	fn.index = index => e(data => (fn(data) || [])[index]);
	fn.first = () => e(data => (fn(data) || [])[0]);
	fn.second = () => e(data => fn(data)[1]);
	fn.map = fn2 => e(data => fn(data).map(fn2));
	fn.filter = fn2 => e(data => fn(data).filter(fn2));
	fn.clean = fn2 => e(data => fn(data).filter(v => v !== null));
	fn.fn = fn2 => e(data => fn2(fn(data)));
	fn.pick = (...args) => e(data => {
		data = fn(data);
		if (Array.isArray(data)) return data.map((v, i) => {
			if (typeof args[i] !== "function") return args[i] ? v : reject;
			return args[i](v);
		}).filter(v => v !== reject);
	});
	fn.flat = (depth = Infinity) => e(data => flat(fn(data), depth));
	//fn.flat = (depth = Infinity) => e(data => fn(data).flat(depth));
	fn.join = (delim = "") => e(data => fn(data).join(delim));
	fn.arr = () => e(data => [fn(data)]);
	fn.obj = (...names) => e(data => {
		data = fn(data) || [];
		data = data.map((v, i) => [names[i], v]);
		return Object.fromEntries(data);
	});
	fn.assign = obj => e(data => Object.assign(fn(data), obj));
	fn.kind = kind => {
		const klass = classes[kind];
		if (klass) return e(data => new klass(fn(data)));
		return e(data => ({kind, data: fn(data)}));
	};
	fn.dev = tag => e(data => ({kind: 'dev', tag, data: fn(data)}));
	fn.field = field => e(data => fn(data).field);
	fn.reorder = (...newPos) => e(data => {
		data = fn(data);
		const arr = [];
		for (let i = 0; i < newPos.length; i++)
			arr.push(data[newPos[i]]);
		return arr;
	});
	
	return fn;
};

const string = e().flat().join();

function printSource(ast) {
	
	if (!ast) return;
	if (typeof ast === "string") return ast;
	if (typeof ast.data === "string") return ast.data;
	
	let s = '';
	
	if (Array.isArray(ast))
		for (let i = 0; i < ast.length; i ++)
			s += printSource(ast[i])
	
	if (Array.isArray(ast.data))
		for (let i = 0; i < ast.data.length; i ++)
			s += printSource(ast.data[i])
	
	return s;
}

function inspect(what, depth = 0) {
	if (what === undefined) return "\t".repeat(depth) + "__undefined__";
	if (typeof what !== "object" || what === null) return "\t".repeat(depth) + typeof what + " " + JSON.stringify(what);
	if (what instanceof Array) {
		let s = "\t".repeat(depth) + what.constructor.name + " [\n";
		for (let i = 0; i < what.length; i++)
			s += "\t".repeat(depth + 1) + inspect(what[i], depth + 1).trim() + "\n";
		return s + "\t".repeat(depth) + "]";
	}
	let s = "\t".repeat(depth) + what.constructor.name + " {\n";
	const props = Object.getOwnPropertyDescriptors(what);
	for (const prop in props)
		s += "\t".repeat(depth + 1) + prop + ": " + inspect(what[prop], depth + 1).trim() + "\n";
	return s + "\t".repeat(depth) + "}";
}

function printAST(ast, depth = 0, skipInitialPad) {
	if (typeof ast !== 'object' || ast === null) return '\t'.repeat(skipInitialPad ? 0 : depth) + JSON.stringify(ast);
	const isArray = ast instanceof Array;
	const isKeyword = ast instanceof Keyword;
	const isValue = isKeyword || ast instanceof SingleProp;
	const start = `${'\t'.repeat(skipInitialPad ? 0 : depth)}${ast.constructor.name} ${isValue ? '' : isArray ? '[' : '{'}`
	let body = '';
	if (isArray) {
		for (let i = 0; i < ast.length; i++)
			if (typeof ast[i] === 'object' && ast[i] !== null)
				body += printAST(ast[i], depth + 1) + "\n";
	} else if (ast.kind === 'dev') {
		const line = "\t".repeat(depth+1) + "-".repeat(50) + "\n";
		body += line + inspect(ast).split("\n").map(v => "\t".repeat(depth) + v).join("\n") + "\n" + line;
	} else if (isKeyword) {
		body += ast.data;
	} else if (isValue) {
		body += printAST(ast.data[0], depth, true);
	} else {
		for (const prop in ast)
			body += `${'\t'.repeat(depth + 1)}${prop}: ${printAST(ast[prop], depth + 1, true)}\n`;
	}
	if (body) return start + (isValue ? '' : "\n") + body + (isValue ? '' : '\t'.repeat(depth) + (isArray ? ']' : '}'));
	else return start + (isArray ? ']' : '}');
}

function print(data) {
	console.log(data);
	console.log(printAST(data));
	//console.log(printSource(data));
}

const findNode = (ast, fn) => {
	if (fn(ast)) return ast;
	
	if (Array.isArray(ast))
		return ast.find(child => findNode(child, fn));
	
	if (typeof ast === "object" && ast !== null && Array.isArray(ast.data))
		return findNode(ast.data, fn);
};

const findKind = (ast, kind) =>
	findNode(ast, node =>
		typeof node === 'object' && node !== null && node.kind === kind);

%}

# //----------------------------------------------------------------------
# // Global Declarations
# //----------------------------------------------------------------------

program         -> program_blocks:+                               {%e().flat().clean().kind('program').fn(r => (print(r), r))%}

program_blocks  -> newline
                 | _ globals_block
				 | _ native_func
				 | _ function_block

globals_block   -> "globals" newline globals_block_statements:* _ "endglobals"       {%e().flat().clean().kind('globals')%}

globals_block_statements -> newline
						  | _ var_declr newline
						  | _ globals_statement_constant newline

globals_statement_constant -> "constant" __ type __ name _ "=" _ expr                      {%e().flat().reorder(2, 4, 8).kind('var').assign({constant: true})%}

native_func     -> "native" __ func_declr                                    {%e().flat().reorder(2, 3, 4).kind('native')%}
                 | "constant" __ func_declr

func_declr      -> name __ "takes" __ param_list __ "returns" __ func_return    {%e().flat().reorder(0, 4, 8)%}

param_list      -> param (_ "," _ param):*                                                             {%e().flat().kind('params')%}
                 | "nothing"                                                                           {%nil%}

func_return     -> type
                 | "nothing"                                                          {%nil%}
				 
function_block  -> "function" _ func_declr newline statements:? _ "endfunction"    {%e().flat().reorder(2, 3, 4, 6, 7).kind('function')%}


# //----------------------------------------------------------------------
# // Local Declarations
# //----------------------------------------------------------------------

var_declr       -> type __ name (_ "=" _ expr):?                            {%e().flat().reorder(0, 2, 6).kind('var')%}
                 | type __ "array" __ name                                  {%e().flat().reorder(0, 4).kind('var').assign({array: true})%}

param           -> type __ name                                             {%e().flat().reorder(0, 2).kind('param')%}

local           -> "local" __ var_declr                                     {%e().flat().index(2)%}


# //----------------------------------------------------------------------
# // Statements
# //----------------------------------------------------------------------

statements      -> _statements:+                                {%e().flat().kind('statements')%}

_statements     -> newline
                 | local
				 | ifthenelse
				 | set

set             -> "set" __ name _ "=" _ expr                              {%e().flat().reorder(2, 6).kind('set')%}
                 | "set" __ name _ "[" _ expr _ "]" _ "=" _ expr            {%e().flat().reorder(2, 12, 6).kind('set')%}

args            -> expr ("," _ expr):*                                    {%e().flat().filter((_, i) => i%3 === 0).kind('args')%}

ifthenelse      -> "if" __ expr __ "then" newline statements:? else_clauses:? "endif"   {%e().flat().reorder(2, 6, 7, 8).pick(1, 1, 1, e().fn(v => v.data)).kind('ifthenelse')%}

else_clauses    -> else_clause:+                                                      {%e().flat().kind('else_clauses')%}

else_clause     -> "else" newline statements:?                                        {%e().flat().reorder(2, 3).kind('else')%}
                 | "elseif" __ expr __ "then" newline statements:?                    {%e().flat().reorder(2, 6, 7).kind('elseif')%}

# //----------------------------------------------------------------------
# // Expressions
# //----------------------------------------------------------------------

expr            -> name                                                   {%e().kind('name')%}
                 | const                                                 # {%id%}
				 | func_call
				 | parens
				 | binary_op

const           -> int_const                                             # {%id%}
                 | real_const                                            # {%id%}
                 | bool_const                                            # {%id%}
                 | string_const                                          # {%id%}
                 | "null"                                                {%nil%}

int_const       -> decimal                                               # {%id%}
                 | octal                                                 # {%id%}
                 | hex                                                   # {%id%}
                 | fourcc                                                # {%id%}

decimal         -> "0"                                                   {%string.fn(v => parseInt(v))%}
                 | [1-9] [0-9]:*                                         {%string.fn(v => parseInt(v))%}

octal           -> "0" [0-7]:+                                           {%string.fn(v => parseInt(v, 8))%}

hex             -> "$" [0-9a-fA-F]:+                                     {%string.fn(v => parseInt(v.slice(1), 16))%}
                 | "0" [xX] [0-9a-fA-F]:+                                {%string.fn(v => parseInt(v.slice(2), 16))%}

fourcc          -> "'" . . . . "'"                                       # {%string%}

real_const      -> [0-9]:+ "." [0-9]:*                                   {%string.fn(v => parseFloat(v))%}
                 | "." [0-9]:+                                           {%string.fn(v => parseFloat(v))%}

bool_const      -> "true"                                                {%e().kind('boolean')%}
                 | "false"                                               {%e().kind('boolean')%}

string_const    -> "\"" [^"]:* "\""                                      {%string.kind('string')%}

binary_op       -> expr _ ("*"|"+"|"-"|"/"|"<"|">"|"=="|"!="|">="|"<=") _ expr {%e().flat().reorder(0, 2, 4).kind('binary_op')%}
                 | expr __ ("and"|"or") __ expr                                {%e().flat().reorder(0, 2, 4).kind('binary_op')%}

func_call       -> name "(" _ args:? _ ")"                                 {%e().flat().reorder(0, 3).kind('call')%}

parens          -> "(" _ expr _ ")"                                        {%e().flat().reorder(2).kind('parens')%}
				
# //----------------------------------------------------------------------
# // Base RegEx
# //----------------------------------------------------------------------

newline         -> _ "\n"                                                  {%() => [null, null]%}
                 | _ comment

type            -> _type                                                   # {%string.kind('type')%}

_type           -> name                                                    # {%e().first().field('data')%}
                 | "code"
                 | "handle"
                 | "integer"
                 | "real"
                 | "boolean"
                 | "string"

name              -> [a-zA-Z] ([a-zA-Z0-9_]:* [a-zA-Z0-9]):? {%(result, _, reject) => {
	result = string(result);
	if (keywords.includes(result)) return reject;
	return result;
	//return e().kind('name')(result);
} %}

_               -> __:?

__              -> [ \t]:+                                                         {%string%}

# todo: move the newline out of comment
comment         -> "//" [^\n]:* "\n"                                               {%string.fn(s => [s.slice(2, -1)]).kind('comment')%}
