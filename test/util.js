
import { promises as fs } from "fs";
import Diff from "diff";

import parser from "../src/parser.js";
import { inspect } from "../src/util.js";

const trimEmptyLines = str => {

	const lines = str.split( "\n" );

	let start = 0;
	while ( lines[ start ].trim() === "" && start < lines.length )
		start ++;

	if ( start === lines.length ) return "";

	let end = lines.length - 1;
	while ( lines[ end ].trim() === "" && end >= 0 )
		end --;

	if ( end === - 1 ) return "";

	return lines.slice( start, end + 1 ).join( "\n" );

};

const trim = str => {

	const lines = trimEmptyLines( str );
	const match = lines.match( /^\W+/ );
	if ( match ) {

		const indent = match[ 0 ];
		const regex = new RegExp( "^" + indent );
		return lines
			.split( "\n" )
			.map( line => line.replace( regex, "" ) )
			.join( "\n" );

	}

	return lines;

};

export const prettyDiff = diff => diff.map( ( v, i ) => {

	const sliceEnd = i + 1 === diff.length ? Infinity : - 1;

	if ( v.removed )
		return v.value.split( "\n" ).slice( 0, sliceEnd ).map( l => "- " + l ).join( "\n" );

	if ( v.added )
		return v.value.split( "\n" ).slice( 0, sliceEnd ).map( l => "+ " + l ).join( "\n" );

	return v.value.split( "\n" ).slice( 0, sliceEnd ).map( l => "  " + l ).join( "\n" );

} ).join( "\n" );

export const minimizePrettyDiff = prettyDiff => {

	const lines = prettyDiff.split( "\n" );
	const diffedLines = lines
		.map( line => line[ 0 ] === "-" || line[ 0 ] === "+" ? true : undefined );

	const linenoLength = Math.floor( Math.log10( lines.length ) ) + 1;

	return lines.map( ( line, index ) =>
		diffedLines[ index - 2 ] ||
        diffedLines[ index - 1 ] ||
        diffedLines[ index ] ||
        diffedLines[ index + 1 ] ||
        diffedLines[ index + 2 ] ? index.toString().padStart( linenoLength ) + " " + line : undefined,
	).filter( v => v !== undefined ).join( "\n" );

};

export const expectParse = ( input, expected ) => {

	const ast = parser( trim( input ) );

	const diff = Diff.diffLines(
		inspect( ast ).trim(),
		trim( expected ),
	);

	const different = diff.some( diff => diff.removed || diff.added );

	if ( different )
		throw new Error( "Incorrect parse result:\n" + prettyDiff( diff ) );

};

const snapshots = {};

const loadSnapshotFile = async file =>
	snapshots[ file ] = await fs.readFile( file, "utf-8" )
		.then( JSON.parse )
		.catch( () => {

			const obj = {};
			Object.defineProperty( obj, "needsWrite", { value: true, writable: true } );
			return obj;

		} );

export const snapshot = async ( test, input ) => {

	input = inspect( input, undefined, "  " );

	const file = test.fullName.split( ".test.js" )[ 0 ] + ".snapshots.json";

	const fileSnapshots = snapshots[ file ] || await loadSnapshotFile( file );

	const testSnapshots = fileSnapshots[ test.name ] || ( fileSnapshots[ test.name ] = [] );
	if ( testSnapshots.cursor === undefined ) testSnapshots.cursor = 0;

	if ( testSnapshots.cursor === testSnapshots.length ) {

		testSnapshots.push( input.split( "\n" ) );
		testSnapshots.cursor ++;
		fileSnapshots.needsWrite = true;

	} else {

		const prev = testSnapshots[ testSnapshots.cursor ].join( "\n" );

		if ( prev !== input ) {

			const diff = Diff.diffLines( prev, input );
			const detail = minimizePrettyDiff( prettyDiff( diff ) );
			throw new Error( `Mismatching snapshot ${testSnapshots.cursor}:\n${detail}` );

		}

		testSnapshots.cursor ++;

	}

	if ( fileSnapshots.needsWrite ) {

		await fs.writeFile( file, JSON.stringify( fileSnapshots, null, 2 ) );
		fileSnapshots.needsWrite = false;

	}

};
