/* global exports */
"use strict";

exports.unsafeForeignProcedure = function(args) {
    return function (stmt) {
        return Function(wrap(args.slice()))();
        function wrap() {
            return !args.length ? stmt : 'return function (' + args.shift() + ') { ' + wrap() + ' };';
        }
    };
};
