console.log('hello');
function login() { if (!validateUser(arguments[0])) return false; console.log('logging in'); return true; }
function validateUser(u) { return !!u; }
