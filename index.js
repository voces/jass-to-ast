#!/usr/bin/env node --experimental-modules --no-warnings
/* eslint-disable no-console */

import fs from "fs";
import { inspect } from "util";
import parse from "./src/parser.js";

const filePath = process.argv[2];

fs.readFile(filePath, "utf-8", (err, res) => {
	if (err) {
		console.error(err.message);
		process.exit(1);
	}

	console.log(inspect(parse(res), false, Infinity, true));
});
