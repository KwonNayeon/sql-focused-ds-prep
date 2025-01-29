WITH highest_prices AS (
    SELECT 
        ticker,
        TO_CHAR(date, 'Mon-YYYY') as highest_mth,
        open as highest_open,
        ROW_NUMBER() OVER (PARTITION BY ticker ORDER BY open DESC) as row_num
    FROM stock_prices
), 
lowest_prices AS (
    SELECT 
        ticker,
        TO_CHAR(date, 'Mon-YYYY') as lowest_mth,
        open as lowest_open,
        ROW_NUMBER() OVER (PARTITION BY ticker ORDER BY open ASC) as row_num
    FROM stock_prices
)
SELECT 
    highest.ticker,
    highest.highest_mth,
    highest.highest_open,
    lowest.lowest_mth,
    lowest.lowest_open
FROM highest_prices as highest 
INNER JOIN lowest_prices AS lowest 
    ON highest.ticker = lowest.ticker 
    AND highest.row_num = 1
    AND lowest.row_num = 1
ORDER BY highest.ticker;
