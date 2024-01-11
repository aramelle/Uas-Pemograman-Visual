unit uReport;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, LR_Class, LR_DBSet;

type

  { TTfrmReport }

  TTfrmReport = class(TForm)
    BCari: TButton;
    BReset: TButton;
    BLaporan: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ECari: TEdit;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    Label1: TLabel;
    SQLConnector1: TSQLConnector;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure BCariClick(Sender: TObject);
    procedure BLaporanClick(Sender: TObject);
    procedure BResetClick(Sender: TObject);
  private
    id: integer;

  public

  end;

var
  TfrmReport: TTfrmReport;

implementation

{$R *.lfm}

{ TTfrmReport }

procedure TTfrmReport.BCariClick(Sender: TObject);
begin
  with SQLQuery1 do
  begin
     Close;
     SQL.Clear;
     SQL.Add('SELECT dt.id, t.customer, t.tanggal as tanggal_transaksi, dt.jumlah, dt.diskon as diskon_beli_barang, t.diskon as diskon_transaksi, t.sub_total, t.total, db.harga_beli, db.harga_jual, db.nama as nama_barang, k.nama as kategori FROM detail_transaksi as dt JOIN data_barang as db ON db.id = dt.barang_id JOIN kategori as k ON k.id = db.kategori_id JOIN transaksi as t ON dt.transaksi_id = t.id WHERE t.customer = :customer');
     Params.ParamByName('customer').AsString := ECari.Text;
     Open;
  end;
end;

procedure TTfrmReport.BLaporanClick(Sender: TObject);
var
  s: string;
begin
  try
   if ECari.Text <> '' then
   begin
     s := extractfilepath(application.ExeName) + 'report.lrf';
   end
   else
   begin
     s := extractfilepath(application.ExeName) + 'report_all.lrf';
   end;

   frDBDataSet1.DataSet := SQLQuery1;
   frReport1.DataSet := frDBDataSet1;
   frReport1.LoadFromFile(s);
   frReport1.ShowReport;
  finally
   frReport1.Clear;
  end;
end;

procedure TTfrmReport.BResetClick(Sender: TObject);
begin
  with SQLQuery1 do
  begin
     Close;
     SQL.Clear;
     SQL.Add('SELECT dt.id, t.customer, t.tanggal as tanggal_transaksi, dt.jumlah, dt.diskon as diskon_beli_barang, t.diskon as diskon_transaksi, t.sub_total, t.total, db.harga_beli, db.harga_jual, db.nama as nama_barang, k.nama as kategori FROM detail_transaksi as dt JOIN data_barang as db ON db.id = dt.barang_id JOIN kategori as k ON k.id = db.kategori_id JOIN transaksi as t ON dt.transaksi_id = t.id');
     Open;
  end;
  ECari.Text := '';
end;

end.

