unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, Grids, DBGrids, StdCtrls;

type
  TForm1 = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    dbgrd1: TDBGrid;
    ZConnection1: TZConnection;
    ZKategori1: TZQuery;
    dskategori1: TDataSource;
    edt1: TEdit;
    edt2: TEdit;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   a: string;
implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin  //simpan
try
    // Menyusun perintah SQL untuk menyisipkan data
    Form1.ZKategori1.SQL.Clear;
    Form1.ZKategori1.SQL.Add('INSERT INTO satuan (nama, diskripsi) VALUES (:nama, :diskripsi)');
    
    // Menetapkan nilai parameter
    Form1.ZKategori1.Params.ParamByName('nama').AsString := edt1.Text;
    Form1.ZKategori1.Params.ParamByName('diskripsi').AsString := 'Deskripsi default'; // Ganti dengan deskripsi yang diinginkan atau ambil dari komponen lain

    // Mengeksekusi perintah SQL
    Form1.ZKategori1.ExecSQL;

    // Menyusun perintah SQL untuk membuka data yang telah dimasukkan
    Form1.ZKategori1.SQL.Clear;
    Form1.ZKategori1.SQL.Add('SELECT * FROM satuan');
    Form1.ZKategori1.Open;

    // Menampilkan pesan sukses
    ShowMessage('Data Berhasil di Simpan!');
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;


procedure TForm1.btn2Click(Sender: TObject);
begin  //update
try
    // Validasi Deskripsi
    if Trim(edt2.Text) = '' then
    begin
      ShowMessage('Deskripsi tidak boleh kosong.');
      Exit;
    end;


     // Menyiapkan perintah SQL untuk memperbarui deskripsi untuk semua baris
    Form1.ZKategori1.SQL.Clear;
    Form1.ZKategori1.SQL.Add('UPDATE satuan SET diskripsi = :diskripsi');
    
    // Menetapkan nilai parameter
    Form1.ZKategori1.Params.ParamByName('diskripsi').AsString := edt2.Text;  // Deskripsi baru

    // Mengeksekusi perintah SQL
    Form1.ZKategori1.ExecSQL;

    // Menyiapkan perintah SQL untuk membuka data yang telah diperbarui
    Form1.ZKategori1.SQL.Clear;
    Form1.ZKategori1.SQL.Add('SELECT * FROM satuan');
    Form1.ZKategori1.Open;

    // Menampilkan pesan sukses
    ShowMessage('Deskripsi Berhasil di Update untuk Semua Baris!');
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
  
end;

procedure TForm1.dbgrd1CellClick(Column: TColumn);
begin
edt1.Text:= Form1.ZKategori1.Fields[1].AsString;
a:= Form1.ZKategori1.Fields[0].AsString;
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
with Form1.ZKategori1 do
begin
  SQL.Clear;
  SQL.Add('delete from satuan where id="'+a+'"');
  ExecSQL;

  SQL.Clear;
  SQL.Add('select * from satuan');
  Open;
end;
ShowMessage('Data Berhasil di Delete!');
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
edt1.Text :='';
edt2.Text :='';
end;

end.
