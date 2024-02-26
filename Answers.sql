
1-)INSERT INTO yazar (yazarad,yazarsoyad)
    VALUES ('KEMAL','UYUMAZ')

2-)INSERT INTO tur (turadi)
   VALUES ('BIYOGRAFI TURU')

3-)INSERT INTO ogrenci (ograd , ogrsoyad , cinsiyet , sinif)
   VALUES ('CAGLAR' , 'UZUMCU','E','10A'),
   ('LEYLA' , 'ALAGOZ','K','9B'),
   ('AYSE' , 'BEKTAS' , 'K' , '11C');

4-) INSERT INTO yazar(yazarad,yazarsoyad)
   SELECT ograd , ogrsoyad FROM ogrenci
   ORDER BY RAND()
   LIMIT 1;

5-) INSERT INTO yazar(yazarad,yazarsoyad)
   SELECT ograd , ogrsoyad FROM ogrenci
   WHERE ogrno > 10 AND ogrno < 30

6-)INSERT INTO yazar (yazarad, yazarsoyad)
   VALUES ('Nurettin', 'Belek')
   SELECT @IDENTITY yazarno;

7-)UPDATE ogrenci
   SET sinif = '10C'
   WHERE ogrno =3

8-)UPDATE ogrenci
    SET sinif ='10A'
    WHERE sinif = '9A'

9-)UPDATE ogrenci
    SET puan = puan +5

10-)DELETE FROM yazar WHERE yazarno = 25

11-)SELECT * FROM ogrenci
    WHERE dtarih IS NULL
    LIMIT 3;

12-)DELETE FROM ogrenci WHERE dtarih IS NULL

13-)UPDATE kitap
    SET puan = puan+2
    WHERE kitapadi LIKE 'a%'

14-)INSERT INTO tur (turadi)
    VALUES('Kisisel GElisim')

15-)UPDATE kitap
    SET turno = {SELECT turno FROM tur WHERE turadi ='Kisisel Gelisim'}
    WHERE kitapadi ='Başarı Rehberi'

16-)CREATE OR REPLACE FUNCTION
    public.ogrenciListesi()
    RETURNS SETOF ogrenci
    LANGUAGE 'sql'
    AS $BODY$
        SELECT * FROM ogrenci
    $BODY$

 17-)CREATE OR REPLACE PROCEDURE
     public.ekle(
     	IN ogrno bigint
     	IN ograd character varying,
     	IN ogrsoyad character varying,
     	IN cinsiyet character,
     	IN dtarih character varying,
     	IN sinif character varying ,
     	IN puan bigint
     )
     LANGUAGE 'sql'
     AS $BODY$
     	INSERT INTO ogrenci(ogrno,ograd,ogrsoyad,cinsiyet,dtarih,sinif,puan)
     	VALUES(ogrno,ograd,ogrsoyad,cinsiyet,dtarih,sinif,puan)
     $BODY$;

     CALL public.ekle(77,'Murat','Simsek','E','17.02','0923',99);

 18-)CREATE OR REPLACE PROCEDURE
    public.sil(IN ogrenciNo bigint)
    LANGUAGE 'sql'
    AS $BODY$
         	DELETE FROM ogrenci
         	WHERE ogrno = ogrenciNo
         $BODY$;

    CALL public.sil(1);

 19-)CREATE OR REPLACE PROCEDURE
    public.changeClass(IN ogrenciNo bigint , IN class character varying)
    LANGUAGE 'sql'
    AS $BODY$
    UPDATE ogrenci
    SET class = sinif
    WHERE ogrenciNo = ogrno
    $BODY$

    CALL public.changeClass(1,'10B');

20-)CREATE OR REPLACE PROCEDURE
    public.searchOgr(IN fullName character varying)
    LANGUAGE 'sql'
        AS $BODY$
           SELECT * FROM ogrenci
           WHERE CONCAT(ogrenciAd , ogrenciSoyad)
           ILIKE CONCAT('%',fullName, '%')
        $BODY$

21-)DROP PROCEDURE IF EXISTS 'ekle'
     DROP PROCEDURE IF EXISTS 'sil'
     DROP PROCEDURE IF EXISTS 'changeClass'
     DROP PROCEDURE IF EXISTS 'searchOgr'

22-) SELECT * FROM kitap
    WHERE turno = (SELECT turno FROM tur WHERE turadi ='Dram')

23-)SELECT *
    FROM kitap
    WHERE yazarno IN (SELECT yazarno FROM yazar WHERE yazarad LIKE 'E%' );

24-)SELECT * FROM ogrenci WHERE ogrno NOT IN (SELECT ogrno FROM islem)

25-)SELECT * FROM kitap WHERE kitapno NOT IN (SELECT kitapno FROM islem)

26-)SELECT * FROM kitap
    WHERE kitapno IN (SELECT kitapno FROM islem WHERE
    EXTRACT (MONTH FROM atarih::timestamp) != 5
    AND
    EXTRACT (MONTH FROM vtarih::timestamp) != 5)
