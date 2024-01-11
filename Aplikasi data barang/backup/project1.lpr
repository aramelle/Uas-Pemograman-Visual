program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uMain, uLogin, uTambahbarang, uUpdateBarang, uDataMaster, uTransaksi,
  uTambahTransaksi, uTambahDetailTransaksi, uReport
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TTfrmMain, TfrmMain);
  Application.CreateForm(TTfrmLogin, TfrmLogin);
  Application.CreateForm(TTfrmTambahBarang, TfrmTambahBarang);
  Application.CreateForm(TTfrmUpdateBarang, TfrmUpdateBarang);
  Application.CreateForm(TTfrmDataMaster, TfrmDataMaster);
  Application.CreateForm(TTfrmTransaksi, TfrmTransaksi);
  Application.CreateForm(TTfrmTambahTransaksi, TfrmTambahTransaksi);
  Application.CreateForm(TTfrmTambahDetailTransaksi, TfrmTambahDetailTransaksi);
  Application.CreateForm(TTfrmReport, TfrmReport);
  Application.Run;
end.

