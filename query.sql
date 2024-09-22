-- Select all documents between dates
-- maybe I can add index to sentDate?
SELECT * FROM Incoming i WHERE i.sentdate BETWEEN :startDate AND :endDate ORDER BY i.id DESC;

-- Select documents for user, who is a member of document's project, or user is an author, or is an executor 
SELECT * FROM Incoming i WHERE 
	(
		i.projectid IN (SELECT projectid FROM Project_Member pm WHERE pm.employeeid = :employeeId) 
		OR :employeeId IN (SELECT employeeid FROM Document_Executor de WHERE de.documentid = i.id) 
		OR i.employeeid = :employeeId
	) 
	AND i.sentdate BETWEEN :startDate AND :endDate 
        ORDER BY i.id DESC;

-- Select documents as previous query, but with text filter
SELECT * FROM Incoming i WHERE 
	(
		i.projectid IN (SELECT projectid FROM Project_Member pm WHERE pm.employeeid = :employeeId) 
            	OR :employeeId IN (SELECT employeeid FROM Document_Executor de WHERE de.documentid = i.id) 
            	OR i.employeeid = :employeeId
	)
        AND (
		i.name ILIKE :filter 
            	OR (i.projectid IN (SELECT projectid FROM Project p WHERE p.name ILIKE :filter)) 
            	OR (i.clientid IN (SELECT companyId FROM Company c WHERE c.title ILIKE :filter)) 
            	OR (CAST(num AS TEXT) LIKE :filter) 
            	OR i.author ILIKE :filter
	) 
        ORDER BY i.id DESC;
