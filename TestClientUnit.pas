﻿unit TestClientUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.Menus, Data.DB, System.JSON,
  Vcl.Grids, Vcl.ExtCtrls ;

type
  TTestClientForm = class(TForm)
    ResponseMemo: TMemo;
    HTTP: TIdHTTP;
    RequestMemo: TMemo;
    MainMenu1: TMainMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    id1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    StringGrid2: TStringGrid;
   // procedure SendButtonClick(Sender: TObject);
    function URLOut(sender:TObject;url:string;massage:string):string;
    procedure Menu(Sender: TObject);
    procedure MenuOrders(Sender:TObject);
    procedure Timer(Sender:TObject);

    procedure loginPassword(Sender: TObject);

    procedure TableClear(Sender:TObject;Table:TStringGrid);

    procedure couriersAdd(Sender: TObject);
    function  couriersId(Sender: TObject;id:string):TJSONObject;
    function  couriersList(Sender: TObject):TJSONObject;
    procedure couriersDelete(Sender: TObject;id:string);
    procedure couriersUpdate(sender:Tobject;id:string);
    procedure couriersOR(Sender:TObject;id :string);

    function  operatorsList(sender:Tobject):TJSONObject;
    function  operatorId(Sender: TObject):TJSONObject;
    procedure operatorAdd(Sender:TObject);
    procedure operatorUpdate(Sender:TObject);
    procedure operatorDelete(Sender:TObject);

    function  ordersList(Sender: TObject):TJSONObject;
    function  ordersId(Sender: TObject):TJSONObject;
    procedure ordersAdd(Sender:TObject);
    procedure ordersDelete(Sender:TObject;id:string);
    procedure ordersUpdate(Sender:TObject;id:string);
    procedure ordersOR(Sender:TObject;id:string);

    function  ordersInfoList(Sender:TObject):TJSONObject;
    function  ordersInfoId (Sender:TObject):TJSONObject;
    procedure ordersInfoAdd (Sender:TObject);
    procedure ordersInfoDelete(Sender:TObject);

    procedure StringGrid1Click(Sender: TObject);
    procedure RequestMemoDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure RequestMemoDragDrop(Sender, Source: TObject; X, Y: Integer);
    {procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean); }
    procedure StringGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    //procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
    //  Rect: TRect; State: TGridDrawState);



  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestClientForm: TTestClientForm;

implementation

{$R *.dfm}
  uses unit1,unit2,unit3,unit4,unit5,unit6,unit7;

  //help

procedure TTestClientForm.loginPassword(Sender: TObject);
var login,password,url:string;
var JsonObject: TJSONObject;
begin

    login:= form7.Edit1.Text;
    password:=form7.Edit2.Text;
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('login', login)
        .AddPair('pass',password);
    url:='/operators/login/';
    login:=URLOut(Sender,url, JsonObject.ToString());
    RequestMemo.Lines.Add(login);
    
end;

  procedure TTestClientForm.TableClear(Sender: TObject;Table:TStringGrid);
var i:integer;
begin
  with Table do
  for i:=0 to ColCount-1 do begin
    Table.RowHeights[I]:=24;
    Table.ColWidths[0]:= 0;
    Table.ColWidths[1]:=64;
    Cols[i].Clear;
  end;
end;

 procedure TTestClientForm.Timer(Sender: TObject);
begin
     Menu(Sender);
     MenuOrders(Sender);
end;

//меню
 procedure TTestClientForm.Menu(Sender: TObject);
 var JSON1,JSON2:TJSONObject;
 var I,K:integer;
 var JSONA1,JSONA2: TJSONArray;
 var url,massage:string;
 var mas:array[0..4] of string[30];
begin
    TableClear(Sender,StringGrid1);
    StringGrid1.Cells[1,0]:= 'Курьеры';
    StringGrid1.Cells[2,0]:= 'Заказы курьеров:';
    JSON1:= couriersList(Sender);
    JSON2:= ordersList(Sender);
    url:='/couriers/list/';
    massage:=URLOut(Sender,url,JSON1.ToString());
    JSONA1:= TJSONObject.ParseJSONValue(massage) as TJSONArray;
    url:= '/orders/list/';
    massage:=URLOut(Sender,url,JSON2.ToString());
    JSONA2:= TJSONObject.ParseJSONValue(massage) as TJSONArray;

    for I := 0 to JSONA1.Size() - 1 do begin
      StringGrid1.RowHeights[I+1]:=100;
      StringGrid1.ColWidths[1]:= 150;
      JSON1:= JSONA1[I] as TJSONObject;
      mas[0]:= JSON1.Values['id'].Value;
      mas[1]:= JSON1.Values['name'].Value;
      for K := 0 to JSONA2.Size() - 1 do begin
        JSON2:= JSONA2[K] as TJSONObject;
        mas[2]:= JSON2.Values['courierid'].value;
          if mas[2] = mas[0] then begin
          StringGrid1.ColWidths[K+1]:= 150;
          mas[3]:=JSON2.Values['id'].value;
          mas[4]:=JSON2.Values['operatorid'].value;
          StringGrid1.Cells[K + 1,I+1]:= 'id ' + mas[3] + ' operatorid ' +  mas[4];
        end;
      end;
      StringGrid1.Cells[1,I+1]:= 'id ' + mas[0] + ' Имя ' +  mas[1];
    end;

    


end;

procedure TTestClientForm.MenuOrders(Sender: TObject);
var JSON:TJSONObject;
 var I:integer;
 var JSONA: TJSONArray;
 var id,url,massage,massage1,massage2:string;
begin
    TableClear(Sender,StringGrid2);
    StringGrid2.Cells[1,0]:= 'Заказы';
    JSON:= ordersList(Sender);
    url:='/orders/list/';
    massage:=URLOut(Sender,url,JSON.ToString());
    JSONA:= TJSONObject.ParseJSONValue(massage) as TJSONArray;

    for I := 0 to JSONA.Size() - 1 do begin
     StringGrid2.RowHeights[I+1]:=100;
     StringGrid2.ColWidths[1]:= 250;
     JSON:=JSONA[I] as TJSONObject;
     id:=JSON.Values['id'].Value;
     massage1:=JSON.Values['courierid'].Value;
     massage2:=JSON.Values['operatorid'].Value;
     StringGrid2.Cells[1,I+1]:='id ' + id + ' id курьера ' +  massage1
       + ' id оператора ' + massage2;
    end;
end;

{procedure TTestClientForm.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var ST:integer;
var JSON:TJSONObject;
var I:integer;
var JSONA: TJSONArray;
var url,massage:string;
begin
    TableClear(Sender);
    StringGrid1.Cells[0,0]:= 'Курьеры';
    JSON:= couriersList(Sender);
    url:='/couriers/list/';
    massage:=URLOut(Sender,url,JSON.ToString());
    JSONA:= TJSONObject.ParseJSONValue(massage) as TJSONArray;


    for I := 0 to JSONA.Size() - 1 do begin
    JSON:=JSONA[I] as TJSONObject;
    url:=JSON.Values['availability'].Value;
    ST:=url.ToInteger();
    if (ST = 0) and (ACol = 0) and (ARow = I) then StringGrid1.Canvas.Brush.Color:=clRed;
    if (ST = 1) and (ACol = 0) and (ARow = I) then StringGrid1.Canvas.Brush.Color:=clGreen;
    StringGrid1.Canvas.FillRect(Rect);
    end;

end; }

//курьеры
function TTestClientForm.couriersId(Sender: TObject;id:string):TJSONObject;



    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', id);
    couriersId:= JsonObject;
end;

procedure TTestClientForm.couriersAdd(Sender: TObject);




    Form1.ShowModal();
    massage[0]:= form1.edit1.text;
    massage[1]:= form1.edit2.text;
    massage[2]:= form1.edit3.text;
    massage[3]:= form1.edit4.text;
    massage[4]:='0';
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('name', massage[0])
          .AddPair('availability',massage[4])
          .AddPair('login', massage[1])
          .AddPair('password', massage[2])
          .AddPair('token', massage[3]);
    url:= '/couriers/add/';
    URLOut(Sender,url,JsonObject.ToString());
end;

procedure TTestClientForm.couriersDelete(Sender: TObject; id:String);



    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', id);
    url:= '/couriers/delete/';
    URLOut(Sender,url,JsonObject.ToString());
end;



function TTestClientForm.couriersList(Sender: TObject):TJSONObject;
var JsonObject: TJSONObject;
begin
    JsonObject:= TJSONObject.Create;
    //URLOut(Sender,url,JsonObject.ToString());
    couriersList:= JsonObject;
end;

procedure TTestClientForm.couriersOR(Sender: TObject;id:string);
var A,B:boolean;
begin
    form6.showModal();
     A:=form6.RadioButton1.Checked;
     B:=form6.RadioButton2.Checked;
     if A and not(B) then couriersDelete(Sender,id);
     if not(A) and B then couriersUpdate(Sender,id);
end;

procedure TTestClientForm.couriersUpdate(sender: Tobject;id:string);
var url:string;
var massage:array[0..4] of string[30];
var JsonObject: TJSONObject;

    Form1.ShowModal();
    massage[0]:= form1.edit1.text;
    massage[1]:= form1.edit2.text;
    massage[2]:= form1.edit3.text;
    massage[3]:= form1.edit4.text;
    massage[4]:='0';
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id',id)
          .AddPair('name', massage[0])
          .AddPair('availability',massage[4])
          .AddPair('login', massage[1])
          .AddPair('password', massage[2])
          .AddPair('token', massage[3]);
    url:= '/couriers/update/';
    URLOut(Sender,url,JsonObject.ToString());
end;



//операторы


procedure TTestClientForm.operatorAdd(Sender: TObject);
var url:string;
var massage:array[0..3] of string[30];

begin
     form3.showModal();
     massage[0]:=form3.edit1.Text;
     massage[1]:=form3.edit2.Text;
     massage[2]:=form3.edit3.Text;
     JsonObject:= TJSONObject.Create;
     JsonObject.AddPair('name', massage[0])
          .AddPair('login', massage[1])
          .AddPair('password', massage[2]);
     url:='/operators/add/';
     URLOut(Sender,url,JsonObject.ToString());

end;

procedure TTestClientForm.operatorDelete(Sender: TObject);
var url, massage:string;
var JsonObject: TJSONObject;

    form2.showModal();
    massage:= form2.edit1.text;
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', massage);
    url:= '/operators/delete/';
    URLOut(Sender,url,JsonObject.ToString());
end;

function TTestClientForm.operatorId(Sender: TObject):TJSONObject;
var massage:string;
var JsonObject: TJSONObject;

    form2.showModal();
    massage:= form2.edit1.text;
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', massage);
    //URLOut(Sender,url,JsonObject.ToString());
    operatorId:=Jsonobject;
end;

function TTestClientForm.operatorsList(sender: Tobject):TJSONObject;
var JsonObject: TJSONObject;
begin
    JsonObject:= TJSONObject.Create;
    //URLOut(Sender,url,JsonObject.ToString());
    operatorsList:=JsonObject;
end;

procedure TTestClientForm.operatorUpdate(Sender: TObject);
var url,id:string;
var massage:array[0..3] of string[30];

begin
     Form2.ShowModal();
     id:=form2.edit1.text;
     form3.showModal();
     massage[0]:=form3.edit1.Text;
     massage[1]:=form3.edit2.Text;
     massage[2]:=form3.edit3.Text;
     JsonObject:= TJSONObject.Create;
     JsonObject.AddPair('id', id)
          .AddPair('name', massage[0])
          .AddPair('login', massage[1])
          .AddPair('password', massage[2]);
     url:='/operators/update/';
     URLOut(Sender,url,JsonObject.ToString());
end;


//orders

procedure TTestClientForm.ordersAdd(Sender: TObject);
var url:string;
var massage:array[0..3] of string[30];

begin
     form4.showModal();
     massage[0]:=form4.edit1.Text;
     massage[1]:=form4.edit2.Text;
     //massage[2]:=form4.edit3.Text;
     massage[3]:=form4.edit4.Text;
     JsonObject:= TJSONObject.Create;
     JsonObject.AddPair('courierid', massage[0])
          .AddPair('operatorid', massage[1])
          //.AddPair('total_summ', massage[2])
          .AddPair('delivery_address',massage[3]);
     url:='/orders/add/';
     URLOut(Sender,url,JsonObject.ToString());

end;

procedure TTestClientForm.ordersDelete(Sender: TObject;id:string);
var url:string;
var JsonObject:TJSONObject;
begin
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', id);
    url:= '/orders/delete/';
    URLOut(Sender,url,JsonObject.ToString());
end;

function TTestClientForm.ordersId(Sender: TObject): TJSONObject;
var massage:string;
var JsonObject: TJSONObject;

    form2.showModal();
    massage:= form2.edit1.text;
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', massage);
    ordersId:= JsonObject;
end;



function TTestClientForm.ordersList(Sender: TObject):TJSONObject;
var JsonObject: TJSONObject;
begin
    JsonObject:= TJSONObject.Create;
    //URLOut(Sender,url,JsonObject.ToString());
    ordersList:=JsonObject;
end;


procedure TTestClientForm.ordersOR(Sender: TObject; id: string);
var A,B:boolean;
begin
    form6.showModal();
     A:=form6.RadioButton1.Checked;
     B:=form6.RadioButton2.Checked;
     if A and not(B) then ordersDelete(Sender,id);
     if not(A) and B then ordersUpdate(Sender,id);
end;

procedure TTestClientForm.ordersUpdate(Sender: TObject;id:string);
var url:string;
var massage:array[0..4] of string[30];

begin
     form4.showModal();
     massage[0]:=form4.edit1.Text;
     massage[1]:=form4.edit2.Text;
     massage[2]:=form4.edit3.Text;
     massage[3]:=form4.edit4.text;
     JsonObject:= TJSONObject.Create;
     JsonObject.AddPair('id', id)
          .AddPair('courierid', massage[0])
          .AddPair('operatorid', massage[1])
          .AddPair('total_summ', massage[2])
          .AddPair('delivery_address',massage[3]);
     url:='/orders/update/';
     URLOut(Sender,url,JsonObject.ToString());
end;


// orders-info



procedure TTestClientForm.ordersInfoAdd(Sender: TObject);
var url:string;
var massage:array[0..3] of string[30];
var JsonObject:TJSONObject;
begin
   form5.ShowModal();
   massage[0]:= form5.edit1.Text;
   massage[1]:= form5.edit2.Text;
   massage[2]:= form5.edit3.Text;
   massage[3]:= form5.edit4.Text;
   JsonObject:= TJSONObject.Create;
   JsonObject.AddPair('order_id', massage[0])
      .AddPair('name',massage[1])
      .AddPair('price',massage[2])
      .AddPair('count',massage[3]);
   url:='/oreders-info/add/';
   URLOut(Sender,url,JsonObject.ToString());

end;

procedure TTestClientForm.ordersInfoDelete(Sender: TObject);
var massage,url:string;
var JsonObject:TJSONObject;
begin
    form2.showModal();
    massage:= form2.edit1.text;
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', massage);
    url:= '/orders-info/delete/';
    URLOut(Sender,url,JsonObject.ToString());
end;



function TTestClientForm.ordersInfoId(Sender: TObject): TJSONObject;
var JsonObject: TJSONObject;
var massage:string;
begin
    form2.showModal();
    massage:= form2.edit1.text;
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', massage);
    ordersInfoId:= JsonObject;
end;

function TTestClientForm.ordersInfoList(Sender: TObject): TJSONObject;
var JsonObject: TJSONObject;
var massage:string;
begin
    form2.showModal();
    massage:= form2.edit1.text;
    JsonObject:= TJSONObject.Create;
    JsonObject.AddPair('id', massage);
    ordersInfoList:= JsonObject;
end;

{procedure TTestClientForm.StringGrid1Click(Sender: TObject);

end;

{procedure TTestClientForm.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin

end;

procedure TTestClientForm.StringGrid1Click(Sender: TObject);
begin

end;

procedure TTestClientForm.N8Click(Sender: TObject);
begin

end;

procedure TTestClientForm.N7Click(Sender: TObject);
begin

end;

procedure TTestClientForm.SendButtonClick(Sender: TObject);
var
  request : TStringStream;
  response : string;
  url : string;
begin
  HTTP.Request.ContentType := 'application/json';
  HTTP.Request.CharSet := 'utf-8';

  url := 'http://' + IPAddressEdit.Text + ':' + PortEdit.Text + URLEdit.Text;

  request := TStringStream.Create(UTF8Encode(RequestMemo.Lines.Text));

  try
    response := HTTP.Post(url, request);
  except
    ResponseMemo.Lines.Add('Не удалось подключится к серверу');
    exit;
  end;

  ResponseMemo.Lines.Text := '';
  ResponseMemo.Lines.Add(response);
end;  }

function TTestClientForm.URLOut(sender: TObject; url: string; massage:string):string;
var
  request : TStringStream;
  response : string;
  urlO:string;
begin
 //loginPassword(Sender);
  HTTP.Request.ContentType := 'application/json';
  HTTP.Request.CharSet := 'utf-8';

  urlO := 'http://' + '127.0.0.1' + ':' + '80' + url;

  request := TStringStream.Create(UTF8Encode(massage));

  try
    response := HTTP.Post(urlO, request);
  except

    ResponseMemo.Lines.Add('Не удалось подключится к серверу');
    exit;
  end;

  ResponseMemo.Lines.Text := '';
  ResponseMemo.Lines.Add(response);
  URLout:=response;
   end;

//drag and drop
procedure TTestClientForm.RequestMemoDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var i : integer;
begin
RequestMemo.clear();
with StringGrid1 do
for i:= 0 to (ColCount - 1) do
begin
RequestMemo.Lines.Add(StringGrid1.Cells[0,i]);
 end;
end;


procedure TTestClientForm.RequestMemoDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
     Accept:= Source IS TStringGrid;
end;

procedure TTestClientForm.StringGrid1Click(Sender: TObject);
var I:integer;
begin
StringGrid1.BeginDrag(True);

end;

procedure TTestClientForm.StringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var massage:string;
  var id:string;
  var ACol, ARow: integer;

  function mI(var s1:string):string;
  var a,i1:integer;
  var s:string;
  begin
  s:=s1;
  i1:=1;
  while s[i1]<>'И' do begin
     if s[i1] = 'd' then a:=i1+2;
     i1:=i1+1;
  end;
  s:=copy(s,a,i1-a);
  val(s,a,i1);
  str(a,s);
  mI:=s;
  end;


begin
   StringGrid1.MouseToCell(X, Y, ACol, ARow);
   massage := StringGrid1.Cells[ACol,ARow];
   if Acol = 1 then if massage = '' then couriersAdd(sender) else begin id:= mI(massage);couriersOR(sender,id); end
   else ;

   RequestMemo.Lines.Add(id);
   RequestMemo.Lines.Add(massage);
   end;

procedure TTestClientForm.StringGrid2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var massage:string;
  var id:string;
  var ACol, ARow: integer;

  function mI(var s1:string):string;
  var a,i1:integer;
  var s:string;
  begin
  s:=s1;
  i1:=1;
  while s[i1]<>'i' do begin
     if s[i1] = 'd' then a:=i1+2;
     i1:=i1+1;
  end;
  s:=copy(s,a,i1-a);
  val(s,a,i1);
  str(a,s);
  mI:=s;
  end;


begin
   StringGrid2.MouseToCell(X, Y, ACol, ARow);
   massage := StringGrid2.Cells[ACol,ARow];
   if Acol = 1 then if massage = '' then ordersAdd(sender) else begin id:= mI(massage);OrdersOR(sender,id); end
   else ;

   //RequestMemo.Lines.Add(id);
   RequestMemo.Lines.Add(massage);
end;

{procedure TTestClientForm.StringGrid2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TTestClientForm.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
  var massage:string;
  var id:string;

  function mI(var s1:string):string;
  var a,i1:integer;
  var s:string;
  begin
  s:=s1;
  i1:=1;
  while s[i1]<>'И' do begin
     if s[i1] = 'd' then a:=i1+2;
     i1:=i1+1;
  end;
  s:=copy(s,a,i1-a);
  val(s,a,i1);
  str(a,s);
  mI:=s;
  end;


begin
   massage := StringGrid1.Cells[ACol,ARow];
   if Acol = 1 then if massage = '' then couriersAdd(sender) else begin id:= mI(massage);couriersOR(sender,id); end
   else ;

   RequestMemo.Lines.Add(id);
   RequestMemo.Lines.Add(massage);
   end;
       }
end.