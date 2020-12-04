unit HttpClient;

interface

uses
  System.SysUtils;

const
  RSS_URL =
    'http://static.feed.rbc.ru/rbc/logical/footer/news.rss';

type
  EHttpClientException = class(Exception);

  IHttpClient = interface
    ['{B21BCBB7-ACD6-44BF-86B6-3E7CA6A24ACC}']
    function GetPageByURL(URL: string): string;
  end;

var
  DefaultHttpClient: IHttpClient = nil;

implementation

end.
