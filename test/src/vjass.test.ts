import { parseSnapshot } from "../util";

it(
	"members",
	parseSnapshot(`
        function foo takes nothing returns nothing
            call foo(bar.baz)
            call foo(bar.baz[foo.bar])
            call foo(function bar.baz.zig)
            // call foo.bar()
            set foo.bar = 0
            // set foo.bar[0] = 0
            set foo().bar = 0
        endfunction
    `),
);

it(
	"struct",
	parseSnapshot(`
        struct foo extends bar
            static integer myInt = 0    // hmm
            private static trigger resolutionChangeTrigg = CreateTrigger()
            readonly static framehandle Game = null
            method baz takes nothing returns nothing
                // do something
            endmethod
        endstruct
    `),
);

it(
	"struct extending array",
	parseSnapshot(`
        struct DefaultFrame extends array
            framehandle Game = null
        endstruct
    `),
);

it(
	"operators",
	parseSnapshot(`
        struct Foo
            static method operator PXTODPI takes nothing returns real
                return 0.6/ResolutionHeight
            endmethod
        endstruct
    `),
);
