'use strict'

var gulp        = require('gulp')
  , purescript  = require('gulp-purescript')
  , shell       = require('gulp-shell')
  ;

var purescripts = [ 'src/**/*.purs'
              , 'tests/**/*.purs'
              , 'bower_components/purescript-*/src/**/*.purs'
              ]
  , outputDir = 'output'
  , testRunnerFile = 'runTests.js'
  , defaultTask = 'test'
  ;

gulp.task('compile', function(cb) {
	var psc = purescript.psc({
    output: testRunnerFile,
    main: true
  });
  psc.on('error', function(e) {
    cb(e.message); // Failure
  });
  gulp
    .src(purescripts)
    .pipe(psc)
    .pipe(gulp.dest(outputDir))
    .on('data', function () {
      cb(); // Success
    })
    ;
});

gulp.task('test', ['compile'], function (cb) {
  var runTests = shell([
    'node <%= file.path %>'
  ]);
  runTests.on('error', function (e) {
    cb('see above for details'); // Failure
  });
  gulp
    .src(outputDir + '/' + testRunnerFile)
    .pipe(runTests)
    .on('data', function () {
      cb(); // Success
    })
    ;
});

gulp.task('watch', function(cb) {
  gulp.start(defaultTask);
  gulp.watch(purescripts, [defaultTask]);
});

gulp.task('default', [defaultTask]);
