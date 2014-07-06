'use strict'

var gulp        = require('gulp')
  , purescript  = require('gulp-purescript')
  ;

var src = 'src/EasyFFI.purs';

gulp.task('compile', function(cb) {
	var psc = purescript.pscMake({
		// Compiler options
		output: 'output'
	});
  psc.on('error', function(e) {
    cb(e.message); // Build failed
  });
  return gulp.src(src)
    .pipe(psc)
    .on('data', function () {
      cb(); // Completed successfully
    })
    ;
});

gulp.task('watch', function(cb) {
  gulp.start('compile');
  gulp.watch(src, ['compile']);
});

gulp.task('default', ['compile']);
