$(function() {
  
	Cufon.replace('nav ul')('h1');
	
	$('nav li a').each(function(idx) {
    var initial = $(this).text(),
        upper = initial.replace(/\b([A-Za-z0-9])/g,'<span class="caps">$1</span>');
    $(this).html(upper).css({'textTransform' : 'uppercase', 'fontSize' : '21px'});
  });
	
	$('nav li, h1').show();
	
	if ($('html.ie6').length === 0) {
	  // http://dowebsitesneedtolookexactlythesameineverybrowser.com/
	  lightbox.init($('a:has(img)')); 
	}

	var $fields = $('#name, #email, #message');
	//var $notice = $('#notice').hide();
	
	$fields.hover(function() {
		$(this).removeClass('error');
	});
	
	/*$('form').submit(function(e) {
		$button = $('input[type=submit]', this).attr('disabled', 'disabled');
		
		var success = true;
		
		$fields.each(function() {
			if ($(this).val().length === 0) {
				$(this).addClass('error');
				success = false;
			}
		});
		
		if (success === false) {
			$notice.text('Please complete all fields.').fadeIn('slow');
			$button.removeAttr("disabled")
		} else if (success === true) {
			$.post('assets/php/send.php', $(this).serialize(), function(data) {
					if (data.status === '1') {
						hold = true;
						$('form').fadeOut('slow', function() {
							$fields.val('');
							$(this).fadeIn();
							$notice.text(data.message).fadeIn();
						});
					} else if (data.status === '0') {
						$notice.text(data.message).addClass('error').fadeIn();
					}
					$button.removeAttr("disabled");
				}, 'json'
			);
		}
		
		setTimeout(function() {
			$notice.fadeOut('slow', function() {
				$(this).text('');
			});
		}, 1e4);
		
		e.preventDefault();
	});*/
	
	var artist;
  if (Modernizr.localstorage) {
  	// there is storage
  	artist = localStorage.getItem('artist');
  	var timestamp = parseInt(localStorage.getItem('timestamp'));
  	var currTime = new Date().getTime();
  	if (!artist || ((timestamp+3e5) < currTime)) {
  		// but no cache, or cache is older than five minutes
  		fetchArtist();
  	} else {
  	  displayArtist(artist);
  	}
  } else {
  	// there's no storage
  	fetchArtist();
  }
  function fetchArtist() {
  	$.get('/php/lastfm.php', [], function(data) {
  		var recentTracks = data.recenttracks;
  		// we check to see if track is an array
  		// as if I'm currently scrobbling, the zeroth
  		// track is what's now playing.
  		// also, ternery inside a ternery, holy crap!
  		var artist = (recentTracks !== undefined) ?
  		  (recentTracks.track[0] === undefined) ? 
  		    recentTracks.track.artist['#text']
  		    : recentTracks.track[0].artist['#text']
  		  : 'Last.fm connection failed.';
  		if (Modernizr.localstorage) {
  		  // add the artist and update the timestamp
  		  localStorage.setItem('artist', artist);
  		  localStorage.setItem('timestamp', new Date().getTime());
  		}
  		displayArtist(artist);
  	}, 'json');
  }
	function displayArtist(artist) {
		$('#lastfmArtist').fadeOut(function() {
			$(this).text(artist).fadeIn();
		});
	}
	
	$('.gtalk').show().find('#gtalk').click(function() {
	  var a;
	  var link = 'http://www.google.com/talk/service/badge/Start?tk\x3dz01q6amlqnf4hducke7e7q8ati7ueb44v5fcu4cabfrlqb7b80e3pdjkej1a3nfri87556g269nn1bk4qhd07udf6s6utfgjtpscjavtf7nkbu4o2ga42dbvk6m1qqiv26g23ggs3nk3bjm95qpgn9ehggenvnegqerdj1u0n';
    a = window.ActiveXObject && window.XMLHttpRequest ? false : true;
    a = 'status=0,scrollbars=0,menubar=0,statusbar=0,resizable=1, width=300,height=500,location=' + (a ? '1' : '0');
    window.open(link, "", a)
	});
});