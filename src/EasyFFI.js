export function unsafeForeignProcedure(args) {
  return function (stmt) {
    return Function(wrap(args.slice()))();
    function wrap() {
      return !args.length
        ? stmt
        : 'return function (' + args.shift() + ') { ' + wrap() + ' };';
    }
  };
}
