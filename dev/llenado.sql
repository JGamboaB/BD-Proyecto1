INSERT INTO wk_days (dayid, name)
VALUES (1, 'Sunday');

INSERT INTO wk_days (dayid, name)
VALUES (2, 'Monday');

INSERT INTO wk_days (dayid, name)
VALUES (3, 'Tuesday');

INSERT INTO wk_days (dayid, name)
VALUES (4, 'Wednesday');

INSERT INTO wk_days (dayid, name)
VALUES (5, 'Thursday');

INSERT INTO wk_days (dayid, name)
VALUES (6, 'Friday');

INSERT INTO wk_days (dayid, name)
VALUES (7, 'Saturday');

INSERT INTO wk_paymentstatus(name)
VALUES ('Approved');

INSERT INTO wk_paymentstatus(name)
VALUES ('Denied');

INSERT INTO wk_paymentstatus(name)
VALUES ('In Transit');

INSERT INTO wk_genders(name)
VALUES ('Male');

INSERT INTO wk_genders(name)
VALUES ('Female');

INSERT INTO wk_icons(url)
VALUES ('https://www.google.com/search?q=monthly+icon&rlz=1C1CHBF_esCR857CR857&sxsrf=ALeKk03To5Be_OOFF9Y0odLk3kh27ekm4A:1620253858330&tbm=isch&source=iu&ictx=1&fir=Edm0uwC3T23ruM%252CylxOxNJc2hGN1M%252C_&vet=1&usg=AI4_-kSPwUquyFzUhNQ_DXf1EKv25FNrzw&sa=X&ved=2ahUKEwjJm6_9y7PwAhXQnuAKHe-DAXAQ9QF6BAgSEAE#imgrc=Edm0uwC3T23ruM');

INSERT INTO wk_plans(iconid, name, description, amount, starttime, endtime, enabled, deleted)
VALUES(1, 'Premium', 'With this plan you can have all the benefits of the premium package.', 50.00, NOW(), null, 1, 0);

INSERT INTO wk_plans(iconid, name, description, amount, starttime, endtime, enabled, deleted)
VALUES(1, 'Regular', 'With this plan you can only have up to two workout rutines.', 0, NOW(), null, 1, 0);