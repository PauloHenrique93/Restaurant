unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

//=========================== LOCAL CLASS ===================================
type
  TLocal = class(TGroupBox)

  private
    { Private declarations }
  public
    { Public declarations }
    constructor create(sender:TComponent);override;
    procedure insertTable(sender: TObject);

  end;

//========================== TFORM1 CLASS =================================
type
  TForm1 = class(TForm)
    restaurantPanel: TPanel;
    addLocalButton: TButton;
    localScrollBox: TScrollBox;
    localNameEdit: TEdit;
    Button1: TButton;
    procedure addLocalButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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

//======================== TABLE CLASS ======================================
type
  TTable = class(TShape)
    private
    { Private declarations }
  public
    { Public declarations }
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

  local:= TLocal.Create(localScrollBox);
  local.Parent:= localScrollBox;
  local.Caption:= localNameEdit.Text;
  //local.OnClick:= insertTable();

  if (already = 0) then
  begin
    local.Top:= 15;
    local.Left:= 15;
    precedentLocalTop:= local.Top;
    precedentLocalLeft:= local.Left;

    already:= 1;
  end

  else if ( (precedentLocalLeft + local.Width + local.Left + 15) >= ((localScrollBox.Width) - 30) ) then
  begin
    local.Top:= precedentLocalTop + local.Height;
    local.Left:= 15;
    precedentLocalTop:= local.Top;
    precedentLocalLeft:= local.Left;
  end

  else
  begin
    local.Top:= precedentLocalTop;
    local.Left:= (precedentLocalLeft + local.Width + 15);
    precedentLocalLeft:= local.Left;
    precedentLocalTop:= local.Top;
  end;

  //reseta as propriedades de adicionar local
  localNameEdit.Visible:= false;
  addLocalButton.Visible:= false;
  localNameEdit.Text:= '';

end;

procedure TRestaurant.insertLocalList();
begin
end;



procedure TForm1.FormShow(Sender: TObject);
begin
  already:= 0;
  localNameEdit.Visible:= false;
  addLocalButton.Visible:= false;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  localNameEdit.Visible:= true;
  addLocalButton.Visible:= true;
end;

{ TLocal }




constructor TLocal.create(sender: TComponent);
begin
   inherited;
  Height:= 185;
  Width:= 169;
end;


procedure TLocal.insertTable(sender: TObject);
begin
//
end;

end.
