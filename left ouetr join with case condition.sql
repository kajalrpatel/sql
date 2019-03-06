select Rd.Jobno,d.ra,D.Imei_In,D.Imei_Out,D.Manufacturer_In,Rd.Return_Type,D.Sku_In,D.Sku_Out,D.Cosm_Grade_In,D.Cosm_Grade_Out,
Rd.Nff,Rd.Pop15days,Rd.Missing_Access,Rd.Cid,Rd.Missing_Pop_Por,Rd.Defective,Rd.Missing_Checklist,Rd.Open_Box,case when '667' in (select visa  from Histofiches where Cptdossier=d.Order_Number and Numligne=D.Line_Number) then 'Yes' else 'No' end as FMIP,
Rd.None as Compliant,upper(Rd.Uname) as userr,D.Date_In,d.time_in,D.Date_Out
from Return_Criteria_Data_Capture rd
left outer join (select d.*,m.ra from Data_In_Wip_Out_New d left outer join (select Me.Cptdossier,Me.Numligne,mp.ra from Mvt_Entete me join (select id_mvt,ra from SBEDBA.Mvt_Bell_Auto_Ra_Prealert union all 
                                                      select id_mvt,ra from SBEDBA.Mvt_Bell_Returns_Prealert)mp on Mp.Id_Mvt = Me.Id_Mvt) m
                                                    on m.Cptdossier = D.Order_Number and m.Numligne = D.Line_Number
                                                    where d.Cust_Code_In in('BRR001','BRZ001','BRR003','BRR004','BRR005')) d on D.Jobnumber = Rd.Jobno
where D.Plant=94 order by date_in desc
