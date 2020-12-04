unit TestRSSParser;

interface

uses
  TestFramework, RSSParser, XmlDocRssParser;

type
  TRSSParserTest = class(TTestCase)
  private
    FParser: TXmlDocParser;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure ParsesRSSDate;
    procedure ParsesRSSFeed;
    procedure RaisesAnExceptionWhenDateCantBeParsed;
    procedure RaisesAnExceptionIfRSSIsInvalid;
    procedure RaisesAnExceptionIfRSSIsEmpty;
  end;

implementation

uses
  System.SysUtils, System.IOUtils, System.StrUtils, RSSModel;


{ TRSSParserTest }

procedure TRSSParserTest.ParsesRSSDate;
var
  d: TDateTime;
begin
  d := FParser.ParseRSSDate('Mon, 06 Sep 2009 16:45:00 +0000');
  CheckEquals('2009-09-06 16:45:00', FormatDateTime('yyyy-mm-dd hh:nn:ss', d));
end;

procedure TRSSParserTest.ParsesRSSFeed;
var
  feedContent: string;
  rssFeed: TRSSFeed;
  rssItem: TRSSItem;
  testFileName: string;
begin
  feedContent := EmptyStr;
  testFileName := ExtractFilePath(ParamStr(0)) + 'feed.xml';

  feedContent := TFile.ReadAllText(testFileName, TEncoding.UTF8);
  rssFeed := FParser.ParseRSSFeed(feedContent);

  CheckEquals('rss.rbc.ru', rssFeed.Description);
  CheckEquals('https://www.rbc.ru/', rssFeed.Link);
  CheckEquals('РБК - Все материалы', rssFeed.Title);

  rssItem := rssFeed.Items[0];
  CheckTrue(ContainsText(rssItem.Description, 'власти затребовали средства'));
  CheckEquals('https://www.rbc.ru/finances/22/07/2019/5d35b51f9a7947961e118b41', rssItem.Link);
  CheckEquals('Минфин поручил вернуть деньги на ликвидацию паводка в Иркутской области', rssItem.Title);
end;

procedure TRSSParserTest.RaisesAnExceptionIfRSSIsEmpty;
begin
  ExpectedException := ERSSParserException;
  FParser.ParseRSSFeed('');
end;

procedure TRSSParserTest.RaisesAnExceptionIfRSSIsInvalid;
begin
  ExpectedException := ERSSParserException;
  FParser.ParseRSSFeed('MALFORMED XML');
end;

procedure TRSSParserTest.RaisesAnExceptionWhenDateCantBeParsed;
begin
  ExpectedException := ERSSParserException;
  FParser.ParseRSSDate('2011-01-02 12:34:45');
end;

procedure TRSSParserTest.SetUp;
begin
  inherited;

  FParser := TXmlDocParser.Create;
end;

procedure TRSSParserTest.TearDown;
begin
  inherited;

  FParser.Free;
end;

initialization
  RegisterTest(TRSSParserTest.Suite);

end.
