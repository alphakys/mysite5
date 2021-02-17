
create table rboard(
        no      number primary key,
        user_no number  not null,
        title   varchar2(500),
        content varchar2(4000),
        hit     number,
        reg_date date,
        group_no number,
        order_no number,
        depth    number,
        
        constraint  fk_code_users foreign key(user_no)
            references users(no) on delete cascade
            );
--게시글--
insert into rboard
values(seq_rboard_no.nextval, '2', '댓글게시판', '댓게작성', '0', sysdate, seq_rboard_no.nextval, '1', '0');
--댓글1--
insert into rboard
values(seq_rboard_no.nextval, '2', '댓글2', '댓게작성', '0', sysdate, '5', '2', '1');
--댓글2--
insert into rboard
values(seq_rboard_no.nextval, '2', '댓글게시판', '댓게작성', '0', sysdate, '5', '3', '2');
--댓글3--
insert into rboard
values(seq_rboard_no.nextval, '2', '댓글게시판', '댓게작성', '0', sysdate, '5', '4', '3');

update rboard
set    order_no = order_no+1
where  group_no = '5' and depth >0;

update rboard
set    title = '   댓글'
where  no = '17';

				select		
				            b.no no,
				            title,
				            u.name name,
				            content,
				            hit,
				            reg_date "date",
				            user_no userNo,
				            group_no groupNo,
				            order_no orderNo,
				            depth
				             
				from rboard b,(select   rownum r,
				                        no
				              from    (select       rownum,
				                                    no
				                       from         rboard
				                       order by no desc)
				              )ro, users u                
				where b.no = ro.no and u.no = b.user_no and name = '정'
				--and r >= 1 and r <= 10 
				order by group_no desc, order_no asc;




select       rownum,
             group_no
from         rboard
where group_no >30
order by     group_no desc;

select group_no
from rboard
where 



select title
from rboard;

      
create sequence seq_rboard_no
start with 1
increment by 1
nocache;


select	*
from    rboard;

drop table rboard;

delete rboard;

drop sequence seq_rboard_no;


