unit TestRSSFeedModel;

interface

uses
  TestFramework, RSSModel;

type
  TRSSFeedModelTest = class(TTestCase)
  private
    FFeed: TRSSFeed;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure HasDescription;
    procedure HasLink;
    procedure HasTitle;
    procedure HasZeroItemsInitialy;
    procedure CanBePopulatedWithSomeItems;
    procedure ItemsHaveSomeAttributes;
  end;

implementation

uses
  System.SysUtils;

{ TRSSFeedModelTest }

procedure TRSSFeedModelTest.CanBePopulatedWithSomeItems;
begin
  FFeed.AddItem;
  FFeed.AddItem;
  CheckEquals(2, FFeed.Items.Count);
end;

procedure TRSSFeedModelTest.HasDescription;

begin
  FFeed :=  TRSSFeed.Create;
  FFeed.Description := 'Some feed';
  CheckEquals('Some feed', FFeed.Description);
end;

procedure TRSSFeedModelTest.HasLink;
begin
  FFeed :=  TRSSFeed.Create;
  FFeed.Link := 'http://link';
  CheckEquals('http://link', FFeed.Link);
end;

procedure TRSSFeedModelTest.HasTitle;
begin
  FFeed :=  TRSSFeed.Create;
  FFeed.Title := 'Заголовок новости';
  CheckEquals('Заголовок новости', FFeed.Title);
end;

procedure TRSSFeedModelTest.HasZeroItemsInitialy;
begin
  CheckEquals(0, FFeed.Items.Count);
end;

procedure TRSSFeedModelTest.ItemsHaveSomeAttributes;
var
  someDay: TDate;
  rssItem: TRSSItem;
begin
  someDay := Now;
  with FFeed.AddItem do
  begin
    Title := 'Item title';
    Link := 'http://example.com/';
    Description := 'Some text';
    PubDate := someDay;
  end;

  rssItem := FFeed.Items[0];
  CheckEquals('Item title', RssItem.Title);
  CheckEquals('http://example.com/', RssItem.Link);
  CheckEquals('Some text', RssItem.Description);
  CheckEquals(someDay, RssItem.PubDate);
end;

procedure TRSSFeedModelTest.SetUp;
begin
  inherited;

  FFeed := TRSSFeed.Create;
end;

procedure TRSSFeedModelTest.TearDown;
begin
  inherited;

  FFeed.Free;
end;

initialization
  RegisterTest(TRSSFeedModelTest.Suite);

end.
