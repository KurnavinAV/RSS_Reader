unit RSSStorage;

interface

uses
  RSSModel;

type
  IRSSStorage = interface
    ['{2DE096E0-5A66-45A8-A43A-F4A3F5612485}']
    procedure StoreItem(Item: TRSSItem);
  end;

var
  DefaultRSSStorage: IRSSStorage = nil;

implementation

end.
