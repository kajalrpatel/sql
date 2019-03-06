select * FROM Brightstar_Falut_Model
WHERE rowid not in
(SELECT MIN(rowid)
FROM Brightstar_Falut_Model b
GROUP BY b.fault, b.Fault_Code, B.Labor_Price,B.Model,B.Oem,B.Part_Family,B.Part_Family_Code,B.Part_Price)
