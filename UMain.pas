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
    procedure insertTable(Sender : TObject);
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
    addTable: TButton;
    index: Integer;
    alreadyScrollTable: Integer;//garante que o scroll no local seja criado dinamicament uma vez
    tableList: TList;
    constructor create(Sender:TComponent);override;
    procedure insertTable(request: TLocal);
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

//======================== TABLE CLASS =========================================
type
  TTable = class(TShape)
    private
    { Private declarations }
  public
    { Public declarations }
     constructor create(Sender:TComponent);override;
  end;

//======================== VARIÁVEIS GLOBAIS ===================================
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


//======================== PROCEDURE ADD LOCAL  ================================
procedure TForm1.addLocalButtonClick(Sender: TObject);
var
  local: TLocal;
begin

  local:= TLocal.Create(localScrollBox);
  local.Parent:= localScrollBox;
  local.addTable:= TButton.Create(local);
  local.addTable.Parent:= local;
  local.addTable.Caption:= localNameEdit.Text;
  local.addTable.Top:= 15;
  local.addTable.Width:= local.Width;
  local.addTable.onClick:= insertTable;
  local.tableList:= TList.Create;

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

//======================== PROCEDURE INSERT LOCAL LIST =========================
procedure TRestaurant.insertLocalList(local: TLocal);
begin
  localList.Add(local);
end;


//======================== PROCEDURE FORM SHOW =================================
procedure TForm1.FormShow(Sender: TObject);
begin
  restaurant:= TRestaurant.Create;
  restaurant.localList:= TList.Create;

  localIndex:= 0;

  localTop:= 15;
  localSpace:= 15;

  tableTop:= 15;
  tableSpace:= 5;

  already:= 0;

  localNameEdit.Visible:= false;
  addLocalButton.Visible:= false;
end;

//======================== PROCEDURE NEW LOCAL BUTTON CLICK=====================
procedure TForm1.newLocalButtonClick(Sender: TObject);
begin
  localNameEdit.Visible:= true;
  addLocalButton.Visible:= true;
end;

{ TLocal }

//======================== TLOCAL CONSTRUCTOR ===============================
constructor TLocal.create(Sender: TComponent);
begin
   inherited;
  Height:= 185;
  Width:= 173;
  alreadyScrollTable:= 0;
end;

//======================== PROCEDURE INSERT TABLE ==============================
procedure TLocal.insertTable(request: TLocal);
var
  table: TTable;
  local: TLocal;
begin
  local:= restaurant.localList.Items[(request).index];
  if ( local.alreadyScrollTable = 0 ) then     //aqui vai ser a verificação itens de localList
   begin
      tableScrollBox:= TScrollBox.Create((request));
      tableScrollBox.Parent:= (request);
      tableScrollBox.HorzScrollBar.Visible:= false;
      tableScrollBox.Width:= (request).Width;
      tableScrollBox.Height:= (request).Height - 40;
      tableScrollBox.Top:= 40;

      restaurant.localList.Items[(request).index]:= local;
   end;

   table:= TTable.Create(tableScrollBox);
   table.Parent:= (tableScrollBox);

   //primeira inserção de table
   if(local.alreadyScrollTable = 0) then   //mesma comparação usada para um fim semelhante para a table
   begin
     table.Top:= tableTop;
      table.Left:= tableSpace;
      precedentTableTop:= table.Top;
      precedentTableLeft:= table.Left;

      local.alreadyScrollTable:= 1;
   end

  //IMPRIMI O PRIMEIRO ELEMENTO SHAPE DA LINHA ABAIXO
  else if ( (precedentTableLeft + table.Width + table.Left + tableSpace) >= ((tableScrollBox.Width) - 40) ) then
  begin
    table.Top:= precedentTableTop + table.Height + tableSpace;
    table.Left:= tableSpace;
    precedentTableTop:= table.Top;
    precedentTableLeft:= table.Left;
  end
  //IMPRIMI O ELEMENTO SHAPE NA MESMA LINHA
  else
  begin
    table.Top:= precedentTableTop;
    table.Left:= (precedentTableLeft + table.Width + tableSpace);
    precedentTableLeft:= table.Left;
    precedentTableTop:= table.Top;
  end;

  //inserindo a mesa na lista
   local.tableList.Add(table);


end;

//======================== PROCEDURE LOCAL NAME EDIT KEY DOWN ==================
procedure TForm1.localNameEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 13 then
  addLocalButton.Click;
end;

{ TTable }

//======================== TABLE CONSTRUCTOR==================
constructor TTable.create(Sender: TComponent);
begin
  inherited;
  width:= 33;
  height:= 33;
  brush.Color:= Rgb(76,255,85);
end;


//======================== PROCEDURE INSERT TABLE ==================
procedure TForm1.insertTable(Sender: TObject);
var
  local: TLocal;
begin
  local:= TLocal((Sender as TButton).Parent); //pegando o pai, o local selecionado
  local.insertTable(local);
end;

end.
