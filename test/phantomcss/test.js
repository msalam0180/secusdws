/*
                Require and initialise PhantomCSS module
                Paths are relative to CasperJs directory
*/

var fs = require( 'fs' );
var path = fs.absolute( fs.workingDirectory + '/phantomcss.js' );
var phantomcss = require( path );
//var server = require('webserver').create();

// var html = fs.read( fs.absolute( '' ));
//
// server.listen(8080,function(req,res){
//             res.statusCode = 200;
//             res.headers = {
//                             'Cache': 'no-cache',
//                             'Content-Type': 'text/html;charset=utf-8'
//             };
//             res.write(html);
//             res.close();
// });


casper.test.begin( 'SEC Visual Regression Tests', function ( test ) {

  phantomcss.init( {
    rebase: casper.cli.get( "rebase" ),
    // SlimerJS needs explicit knowledge of this Casper, and lots of absolute paths
    casper: casper,
    libraryRoot: fs.absolute( fs.workingDirectory + '' ),
    screenshotRoot: fs.absolute( fs.workingDirectory + '/screenshots' ),
    failedComparisonsRoot: fs.absolute( fs.workingDirectory + '/failures' ),
    addLabelToFailedImage: false,
    /*
    screenshotRoot: '/screenshots',
    failedComparisonsRoot: '/failures'
    casper: specific_instance_of_casper,
    libraryRoot: '/phantomcss',
    fileNameGetter: function overide_file_naming(){},
    onPass: function passCallback(){},
    onFail: function failCallback(){},
    onTimeout: function timeoutCallback(){},
    onComplete: function completeCallback(){},
    hideElements: '#thing.selector',
    addLabelToFailedImage: true,
    outputSettings: {
    errorColor: {
                    red: 255,
                    green: 255,
                    blue: 0
    },
    errorType: 'movement',
    transparency: 0.3
    }*/
  } );

  casper.on( 'remote.message', function ( msg ) {
    this.echo( msg );
  } );

  casper.on( 'error', function ( err ) {
    this.die( "PhantomJS has errored: " + err );
  } );

  casper.on( 'resource.error', function ( err ) {
  casper.log( 'Resource load error: ' + err, 'warning' );
  } );

  /*
                  The test scenario
  */
  casper.start( 'http://secgov.dev.dd:8083' );
  casper.viewport( 1024, 768 );

  casper.then( function () {
    this.evaluate(function() {
      document.querySelector('#page.homepage .block-region-section-1-right .pr-list h3 a').textContent = 'Lorem Ipsum';
    });
    phantomcss.screenshot( '#section-1', 'Stories Section CMS' );
  } );

  casper.then( function () {
    phantomcss.screenshot( '#section-1', 0, '.homepage-featured-video', 'Stories Section CMS - Hidden' );
  } );

/*global header */
  casper.then( function () {
    this.evaluate(function() {
      document.querySelector('#global-header .banner-org-name a').textContent = 'Lorem Ipsum';
      document.querySelector('#global-header #global-search .overlabel').textContent = 'Lorem Ipsum';

      var optionlinks = document.querySelectorAll('.option-link');
      for (var i = 0; i < optionlinks.length; i++){
        optionlinks[i].textContent = 'Lorem Ipsum';
      }

      var menulinks = document.querySelectorAll('#global-navigation #main-menu li a');
      for (var i = 0; i < menulinks.length; i++){
        menulinks[i].textContent = 'Lorem Ipsum';
      }
    });

    phantomcss.screenshot( 'section[role="header"]', 'Global Header' );
  } );

  /*global footer */
  casper.then( function () {
    this.evaluate(function() {
      document.querySelector('p#stay-connected-footer span').textContent = 'Lorem Ipsum';

      var menulinks = document.querySelectorAll('p#stay-connected-footer a span:nth-child(2)');
      for (var i = 0; i < menulinks.length; i++){
        menulinks[i].textContent = 'Lorem Ipsum';
      }

      var menulinks2 = document.querySelectorAll('#block-secgov-footer ul li a');
      for (var i = 0; i < menulinks2.length; i++){
        menulinks2[i].textContent = 'Lorem Ipsum';
      }
    });

    phantomcss.screenshot( 'section[role="footer"]', 'Global Footer' );
  } );


/*left nav */
casper.then( function () {
  this.evaluate(function() {
    document.querySelector('p#stay-connected-footer span').textContent = 'Lorem Ipsum';

    var menulinks = document.querySelectorAll('p#stay-connected-footer a span:nth-child(2)');
    for (var i = 0; i < menulinks.length; i++){
      menulinks[i].textContent = 'Lorem Ipsum';
    }

    var menulinks2 = document.querySelectorAll('#block-secgov-footer ul li a');
    for (var i = 0; i < menulinks2.length; i++){
      menulinks2[i].textContent = 'Lorem Ipsum';
    }
  });

  phantomcss.screenshot( 'section[role="footer"]', 'Global Footer' );
} );


  casper.then( function now_check_the_screenshots() {
    // compare screenshots
    phantomcss.compareAll();
  } );

  /*
  Casper runs tests
  */
  casper.run( function () {
    console.log( '\nTHE END.' );
    // phantomcss.getExitStatus() // pass or fail?
    casper.test.done();
  } );
} );
