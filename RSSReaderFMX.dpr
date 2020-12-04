program RSSReaderFMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  FormNews in 'FormNews.pas' {fmNews},
  HttpClient in 'HttpClient.pas',
  NetHttpClient in 'NetHttpClient.pas',
  RSSModel in 'RSSModel.pas',
  RSSParser in 'RSSParser.pas',
  RSSStorage in 'RSSStorage.pas',
  SyncManager in 'SyncManager.pas',
  UINotification in 'UINotification.pas',
  XmlDocRssParser in 'XmlDocRssParser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmNews, fmNews);
  Application.Run;
end.
