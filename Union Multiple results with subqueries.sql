select * from (select jobnumber,status,utilcre,Date_In, 1 as orderdata from (select jobnumber,status,h.utilcre,D.Date_In,row_number() over(partition by d.jobnumber order by h.datecre desc) as ord from sbe.DATA_WIP_NEW d
					left outer join histofiches h
					on d.order_number = h.cptdossier and d.line_number = h.numligne
					where plant = 96 and flow = 'Brightstar' and status in ('BER','Aw. Quote Validation','Aw. Quotation Response')
					) where ord =1 
					union
					select jobnumber,status,utilcre,Date_In,2 from (select jobnumber,status,h.utilcre,D.Date_In,row_number() over(partition by d.jobnumber order by h.datecre desc) as ord from sbe.DATA_WIP_NEW d
					left outer join histofiches h
					on d.order_number = h.cptdossier and d.line_number = h.numligne
					where plant = 96 and flow = 'Brightstar' and status in ('Aw. Customer Informations','Aw. Customer Breakdown Informations')
					) where ord =2
					union
					select jobnumber,status,utilcre,Date_In,3 from (select jobnumber,status,h.utilcre,D.Date_In,row_number() over(partition by d.jobnumber order by h.datecre desc) as ord from sbe.DATA_WIP_NEW d
					left outer join histofiches h
					on d.order_number = h.cptdossier and d.line_number = h.numligne
					where plant = 96 and flow = 'Brightstar' and status_n_1 in ('BER','Aw. Quote Validation','Aw. Quotation Response','Aw. Customer Breakdown Informations','Aw. Customer Informations') 
					  and status not in ('BER','Aw. Quote Validation','Aw. Quotation Response','Aw. Customer Breakdown Informations','Aw. Customer Informations')
								) where ord =3 
					  ) order by orderdata desc
