SELECT
    jt.position,
    COUNT(jt.position) AS players
FROM baseball_positions,
    JSON_TABLE(
        CONCAT('["',REPLACE(position, '/', '","'),'"]'),
        '$[*]' COLUMNS(position TEXT PATH '$')
    ) AS jt
GROUP BY jt.position
ORDER BY players DESC