SELECT dd.*,Re.Repair_Parts_Cost_Estimate,Re.Repair_Labor_Cost_Estimate,Re.Id_Mvt,Re.Reference_Number,Me.Cptdossier,Me.Id_Mvt FROM (SELECT Distinct ID_MVT,
  REFERENCE_NUMBER,
  CAN_BE_REPAIRED,
  CAN_BE_REPLACED,
  CANNOT_REPAIR_REASON,
  CONDITION,
  REPAIR_PARTS_COST_ESTIMATE,
  REPAIR_LABOR_COST_ESTIMATE,
  NOTES,
  ACTION, ROW_NUMBER() OVER (PARTITION BY REFERENCE_NUMBER ORDER BY ID_MVT DESC) AS ORD 
FROM MVT_BRIGHTSTAR_CAN_REP_EQUIP order by ID_MVT desc) RE JOIN MVT_ENTETE ME ON ME.Id_Mvt= Re.Id_Mvt
left JOIN (select JOBNUMBER, IMEI_IN, STATUS, MODEL_IN, ORDER_NUMBER, LINE_NUMBER, CODEREF, NUMMODEL, DATE_IN, FAULT, PART_FAMILY, sum(PART_PRICE), LABOR_PRICE
, ROW_NUMBER() OVER (PARTITION BY JOBNUMBER, IMEI_IN, STATUS, MODEL_IN, ORDER_NUMBER, LINE_NUMBER, CODEREF, NUMMODEL, DATE_IN, FAULT, PART_FAMILY ORDER BY LABOR_PRICE DESC) AS ORD 
from (select Distinct D.Jobnumber,D.Imei_In,D.Status,D.Model_In,D.Order_Number,D.Line_Number,R.Coderef,M.Nummodel,D.Date_In,Bm.Fault,Bm.Part_Family,Bm.Part_Price,Bm.Labor_Price from SBE.data_in_wip_out_new d
left outer join pieces_changees p
on d.order_number = p.cptdossier and d.line_number = p.numligne
left outer join sbedba.REFERENCES R
 ON  P.NUMPIE = R.NUMPRO_EXT
 left outer  JOIN sbedba.PRODUITS P ON R.NUMPRO_INT = P.NUMPRO_INT
left outer JOIN sbedba.LIBELLES L ON P.FAMILLE = L.LIGNE and l.entete = 39 
left outer join SBEDBA.Modeles m on d.Model_In = M.Modele
left outer join SBE.Brightstar_Falut_Model bm on Bm.Model = M.Nummodel and Bm.Part_Family = L.Commentaire
where D.Plant=96 and flow= 'Brightstar' and process='Repair Only' and l.commentaire not in ('SCREWS','FLEX','STICKER') order by M.Nummodel desc) group by JOBNUMBER, IMEI_IN, STATUS, MODEL_IN, ORDER_NUMBER, LINE_NUMBER, CODEREF, NUMMODEL, DATE_IN, FAULT, PART_FAMILY,  LABOR_PRICE
) DD on Dd.Order_Number =  Me.Cptdossier WHERE ORD = 1 and Coderef != '0000'
