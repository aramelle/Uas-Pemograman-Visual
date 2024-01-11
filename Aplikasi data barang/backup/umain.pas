unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  uLogin, uDataMaster, uTransaksi, uReport;

type

  { TTfrmMain }


  TTfrmMain = class(TForm)
    LNS: TLabel;
    MainMenu1: TMainMenu;
    MenuFile: TMenuItem;
    MenuDataMaster: TMenuItem;
    MenuTransaksi: TMenuItem;
    MenuLaporan: TMenuItem;
    MenuLogin: TMenuItem;
    MenuLogout: TMenuItem;
    MenuExit: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure MenuDataMasterClick(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure MenuLaporanClick(Sender: TObject);
    procedure MenuLoginClick(Sender: TObject);
    procedure MenuLogoutClick(Sender: TObject);
    procedure MenuTransaksiClick(Sender: TObject);

  private
    FUsername: string;
    FRole: integer;

  public
    procedure DisableMenu(AMenu: TMenuItem);
    procedure EnableMenu(AMenu: TMenuItem);
  end;

var
  TfrmMain: TTfrmMain;

implementation

{$R *.lfm}

{ TTfrmMain }

procedure TTfrmMain.MenuLoginClick(Sender: TObject);
var
  frmLogin: TTfrmLogin;
begin
  try
    frmLogin := TTfrmLogin.Create(Self);
    Self.Hide;
    if frmLogin.ShowModal = mrOk then
    begin
      if frmLogin.Login then
      begin
         FUsername := frmLogin.EUsername.Text;
         FRole := frmLogin.GetRole;
         EnableMenu(MainMenu1.Items);
         LNS.Caption := 'SELAMAT DATANG ' + UpperCase(Fusername);
         LNS.Visible:= true;
         if FRole <> 1 then
         begin
            MenuDataMaster.Enabled := false;
            MenuLaporan.Enabled := false;
         end;
         MenuLogin.Enabled := false;
      end
      else
          ShowMessage('Gagal login');
    end;
  finally
    frmLogin.Free;
    Self.Show;
  end;
end;

procedure TTfrmMain.MenuLogoutClick(Sender: TObject);
begin
  DisableMenu(MainMenu1.items);

  FUsername := '';
  FRole := 0;
  LNS.Visible:= false;
  MenuFile.Enabled:=true;
  MenuLogin.Enabled:=true;
  MenuExit.Enabled:=true;
end;

procedure TTfrmMain.MenuTransaksiClick(Sender: TObject);
var
  frmTransaksi: TTfrmTransaksi;
begin
  try
    frmTransaksi := TTfrmTransaksi.Create(Self);
    Self.Hide;
    if frmTransaksi.ShowModal = mrOk then
    begin
    end;
  finally
    frmTransaksi.Free;
    Self.Show;
  end;
end;

procedure TTfrmMain.FormCreate(Sender: TObject);
begin
  DisableMenu(MainMenu1.items);
  MenuFile.Enabled:=true;
  MenuLogin.Enabled:=true;
  MenuExit.Enabled:=true;
end;

procedure TTfrmMain.MenuDataMasterClick(Sender: TObject);
var
  frmDataBarang: TTfrmDataMaster;
begin
  try
    frmDataBarang := TTfrmDataMaster.Create(Self);
    Self.Hide;
    if frmDataBarang.ShowModal = mrOk then
    begin
    end;
  finally
    frmDataBarang.Free;
    Self.Show;
  end;
end;

procedure TTfrmMain.MenuExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TTfrmMain.MenuLaporanClick(Sender: TObject);
var
  frmReport: TTfrmReport;
begin
  try
    frmReport := TTfrmReport.Create(Self);
    Self.Hide;
    if frmReport.ShowModal = mrOk then
    begin
    end;
  finally
    frmReport.Free;
    Self.Show;
  end;
end;

procedure TTfrmMain.DisableMenu(AMenu: TMenuItem);
var
  i: integer;
begin
  for i := 0 to AMenu.Count - 1 do
  begin
    AMenu[i].Enabled := false;
    DisableMenu(AMenu[i]);
  end;
end;

procedure TTfrmMain.EnableMenu(AMenu: TMenuItem);
var
  i: integer;
begin
  for i := 0 to AMenu.Count - 1 do
  begin
    AMenu[i].Enabled := true;
    EnableMenu(AMenu[i]);
  end;
end;

end.

