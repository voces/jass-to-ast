
import { SingleProp } from "./grammar/types.js";

const primitives = [ String, Boolean ];

const primitiveNode = node =>
	typeof node !== "object" ||
    node === null ||
    primitives.some( primitive => node instanceof primitive );

export const inspect = ( ast, enumerable = true, char = "\t", depth = 0 ) => {

	if ( ast === undefined ) return char.repeat( depth ) + "__undefined__";
	if ( ast === null ) return char.repeat( depth ) + "Null";
	if ( primitiveNode( ast ) ) return char.repeat( depth ) + ast.constructor.name + " " + JSON.stringify( ast );
	if ( ast instanceof SingleProp )

		return char.repeat( depth ) + ast.constructor.name + " " + inspect( ast.data[ 0 ], enumerable, char, depth ).trim();
		// const superClass = Object.getPrototypeOf( Object.getPrototypeOf( ast ) ).constructor;
		// if ( superClass === Node ) return ast.constructor.name + " " + inspect( ast.data, enumerable, char, depth, true );
		// return ast.constructor.name + " " + inspect( new superClass( ...ast.data ), enumerable, char, depth, true );

	if ( ast instanceof Array ) {

		let s = char.repeat( depth ) + ast.constructor.name + " [\n";
		for ( let i = 0; i < ast.length; i ++ )
			s += char.repeat( depth + 1 ) + inspect( ast[ i ], enumerable, char, depth + 1 ).trim() + "\n";
		return s + char.repeat( depth ) + "]";

	}
	const s = char.repeat( depth ) + ast.constructor.name + " {";
	let body = "";
	if ( enumerable )

		for ( const prop in ast )
			body += char.repeat( depth + 1 ) + prop + ": " + inspect( ast[ prop ], enumerable, char, depth + 1 ).trim() + "\n";

	else {

		const props = Object.getOwnPropertyDescriptors( ast );
		for ( const prop in props )
			body += char.repeat( depth + 1 ) + prop + ": " + inspect( ast[ prop ], enumerable, char, depth + 1 ).trim() + "\n";

	}
	return s + ( body ? "\n" + body + char.repeat( depth ) + "}" : "}" );

};
