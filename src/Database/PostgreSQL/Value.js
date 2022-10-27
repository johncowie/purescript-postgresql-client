/* global Buffer, exports, require */
/* jshint -W097 */

'use strict';

const instantToString = function(i) {
    return new Date(i).toUTCString();
};

const instantFromString = function(Left) {
  return function(Right) {
    return function(s) {
      try {
        return Right(Date.parse(s));
      } catch(e) {
        return Left("Date string parsing failed: \"" + s + "\", with: " + e);
      }
    };
  };
};

const unsafeIsBuffer = function(x) {
    return x instanceof Buffer;
};

export {instantToString, instantFromString, unsafeIsBuffer, null = 'null'}
