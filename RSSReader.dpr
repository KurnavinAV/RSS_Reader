program RSSReader;

uses
  FMX.Forms,
  FormMain in 'FormMain.pas' {fmMain},
  HttpClient in 'HttpClient.pas',
  RSSModel in 'RSSModel.pas',
  RSSParser in 'RSSParser.pas',
  NetHttpClient in 'NetHttpClient.pas',
  XmlDocRssParser in 'XmlDocRssParser.pas',
  RSSStorage in 'RSSStorage.pas',
  SyncManager in 'SyncManager.pas',
  UINotification in 'UINotification.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
