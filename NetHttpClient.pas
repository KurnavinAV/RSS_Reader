unit NetHttpClient;

interface

uses
  HttpClient, System.SysUtils;

type
  TOwnNetHttpClient = class(TInterfacedObject, IHttpClient)
  public
    function GetPageByURL(URL: string): string;
  end;

implementation

uses
  System.Net.HttpClientComponent, System.Classes;

{ TOwnNetHttpClient }

function TOwnNetHttpClient.GetPageByURL(URL: string): string;
var
  HTTPClient: TNetHTTPClient;
  stream: TStringStream;
begin
  HTTPClient := TNetHTTPClient.Create(nil);
  stream := TStringStream.Create(EmptyStr, TEncoding.UTF8);
  try
    try
      HTTPClient.Get(URL, stream);
    except
      on E: Exception do
        raise EHttpClientException.Create(E.Message);
    end;

    Result := stream.DataString;
  finally
    HTTPClient.Free;
    stream.Free;
  end;
end;

end.
