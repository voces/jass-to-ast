import { parseSnapshot } from "../util";

it(
	"not without spaces",
	parseSnapshot(`
		function f takes nothing returns boolean
			return not(a==b)
		endfunction
	`),
);
