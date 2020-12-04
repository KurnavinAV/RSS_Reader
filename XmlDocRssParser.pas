unit XmlDocRssParser;

interface

uses
  RSSParser, RSSModel;

type
  TXmlDocParser = class(TInterfacedObject, IRSSParser)
  public
    function ParseRSSDate(DateStr: string): TDateTime;
    function ParseRSSFeed(XML: string): TRSSFeed;
  end;

implementation

uses
  XMLIntf, XMLDoc, System.SysUtils;

function FetchNextToken(var s: string; space: string = ' '): string;
var
  spacePos: Integer;
begin
  spacePos := Pos(space, s);
  if spacePos = 0 then
  begin
    Result := s;
    s := '';
  end
  else
  begin
    Result := Copy(s, 1, spacePos - 1);
    Delete(s, 1, spacePos);
  end;
end;

function MonthToInt(MonthStr: string): Integer;
const
  Months: array [1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul',
    'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
var
  m: Integer;
begin
  for m := 1 to 12 do
    if Months[m] = MonthStr then
      Exit(m);
  raise ERSSParserException.CreateFmt('Unknown month: %s', [MonthStr]);
end;

{ TXmlDocParser }

function TXmlDocParser.ParseRSSDate(DateStr: string): TDateTime;
var
  day, month, year, hour, minute, second: Integer;
begin
  try
    FetchNextToken(DateStr);                          // Ignore "Mon, "
    Day := StrToInt(FetchNextToken(DateStr));         // "06"
    Month := MonthToInt(FetchNextToken(DateStr));     // "Sep"
    Year := StrToInt(FetchNextToken(DateStr));        // "2009"
    Hour := StrToInt(FetchNextToken(DateStr, ':'));   // "16"
    Minute := StrToInt(FetchNextToken(DateStr, ':')); // "45"
    Second := StrToInt(FetchNextToken(DateStr));      // "00"
    Result := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Minute, Second, 0);
  except
    on E: Exception do
      raise ERSSParserException.CreateFmt('Can''t parse date "%s": %s', [DateStr, E.Message]);
  end;
end;

function TXmlDocParser.ParseRSSFeed(XML: string): TRSSFeed;
var
  doc: IXMLDocument;
  channelNode, node: IXMLNode;
  rssItem: TRSSItem;
begin
  Result := nil;

  try
    doc := LoadXMLData(XML);
    doc.Active;
    channelNode := doc.DocumentElement.ChildNodes.First;

    Result := TRSSFeed.Create;

    node := channelNode.ChildNodes.First;
    while node <> nil do
    begin
      if node.NamespaceURI.IsEmpty then
      begin
        if node.NodeName = 'title' then
          Result.Title := Node.Text
        else
        if node.NodeName = 'link' then
          Result.Link := Node.Text
        else
        if node.NodeName = 'description' then
          Result.Description := Node.Text
        else
        if node.NodeName = 'item' then
        begin
          rssItem := Result.AddItem;
          rssItem.Title := Node.ChildNodes['title'].Text;
          rssItem.Link := Node.ChildNodes['link'].Text;
          rssItem.Description := Node.ChildNodes['description'].Text;
          rssItem.PubDate := ParseRSSDate(Node.ChildNodes['pubDate'].Text);
        end;
      end;

      node := node.NextSibling;
    end;
  except
    on E: Exception do
    begin
      if Result <> nil then
        Result.Free;
      raise ERSSParserException.CreateFmt('Failed to parse RSS: %s', [E.Message]);
    end;
  end;
end;

end.
