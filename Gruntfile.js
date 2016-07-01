module.exports = function(grunt) {

  var mozjpeg = require('imagemin-mozjpeg');

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    clean: {
      js: 'js',
      css: 'css',
      images: ['images', 'screenshot.png', 'logo.png'],
      sass_cache: '.sass-cache'
    },
    watch: {
      sass: {
        files: 'src/sass/**/*.scss',
        tasks: ['newer:imagemin', 'compass:development']
      },
      js: {
        files: 'src/js/**/*.js',
        tasks: ['newer:copy:development', 'jshint:development']
      },
      images: {
        files: ['src/images/**/*.{svg,png,gif,jpg,jpeg}', 'screenshot.png', 'logo.png'],
        tasks: ['newer:imagemin']
      }
    },
    uglify: {
      production: {
        options: {
          compress: true,
          mangle: {
            except: ['jQuery', 'Drupal', 'Western']
          }
        },
        files: [{
          expand: true,
          cwd: 'src/js',
          src: '**/*.js',
          dest: 'js',
          ext: '.min.js'
        }]
      }
    },
    copy: {
      development: {
        files: [{
          expand: true,
          cwd: 'src/js',
          src: '**/*.js',
          dest: 'js',
          ext: '.min.js'
        }]
      }
    },
    compass: {
      options: {
        config: 'config.rb',
        bundleExec: true
      },
      production: {
        options: {
          environment: 'production',
          outputStyle: 'compressed',
          force: true
        }
      },
      development: {
        options: {
          environment: 'development',
          outputStyle: 'expanded',
          force: false
        }
      }
    },
    jshint: {
      options: {
        browser: true,
        devel: true,
        freeze: true,
        jquery: true,
        node: true,
        undef: true,
        unused: true,
        globals: {
          jQuery: true,
          Drupal: true,
          Western: true
        },
      },
      development: {
        files: {
          src: ['Gruntfile.js', 'src/js/**/*.js']
        },
        options: {
          force: true
        }
      }
    },
    imagemin: {
      options: {
        optimizationLevel: 3,
        svgoPlugins: [{
          removeViewBox: false
        }],
        progressive: true,
        interlaced: true,
        use: [mozjpeg()]
      },
      static: {
        files: [
          {
            src: 'src/images/screenshot.png',
            dest: 'screenshot.png'
          },
          {
            src: 'src/images/logo.png',
            dest: 'logo.png'
          },
        ],
      },
      dynamic: {
        files: [{
          expand: true,
          cwd: 'src/images',
          src: ['**/*.{svg,png,gif,jpg,jpeg}'],
          dest: 'images',
        }],
      },
    },
  });

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-imagemin');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-newer');

  grunt.registerTask(
    'default',
    'The development task suite.',
    [
      'jshint:development',
      'newer:copy:development',
      'newer:imagemin',
      'compass:development'
    ]
  );

  grunt.registerTask(
    'build',
    'The production build task suite.',
    [
      'uglify:production',
      'imagemin',
      'compass:production'
    ]
  );

};
