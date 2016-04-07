unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

//========================== TFORM1 CLASS =================================
type
  TForm1 = class(TForm)
    restaurantPanel: TPanel;
    addLocalButton: TButton;
    procedure addLocalButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
//=========================== LOCAL CLASS ===================================
type
  TLocal = class(TGroupBox)

  private
    { Private declarations }
  public
    { Public declarations }

  end;
//========================= RESTAURANT CLASS =================================
type
  TRestaurant = class

  private
    { Private declarations }
  public
    { Public declarations }
    localList: array[1..100] of TLocal;
    procedure insertLocalList();
  end;
var
  Form1: TForm1;
  already: Integer;
  precedentLocalTop: Integer;
  precedentLocalLeft: Integer;

implementation

{$R *.dfm}

procedure TForm1.addLocalButtonClick(Sender: TObject);
var
  local: TLocal;
begin
  local:= TLocal.Create(restaurantPanel);
  local.Parent:= restaurantPanel;
  local.Caption:= 'titulo';
  local.Height:= 185;
  local.Width:= 169;

  if (already = 0) then
  begin
    local.Top:= 15;
    local.Left:= 10;
    precedentLocalTop:= local.Top;
    precedentLocalLeft:= local.Left;

    already:= 1;
  end

  else if ( (precedentLocalLeft + local.Width + local.Left + 10) >= ((restaurantPanel.Width) - 30) ) then
  begin
    local.Top:= precedentLocalTop + local.Height;
    local.Left:= 10;
    precedentLocalTop:= local.Top;
    precedentLocalLeft:= local.Left;
  end

  else
  begin
    local.Top:= precedentLocalTop;
    local.Left:= (precedentLocalLeft + local.Width + 10);
    precedentLocalLeft:= local.Left;
    precedentLocalTop:= local.Top;
  end;

end;

procedure TRestaurant.insertLocalList();
begin
end;



procedure TForm1.FormShow(Sender: TObject);
begin
  already:= 0;
end;

end.
