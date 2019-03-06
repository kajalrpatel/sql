select ASSOM||','|| TAGN||','|| JOBNUMBER as assoc from (select 
						case when date_out is null then 'A' else 'R' end as assom,  substr(c.commentaire,6,12) as tagn , jobnumber
					--case when date_out is null and status != 'Product sent in sub contract' then 'A' else 'R' end as assom,  substr(c.commentaire,6,12) as tagn , jobnumber
						from data_in_wip_out_new d
						left outer join(
            select * from (select cptdossier, numligne ,case when e.mac_add is not null then 'ESL94'||e.mac_add else  commentaire end as commentaire, e.mac_add, row_number()over (partition by commentaire order by datecre desc) as ord from commentsbe c
            left outer join esl_mapping e
            on e.barcode = substr(c.commentaire,6,12)
            where c.commentaire like 'ESL94%'
            ) where ord = 1
            )  c
						on d.order_number = c.cptdossier and d.line_number = c.numligne and c.commentaire like 'ESL94%'
						where  c.commentaire like 'ESL94%'
						and date_out is null)
