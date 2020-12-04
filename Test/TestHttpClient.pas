unit TestHttpClient;

interface

uses
  TestFramework, HttpClient, NetHttpClient;

type
  THttpClientTest = class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure GetContentByURL;
    procedure RaisesAnExceptionWhenServerIsDown;
  end;

implementation

{ THttpClientTest }

procedure THttpClientTest.GetContentByURL;
var
  response: string;
begin
  response := DefaultHttpClient.GetPageByURL('http://static.feed.rbc.ru/rbc/logical/footer/news.rss');
  CheckNotEquals(0, Pos('<rss', response), 'Response doesnt contain RSS feed');
end;

procedure THttpClientTest.RaisesAnExceptionWhenServerIsDown;
begin
  ExpectedException := EHttpClientException;
  DefaultHttpClient.GetPageByURL('http://127.0.0.1:9919/');
end;

procedure THttpClientTest.SetUp;
begin
  inherited;

  DefaultHttpClient := TOwnNetHttpClient.Create;
end;

procedure THttpClientTest.TearDown;
begin
  inherited;

  DefaultHttpClient := nil;
end;

initialization
  RegisterTest(THttpClientTest.Suite);

end.
