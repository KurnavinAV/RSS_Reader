unit RSSModel;

interface

uses
  Generics.Collections;

type
  TRSSItem = class
  private
    FPubDate: TDate;
    FLink: string;
    FTitle: string;
    FDescription: string;
  public
    property Title: string read FTitle write FTitle;
    property Link: string read FLink write FLink;
    property Description: string read FDescription write FDescription;
    property PubDate: TDate read FPubDate write FPubDate;
  end;

  TRSSFeed = class
  private
    FDescription: string;
    FLink: string;
    FTitle: string;
    FItems: TObjectList<TRSSItem>;
  public
    constructor Create;
    destructor Destroy; override;

    function AddItem: TRSSItem;

    property Description: string read FDescription write FDescription;
    property Link: string read FLink write FLink;
    property Title: string read FTitle write FTitle;
    property Items: TObjectList<TRSSItem> read FItems;
  end;

implementation

{ TRSSFeed }

function TRSSFeed.AddItem: TRSSItem;
begin
  Result := TRSSItem.Create;
  FItems.Add(Result);
end;

constructor TRSSFeed.Create;
begin
  FItems := TObjectList<TRSSItem>.Create;
end;

destructor TRSSFeed.Destroy;
begin
  FItems.Free;

  inherited;
end;

end.
