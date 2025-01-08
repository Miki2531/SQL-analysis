/* 
    QUESTIONS: Imagine you're working for a library and you're tasked with generating a report on the borrowing habits of patrons. You have two tables in your database: Books and Borrowers.
    Write an SQL to display the name of each borrower along with a comma-separated list of the books they have borrowed in alphabetical order, display the output in ascending order of Borrower Name.
    Note: The output should be displayed in the following format:
                    Tables: Books
                    +-------------+-------------+
                    | COLUMN_NAME | DATA_TYPE   |
                    +-------------+-------------+
                    | BookID      | int         |
                    | BookName    | varchar(30) |
                    | Genre       | varchar(20) |
                    +-------------+-------------+

                    Tables: Borrowers
                    +--------------+-------------+
                    | COLUMN_NAME  | DATA_TYPE   |
                    +--------------+-------------+
                    | BorrowerID   | int         |
                    | BorrowerName | varchar(10) |
                    | BookID       | int         |
                    +--------------+-------------+
*/

SELECT b.BorrowerName, 
    GROUP_CONCAT(bk.BookName ORDER BY bK.BookName SEPARATOR ', ') AS Borrowers_Book_name
FROM Borrowers b
JOIN Books bk 
    ON bk.BookID = b.BookID
GROUP BY b.BorrowerName
ORDER BY b.BorrowerName ASC;