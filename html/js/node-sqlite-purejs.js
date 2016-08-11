// Generated by CoffeeScript 1.4.0
var Sql, code, fs, vm;

vm = require('vm');

fs = require('fs');

code = '';

module.exports = Sql = (function() {

  function Sql() {}

  Sql.open = function(file, options, cb) {
    var data, js_file, s, serial;
    s = new Sql();
    s.file = file;
    s.options = options || {};
    js_file = __dirname + '/sql.js';
    data = undefined;
    serial = [];
    serial[0] = function() {
      var next;
      next = serial[1];
      if (code) {
        return next();
      }
      fs.readFile(js_file, 'utf8', function(err, _code) {
        if (err) {
          return cb(err);
        }
        code = _code;
        return next();
      });
    };
    serial[1] = function() {
      var next, sandbox;
      next = serial[2];
      sandbox = vm.createContext({
        ArrayBuffer: ArrayBuffer,
        Float32Array: Float32Array,
        Float64Array: Float64Array,
        Int16Array: Int16Array,
        Int32Array: Int32Array,
        Int8Array: Int8Array,
        Uint16Array: Uint16Array,
        Uint32Array: Uint32Array,
        Uint8Array: Uint8Array,
        process: process,
        require: require,
        console: {
          log: console.log
        }
      });
      vm.runInContext(code, sandbox, js_file);
      s.instance = sandbox.SQL;
      if (s.options.manual_load === true) {
        return next();
      }
      return fs.exists(s.file, function(exists) {
        if (!exists) {
          return next();
        }
        return s.load(function(err, _data) {
          if (err) {
            return cb(err);
          }
          data = _data;
          return next();
        });
      });
    };
    serial[2] = function() {
      s.db = s.instance.open(data);
      cb(null, s);
    };
    serial[0]();
  };

  Sql.prototype.exec = function(sql, cb) {
    var k, last_result, serial,
      _this = this;
    try {
      if (this.options.parse_multiple) {
        sql = sql.split(';');
      } else {
        sql = [sql];
      }
      for (k in sql) {
        if (sql[k]) {
          last_result = this.db.exec(sql[k]);
        }
      }
      serial = [];
      serial[0] = function() {
        var next;
        next = serial[1];
        if (_this.options.manual_save === true) {
          return next();
        }
        return _this.save(function(err) {
          if (err) {
            return cb(err);
          }
          return next();
        });
      };
      serial[1] = function() {
        var col, i, ii, record, recordset, row;
        recordset = [];
        for (i in last_result) {
          row = last_result[i];
          record = {};
          for (ii in row) {
            col = row[ii];
            if (typeof col.value === 'string' && col.value === '(null)') {
              col.value = null;
            }
            record[col.column] = col.value;
          }
          recordset.push(record);
        }
        return cb && cb(null, recordset);
      };
      serial[0]();
    } catch (err) {
      cb && cb(err);
    }
  };

  Sql.prototype.execute_sql = Sql.prototype.exec;

  Sql.prototype.load = function(cb) {
    fs.readFile(this.file, function(err, buffer) {
      if (err) {
        return cb(err);
      }
      return cb(null, new Uint8Array(buffer));
    });
  };

  Sql.prototype.save = function(cb) {
    var buffer, i, view;
    view = this.db.exportData();
    buffer = new Buffer(view.byteLength);
    if (buffer.length === 0) {
      return false;
    }
    i = 0;
    while (i < buffer.length) {
      buffer[i] = view[i++];
    }
    fs.writeFile(this.file, buffer, function(err) {
      setTimeout((function() {
        return cb(err);
      }), 0);
    });
  };

  return Sql;

})();