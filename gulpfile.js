'use strict'

var gulp      	= require('gulp')
  , purescript 	= require('gulp-purescript')
  ;

gulp.task('compile', function(cb) {
	var psc = purescript.psc({
		// Compiler options
		output: "easy.js",
    module: "Data.Foreign.EasyFFI"
	});
  psc.on('error', function(e) {
    console.log('wtf');
    cb(e.message); // Build failed
  });
  gulp.src(["src/*.purs"])
    .pipe(psc)
    .pipe(gulp.dest("out"))
    .on('data', function () {
      cb(); // Completed successfully
    })
    ;
});

gulp.task('default', ['compile']);
