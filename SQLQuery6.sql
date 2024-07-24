CREATE DATABASE EXAMPLE1
GO

USE EXAMPLE1
GO

CREATE TABLE PhongBan(
MaPB varchar(7) PRIMARY KEY,
TenPB nvarchar(50)
)
GO

CREATE TABLE NhanVien(
MaNV varchar(7) PRIMARY KEY,
TenNV nvarchar(50),
NgaySinh Datetime,
SoCMND char(9),
GioiTinh char(1),
DiaChi nvarchar(100),
NgayVaoLam Datetime,
MaPB varchar(7),
CONSTRAINT fk FOREIGN KEY (MaPB) REFERENCES PhongBan(MaPB)
)
GO

CREATE TABLE LuongDA(
MaDA varchar(8), 
MaNV varchar(7),
NgayNhan Datetime,
SoTien money CHECK (SoTien >0),
PRIMARY KEY (MaDA, MaNV),
    CONSTRAINT manv FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
)
GO

INSERT INTO PhongBan (MaPB, TenPB) VALUES
('PB001', 'Phong Ke Toan'),
('PB002', 'Phong Nhan Su'),
('PB003', 'Phong Kinh Doanh'),
('PB004', 'Phong IT'),
('PB005', 'Phong Marketing');
GO

INSERT INTO NhanVien (MaNV, TenNV, NgaySinh, SoCMND, GioiTinh, DiaChi, NgayVaoLam, MaPB) VALUES
('NV001', 'Charlie Sampson', '1990-01-01', '123456789', 'M', 'Ha Noi', '2020-01-01', 'PB001'),
('NV002', 'Liz Buxbam', '1985-02-02', '234567890', 'F', 'Hai Phong', '2019-02-02', 'PB002'),
('NV003', 'Wes Bennet', '1992-03-03', '345678901', 'M', 'Da Nang', '2021-03-03', 'PB003'),
('NV004', 'Bailey Mitchell', '1994-04-04', '456789012', 'F', 'Ho Chi Minh', '2018-04-04', 'PB004'),
('NV005', 'Levi Coldwell', '1988-05-05', '567890123', 'M', 'Can Tho', '2022-05-05', 'PB005');
GO

INSERT INTO LuongDA (MaDA, MaNV, NgayNhan, SoTien) VALUES
('DA001', 'NV001', '2023-01-01', 1000),
('DA002', 'NV002', '2023-02-01', 1200),
('DA003', 'NV003', '2023-03-01', 1100),
('DA004', 'NV004', '2023-04-01', 1300),
('DA005', 'NV005', '2023-05-01', 1050);
GO

SELECT 
    LuongDA.MaDA,
    LuongDA.MaNV,
    LuongDA.NgayNhan,
    LuongDA.SoTien,
    NhanVien.TenNV,
    NhanVien.NgaySinh,
    NhanVien.SoCMND,
    NhanVien.GioiTinh,
    NhanVien.DiaChi,
    NhanVien.NgayVaoLam,
    NhanVien.MaPB,
    PhongBan.TenPB
FROM 
    LuongDA
JOIN 
    NhanVien ON LuongDA.MaNV = NhanVien.MaNV
JOIN 
    PhongBan ON NhanVien.MaPB = PhongBan.MaPB;
GO


SELECT * FROM NhanVien
WHERE 
    GioiTinh = 'F';

SELECT MaDA FROM LuongDA;

SELECT MaNV, SUM(SoTien) AS TongLuong
FROM LuongDA
GROUP BY MaNV


SELECT * FROM 
    NhanVien
WHERE 
    MaPB='PB001'


SELECT SoTien FROM 
    LuongDA
WHERE 
    MaNV = 'NV001'

SELECT PhongBan.TenPB, COUNT(NhanVien.MaNV) AS SoLuongNhanVien
FROM PhongBan
LEFT JOIN
NhanVien ON PhongBan.MaPB = NhanVien.MaPB
GROUP BY
PhongBan.TenPB


DELETE FROM LuongDA WHERE MaDA='DA002'
GO

UPDATE LuongDA 
SET SoTien=SoTien*1.1
WHERE MaNV IN (SELECT MaNV FROM LuongDA WHERE MaDA = 'DA003')
GO

DELETE FROM LuongDA WHERE SoTien = '5000000'
GO

DELETE FROM NhanVien WHERE MaNV NOT IN ( SELECT MaNV FROM LuongDA)
GO
