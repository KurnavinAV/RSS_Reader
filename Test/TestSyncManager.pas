unit TestSyncManager;

interface

uses
  TestFramework, System.SysUtils,
  SyncManager, RssModel,
  HttpClient, FakeHttpClient,
  RssParser, FakeRSSParser,
  UINotification, FakeUINotification,
  RssStorage, FakeRSSStorage;

type
  TSyncManagerTest = class(TTestCase)
  private
    FRSSFeed: TRSSFeed;
    FFirstFeedItem: TRSSItem;
    FSecondFeedItem: TRSSItem;

    FFakeHttpClient: TFakeHttpClient;
    FFakeRSSParser: TFakeRSSParser;
    FFakeUINotification: TFakeUINotificationService;
    FFakeRSSStorage: TFakeRSSStorage;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure GetsAndStoresNewItemsWithNotification;
  end;

implementation

{ TSyncManagerTest }

procedure TSyncManagerTest.GetsAndStoresNewItemsWithNotification;
var
  storedItemsCount: Integer;
  notificationsCount: Integer;
begin
  // HttpClient will return some dummy XML
  FFakeHttpClient.OnGetPageByURL :=
    function (URL: string): string
    begin
      CheckEquals('http://static.feed.rbc.ru/rbc/logical/footer/news.rss', URL);
      Result := 'Some XML';
    end;

  // Parser should be called with that dummy XML
  FFakeRSSParser.OnParseRSSFeed :=
    function (XML: string): TRSSFeed
    begin
      CheckEquals('Some XML', XML);
      Result := FRSSFeed;
    end;

   // Storage should receive both items from RSS
  storedItemsCount := 0;
  FFakeRSSStorage.OnStoreItem :=
    procedure (Item: TRSSItem)
    begin
      Check((Item = FFirstFeedItem) or (Item = FSecondFeedItem), 'StoreItem() was called with unknown item');
      Inc(storedItemsCount);
    end;

    // Sync should call Notify function for each stored item
  FFakeUINotification.OnNotify :=
    procedure (Item: TRSSItem)
    begin
      Check((Item = FFirstFeedItem) or (Item = FSecondFeedItem),
        'Notify() was called with unknown item');
      Inc(notificationsCount);
    end;

  Sync('http://static.feed.rbc.ru/rbc/logical/footer/news.rss');
  CheckEquals(2, storedItemsCount, 'StoreItem should have been called 2 times');
  CheckEquals(2, notificationsCount, 'Notify should have been called 2 times');
end;

procedure TSyncManagerTest.SetUp;
begin
  inherited;

  FFakeHttpClient := TFakeHttpClient.Create;
  FFakeRSSParser := TFakeRSSParser.Create;
  FFakeUINotification := TFakeUINotificationService.Create;
  FFakeRSSStorage := TFakeRSSStorage.Create;

  DefaultHttpClient := FFakeHttpClient;
  DefaultRSSStorage := FFakeRSSStorage;
  DefaultRSSParser := FFakeRSSParser;
  DefaultUINotification := FFakeUINotification;

  // Construct test data
  FRSSFeed := TRSSFeed.Create;
  FFirstFeedItem := FRSSFeed.AddItem;
  FSecondFeedItem := FRSSFeed.AddItem;
end;

procedure TSyncManagerTest.TearDown;
begin
  inherited;

  DefaultHttpClient := nil;
  DefaultRSSStorage := nil;
  DefaultRSSParser := nil;
  DefaultUINotification := nil;
  FRSSFeed.Free;
end;

initialization
  RegisterTest(TSyncManagerTest.Suite);

end.
