unit UINotification;

interface

uses
  RssModel, SysUtils;

type
  IUINotificationService = interface
    ['{935ED2B8-4C4C-462B-83F0-D29ABDC92DD0}']
    procedure Notify(Item: TRSSItem);
    procedure NotifyError(E: Exception);
  end;

var
  DefaultUINotification: IUINotificationService = nil;

implementation

end.
