/*
    QUESTION: You're working for a large financial institution that provides various types of loans to customers. Your task is to analyze loan repayment data to assess credit risk and improve risk management strategies.

    Write an SQL to create 2 flags for each loan as per below rules. Display loan id, loan amount , due date and the 2 flags.

 

    1- fully_paid_flag: 1 if the loan was fully repaid irrespective of payment date else it should be 0.
    2- on_time_flag : 1 if the loan was fully repaid on or before due date else 0.
 */

WITH loan_data AS (
    SELECT
        l.loan_id,
        l.loan_amount,
        l.due_date,
        MAX(p.payment_date) AS latest_payment_date, 
  		SUM(p.amount_paid) AS total_paid,
        CASE
            WHEN SUM(p.amount_paid)=l.loan_amount THEN 1
            ELSE 0
        END AS fully_paid_flag,
        CASE
            WHEN MAX(p.payment_date) <= l.due_date AND SUM(p.amount_paid)=l.loan_amount THEN 1
            ELSE 0
        END AS on_time_flag
    FROM loans l
    LEFT JOIN payments p ON l.loan_id = p.loan_id
    GROUP BY l.loan_id, l.loan_amount, l.due_date
) SELECT
    loan_id,
    loan_amount,
    due_date,
    fully_paid_flag,
    on_time_flag
FROM
    loan_data
ORDER BY loan_id;
