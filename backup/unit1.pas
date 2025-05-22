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
    sendButton: TButton;
    sendEdit: TLabeledEdit;
    procedure connectButtonClick(Sender: TObject);
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

  try
    COMPort.Open;
  except
    on E: ERS232OpenError do
      ShowMessage(E.PortName + ': ' + E.Message + '.');
  end;
end;

end.

