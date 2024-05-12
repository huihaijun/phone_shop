create definer = root@`%` view view_product as
select `phone_shop`.`s_catalog`.`catalogName` AS `catalogName`,
       `phone_shop`.`s_product`.`bookId`      AS `bookId`,
       `phone_shop`.`s_product`.`catalogId`   AS `catalogId`,
       `phone_shop`.`s_product`.`bookName`    AS `bookName`,
       `phone_shop`.`s_product`.`price`       AS `price`,
       `phone_shop`.`s_product`.`description` AS `description`,
       `phone_shop`.`s_product`.`imgId`       AS `imgId`,
       `phone_shop`.`s_uploadimg`.`imgName`   AS `imgName`,
       `phone_shop`.`s_uploadimg`.`imgSrc`    AS `imgSrc`,
       `phone_shop`.`s_uploadimg`.`imgType`   AS `imgType`,
       `phone_shop`.`s_product`.`author`      AS `author`,
       `phone_shop`.`s_product`.`press`       AS `press`,
       `phone_shop`.`s_product`.`addTime`     AS `addTime`
from ((`phone_shop`.`s_product` join `phone_shop`.`s_catalog` on ((`phone_shop`.`s_product`.`catalogId` =
                                                                   `phone_shop`.`s_catalog`.`catalogId`)))
         join `phone_shop`.`s_uploadimg` on ((`phone_shop`.`s_product`.`imgId` = `phone_shop`.`s_uploadimg`.`imgId`)));

