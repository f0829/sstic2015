var fs = require('fs');
var esprima = require('esprima');
var estraverse = require('estraverse');
var escodegen = require('escodegen');

var filename = process.argv[2];
console.log('Processing', filename);
var ast = esprima.parse(fs.readFileSync(filename));

function simplify_ast(ast) {
    var assignments = {};

    estraverse.traverse(ast, {
	enter: function(node, parent) {
	    if (node.type == 'Identifier') {
		if (parent.type == 'AssignmentExpression') {
		    if (parent.left == node) {
			right = parent.right;
			if ((right.type == 'Literal') || (right.type == 'Identifier')) {
			    k = assignments[node.name];
			    if (!k) {
				assignments[node.name] = { node: right, ref_count: 0 };
			    } else {
				k['ref_count'] += 1;
				assignments[node.name] = k;
			    }
			}
		    }
		} else if (parent.type == 'UpdateExpression') {
		    k = assignments[node.name];
		    if (k) {
		    	k['ref_count'] += 1;
		    	assignments[node.name] = k;
		    }
		} else {
		    console.log("Not handled: ", parent.type);
		    console.log(parent);
		}
	    }
	}
    });

    result = estraverse.replace(ast, {
	enter: function(node, parent) {
	    if (node.type == 'Identifier') {
	    	k = assignments[node.name];
	    	if ( (!k) ||
	    	     (parent.type == 'AssignmentExpression') && (parent.left == node) ||
	    	     (parent.type == 'UpdateExpression')
	    	   ) {
	    	    return node;
		}
		if (k['ref_count'] == 0) {
		    return k.node;
		}
	    }
	    if ((node.type == 'BinaryExpression') &&
	    	(node.left.type == 'Literal') &&
	    	(node.right.type == 'Literal')) {
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
    });

    return result;

}

do {
  old_code = escodegen.generate(ast);
  new_ast = simplify_ast(ast);
  new_code = escodegen.generate(new_ast);
}
while(new_code != old_code);
  
console.log(new_code);
