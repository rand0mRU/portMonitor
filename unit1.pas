unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  RS232Port;

type

  { TForm1 }

  TForm1 = class(TForm)
    baudEdit: TComboBox;
    disconnectButton: TButton;
    connectButton: TButton;
    console: TMemo;
    COMPort: TRS232Port;
    connectBox: TGroupBox;
    connectPort: TLabeledEdit;
    Label1: TLabel;
    Label2: TLabel;
    sendButton: TButton;
    sendEdit: TLabeledEdit;
    procedure COMPortReadingProcess(Sender: TObject; Status, NBytes: integer;
      Data: ShortString);
    procedure connectButtonClick(Sender: TObject);
    procedure disconnectButtonClick(Sender: TObject);
    procedure sendButtonClick(Sender: TObject);
    procedure sendEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.connectButtonClick(Sender: TObject);
begin
  COMPort.Device:=connectPort.Text;
                                                          
  if baudEdit.Text='1200' then COMPort.BaudRate:=br001200;
  if baudEdit.Text='2400' then COMPort.BaudRate:=br002400;
  if baudEdit.Text='4800' then COMPort.BaudRate:=br004800;  
  if baudEdit.Text='9600' then COMPort.BaudRate:=br009600; 
  if baudEdit.Text='19200' then COMPort.BaudRate:=br019200;
  if baudEdit.Text='38400' then COMPort.BaudRate:=br038400;
  if baudEdit.Text='57600' then COMPort.BaudRate:=br057600;
  if baudEdit.Text='115200' then COMPort.BaudRate:=br115200;
  console.Append(inttostr(COMPort.BaudRateToInt(COMPort.BaudRate)));
                
  Label2.Caption:='Подключено: ' + connectPort.Text;
  try
    COMPort.Open;
  except
    on E: ERS232OpenError do
    begin                    
      Label2.Caption:='Отключено';
      ShowMessage(E.PortName + ': ' + E.Message + '.');
    end;
  end;
end;

procedure TForm1.COMPortReadingProcess(Sender: TObject; Status,
  NBytes: integer; Data: ShortString);
begin
  console.append(Data);
end;

procedure TForm1.disconnectButtonClick(Sender: TObject);
begin
  COMPort.Close;     
  Label2.Caption:='Отключено';
end;

procedure TForm1.sendButtonClick(Sender: TObject);
begin    
  COMPort.WriteData(sendEdit.Text);
  console.append('> ' + sendEdit.Text);  
  sendEdit.Text:='';
end;

procedure TForm1.sendEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key.ToString()='13') then
  begin
     COMPort.WriteData(sendEdit.Text);
     console.append('> ' + sendEdit.Text);
     sendEdit.Text:='';
  end;
end;



end.

