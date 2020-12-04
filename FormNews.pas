unit FormNews;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,
  FMX.Platform.Win,
  HttpClient, RSSParser, RSSModel, FMX.ListBox, FMX.Controls,
  System.IOUtils;

type
  TfmNews = class(TForm)
    lytRCC: TLayout;
    lytButtons: TLayout;
    btnLoadNews: TButton;
    lvRCC: TListView;
    TimerLoadRSS: TTimer;
    lytRssChoiñe: TLayout;
    cmxRssChoice: TComboBox;
    StyleBook: TStyleBook;
    procedure btnLoadNewsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvRCCItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure TimerLoadRSSTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FClient: IHttpClient;
    FParser: IRSSParser;

    procedure LoadNews(const ARSSUrl: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  end;

var
  fmNews: TfmNews;

implementation

uses
  NetHttpClient, XMLDocRssParser, ShellAPI, Winapi.Windows, FMX.Styles;

{$R *.fmx}

procedure TfmNews.btnLoadNewsClick(Sender: TObject);
begin
  LoadNews(cmxRssChoice.Items[cmxRssChoice.ItemIndex]);
end;

constructor TfmNews.Create(AOwner: TComponent);
begin
  inherited;

  FClient := TOwnNetHttpClient.Create;
  FParser := TXmlDocParser.Create;
end;

destructor TfmNews.Destroy;
begin
  FParser := nil;
  FClient := nil;

  inherited;
end;

procedure TfmNews.FormCreate(Sender: TObject);
begin
  // TStyleManager.SetStyleFromFile(TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'AquaGraphite.Style'));
end;

procedure TfmNews.FormShow(Sender: TObject);
begin
  LoadNews(cmxRssChoice.Items[cmxRssChoice.ItemIndex]);
end;

procedure TfmNews.LoadNews(const ARSSUrl: string);
var
  xml: string;
  feed: TRSSFeed;
  i: Integer;
  item: TListViewItem;
begin
  xml := FClient.GetPageByURL(ARSSUrl);
  feed := FParser.ParseRSSFeed(xml);
  try
    lvRCC.BeginUpdate;
    try
      lvRCC.Items.Clear;

      for i := 0 to feed.Items.Count - 1 do
      begin
        item := lvRCC.Items.Add;
        item.Text := DateTimeToStr(feed.Items[i].PubDate);
        item.Purpose := TListItemPurpose.Header;

        item := lvRCC.Items.Add;
        item.Objects.DrawableByName('Title').Data := feed.Items[i].Title;

        if not feed.Items[i].Description.IsEmpty then
          item.Objects.DrawableByName('Description').Data := feed.Items[i].Description;

        item.TagString := feed.Items[i].Link;
      end;
    finally
      lvRCC.EndUpdate;
    end;
  finally
    feed.DisposeOf;
  end;
end;

procedure TfmNews.lvRCCItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  ShellExecute(FormToHWND(Self), 'open', PChar(AItem.TagString), nil, nil, SW_NORMAL);
end;

procedure TfmNews.TimerLoadRSSTimer(Sender: TObject);
begin
  LoadNews(cmxRssChoice.Items[cmxRssChoice.ItemIndex]);
end;

end.
