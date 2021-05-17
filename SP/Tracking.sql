DROP PROCEDURE `wk_consultTrackings`;
DELIMITER $$

CREATE PROCEDURE `wk_consultTrackings`
(
	IN pUserName VARCHAR(20)
)
BEGIN
	SET @userid = 0;
	
    SELECT IFNULL(userid, @userid) INTO @userid FROM wk_users WHERE TRIM(`username`)=pUserName;
    
	SELECT height AS `Height`, weight AS `Weight`, IFNULL(BMI, 'Not added') AS `BMI`, posttime AS `Date`
    FROM wk_tracking
    WHERE clientid = @userid
    ORDER BY posttime;
    
END$$

CREATE PROCEDURE `wk_consultTracking`
(
	IN pTrackingId BIGINT
)
BEGIN 
	
    SELECT trackings.height AS `Height`, trackings.weight AS `Weight`, IFNULL(trackings.BMI, 'Not added') AS `BMI`, trackings.posttime AS `Date`,
		   trackings.additionalNotes AS `Notes`, pictures.url AS `Picture`
    FROM wk_picturesPerTracking AS picturesPerTracking
    JOIN wk_tracking AS trackings ON picturesPerTracking.trackingid = trackings.trackingid
    JOIN wk_pictures AS pictures ON picturesPerTracking.pictureid = pictures.pictureid
    WHERE picturesPerTracking.trackingid = pTrackingId
    ORDER BY posttime;

END$$


