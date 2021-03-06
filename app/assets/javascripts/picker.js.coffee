$.datepicker.regional['pl'] =
	closeText: 'Zamknij',
	prevText: '&#x3c;Poprzedni',
	nextText: 'Następny&#x3e;',
	currentText: 'Dziś',
	monthNames: ['Styczeń','Luty','Marzec','Kwiecień','Maj','Czerwiec','Lipiec','Sierpień','Wrzesień','Październik','Listopad','Grudzień'],
	monthNamesShort: ['Sty','Lu','Mar','Kw','Maj','Cze','Lip','Sie','Wrz','Pa','Lis','Gru'],
	dayNames: ['Niedziela','Poniedzialek','Wtorek','Środa','Czwartek','Piątek','Sobota'],
	dayNamesShort: ['Nie','Pn','Wt','Śr','Czw','Pt','So'],
	dayNamesMin: ['N','Pn','Wt','Śr','Cz','Pt','So'],
	weekHeader: 'Tydz',
	dateFormat: 'yy-mm-dd',
	firstDay: 1,
	isRTL: false,
	showMonthAfterYear: false,
	yearSuffix: ''
		
$.datepicker.setDefaults($.datepicker.regional['pl']);

$.timepicker.regional['pl'] =
	timeOnlyTitle: 'Pokaż tylko czas',
	timeText: 'Czas',
	hourText: 'godzin',
	minuteText: 'minut',
	secondText: 'sekund',
	millisecText: 'milisekund',
	currentText: 'Teraz',
	closeText: 'Zamknij',
	ampm: false


$.timepicker.setDefaults($.timepicker.regional['pl']);

$ ->
	$(".date_entry").datetimepicker
		stepMinute: 5
