import { parseSnapshot } from "../util";

it(
	"comments",
	parseSnapshot(`
        library A // foo
            // bar
        endlibrary // baz
    `),
);

describe("requires", () => {
	it(
		"none",
		parseSnapshot(`
            library A
            endlibrary
        `),
	);

	it(
		"one",
		parseSnapshot(`
            library B requires A
            endlibrary
        `),
	);

	it(
		"two",
		parseSnapshot(`
            library C requires A, B
            endlibrary
        `),
	);

	it(
		"optionals",
		parseSnapshot(`
            library E requires A, optional B, optional C, D
            endlibrary
        `),
	);
});

describe("globals", () => {
	it(
		"simple",
		parseSnapshot(`
            library A

                globals
                    gamecache cache
                endglobals

            endlibrary
        `),
	);

	it(
		"scoped",
		parseSnapshot(`
            library A
                globals
                    integer globalInt
                    private integer privInt
                    public integer pubInt
                    private constant integer privConstInt
                endglobals
            endlibrary
        `),
	);
});

describe("functions", () => {
	it(
		"general",
		parseSnapshot(`
            library B
                function Bfun takes nothing returns integer
                    local integer i = 0
                    set i = i + 1
                    return i
                endfunction
            endlibrary
        `),
	);

	it(
		"scoped",
		parseSnapshot(`
            library A
                function GlobalFunc takes nothing returns integer
                endfunction

                private function PrivFunc takes nothing returns integer
                endfunction

                public function PubFunc takes nothing returns integer
                endfunction
            endlibrary
        `),
	);
});

it(
	"initializer",
	parseSnapshot(`
        library A initializer Init
            function Init takes nothing returns integer
            endfunction
        endlibrary
    `),
);

it(
	"scopes",
	parseSnapshot(`
        scope A
            private function Init takes nothing returns integer
            endfunction
        endscope
    `),
);

it(
	"modules",
	parseSnapshot(`
    module A
        private module B
        endmodule
    endmodule
`),
);

it(
	"keywords",
	parseSnapshot(`
        module Foo
            private keyword B // test
        endmodule
    `),
);
