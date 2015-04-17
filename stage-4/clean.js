var fs = require('fs');
var esprima = require('esprima');
var estraverse = require('estraverse');
var escodegen = require('escodegen');

var filename = process.argv[2];
console.log('Processing', filename);
var ast = esprima.parse(fs.readFileSync(filename));

function simplify_node(node) {
    if ((node.type == 'BinaryExpression') &&
	    (node.left.type == 'Literal') &&
	    (node.right.type == 'Literal'))
    {
	if (node.operator == '+') {
	    return { type: 'Literal', value: node.left.value + node.right.value,
		raw: node.left.raw + node.right.raw };
	} else if (node.operator == '*') {
	    return { type: 'Literal', value: node.left.value * node.right.value,
		raw: node.left.raw * node.right.raw };
	}
    }
    return node;
}

function simplify_ast(ast) {
    var assignments = {};
    var renaming = {};
    var f_count = 0;
    var arg_count = 0;

    estraverse.traverse(ast, {
	enter: function(node, parent) {
	    if (node.type == 'Identifier') {
		k = assignments[node.name];
		if (parent.type == 'AssignmentExpression') {
		    /* Node is on the left-hand side of the assignment */
		    if (parent.left == node) {
			right = parent.right;
			if ( (right.type == 'Literal')
			    || (right.type == 'Identifier')
			    // || (right.type == 'MemberExpression') 
			   ) {
			       if (!k) {
				   assignments[node.name] = { node: right, ref_count: 1 };
			       } else {
				   /* Not the first assignment, increasing ref count */
				   k['ref_count'] += 1;
				   assignments[node.name] = k;
			       }
			   } 
		    }
		} else if (parent.type == 'UpdateExpression') {
		    if (k) {
			k['ref_count'] += 1;
			assignments[node.name] = k;
		    }
		} else if ((parent.type == 'FunctionDeclaration') && (parent.id == node)) {
		    renaming[node.name] = "func_" + f_count;
		    f_count += 1;
		} 
	    }
	}
    });

    result = estraverse.replace(ast, {
	enter: function(node, parent) {
	    if (node.type == 'Identifier') {
		k = assignments[node.name];
		if ( (parent.type == 'AssignmentExpression') && (parent.left == node) ||
		    (parent.type == 'UpdateExpression')
		   ) {
		       return node;
		   }
		if (k && k['ref_count'] == 1) {
		    return k.node;
		}
		if (renaming[node.name]) {
		    node.name = renaming[node.name];
		}
	    }
	    return simplify_node(node);
	}
    });

    return result;
}

new_code = ""
do {
    old_code = new_code;
    ast = simplify_ast(ast);
    new_code = escodegen.generate(ast);
}
while(new_code != old_code);

console.log(new_code);
