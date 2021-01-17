import { parseSnapshot } from "../util";

it(
	"not without spaces",
	parseSnapshot(`
		function f takes nothing returns boolean
		if(not(udg_a==udg_b))then
			return false
		endif
		endfunction
	`),
);
