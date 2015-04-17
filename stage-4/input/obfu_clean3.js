var data = "2b1f25c[...]1646ffe2";
var hash = "08c3be636f7dffd91971f65be4cec3c6d162cb1c";

ua = window.navigator.userAgent;
document.write('<h1>Download manager</h1>');
document.write('<div id="status"><i>loading...</i></div>');
document.write('<div style="display:none"><a target="blank" href="chrome://browser/content/preferences/preferences.xul">Back to preferences</a></div>');

function stringToBytes(arg) {
    res = [];
    for (i = 0; i < arg.length; ++i)
	res.push(arg.charCodeAt(i));
    return new Uint8Array(res);
}

function hexToBytes(arg) {
    res = [];
    for (i = 0; i < arg.length / 2; ++i)
	res.push(parseInt(arg.substr(i * 2, 2), 16));
    return new Uint8Array(res);
}

function bytesToHex(arg) {
    res = '';
    for (i = 0; i < arg.byteLength; ++i) {
	s = arg[i].toString(16);
	if (s.length < 2)
	    res += 0;
	res += s;
    }
    return res;
}

function f3() {
    iv = stringToBytes(ua.substr(ua.indexOf('(') + 1, 16));
    key = stringToBytes(ua.substr(ua.indexOf(')') - 16, 16));
    ctx = {};
    ctx['name'] = 'AES-CBC';
    ctx['iv'] = iv;
    ctx['length'] = key['length'] * 8;
    window.crypto.subtle.importKey('raw', key, ctx, false, ['decrypt']).then(function(arg0) {
	window.crypto.subtle.decrypt(ctx, arg0, hexToBytes(data)).then(function(arg1) {
	    plainText = new Uint8Array(arg1);
	    window.crypto.subtle.digest({
		name: 'SHA-1'
	    }, plainText).then(function(arg2) {
		if (hash == bytesToHex(new Uint8Array(arg2))) {
		    props = {};
		    props['type'] = 'application/octet-stream';
		    blob = new Blob([plainText], props);
		    url = URL.createObjectURL(blob);
		    document.getElementById('status').innerHTML = '<a href="' + url + '" download="stage5.zip">download stage5</a>';
		} else {
		    document.getElementById('status').innerHTML = '<b>Failed to load stage5</b>';
		}
	    });
	}).catch(function() {
	    document.getElementById('status').innerHTML = '<b>Failed to load stage5</b>';
	});
    }).catch(function() {
	document.getElementById('status').innerHTML = '<b>Failed to load stage5</b>';
    });
}
window.setTimeout(f3, 1000);

