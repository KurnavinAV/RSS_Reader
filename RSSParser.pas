unit RSSParser;

interface

uses
  RSSModel, System.SysUtils;

type
  ERSSParserException = class(Exception);

  IRSSParser = interface
    ['{631A4D28-8406-42A3-B285-5C89AB24D3D9}']
    function ParseRSSFeed(XML: string): TRSSFeed;
  end;

var
  DefaultRSSParser: IRSSParser = nil;

implementation

end.
