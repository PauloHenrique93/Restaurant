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
    localScrollBox: TScrollBox;
    localNameEdit: TEdit;
    newLocalButton: TButton;
    procedure addLocalButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure newLocalButtonClick(Sender: TObject);
    procedure localNameEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
    tableScrollBox: TScrollBox;
    index: Integer;
    alreadyScrollTable: Integer;//garante que o scroll no local seja criado dinamicament uma vez
    procedure insertTable(Sender: TObject);
    constructor create(Sender:TComponent);override;
  end;


//========================= RESTAURANT CLASS =================================
type
  TRestaurant = class

  private
    { Private declarations }
  public
    { Public declarations }
    localList: TList;
    procedure insertLocalList(local: TLocal);
  end;

//======================== TABLE CLASS ======================================
type
  TTable = class(TShape)
    private
    { Private declarations }
  public
    { Public declarations }
     constructor create(Sender:TComponent);override;
  end;

var
  Form1: TForm1;
  restaurant: TRestaurant;
  already: Integer;

  localTop: Integer;
  localSpace: Integer;

  tableTop: Integer;
  tableSpace: Integer;

  precedentLocalTop: Integer;
  precedentLocalLeft: Integer;

  precedentTableTop: Integer;
  precedentTableLeft: Integer;
  localIndex: Integer;

implementation

{$R *.dfm}

procedure TForm1.addLocalButtonClick(Sender: TObject);
var
  local: TLocal;
begin

  local:= TLocal.Create(localScrollBox);
  local.Parent:= localScrollBox;
  local.Caption:= localNameEdit.Text;
  local.OnClick:= local.insertTable;

  //IMPRIMI O PRIMEIRO ELEMENTO GROUPBOX INSERIDO
  if (already = 0) then
  begin

    local.Top:= localTop;
    local.Left:= localSpace;
    precedentLocalTop:= local.Top;
    precedentLocalLeft:= local.Left;

    already:= 1;
  end

  //IMPRIMI O PRIMEIRO ELEMENTO BROUPBOX DA LINHA ABAIXO
  else if ( (precedentLocalLeft + local.Width + local.Left + localSpace) >= ((localScrollBox.Width) - 30) ) then
  begin
    local.Top:= precedentLocalTop + local.Height;
    local.Left:= localSpace;
    precedentLocalTop:= local.Top;
    precedentLocalLeft:= local.Left;
  end
  //IMPRIMI O ELEMENTO GROUPBOX NA MESMA LINHA
  else
  begin
    local.Top:= precedentLocalTop;
    local.Left:= (precedentLocalLeft + local.Width + localSpace);
    precedentLocalLeft:= local.Left;
    precedentLocalTop:= local.Top;
  end;

  //--
  local.index:= localIndex;
  inc(localIndex);
  local.alreadyScrollTable:= 0;
  restaurant.insertLocalList(local);

  //reseta as propriedades de adicionar local
  localNameEdit.Visible:= false;
  addLocalButton.Visible:= false;
  localNameEdit.Clear;

end;

procedure TRestaurant.insertLocalList(local: TLocal);
begin
  localList.Add(local);
end;



procedure TForm1.FormShow(Sender: TObject);
begin
  restaurant:= TRestaurant.Create;
  restaurant.localList:= TList.Create;
  localIndex:= 0;

  localTop:= 15;
  localSpace:= 15;

  tableTop:= 15;
  tableSpace:= 15;

  already:= 0;

  localNameEdit.Visible:= false;
  addLocalButton.Visible:= false;
end;


procedure TForm1.newLocalButtonClick(Sender: TObject);
begin
  localNameEdit.Visible:= true;
  addLocalButton.Visible:= true;
end;

{ TLocal }

constructor TLocal.create(Sender: TComponent);
begin
   inherited;
  Height:= 185;
  Width:= 169;
  alreadyScrollTable:= 0;
end;

//PAREI AQUI !!!!!!!!!!!!!!!!  resolver o problema de acesso ao atributo alreadyScrolllocal
procedure TLocal.insertTable(Sender: TObject);
var
  table: TTable;
  local: TLocal;
begin
  local:= restaurant.localList.Items[(Sender as TLocal).index];
  if ( local.alreadyScrollTable = 0 ) then     //aqui vai ser a verificação itens de localList
   begin
      tableScrollBox:= TScrollBox.Create((Sender as TGroupbox));
      tableScrollBox.Parent:= (Sender as TGroupbox);
      tableScrollBox.Width:= (Sender as TGroupbox).Width;
      tableScrollBox.Height:= (Sender as TGroupbox).Height;

      local.alreadyScrollTable:= 1;
      restaurant.localList.Items[(Sender as TLocal).index]:= local;
   end;

   table:= TTable.Create(tableScrollBox);
   table.Parent:= (tableScrollBox);

end;

procedure TForm1.localNameEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  addLocalButton.Click;
end;

{ TTable }

constructor TTable.create(Sender: TComponent);
begin
  inherited;
  width:= 40;
  height:= 40;
  brush.Color:= Rgb(76,255,85);
end;

end.
