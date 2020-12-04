program RSSReaderTests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  TestHttpClient in 'TestHttpClient.pas',
  HttpClient in '..\HttpClient.pas',
  TestRSSParser in 'TestRSSParser.pas',
  TestRSSFeedModel in 'TestRSSFeedModel.pas',
  RSSModel in '..\RSSModel.pas',
  RSSParser in '..\RSSParser.pas',
  NetHttpClient in '..\NetHttpClient.pas',
  XmlDocRssParser in '..\XmlDocRssParser.pas',
  TestSyncManager in 'TestSyncManager.pas',
  SyncManager in '..\SyncManager.pas',
  UINotification in '..\UINotification.pas',
  FakeHttpClient in 'FakeHttpClient.pas',
  FakeRSSParser in 'FakeRSSParser.pas',
  FakeRSSStorage in 'FakeRSSStorage.pas',
  RSSStorage in '..\RSSStorage.pas',
  FakeUINotification in 'FakeUINotification.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

