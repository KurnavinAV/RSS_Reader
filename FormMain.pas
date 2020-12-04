unit FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  HttpClient, RSSParser, RSSModel;

type
  TfmMain = class(TForm)
    pnlRCC: TPanel;
    pnlButtons: TPanel;
    btnShowNews: TBitBtn;
    lvRCC: TListView;

    procedure btnShowNewsClick(Sender: TObject);
  private
    FClient: IHttpClient;
    FParser: IRSSParser;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  fmMain: TfmMain;

implementation

uses
  NetHttpClient, XMLDocRssParser;

{$R *.dfm}

procedure TfmMain.btnShowNewsClick(Sender: TObject);
var
  xml: string;
  feed: TRSSFeed;
  i: Integer;
  listItem: TListItem;
begin
  xml := FClient.GetPageByURL(RSS_URL);
  feed := FParser.ParseRSSFeed(xml);

  for i := 0 to feed.Items.Count - 1 do
  begin
    lvRCC.Items.BeginUpdate;
    try
      listItem := lvRCC.Items.Add;

      listItem.Caption :=
        DateToStr(feed.Items[i].PubDate) + sLineBreak +
        feed.Items[i].Title + sLineBreak +
        feed.Items[i].Description;
    finally
      lvRCC.Items.EndUpdate;
    end;
  end;
end;

constructor TfmMain.Create(AOwner: TComponent);
begin
  inherited;

  FClient := TOwnNetHttpClient.Create;
  FParser := TXmlDocParser.Create;
end;

destructor TfmMain.Destroy;
begin
  FParser := nil;
  FClient := nil;

  inherited;
end;

end.
