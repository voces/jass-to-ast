#!/usr/bin/env node --experimental-modules --no-warnings

import fs from "fs";
import parse from "./src/parser.js";
import { inspect } from "./src/util.js";

const filePath = process.argv[ 2 ];

fs.readFile( filePath, "utf-8", ( err, res ) => {

	if ( err ) {

		console.error( err.message );
		process.exit( 1 );

	}

	console.log( inspect( parse( res ) ) );

} );
