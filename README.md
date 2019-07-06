# jass-to-ast
Converts WC3 JASS to an abstract syntax tree

## Usage
```javascript
import parse from "jass-to-ast";

parse( `
globals
  boolean flipped = false
endglobals

function flip takes nothing returns nothing
  local boolean previousState = flipped
  set flipped = true
  return previousState
endfunction
`.trim() );

> Program [
    Globals {
      globals: Statements [
        Variable { type: 'boolean', name: 'flipped', value: false }
      ]
    },
    EmptyLine {},
    JASSFunction {
      name: 'flip',
      statements: Statements [
        Variable {
          type: 'boolean',
          name: 'previousState',
          value: [String (Name): 'flipped']
        },
        JASSSet { name: 'flipped', value: true },
        Return { data: [ [String (Name): 'previousState'] ] }
      ]
    }
  ]
```

## CLI

```bash
> jass-to-ast example.j
Program [
  Globals {
    globals: Statements [
      Variable { type: 'boolean', name: 'flipped', value: false }
    ]
  },
  EmptyLine {},
  JASSFunction {
    name: 'flip',
    statements: Statements [
      Variable {
        type: 'boolean',
        name: 'previousState',
        value: [String (Name): 'flipped']
      },
      JASSSet { name: 'flipped', value: true },
      Return { data: [ [String (Name): 'previousState'] ] }
    ]
  }
]
```
