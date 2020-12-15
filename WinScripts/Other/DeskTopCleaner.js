var Cleaner = {
	run: function(from, to, interval) {
		var fso = new ActiveXObject("Scripting.FileSystemObject");
		var iter = new Enumerator(from.files);
		var ATTR_HIDDEN = 2;
		var ATTR_ALIAS  = 64;
		// WScript.Echo(recycle);
		var now = new Date();
		var limit = new Date();
		limit.setTime(now.getTime() - interval * 24 * 60 * 60 * 1000);
		// WScript.Echo(limit);
		while ( !iter.atEnd() ) {
			var file = fso.GetFile(iter.item());
			if (! ( (file.Attributes & ATTR_HIDDEN) || (file.Attributes & ATTR_ALIAS) ) ) {		
				if ( ! file.Path.match(/.lnk$/) ) {
					var time = new Date;
					time.setTime(Date.parse(file.DateLastAccessed));
					
					if ( time.getTime() < limit.getTime() ) {
						// fso.MoveFile(file.Path);
						to.MoveHere(file.Path); 
					}
				}
			}
			
			iter.moveNext();
		}
	}
};

var DesktopCleaner = {
	run: function() {
		var shell = new ActiveXObject("WScript.Shell");
		var wshell = new ActiveXObject("Shell.Application");
		var RECYCLE_KEY = "::{645FF040-5081-101B-9F08-00AA002F954E}";
		var recycle = wshell.NameSpace(RECYCLE_KEY);

		var DESKTOP = shell.SpecialFolders("Desktop");
		var fso = new ActiveXObject("Scripting.FileSystemObject");
		var target = fso.GetFolder(DESKTOP);
		Cleaner.run(target, recycle, 14);
	}
};

DesktopCleaner.run();