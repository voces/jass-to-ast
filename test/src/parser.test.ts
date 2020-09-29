import { parseSnapshot } from "../util";

describe("globals", () => {
	it(
		"empty globals block",
		parseSnapshot(`
			globals
			endglobals
		`),
	);

	it(
		"commented",
		parseSnapshot(`
			globals //foo
			//bar
			endglobals //baz
		`),
	);

	it(
		"with globals",
		parseSnapshot(`
			globals
				constant force sheep = CreateForce()
				real salesTax = 1.5
				real specialTax = salesTax
			endglobals
		`),
	);

	it(
		"self-referencing globals",
		parseSnapshot(`
			globals
				constant real bj_PI = 3.14159
				constant real bj_RADTODEG = 180.0 / bj_PI
			endglobals
		`),
	);
});

it(
	"natives",
	parseSnapshot(`
		native FuncName takes argType1 argName1, argType2 argName2 returns returnType //with comments
		constant native foo takes nothing returns nothing
	`),
);

describe("functions", () => {
	it(
		"comments",
		parseSnapshot(`
			function funcName takes nothing returns nothing //function-comment
				//internal-comment
			endfunction //endfunction-comment
		`),
	);

	it(
		"multiple functions",
		parseSnapshot(`
			function foo takes nothing returns nothing
			endfunction

			function bar takes nothing returns nothing
			endfunction
		`),
	);

	describe("locals", () => {
		it(
			"can define locals",
			parseSnapshot(`
				function foo takes nothing returns nothing
					local varType1 varName1

					local varType2 varName2 = "string with \\"quotes\\""
					local varType3 varName3 = 'abcd'

					local varType4 varName4 = 0
					local varType5 varName5 = 010
					local varType6 varName6 = 0x10
					local varType7 varName7 = $10

					local varType8 varName8 = 0.1

					local varType9 varName9 = true
					local varType10 varName10 = false

					local varType11 varName11 = (1 + 2)
					local varType12 varName12 = varName11
				endfunction
			`),
		);
	});

	describe("calls", () => {
		it(
			"with lots of parens",
			parseSnapshot(`
				function foo takes nothing returns nothing
					call SaveStr(A,(((B[i]))),(-xG),(oG))
				endfunction
			`),
		);
	});
});

describe("if-then-else", () => {
	it(
		"empty",
		parseSnapshot(`
			function foo takes nothing returns nothing
				if true then
				endif
			endfunction
		`),
	);

	it(
		"simple",
		parseSnapshot(`
			function foo takes nothing returns nothing
				if true then
					set bar = buz
				endif
			endfunction
		`),
	);

	it(
		"else",
		parseSnapshot(`
			function foo takes nothing returns nothing
				if true then
					set bar = buz
				else
					set bar = qux
				endif
			endfunction
		`),
	);

	it(
		"elseif",
		parseSnapshot(`
			function foo takes nothing returns nothing
				if true then
					set bar = buz
				elseif false then
					set bar = qux
				endif
			endfunction
		`),
	);

	it(
		"elseif with else",
		parseSnapshot(`
			function foo takes nothing returns nothing
				if true then
					set bar = buz
				elseif false then
					set bar = qux
				else
					set bar = thud
				endif
			endfunction
		`),
	);

	it(
		"static if",
		parseSnapshot(`
			function foo takes nothing returns nothing
				static if true then
					// works
				endif
			endfunction
		`),
	);
});

describe("edge cases", () => {
	it(
		"multiple left expressions",
		parseSnapshot(`
			globals
				boolean test = a==b[c]or d==e[f]or g==h[i]or j
			endglobals
		`),
	);
});

describe("types", () => {
	it(
		"works",
		parseSnapshot(`
			type a extends handle
				type   c    extends    d   //with comment
		`),
	);
});

it(
	"chars",
	parseSnapshot(`
		function a takes nothing returns nothing
			local integer i = 'a'
		endfunction
	`),
);

it(
	"debug",
	parseSnapshot(`
		function a takes nothing returns nothing
			debug local integer i = 'a'
		endfunction
	`),
);

describe("comments", () => {
	it(
		"multiline",
		parseSnapshot(`
			/* multi
			line
			comments */
		`),
	);

	it(
		"single line",
		parseSnapshot(`
			// single line comment
		`),
	);
});

it(
	"nulls",
	parseSnapshot(`
	function a takes nothing returns boolean
		return null==null
	endfunction
`),
);
