unit SyncManager;

interface

procedure Sync(URL: string);

implementation

uses
  HttpClient, RssParser, RssModel, RssStorage, UINotification;

procedure Sync(URL: string);
var
  xml: string;
  feed: TRSSFeed;
  i: Integer;
begin
  xml := DefaultHttpClient.GetPageByURL(URL);
  feed := DefaultRSSParser.ParseRSSFeed(xml);
  for i := 0 to feed.Items.Count - 1 do
  begin
    DefaultRSSStorage.StoreItem(feed.Items[i]);
    DefaultUINotification.Notify(feed.Items[i]);
  end;
end;

end.
