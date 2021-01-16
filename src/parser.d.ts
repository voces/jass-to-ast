export class Comment extends String {}

export class FourCC extends String {}
export class Name extends String {}
export class Node {
	data: Array<Node | string>;
}
export class EmptyLine extends Node {}
export class SingleProp {
	data: string;
}
export class FuncRef extends SingleProp {}
export class ExitWhen extends SingleProp {}
export class Return extends SingleProp {}
export class Parens extends SingleProp {}
export class Debug extends Node {
	statement: Node;
}
export class Type extends Node {
	base: Name | "code" | "handle" | "integer" | "real" | "boolean" | "string";
	super?: Type;
}
export class Param extends Node {
	type: Name;
	name: Name;
}
export class Globals extends Node {
	comment: Comment;
	globals: List<EmptyLine | Variable>;
	endComment: Comment;
}
export class Native extends Node {
	name: string;
	params: Params;
	returns: Args;
}
export class Variable extends Node {
	type: Name;
	name: Name;
	value: Node;
	constant?: true;
	array?: true;
}
export class Call extends Node {
	name: string;
	args: Args;
}
export class JASSFunction extends Node {
	name: string;
	params: Params;
	returns: Name;
	comment: Comment;
	statements: Statements;
}
export class BinaryOp extends Node {
	left: Node;
	operator: "<" | ">" | "==" | "!=" | ">=" | "<=" | "and" | "or";
	right: Node;
}
export class IfThenElse extends Node {
	condition: Node;
	comment: Comment;
	then: Statements;
	elses: List<Else | ElseIf>;
}
export class Else extends Node {
	comment: Comment;
	statements: Statements;
}
export class ElseIf extends Node {
	condition: Node;
	comment: Comment;
	statements: Statements;
}
export class JASSSet extends Node {
	name: Name;
	value: Node;
	prop?: Node;
}
export class Loop extends Node {
	comment: Comment;
	statements: Statements;
	returns: Node;
	// comment: Comment; // IDK why this exists twice
	// statements: Statements; // IDK why this exists twice
}
export class ArrayRef extends Node {
	name: Name;
	prop: Node;
}
export class UnaryOp extends Node {
	operator: "+" | "-" | "not";
	expr: Node;
}
export class List<T> extends Array<T> {}
export class Block<T> extends List<T> {}
export class Params extends List<Param> {}
export class Args extends List<Node> {}
export class Statements extends Block<Node> {}
export class Program extends Block<
	EmptyLine | Globals | JASSFunction | Native | Type
> {}

export default function (jass: string): Program;
