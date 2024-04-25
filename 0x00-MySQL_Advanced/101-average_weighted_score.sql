-- Task 13: Create a stored procedure for computing average weighted score for all users
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE user_id INT;
    DECLARE total_score FLOAT;
    DECLARE total_weight INT;
    DECLARE average_weighted_score FLOAT;

    -- Cursor for iterating through users
    DECLARE cur CURSOR FOR
        SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN cur;

    -- Loop through each user
    users_loop: LOOP
        -- Fetch the user ID
        FETCH cur INTO user_id;
        IF done THEN
            LEAVE users_loop;
        END IF;

        -- Reset variables for each user
        SET total_score = 0;
        SET total_weight = 0;

        -- Calculate total score and total weight for the user
        SELECT SUM(c.score * p.weight), SUM(p.weight)
        INTO total_score, total_weight
        FROM corrections c
        INNER JOIN projects p ON c.project_id = p.id
        WHERE c.user_id = user_id;

        -- Calculate average weighted score
        IF total_weight > 0 THEN
            SET average_weighted_score = total_score / total_weight;
        ELSE
            SET average_weighted_score = 0;
        END IF;

        -- Update the user's average score
        UPDATE users
        SET average_score = average_weighted_score
        WHERE id = user_id;
    END LOOP;

    -- Close the cursor
    CLOSE cur;
END //

DELIMITER ;
