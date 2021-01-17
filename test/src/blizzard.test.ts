import fs from "fs";

import { parseSnapshot } from "../util";

it("smoke Blizzard.j", () => {
	const source = fs.readFileSync("test/samples/Blizzard.j", "utf-8");

	parseSnapshot(source)();
});
