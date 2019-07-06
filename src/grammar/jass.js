// Generated automatically by nearley, version unknown
// http://github.com/Hardmath123/nearley

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

function id(x) { return x[0]; }
let Lexer = undefined;
let ParserRules = [
    {"name": "program$ebnf$1", "symbols": ["program_blocks"]},
    {"name": "program$ebnf$1", "symbols": ["program$ebnf$1", "program_blocks"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "program", "symbols": ["program$ebnf$1", "_", "fin"], "postprocess": o(e().flat().clean().kind('program'))},
    {"name": "fin$string$1", "symbols": [{"literal":"f"}, {"literal":"i"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "fin", "symbols": ["fin$string$1"], "postprocess": () => (fin = true, null)},
    {"name": "program_blocks", "symbols": ["emptyline"]},
    {"name": "program_blocks", "symbols": ["_", "globals_block"]},
    {"name": "program_blocks", "symbols": ["_", "native_func"]},
    {"name": "program_blocks", "symbols": ["_", "function_block"]},
    {"name": "globals_block$string$1", "symbols": [{"literal":"g"}, {"literal":"l"}, {"literal":"o"}, {"literal":"b"}, {"literal":"a"}, {"literal":"l"}, {"literal":"s"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "globals_block$ebnf$1", "symbols": ["globals_block_statements"], "postprocess": id},
    {"name": "globals_block$ebnf$1", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "globals_block$string$2", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}, {"literal":"g"}, {"literal":"l"}, {"literal":"o"}, {"literal":"b"}, {"literal":"a"}, {"literal":"l"}, {"literal":"s"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "globals_block", "symbols": ["globals_block$string$1", "newline", "globals_block$ebnf$1", "_", "globals_block$string$2", "newline"], "postprocess": e().flat().reorder(1, 2, 5).kind('globals')},
    {"name": "globals_block_statements$ebnf$1", "symbols": ["_globals_block_statement"]},
    {"name": "globals_block_statements$ebnf$1", "symbols": ["globals_block_statements$ebnf$1", "_globals_block_statement"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "globals_block_statements", "symbols": ["globals_block_statements$ebnf$1"], "postprocess": e().flat().kind('statements')},
    {"name": "_globals_block_statement", "symbols": ["emptyline"]},
    {"name": "_globals_block_statement", "symbols": ["_", "var_declr", "newline"], "postprocess": e().flat().reorder(1, 2).lastAsComment()},
    {"name": "_globals_block_statement", "symbols": ["_", "globals_statement_constant", "newline"], "postprocess": e().flat().reorder(1, 2).lastAsComment()},
    {"name": "globals_statement_constant$string$1", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"n"}, {"literal":"s"}, {"literal":"t"}, {"literal":"a"}, {"literal":"n"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "globals_statement_constant", "symbols": ["globals_statement_constant$string$1", "__", "type", "__", "name", "_", {"literal":"="}, "_", "expr"], "postprocess": e().flat().reorder(2, 4, 8).kind('var').assign({constant: true})},
    {"name": "native_func$string$1", "symbols": [{"literal":"n"}, {"literal":"a"}, {"literal":"t"}, {"literal":"i"}, {"literal":"v"}, {"literal":"e"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "native_func", "symbols": ["native_func$string$1", "__", "func_declr", "newline"], "postprocess": e().flat().reorder(2, 3, 4, 5).kind('native').commentable()},
    {"name": "native_func$string$2", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"n"}, {"literal":"s"}, {"literal":"t"}, {"literal":"a"}, {"literal":"n"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "native_func", "symbols": ["native_func$string$2", "__", "func_declr"]},
    {"name": "func_declr$string$1", "symbols": [{"literal":"t"}, {"literal":"a"}, {"literal":"k"}, {"literal":"e"}, {"literal":"s"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "func_declr$string$2", "symbols": [{"literal":"r"}, {"literal":"e"}, {"literal":"t"}, {"literal":"u"}, {"literal":"r"}, {"literal":"n"}, {"literal":"s"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "func_declr", "symbols": ["name", "__", "func_declr$string$1", "__", "param_list", "__", "func_declr$string$2", "__", "func_return"], "postprocess": e().flat().reorder(0, 4, 8)},
    {"name": "param_list$ebnf$1", "symbols": []},
    {"name": "param_list$ebnf$1$subexpression$1", "symbols": ["_", {"literal":","}, "_", "param"]},
    {"name": "param_list$ebnf$1", "symbols": ["param_list$ebnf$1", "param_list$ebnf$1$subexpression$1"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "param_list", "symbols": ["param", "param_list$ebnf$1"], "postprocess": e().flat().filter((_, i) => i % 4 === 0).kind('params')},
    {"name": "param_list$string$1", "symbols": [{"literal":"n"}, {"literal":"o"}, {"literal":"t"}, {"literal":"h"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "param_list", "symbols": ["param_list$string$1"], "postprocess": nil},
    {"name": "func_return", "symbols": ["type"]},
    {"name": "func_return$string$1", "symbols": [{"literal":"n"}, {"literal":"o"}, {"literal":"t"}, {"literal":"h"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "func_return", "symbols": ["func_return$string$1"], "postprocess": nil},
    {"name": "function_block$string$1", "symbols": [{"literal":"f"}, {"literal":"u"}, {"literal":"n"}, {"literal":"c"}, {"literal":"t"}, {"literal":"i"}, {"literal":"o"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "function_block$ebnf$1", "symbols": ["statements"], "postprocess": id},
    {"name": "function_block$ebnf$1", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "function_block$string$2", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}, {"literal":"f"}, {"literal":"u"}, {"literal":"n"}, {"literal":"c"}, {"literal":"t"}, {"literal":"i"}, {"literal":"o"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "function_block", "symbols": ["function_block$string$1", "_", "func_declr", "newline", "function_block$ebnf$1", "_", "function_block$string$2", "newline"], "postprocess": e().flat().reorder(2, 3, 4, 5, 6, 9).kind('function').commentable('endComment')},
    {"name": "function_block$string$3", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"n"}, {"literal":"s"}, {"literal":"t"}, {"literal":"a"}, {"literal":"n"}, {"literal":"t"}, {"literal":" "}, {"literal":"f"}, {"literal":"u"}, {"literal":"n"}, {"literal":"c"}, {"literal":"t"}, {"literal":"i"}, {"literal":"o"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "function_block$ebnf$2", "symbols": ["statements"], "postprocess": id},
    {"name": "function_block$ebnf$2", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "function_block$string$4", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}, {"literal":"f"}, {"literal":"u"}, {"literal":"n"}, {"literal":"c"}, {"literal":"t"}, {"literal":"i"}, {"literal":"o"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "function_block", "symbols": ["function_block$string$3", "_", "func_declr", "newline", "function_block$ebnf$2", "_", "function_block$string$4", "newline"], "postprocess": e().flat().reorder(2, 3, 4, 5, 6, 9).kind('function').commentable('endComment').assign({constant: true})},
    {"name": "var_declr$ebnf$1$subexpression$1", "symbols": ["_", {"literal":"="}, "_", "expr"]},
    {"name": "var_declr$ebnf$1", "symbols": ["var_declr$ebnf$1$subexpression$1"], "postprocess": id},
    {"name": "var_declr$ebnf$1", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "var_declr", "symbols": ["type", "__", "name", "var_declr$ebnf$1"], "postprocess": e().flat().reorder(0, 2, 6).kind('var')},
    {"name": "var_declr$string$1", "symbols": [{"literal":"a"}, {"literal":"r"}, {"literal":"r"}, {"literal":"a"}, {"literal":"y"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "var_declr", "symbols": ["type", "__", "var_declr$string$1", "__", "name"], "postprocess": e().flat().reorder(0, 4).kind('var').assign({array: true})},
    {"name": "param", "symbols": ["type", "__", "name"], "postprocess": e().flat().reorder(0, 2).kind('param')},
    {"name": "local$string$1", "symbols": [{"literal":"l"}, {"literal":"o"}, {"literal":"c"}, {"literal":"a"}, {"literal":"l"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "local", "symbols": ["local$string$1", "__", "var_declr"], "postprocess": e().flat().index(2)},
    {"name": "statements$ebnf$1", "symbols": ["_statement"]},
    {"name": "statements$ebnf$1", "symbols": ["statements$ebnf$1", "_statement"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "statements", "symbols": ["statements$ebnf$1"], "postprocess": e().flat().kind('statements')},
    {"name": "_statement", "symbols": ["emptyline"]},
    {"name": "_statement", "symbols": ["_", "__statement", "newline"], "postprocess": e().flat().reorder(1, 2).fn(([statement, comment]) => comment ? Object.assign(statement, {comment}) : statement)},
    {"name": "__statement", "symbols": ["local"]},
    {"name": "__statement", "symbols": ["set"]},
    {"name": "__statement", "symbols": ["call"]},
    {"name": "__statement", "symbols": ["ifthenelse"]},
    {"name": "__statement", "symbols": ["loop"]},
    {"name": "__statement", "symbols": ["exitwhen"]},
    {"name": "__statement", "symbols": ["return"]},
    {"name": "set$string$1", "symbols": [{"literal":"s"}, {"literal":"e"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "set", "symbols": ["set$string$1", "__", "name", "_", {"literal":"="}, "_", "expr"], "postprocess": e().flat().reorder(2, 6).kind('set')},
    {"name": "set$string$2", "symbols": [{"literal":"s"}, {"literal":"e"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "set", "symbols": ["set$string$2", "__", "name", "_", {"literal":"["}, "_", "expr", "_", {"literal":"]"}, "_", {"literal":"="}, "_", "expr"], "postprocess": e().flat().reorder(2, 12, 6).kind('set')},
    {"name": "call$string$1", "symbols": [{"literal":"c"}, {"literal":"a"}, {"literal":"l"}, {"literal":"l"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "call$ebnf$1$subexpression$1", "symbols": ["args", "_"]},
    {"name": "call$ebnf$1", "symbols": ["call$ebnf$1$subexpression$1"], "postprocess": id},
    {"name": "call$ebnf$1", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "call", "symbols": ["call$string$1", "__", "name", "_", {"literal":"("}, "_", "call$ebnf$1", {"literal":")"}], "postprocess": e().flat().reorder(2, 6).kind('call').assign({statement: true})},
    {"name": "args$ebnf$1", "symbols": []},
    {"name": "args$ebnf$1$subexpression$1", "symbols": ["_", {"literal":","}, "_", "expr"]},
    {"name": "args$ebnf$1", "symbols": ["args$ebnf$1", "args$ebnf$1$subexpression$1"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "args", "symbols": ["expr", "args$ebnf$1"], "postprocess": e().flat().filter((_, i) => i%4 === 0).kind('args')},
    {"name": "ifthenelse$string$1", "symbols": [{"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "ifthenelse$string$2", "symbols": [{"literal":"t"}, {"literal":"h"}, {"literal":"e"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "ifthenelse$ebnf$1", "symbols": ["statements"], "postprocess": id},
    {"name": "ifthenelse$ebnf$1", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "ifthenelse$ebnf$2", "symbols": ["else_clauses"], "postprocess": id},
    {"name": "ifthenelse$ebnf$2", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "ifthenelse$string$3", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}, {"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "ifthenelse", "symbols": ["ifthenelse$string$1", "_", "expr", "_", "ifthenelse$string$2", "newline", "ifthenelse$ebnf$1", "ifthenelse$ebnf$2", "_", "ifthenelse$string$3"], "postprocess": e().flat().reorder(2, 5, 7, 8).pick(1, 1, 1, e().fn(v => v && v.data)).kind('ifthenelse')},
    {"name": "else_clauses$ebnf$1$subexpression$1", "symbols": ["_", "else_clause"]},
    {"name": "else_clauses$ebnf$1", "symbols": ["else_clauses$ebnf$1$subexpression$1"]},
    {"name": "else_clauses$ebnf$1$subexpression$2", "symbols": ["_", "else_clause"]},
    {"name": "else_clauses$ebnf$1", "symbols": ["else_clauses$ebnf$1", "else_clauses$ebnf$1$subexpression$2"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "else_clauses", "symbols": ["else_clauses$ebnf$1"], "postprocess": e().map(v => v[1]).flat().kind('else_clauses')},
    {"name": "else_clause$string$1", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "else_clause$ebnf$1", "symbols": ["statements"], "postprocess": id},
    {"name": "else_clause$ebnf$1", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "else_clause", "symbols": ["else_clause$string$1", "newline", "else_clause$ebnf$1"], "postprocess": e().flat().reorder(1, 2).kind('else')},
    {"name": "else_clause$string$2", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}, {"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "else_clause$string$3", "symbols": [{"literal":"t"}, {"literal":"h"}, {"literal":"e"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "else_clause$ebnf$2", "symbols": ["statements"], "postprocess": id},
    {"name": "else_clause$ebnf$2", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "else_clause", "symbols": ["else_clause$string$2", "_", "expr", "_", "else_clause$string$3", "newline", "else_clause$ebnf$2"], "postprocess": e().flat().reorder(2, 5, 6).kind('elseif')},
    {"name": "loop$string$1", "symbols": [{"literal":"l"}, {"literal":"o"}, {"literal":"o"}, {"literal":"p"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "loop$ebnf$1", "symbols": ["statements"], "postprocess": id},
    {"name": "loop$ebnf$1", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "loop$string$2", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}, {"literal":"l"}, {"literal":"o"}, {"literal":"o"}, {"literal":"p"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "loop", "symbols": ["loop$string$1", "newline", "loop$ebnf$1", "_", "loop$string$2"], "postprocess": e().flat().reorder(1, 2).kind('loop')},
    {"name": "exitwhen$string$1", "symbols": [{"literal":"e"}, {"literal":"x"}, {"literal":"i"}, {"literal":"t"}, {"literal":"w"}, {"literal":"h"}, {"literal":"e"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "exitwhen", "symbols": ["exitwhen$string$1", "_", "expr"], "postprocess": e().flat().reorder(2).kind('exitwhen')},
    {"name": "return$string$1", "symbols": [{"literal":"r"}, {"literal":"e"}, {"literal":"t"}, {"literal":"u"}, {"literal":"r"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "return$ebnf$1$subexpression$1", "symbols": ["_", "expr"]},
    {"name": "return$ebnf$1", "symbols": ["return$ebnf$1$subexpression$1"], "postprocess": id},
    {"name": "return$ebnf$1", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "return", "symbols": ["return$string$1", "return$ebnf$1"], "postprocess": e().flat().reorder(2).kind('return')},
    {"name": "expr", "symbols": ["logical_op"]},
    {"name": "_expr", "symbols": ["name"], "postprocess": e().kind('name')},
    {"name": "_expr", "symbols": ["const"]},
    {"name": "_expr", "symbols": ["func_call"]},
    {"name": "_expr", "symbols": ["parens"]},
    {"name": "_expr", "symbols": ["unary_op"]},
    {"name": "_expr", "symbols": ["array_ref"]},
    {"name": "_expr", "symbols": ["func_ref"]},
    {"name": "left_expr", "symbols": ["func_call"]},
    {"name": "left_expr", "symbols": ["parens"]},
    {"name": "left_expr", "symbols": ["array_ref"]},
    {"name": "left_expr", "symbols": ["left_unary_op"]},
    {"name": "left_expr", "symbols": ["string_const"]},
    {"name": "left_expr", "symbols": ["fourcc"]},
    {"name": "right_expr", "symbols": ["parens"]},
    {"name": "right_expr", "symbols": ["string_const"]},
    {"name": "right_expr", "symbols": ["fourcc"]},
    {"name": "left_right_expr", "symbols": ["parens"]},
    {"name": "left_right_expr", "symbols": ["string_const"]},
    {"name": "left_right_expr", "symbols": ["fourcc"]},
    {"name": "const", "symbols": ["number_const"]},
    {"name": "const", "symbols": ["bool_const"]},
    {"name": "const", "symbols": ["string_const"]},
    {"name": "const$string$1", "symbols": [{"literal":"n"}, {"literal":"u"}, {"literal":"l"}, {"literal":"l"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "const", "symbols": ["const$string$1"], "postprocess": nil},
    {"name": "number_const", "symbols": ["int_const"]},
    {"name": "number_const", "symbols": ["real_const"]},
    {"name": "int_const", "symbols": ["decimal"]},
    {"name": "int_const", "symbols": ["octal"]},
    {"name": "int_const", "symbols": ["hex"]},
    {"name": "int_const", "symbols": ["fourcc"]},
    {"name": "decimal", "symbols": [{"literal":"0"}], "postprocess": () => 0},
    {"name": "decimal$ebnf$1", "symbols": []},
    {"name": "decimal$ebnf$1", "symbols": ["decimal$ebnf$1", /[0-9]/], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "decimal", "symbols": [/[1-9]/, "decimal$ebnf$1"], "postprocess": string.fn(v => parseInt(v))},
    {"name": "octal$ebnf$1", "symbols": [/[0-7]/]},
    {"name": "octal$ebnf$1", "symbols": ["octal$ebnf$1", /[0-7]/], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "octal", "symbols": [{"literal":"0"}, "octal$ebnf$1"], "postprocess": string.fn(v => parseInt(v, 8))},
    {"name": "hex$ebnf$1", "symbols": [/[0-9a-fA-F]/]},
    {"name": "hex$ebnf$1", "symbols": ["hex$ebnf$1", /[0-9a-fA-F]/], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "hex", "symbols": [{"literal":"$"}, "hex$ebnf$1"], "postprocess": string.fn(v => parseInt(v.slice(1), 16))},
    {"name": "hex$ebnf$2", "symbols": [/[0-9a-fA-F]/]},
    {"name": "hex$ebnf$2", "symbols": ["hex$ebnf$2", /[0-9a-fA-F]/], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "hex", "symbols": [{"literal":"0"}, /[xX]/, "hex$ebnf$2"], "postprocess": string.fn(v => parseInt(v.slice(2), 16))},
    {"name": "fourcc", "symbols": [{"literal":"'"}, /./, /./, /./, /./, {"literal":"'"}], "postprocess": string.fn(v => v.slice(1, -1)).kind('fourcc')},
    {"name": "real_const$ebnf$1", "symbols": [/[0-9]/]},
    {"name": "real_const$ebnf$1", "symbols": ["real_const$ebnf$1", /[0-9]/], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "real_const$ebnf$2", "symbols": []},
    {"name": "real_const$ebnf$2", "symbols": ["real_const$ebnf$2", /[0-9]/], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "real_const", "symbols": ["real_const$ebnf$1", {"literal":"."}, "real_const$ebnf$2"], "postprocess": string.fn(v => parseFloat(v))},
    {"name": "real_const$ebnf$3", "symbols": [/[0-9]/]},
    {"name": "real_const$ebnf$3", "symbols": ["real_const$ebnf$3", /[0-9]/], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "real_const", "symbols": [{"literal":"."}, "real_const$ebnf$3"], "postprocess": string.fn(v => parseFloat(v))},
    {"name": "bool_const$string$1", "symbols": [{"literal":"t"}, {"literal":"r"}, {"literal":"u"}, {"literal":"e"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "bool_const", "symbols": ["bool_const$string$1"], "postprocess": e().fn(JSON.parse)},
    {"name": "bool_const$string$2", "symbols": [{"literal":"f"}, {"literal":"a"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "bool_const", "symbols": ["bool_const$string$2"], "postprocess": e().fn(JSON.parse)},
    {"name": "string_const$ebnf$1", "symbols": []},
    {"name": "string_const$ebnf$1$subexpression$1", "symbols": [/[^"]/]},
    {"name": "string_const$ebnf$1$subexpression$1$string$1", "symbols": [{"literal":"\\"}, {"literal":"\""}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "string_const$ebnf$1$subexpression$1", "symbols": ["string_const$ebnf$1$subexpression$1$string$1"]},
    {"name": "string_const$ebnf$1", "symbols": ["string_const$ebnf$1", "string_const$ebnf$1$subexpression$1"], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "string_const", "symbols": [{"literal":"\""}, "string_const$ebnf$1", {"literal":"\""}], "postprocess": string.fn(v => v.slice(1, -1))},
    {"name": "string_const", "symbols": [{"literal":"'"}, /[^']/, {"literal":"'"}], "postprocess": string.fn(v => v.slice(1, -1))},
    {"name": "logical_op$subexpression$1$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "logical_op$subexpression$1", "symbols": ["logical_op$subexpression$1$string$1"]},
    {"name": "logical_op$subexpression$1$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "logical_op$subexpression$1", "symbols": ["logical_op$subexpression$1$string$2"]},
    {"name": "logical_op", "symbols": ["logical_op", "__", "logical_op$subexpression$1", "__", "binary_op"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "logical_op$subexpression$2$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "logical_op$subexpression$2", "symbols": ["logical_op$subexpression$2$string$1"]},
    {"name": "logical_op$subexpression$2$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "logical_op$subexpression$2", "symbols": ["logical_op$subexpression$2$string$2"]},
    {"name": "logical_op", "symbols": ["logical_op", "__", "logical_op$subexpression$2", "right_binary_op"], "postprocess": e().flat().reorder(0, 2, 3).kind('binary_op')},
    {"name": "logical_op$subexpression$3$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "logical_op$subexpression$3", "symbols": ["logical_op$subexpression$3$string$1"]},
    {"name": "logical_op$subexpression$3$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "logical_op$subexpression$3", "symbols": ["logical_op$subexpression$3$string$2"]},
    {"name": "logical_op", "symbols": ["left_logical_op", "logical_op$subexpression$3", "__", "binary_op"], "postprocess": e().flat().reorder(0, 1, 3).kind('binary_op')},
    {"name": "logical_op$subexpression$4$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "logical_op$subexpression$4", "symbols": ["logical_op$subexpression$4$string$1"]},
    {"name": "logical_op$subexpression$4$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "logical_op$subexpression$4", "symbols": ["logical_op$subexpression$4$string$2"]},
    {"name": "logical_op", "symbols": ["left_logical_op", "logical_op$subexpression$4", "right_binary_op"], "postprocess": e().flat().reorder(0, 1, 2).kind('binary_op')},
    {"name": "logical_op", "symbols": ["binary_op"]},
    {"name": "left_logical_op$subexpression$1$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_logical_op$subexpression$1", "symbols": ["left_logical_op$subexpression$1$string$1"]},
    {"name": "left_logical_op$subexpression$1$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_logical_op$subexpression$1", "symbols": ["left_logical_op$subexpression$1$string$2"]},
    {"name": "left_logical_op", "symbols": ["logical_op", "__", "left_logical_op$subexpression$1", "__", "left_binary_op"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "left_logical_op$subexpression$2$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_logical_op$subexpression$2", "symbols": ["left_logical_op$subexpression$2$string$1"]},
    {"name": "left_logical_op$subexpression$2$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_logical_op$subexpression$2", "symbols": ["left_logical_op$subexpression$2$string$2"]},
    {"name": "left_logical_op", "symbols": ["logical_op", "__", "left_logical_op$subexpression$2", "left_right_binary_op"], "postprocess": e().flat().reorder(0, 2, 3).kind('binary_op')},
    {"name": "left_logical_op$subexpression$3$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_logical_op$subexpression$3", "symbols": ["left_logical_op$subexpression$3$string$1"]},
    {"name": "left_logical_op$subexpression$3$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_logical_op$subexpression$3", "symbols": ["left_logical_op$subexpression$3$string$2"]},
    {"name": "left_logical_op", "symbols": ["left_logical_op", "left_logical_op$subexpression$3", "__", "left_binary_op"], "postprocess": e().flat().reorder(0, 1, 3).kind('binary_op')},
    {"name": "left_logical_op$subexpression$4$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_logical_op$subexpression$4", "symbols": ["left_logical_op$subexpression$4$string$1"]},
    {"name": "left_logical_op$subexpression$4$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_logical_op$subexpression$4", "symbols": ["left_logical_op$subexpression$4$string$2"]},
    {"name": "left_logical_op", "symbols": ["left_logical_op", "left_logical_op$subexpression$4", "left_right_binary_op"], "postprocess": e().flat().reorder(0, 1, 2).kind('binary_op')},
    {"name": "left_logical_op", "symbols": ["left_binary_op"]},
    {"name": "right_logical_op$subexpression$1$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "right_logical_op$subexpression$1", "symbols": ["right_logical_op$subexpression$1$string$1"]},
    {"name": "right_logical_op$subexpression$1$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "right_logical_op$subexpression$1", "symbols": ["right_logical_op$subexpression$1$string$2"]},
    {"name": "right_logical_op", "symbols": ["right_logical_op", "__", "right_logical_op$subexpression$1", "__", "binary_op"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "right_logical_op$subexpression$2$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "right_logical_op$subexpression$2", "symbols": ["right_logical_op$subexpression$2$string$1"]},
    {"name": "right_logical_op$subexpression$2$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "right_logical_op$subexpression$2", "symbols": ["right_logical_op$subexpression$2$string$2"]},
    {"name": "right_logical_op", "symbols": ["right_logical_op", "__", "right_logical_op$subexpression$2", "right_binary_op"], "postprocess": e().flat().reorder(0, 2, 3).kind('binary_op')},
    {"name": "right_logical_op$subexpression$3$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "right_logical_op$subexpression$3", "symbols": ["right_logical_op$subexpression$3$string$1"]},
    {"name": "right_logical_op$subexpression$3$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "right_logical_op$subexpression$3", "symbols": ["right_logical_op$subexpression$3$string$2"]},
    {"name": "right_logical_op", "symbols": ["left_right_logical_op", "right_logical_op$subexpression$3", "__", "binary_op"], "postprocess": e().flat().reorder(0, 1, 3).kind('binary_op')},
    {"name": "right_logical_op$subexpression$4$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "right_logical_op$subexpression$4", "symbols": ["right_logical_op$subexpression$4$string$1"]},
    {"name": "right_logical_op$subexpression$4$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "right_logical_op$subexpression$4", "symbols": ["right_logical_op$subexpression$4$string$2"]},
    {"name": "right_logical_op", "symbols": ["left_right_logical_op", "right_logical_op$subexpression$4", "right_binary_op"], "postprocess": e().flat().reorder(0, 1, 2).kind('binary_op')},
    {"name": "right_logical_op", "symbols": ["right_binary_op"]},
    {"name": "left_right_logical_op$subexpression$1$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_right_logical_op$subexpression$1", "symbols": ["left_right_logical_op$subexpression$1$string$1"]},
    {"name": "left_right_logical_op$subexpression$1$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_right_logical_op$subexpression$1", "symbols": ["left_right_logical_op$subexpression$1$string$2"]},
    {"name": "left_right_logical_op", "symbols": ["right_logical_op", "__", "left_right_logical_op$subexpression$1", "__", "left_binary_op"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "left_right_logical_op$subexpression$2$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_right_logical_op$subexpression$2", "symbols": ["left_right_logical_op$subexpression$2$string$1"]},
    {"name": "left_right_logical_op$subexpression$2$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_right_logical_op$subexpression$2", "symbols": ["left_right_logical_op$subexpression$2$string$2"]},
    {"name": "left_right_logical_op", "symbols": ["right_logical_op", "__", "left_right_logical_op$subexpression$2", "left_right_binary_op"], "postprocess": e().flat().reorder(0, 2, 3).kind('binary_op')},
    {"name": "left_right_logical_op$subexpression$3$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_right_logical_op$subexpression$3", "symbols": ["left_right_logical_op$subexpression$3$string$1"]},
    {"name": "left_right_logical_op$subexpression$3$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_right_logical_op$subexpression$3", "symbols": ["left_right_logical_op$subexpression$3$string$2"]},
    {"name": "left_right_logical_op", "symbols": ["left_right_logical_op", "left_right_logical_op$subexpression$3", "__", "left_binary_op"], "postprocess": e().flat().reorder(0, 1, 3).kind('binary_op')},
    {"name": "left_right_logical_op$subexpression$4$string$1", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_right_logical_op$subexpression$4", "symbols": ["left_right_logical_op$subexpression$4$string$1"]},
    {"name": "left_right_logical_op$subexpression$4$string$2", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_right_logical_op$subexpression$4", "symbols": ["left_right_logical_op$subexpression$4$string$2"]},
    {"name": "left_right_logical_op", "symbols": ["left_right_logical_op", "left_right_logical_op$subexpression$4", "left_right_binary_op"], "postprocess": e().flat().reorder(0, 1, 2).kind('binary_op')},
    {"name": "left_right_logical_op", "symbols": ["left_right_logical_op"]},
    {"name": "binary_op$subexpression$1", "symbols": [{"literal":"<"}]},
    {"name": "binary_op$subexpression$1", "symbols": [{"literal":">"}]},
    {"name": "binary_op$subexpression$1$string$1", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "binary_op$subexpression$1", "symbols": ["binary_op$subexpression$1$string$1"]},
    {"name": "binary_op$subexpression$1$string$2", "symbols": [{"literal":"!"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "binary_op$subexpression$1", "symbols": ["binary_op$subexpression$1$string$2"]},
    {"name": "binary_op$subexpression$1$string$3", "symbols": [{"literal":">"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "binary_op$subexpression$1", "symbols": ["binary_op$subexpression$1$string$3"]},
    {"name": "binary_op$subexpression$1$string$4", "symbols": [{"literal":"<"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "binary_op$subexpression$1", "symbols": ["binary_op$subexpression$1$string$4"]},
    {"name": "binary_op", "symbols": ["binary_op", "_", "binary_op$subexpression$1", "_", "sum_op"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "binary_op", "symbols": ["sum_op"]},
    {"name": "left_binary_op$subexpression$1", "symbols": [{"literal":"<"}]},
    {"name": "left_binary_op$subexpression$1", "symbols": [{"literal":">"}]},
    {"name": "left_binary_op$subexpression$1$string$1", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_binary_op$subexpression$1", "symbols": ["left_binary_op$subexpression$1$string$1"]},
    {"name": "left_binary_op$subexpression$1$string$2", "symbols": [{"literal":"!"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_binary_op$subexpression$1", "symbols": ["left_binary_op$subexpression$1$string$2"]},
    {"name": "left_binary_op$subexpression$1$string$3", "symbols": [{"literal":">"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_binary_op$subexpression$1", "symbols": ["left_binary_op$subexpression$1$string$3"]},
    {"name": "left_binary_op$subexpression$1$string$4", "symbols": [{"literal":"<"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_binary_op$subexpression$1", "symbols": ["left_binary_op$subexpression$1$string$4"]},
    {"name": "left_binary_op", "symbols": ["binary_op", "_", "left_binary_op$subexpression$1", "_", "left_sum_op"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "left_binary_op", "symbols": ["left_sum_op"]},
    {"name": "right_binary_op$subexpression$1", "symbols": [{"literal":"<"}]},
    {"name": "right_binary_op$subexpression$1", "symbols": [{"literal":">"}]},
    {"name": "right_binary_op$subexpression$1$string$1", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "right_binary_op$subexpression$1", "symbols": ["right_binary_op$subexpression$1$string$1"]},
    {"name": "right_binary_op$subexpression$1$string$2", "symbols": [{"literal":"!"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "right_binary_op$subexpression$1", "symbols": ["right_binary_op$subexpression$1$string$2"]},
    {"name": "right_binary_op$subexpression$1$string$3", "symbols": [{"literal":">"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "right_binary_op$subexpression$1", "symbols": ["right_binary_op$subexpression$1$string$3"]},
    {"name": "right_binary_op$subexpression$1$string$4", "symbols": [{"literal":"<"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "right_binary_op$subexpression$1", "symbols": ["right_binary_op$subexpression$1$string$4"]},
    {"name": "right_binary_op", "symbols": ["right_binary_op", "_", "right_binary_op$subexpression$1", "_", "sum_op"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "right_binary_op", "symbols": ["right_sum_op"]},
    {"name": "left_right_binary_op$subexpression$1", "symbols": [{"literal":"<"}]},
    {"name": "left_right_binary_op$subexpression$1", "symbols": [{"literal":">"}]},
    {"name": "left_right_binary_op$subexpression$1$string$1", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_right_binary_op$subexpression$1", "symbols": ["left_right_binary_op$subexpression$1$string$1"]},
    {"name": "left_right_binary_op$subexpression$1$string$2", "symbols": [{"literal":"!"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_right_binary_op$subexpression$1", "symbols": ["left_right_binary_op$subexpression$1$string$2"]},
    {"name": "left_right_binary_op$subexpression$1$string$3", "symbols": [{"literal":">"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_right_binary_op$subexpression$1", "symbols": ["left_right_binary_op$subexpression$1$string$3"]},
    {"name": "left_right_binary_op$subexpression$1$string$4", "symbols": [{"literal":"<"}, {"literal":"="}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "left_right_binary_op$subexpression$1", "symbols": ["left_right_binary_op$subexpression$1$string$4"]},
    {"name": "left_right_binary_op", "symbols": ["right_binary_op", "_", "left_right_binary_op$subexpression$1", "_", "left_sum_op"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "left_right_binary_op", "symbols": ["left_right_sum_op"]},
    {"name": "sum_op$subexpression$1", "symbols": [{"literal":"+"}]},
    {"name": "sum_op$subexpression$1", "symbols": [{"literal":"-"}]},
    {"name": "sum_op", "symbols": ["sum_op", "_", "sum_op$subexpression$1", "_", "prod_op"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "sum_op", "symbols": ["prod_op"]},
    {"name": "left_sum_op$subexpression$1", "symbols": [{"literal":"+"}]},
    {"name": "left_sum_op$subexpression$1", "symbols": [{"literal":"-"}]},
    {"name": "left_sum_op", "symbols": ["sum_op", "_", "left_sum_op$subexpression$1", "_", "left_prod_op"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "left_sum_op", "symbols": ["left_prod_op"]},
    {"name": "right_sum_op$subexpression$1", "symbols": [{"literal":"+"}]},
    {"name": "right_sum_op$subexpression$1", "symbols": [{"literal":"-"}]},
    {"name": "right_sum_op", "symbols": ["right_sum_op", "_", "right_sum_op$subexpression$1", "_", "prod_op"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "right_sum_op", "symbols": ["right_prod_op"]},
    {"name": "left_right_sum_op$subexpression$1", "symbols": [{"literal":"+"}]},
    {"name": "left_right_sum_op$subexpression$1", "symbols": [{"literal":"-"}]},
    {"name": "left_right_sum_op", "symbols": ["right_sum_op", "_", "left_right_sum_op$subexpression$1", "_", "left_prod_op"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "left_right_sum_op", "symbols": ["left_right_prod_op"]},
    {"name": "prod_op$subexpression$1", "symbols": [{"literal":"*"}]},
    {"name": "prod_op$subexpression$1", "symbols": [{"literal":"/"}]},
    {"name": "prod_op", "symbols": ["prod_op", "_", "prod_op$subexpression$1", "_", "_expr"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "prod_op", "symbols": ["_expr"]},
    {"name": "left_prod_op$subexpression$1", "symbols": [{"literal":"*"}]},
    {"name": "left_prod_op$subexpression$1", "symbols": [{"literal":"/"}]},
    {"name": "left_prod_op", "symbols": ["prod_op", "_", "left_prod_op$subexpression$1", "_", "left_expr"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "left_prod_op", "symbols": ["left_expr"]},
    {"name": "right_prod_op$subexpression$1", "symbols": [{"literal":"*"}]},
    {"name": "right_prod_op$subexpression$1", "symbols": [{"literal":"/"}]},
    {"name": "right_prod_op", "symbols": ["right_prod_op", "_", "right_prod_op$subexpression$1", "_", "_expr"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "right_prod_op", "symbols": ["right_expr"]},
    {"name": "left_right_prod_op$subexpression$1", "symbols": [{"literal":"*"}]},
    {"name": "left_right_prod_op$subexpression$1", "symbols": [{"literal":"/"}]},
    {"name": "left_right_prod_op", "symbols": ["right_rod_op", "_", "left_right_prod_op$subexpression$1", "_", "left_expr"], "postprocess": e().flat().reorder(0, 2, 4).kind('binary_op')},
    {"name": "left_right_prod_op", "symbols": ["left_right_expr"]},
    {"name": "unary_op", "symbols": ["_unary_op"], "postprocess": e().flat().reorder(0, 2).kind('unary_op')},
    {"name": "_unary_op$subexpression$1", "symbols": [{"literal":"+"}]},
    {"name": "_unary_op$subexpression$1", "symbols": [{"literal":"-"}]},
    {"name": "_unary_op", "symbols": ["_unary_op$subexpression$1", "_", "_expr"]},
    {"name": "_unary_op$string$1", "symbols": [{"literal":"n"}, {"literal":"o"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "_unary_op", "symbols": ["_unary_op$string$1", "__", "_expr"]},
    {"name": "_unary_op$string$2", "symbols": [{"literal":"n"}, {"literal":"o"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "_unary_op", "symbols": ["_unary_op$string$2", "left_expr"]},
    {"name": "left_unary_op", "symbols": ["_left_unary_op"], "postprocess": e().flat().reorder(0, 2).kind('unary_op')},
    {"name": "_left_unary_op$subexpression$1", "symbols": [{"literal":"+"}]},
    {"name": "_left_unary_op$subexpression$1", "symbols": [{"literal":"-"}]},
    {"name": "_left_unary_op", "symbols": ["_left_unary_op$subexpression$1", "_", "left_expr"]},
    {"name": "_left_unary_op$string$1", "symbols": [{"literal":"n"}, {"literal":"o"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "_left_unary_op", "symbols": ["_left_unary_op$string$1", "__", "left_expr"]},
    {"name": "_left_unary_op$string$2", "symbols": [{"literal":"n"}, {"literal":"o"}, {"literal":"t"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "_left_unary_op", "symbols": ["_left_unary_op$string$2", "left_right_expr"]},
    {"name": "func_call$ebnf$1$subexpression$1", "symbols": ["args", "_"]},
    {"name": "func_call$ebnf$1", "symbols": ["func_call$ebnf$1$subexpression$1"], "postprocess": id},
    {"name": "func_call$ebnf$1", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "func_call", "symbols": ["name", {"literal":"("}, "_", "func_call$ebnf$1", {"literal":")"}], "postprocess": e().flat().reorder(0, 3).kind('call')},
    {"name": "parens", "symbols": [{"literal":"("}, "_", "expr", "_", {"literal":")"}], "postprocess": e().flat().reorder(2).kind('parens')},
    {"name": "array_ref", "symbols": ["name", "_", {"literal":"["}, "_", "expr", "_", {"literal":"]"}], "postprocess": e().flat().reorder(0, 4).kind('array_ref')},
    {"name": "func_ref$string$1", "symbols": [{"literal":"f"}, {"literal":"u"}, {"literal":"n"}, {"literal":"c"}, {"literal":"t"}, {"literal":"i"}, {"literal":"o"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "func_ref", "symbols": ["func_ref$string$1", "__", "name"], "postprocess": e().flat().index(2).kind('func_ref')},
    {"name": "newline", "symbols": ["_", {"literal":"\n"}], "postprocess": nil},
    {"name": "newline", "symbols": ["_", "comment"], "postprocess": ([whitespace, comment]) => comment || null},
    {"name": "emptyline", "symbols": ["_", {"literal":"\n"}], "postprocess": e().index(1).kind('emptyline')},
    {"name": "emptyline", "symbols": ["_", "comment"], "postprocess": e().index(1)},
    {"name": "type", "symbols": ["_type"]},
    {"name": "_type", "symbols": ["name"]},
    {"name": "_type$string$1", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"d"}, {"literal":"e"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "_type", "symbols": ["_type$string$1"]},
    {"name": "_type$string$2", "symbols": [{"literal":"h"}, {"literal":"a"}, {"literal":"n"}, {"literal":"d"}, {"literal":"l"}, {"literal":"e"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "_type", "symbols": ["_type$string$2"]},
    {"name": "_type$string$3", "symbols": [{"literal":"i"}, {"literal":"n"}, {"literal":"t"}, {"literal":"e"}, {"literal":"g"}, {"literal":"e"}, {"literal":"r"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "_type", "symbols": ["_type$string$3"]},
    {"name": "_type$string$4", "symbols": [{"literal":"r"}, {"literal":"e"}, {"literal":"a"}, {"literal":"l"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "_type", "symbols": ["_type$string$4"]},
    {"name": "_type$string$5", "symbols": [{"literal":"b"}, {"literal":"o"}, {"literal":"o"}, {"literal":"l"}, {"literal":"e"}, {"literal":"a"}, {"literal":"n"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "_type", "symbols": ["_type$string$5"]},
    {"name": "_type$string$6", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "_type", "symbols": ["_type$string$6"]},
    {"name": "name$ebnf$1$subexpression$1$ebnf$1", "symbols": []},
    {"name": "name$ebnf$1$subexpression$1$ebnf$1", "symbols": ["name$ebnf$1$subexpression$1$ebnf$1", /[a-zA-Z0-9_]/], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "name$ebnf$1$subexpression$1", "symbols": ["name$ebnf$1$subexpression$1$ebnf$1", /[a-zA-Z0-9]/]},
    {"name": "name$ebnf$1", "symbols": ["name$ebnf$1$subexpression$1"], "postprocess": id},
    {"name": "name$ebnf$1", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "name", "symbols": [/[a-zA-Z]/, "name$ebnf$1"], "postprocess": (result, _, reject) => {
        	result = string(result);
        	if (keywords.includes(result)) return reject;
        	return result;
        } },
    {"name": "_$ebnf$1", "symbols": ["__"], "postprocess": id},
    {"name": "_$ebnf$1", "symbols": [], "postprocess": function(d) {return null;}},
    {"name": "_", "symbols": ["_$ebnf$1"]},
    {"name": "__$ebnf$1", "symbols": [/[ \t]/]},
    {"name": "__$ebnf$1", "symbols": ["__$ebnf$1", /[ \t]/], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "__", "symbols": ["__$ebnf$1"], "postprocess": string},
    {"name": "comment$string$1", "symbols": [{"literal":"/"}, {"literal":"/"}], "postprocess": function joiner(d) {return d.join('');}},
    {"name": "comment$ebnf$1", "symbols": []},
    {"name": "comment$ebnf$1", "symbols": ["comment$ebnf$1", /[^\n]/], "postprocess": function arrpush(d) {return d[0].concat([d[1]]);}},
    {"name": "comment", "symbols": ["comment$string$1", "comment$ebnf$1", {"literal":"\n"}], "postprocess": string.fn(s => [s.slice(2, -1)]).kind('comment')}
];
let ParserStart = "program";
export default { Lexer, ParserRules, ParserStart };
