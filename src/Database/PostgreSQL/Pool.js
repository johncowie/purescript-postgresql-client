import pg from 'pg';

"use strict";

const ffiNew = function(config) {
    return function() {
        return new pg.Pool(config);
    };
};

const totalCount = function(pool) {
  return function() {
    return pool.totalCount;
  };
};

const idleCount = function(pool) {
  return function() {
    return pool.idleCount;
  };
};

const waitingCount = function(pool) {
  return function() {
    return pool.waitingCount;
  };
};

export {ffiNew, totalCount, idleCount, waitingCount}
