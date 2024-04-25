-- Task 12: Create a stored procedure for computing average weighted score
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_score FLOAT;
    DECLARE total_weight INT;
    DECLARE average_weighted_score FLOAT;

    SELECT SUM(c.score * p.weight), SUM(p.weight)
    INTO total_score, total_weight
    FROM corrections c
    INNER JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;

    IF total_weight > 0 THEN
        SET average_weighted_score = total_score / total_weight;
    ELSE
        SET average_weighted_score = 0;
    END IF;

    UPDATE users
    SET average_score = average_weighted_score
    WHERE id = user_id;
END //

DELIMITER ;
