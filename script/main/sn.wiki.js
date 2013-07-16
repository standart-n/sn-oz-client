(function() {
  return window.snWiki = (function() {
    function snWiki(options) {
      this.options = options;
      if (this.options == null) {
        this.options = {
          images: {
            url: ''
          },
          files: {
            url: ''
          },
          gismeteo: {
            url: ''
          }
        };
      }
    }

    snWiki.prototype.render = function(text) {
      text = this.before(text);
      text = this.formating(text);
      text = this.headings(text);
      text = this.icons(text);
      text = this.externalLinks(text);
      text = this.fileLinks(text);
      text = this.internalLinks(text);
      text = this.mailTo(text);
      text = this.image(text);
      text = this.fonts(text);
      text = this.anchor(text);
      text = this.ind(text);
      text = this.gismeteo(text);
      text = this.spoiler(text);
      text = this.header(text);
      text = this.spaces(text);
      text = this.noevent(text);
      return text;
    };

    snWiki.prototype.before = function(text) {
      return text.replace(/\|\n/g, '').replace(/\]\n\n/g, ']<br><br>').replace(/\]\n/g, ']<br>').replace(/>\n\n/g, '>\n');
    };

    snWiki.prototype.formating = function(text) {
      return text.replace(/'''''(.*?)'''''/g, "<i><b>$1</b></i>").replace(/'''(.*?)'''/g, "<b>$1</b>").replace(/''(.*?)''/g, "<i>$1</i>");
    };

    snWiki.prototype.headings = function(text) {
      text = text.replace(/======(.*?)======\n?/g, "<h6>$1</h6>");
      text = text.replace(/=====(.*?)=====\n?/g, "<h5>$1</h5>");
      text = text.replace(/====(.*?)====\n?/g, "<h4>$1</h4>");
      text = text.replace(/===(.*?)===\n?/g, "<h3>$1</h3>");
      return text = text.replace(/==(.*?)==\n?/g, "<h2>$1</h2>");
    };

    snWiki.prototype.icons = function(text) {
      return text.replace(/\[(i|ico|icon|icons):icon-([a-zA-Z0-9\_\-]+)[\s]+(inverse|white)\]/g, '<i class="icon-$2 icon-white"></i> ').replace(/\[(i|ico|icon|icons):([a-zA-Z0-9\_\-]+)[\s]+(inverse|white)\]/g, '<i class="icon-$2 icon-white"></i> ').replace(/\[(i|ico|icon|icons):icon-([a-zA-Z0-9\_\-]+)\]/g, '<i class="icon-$2"></i> ').replace(/\[(i|ico|icon|icons):([a-zA-Z0-9\_\-]+)\]/g, '<i class="icon-$2"></i> ').replace(/([\s]+)(i|ico|icon|icons):icon-([a-zA-Z0-9\_\-]+)[\s]+(inverse|white)([\s]+)/g, '$1<i class="icon-$3 icon-white"></i>$4').replace(/([\s]+)(i|ico|icon|icons):([a-zA-Z0-9\_\-]+)[\s]+(inverse|white)([\s]+)/g, '$1<i class="icon-$3 icon-white"></i>$4').replace(/([\s]+)(i|ico|icon|icons):icon-([a-zA-Z0-9\_\-]+)([\s]+)/g, '$1<i class="icon-$3"></i>$4').replace(/([\s]+)(i|ico|icon|icons):([a-zA-Z0-9\_\-]+)([\s]+)/g, '$1<i class="icon-$3"></i>$4');
    };

    snWiki.prototype.internalLinks = function(text) {
      return text.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" data-placement="$6" rel="tooltip" title="$5">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$5">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" data-placement="$5" rel="tooltip" title="$4">$3</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$4">$3</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn btn-$2" href="#$3">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)\]/g, '<a class="btn btn-$2" href="#$1">$1</a>').replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$2" class="btn tooltip-toggle" data-placement="$5" rel="tooltip" title="$4">$3</a>').replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$2" class="btn tooltip-toggle" rel="tooltip" title="$4">$3</a>').replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$2" class="btn tooltip-toggle" data-placement="$4" rel="tooltip" title="$3">$2</a>').replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$2" class="btn tooltip-toggle" rel="tooltip" title="$3">$2</a>').replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn" href="#$2">$3</a>').replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)\]/g, '<a href="#$1">$1</a>').replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$1" class="tooltip-toggle" data-placement="$4" rel="tooltip" title="$3">$2</a>').replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$1" class="tooltip-toggle" rel="tooltip" title="$3">$2</a>').replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$1" class="tooltip-toggle" data-placement="$3" rel="tooltip" title="$2">$1</a>').replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$1" class="tooltip-toggle" rel="tooltip" title="$2">$1</a>').replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$1">$2</a>').replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)\]/g, '<a href="#$1">$1</a>').replace(/([\s+])#([a-zA-Z0-9\-\.\/\?%\#_\:]+)([\s]+)/g, '$1<a href="#$2">$2</a>$3');
    };

    snWiki.prototype.externalLinks = function(text) {
      return text.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+) (left|top|right|bottom)\]/g, '<a href="http://$3" class="btn btn-$2 tooltip-toggle" data-placement="$6" rel="tooltip" title="$5" target="_blank">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$5" target="_blank">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://$3" class="btn btn-$2 tooltip-toggle" data-placement="$5" rel="tooltip" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$3" class="btn btn-$2" target="_blank">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a class="btn btn-$2" href="http://$2" target="_blank">$2</a>').replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+) (left|top|right|bottom)\]/g, '<a href="http://$2" class="btn tooltip-toggle" data-placement="$5" rel="tooltip" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$2" class="btn tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://$2" class="btn tooltip-toggle" data-placement="$4" rel="tooltip" title="$3" target="_blank">$2</a>').replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$2" class="tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>').replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn" href="http://$2" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a class="btn" href="http://$2" target="_blank">$2</a>').replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://$1" class="tooltip-toggle" data-placement="$4" rel="tooltip" title="$3" target="_blank">$2</a>').replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$1" class="tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>').replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://$1" class="tooltip-toggle" data-placement="$3" rel="tooltip" title="$2" target="_blank">$1</a>').replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$1" class="tooltip-toggle" rel="tooltip" title="$2" target="_blank">$1</a>').replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$1" target="_blank">$2</a>').replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a href="http://$1" target="_blank">$1</a>').replace(/([\s]+)https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)([\s]+)/g, '$1<a href="http://$2" target="_blank">$2</a>$3');
    };

    snWiki.prototype.fileLinks = function(text) {
      return text.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + this.options.files.url + '$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" data-placement="$6" title="$5" target="_blank">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + this.options.files.url + '$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$5" target="_blank">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + this.options.files.url + '$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" data-placement="$5" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + this.options.files.url + '$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn btn-$2" href="' + this.options.files.url + '$3" target="_blank">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a class="btn btn-$2" href="' + this.options.files.url + '$3" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + this.options.files.url + '$2" class="btn tooltip-toggle" rel="tooltip" data-placement="$5" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + this.options.files.url + '$2" class="btn tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + this.options.files.url + '$2" class="btn tooltip-toggle" rel="tooltip" data-placement="$4" title="$3" target="_blank">$2</a>').replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + this.options.files.url + '$2" class="btn tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>').replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn" href="' + this.options.files.url + '$2" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a class="btn" href="' + this.options.files.url + '$2" target="_blank">$2</a>').replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + this.options.files.url + '$1" class="tooltip-toggle" rel="tooltip" data-placement="$4" title="$3" target="_blank">$2</a>').replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + this.options.files.url + '$1" class="tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>').replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + this.options.files.url + '$1" class="tooltip-toggle" rel="tooltip" data-placement="$3" title="$2" target="_blank">$1</a>').replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + this.options.files.url + '$1" class="tooltip-toggle" rel="tooltip" title="$2" target="_blank">$1</a>').replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + this.options.files.url + '$1" target="_blank">$2</a>').replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a href="' + this.options.files.url + '$1" target="_blank">$1</a>').replace(/([\s]+)files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)([\s]+)/g, '$1<a href="' + this.options.files.url + '$2" target="_blank">$2</a>$3');
    };

    snWiki.prototype.mailTo = function(text) {
      return text.replace(/\[e\-?mail:([a-zA-Z0-9@\-\.\/\?%\#_]+)[\s]+(.*?)\]/g, '<a href="mailto:$1">$2</a>').replace(/\[e\-?mail:([a-zA-Z0-9@\-\.\/\?%\#_]+)\]/g, '<a href="mailto:$1">$1</a>');
    };

    snWiki.prototype.image = function(text, options) {
      return text.replace(/\[(img|image|picture|photo):([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+(right|left)\]/g, '<img class="pull-$3" src="' + this.options.images.url + '$2">').replace(/\[(img|image|picture|photo):([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<img src="' + this.options.images.url + '$2">').replace(/([\s]+)(img|image|picture|photo):([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+(right|left)([\s]+)/g, '$1<img class="pull-$4" src="' + this.options.images.url + '$3">$5').replace(/([\s]+)(img|image|picture|photo):([a-zA-Z0-9\-\.\/\?\%\#\_]+)([\s]+)/g, '$1<img src="' + this.options.images.url + '$3">$4');
    };

    snWiki.prototype.fonts = function(text) {
      return text.replace(/\[badge[\s]+(success|warning|important|info|inverse)\][\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)/g, '<span class="badge badge-$1">$2</span>').replace(/\[badge[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(success|warning|important|info|inverse)\]/g, '<span class="badge badge-$2">$1</span>').replace(/\[badge[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<span class="badge">$1</span>').replace(/\[label[\s]+(success|warning|important|info|inverse)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<span class="label label-$1">$2</span>').replace(/\[label[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(success|warning|important|info|inverse)\]/g, '<span class="label label-$2">$1</span>').replace(/\[label[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<span class="label">$1</span>').replace(/\[color:\#([a-zA-Z0-9]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<font style="color:#$1">$2</font>').replace(/\[color:([a-zA-Z0-9]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<span class="$1">$2</span>').replace(/\[\[color:\#([a-zA-Z0-9]+)\](.*?)\]/g, '<font style="color:#$1">$2</font>').replace(/\[\[color:([a-zA-Z0-9]+)\](.*?)\]/g, '<span class="$1">$2</span>');
    };

    snWiki.prototype.ind = function(text) {
      return text.replace(/<<<\#?\:?([a-zA-Z0-9\-\.\/\?\_]+)\n?/g, '<div class="well well-small"><a id="anchor-$1"></a>').replace(/<<<\n?/g, '<div class="well well-small">').replace(/>>>\n?/g, '</div>');
    };

    snWiki.prototype.anchor = function(text) {
      return text.replace(/\[anchor:([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]\n?/g, '<a id="anchor-$1"></a>');
    };

    snWiki.prototype.gismeteo = function(text) {
      return text.replace(/\[gismeteo\]\n?/g, '<iframe src="' + this.options.gismeteo.url + '" width="96%" height="160" scrolling="no" marginheight="0" marginwidth="0" frameborder="0"></iframe>&nbsp;');
    };

    snWiki.prototype.spoiler = function(text) {
      return text.replace(/<<\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]\n?/g, '<div class="spoiler">' + '<a href="#spoiler" class="btn btn-$2 spoiler-caption spoiler-close">' + '<span class="caret"></span>&nbsp;$3</a><p>' + '<div class="hide spoiler-body spoiler-close"><pre>').replace(/<<\[b(tn|utton)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]\n?/g, '<div class="spoiler">' + '<a href="#spoiler" class="btn spoiler-caption spoiler-close">' + '<span class="caret"></span>&nbsp;$2</a><p>' + '<div class="hide spoiler-body spoiler-close"><pre>').replace(/<<\[([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]\n?/g, '<div class="spoiler">' + '<a href="#spoiler" class="spoiler-caption spoiler-close">' + '$1</a><p>' + '<div class="hide spoiler-body spoiler-close"><pre>').replace(/>>\n?/g, '</pre></div></p></div>');
    };

    snWiki.prototype.header = function(text) {
      return text.replace(/<\[\n?/g, '<div class="page-header">').replace(/\]>\n?/g, '</div>');
    };

    snWiki.prototype.spaces = function(text) {
      return text.replace(/^\n/, "").replace(/\n\n/g, "<br><br>").replace(/>\n?/g, '>').replace(/<pre><br>/g, '<pre>').replace(/\n/g, "<br>");
    };

    snWiki.prototype.noevent = function(text) {
      return text.replace(/(href="#")/g, '$1 data-noevent="true"');
    };

    return snWiki;

  })();
});
