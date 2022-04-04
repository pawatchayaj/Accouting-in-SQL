USE H_Accounting;

-- drop procedure if already produced
DROP PROCEDURE IF EXISTS H_Accounting.sp_pjarrunakorn2020;

-- create procedure
DELIMITER $$
CREATE PROCEDURE H_Accounting.sp_pjarrunakorn2020(varCalendarYear SMALLINT)
BEGIN
    -- declaring variables
	DECLARE varTotalRevenues DOUBLE DEFAULT 0;
    DECLARE varTotalRevenuesP DOUBLE DEFAULT 0;
    DECLARE varCogs DOUBLE DEFAULT 0;
    DECLARE varCogsP DOUBLE DEFAULT 0;
    DECLARE varReturn DOUBLE DEFAULT 0;
    DECLARE varReturnP DOUBLE DEFAULT 0;
    DECLARE varAdExp DOUBLE DEFAULT 0;
    DECLARE varAdExpP DOUBLE DEFAULT 0;
    DECLARE varSExp DOUBLE DEFAULT 0;
    DECLARE varSExpP DOUBLE DEFAULT 0;
    DECLARE varOExp DOUBLE DEFAULT 0;
    DECLARE varOExpP DOUBLE DEFAULT 0;
    DECLARE varOIncome DOUBLE DEFAULT 0;
    DECLARE varOIncomeP DOUBLE DEFAULT 0;
    DECLARE varInTax DOUBLE DEFAULT 0;
    DECLARE varInTaxP DOUBLE DEFAULT 0;
    DECLARE varOTax DOUBLE DEFAULT 0;
    DECLARE varOTaxP DOUBLE DEFAULT 0;
    DECLARE varCurAsset DOUBLE DEFAULT 0;
    DECLARE varCurAssetP DOUBLE DEFAULT 0;
    DECLARE varFixedAsset DOUBLE DEFAULT 0;
    DECLARE varFixedAssetP DOUBLE DEFAULT 0;
    DECLARE varDefAsset DOUBLE DEFAULT 0;
    DECLARE varDefAssetP DOUBLE DEFAULT 0;
    DECLARE varCurLia DOUBLE DEFAULT 0;
    DECLARE varCurLiaP DOUBLE DEFAULT 0;
    DECLARE varLTLia DOUBLE DEFAULT 0;
    DECLARE varLTLiaP DOUBLE DEFAULT 0;
    DECLARE varDefLia DOUBLE DEFAULT 0;
    DECLARE varDefLiaP DOUBLE DEFAULT 0;
    DECLARE varEquity DOUBLE DEFAULT 0;
    DECLARE varEquityP DOUBLE DEFAULT 0;
    
  
	--  We calculate the value of the sales for the given year and we store it into the variable we just declared
	SELECT SUM(jeli.credit) INTO varTotalRevenues
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "REV" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = varCalendarYear
	;
    SELECT SUM(jeli.credit) INTO varTotalRevenuesP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "REV" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = (varCalendarYear-1)
	
	;
    -- calculating COGS
    SELECT sum(COALESCE(jeli.debit,0)) INTO varCogs
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "COGS" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = varCalendarYear
	;
    SELECT sum(COALESCE(jeli.debit,0)) INTO varCogsP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "COGS" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = (varCalendarYear-1)
	;
    -- calculating Return/Refund/Discount
    SELECT sum(COALESCE(jeli.debit,0)) INTO varReturn
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "RET" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = varCalendarYear
	;
    SELECT sum(COALESCE(jeli.debit,0)) INTO varReturnP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "RET" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = (varCalendarYear-1)
	;
    -- caculating Administrative expenses
    SELECT sum(COALESCE(jeli.debit,0)) INTO varAdExp
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "GEXP" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = varCalendarYear
	;
    SELECT sum(COALESCE(jeli.debit,0)) INTO varAdExpP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "GEXP" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = (varCalendarYear-1)
	;
    -- calculating Selling expenses
    SELECT sum(COALESCE(jeli.debit,0)) INTO varSExp
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "SEXP" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = varCalendarYear
	;
    SELECT sum(COALESCE(jeli.debit,0)) INTO varSExpP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "SEXP" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = (varCalendarYear-1)
	;
    -- calculating Other expenses
    SELECT sum(COALESCE(jeli.debit,0)) INTO varOExp
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "OEXP" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = varCalendarYear
	;
    SELECT sum(COALESCE(jeli.debit,0)) INTO varOExpP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "OEXP" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = (varCalendarYear-1)
	;
    -- calculating Other income
    SELECT sum(COALESCE(jeli.credit,0)) INTO varOIncome
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "OI" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = varCalendarYear
	;
    SELECT sum(COALESCE(jeli.credit,0)) INTO varOIncomeP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "OI" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = (varCalendarYear-1)
	;
    -- calculating Income tax
    SELECT sum(COALESCE(jeli.debit,0)) INTO varInTax
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "INCTAX" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = varCalendarYear
	;
    SELECT sum(COALESCE(jeli.debit,0)) INTO varInTaxP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "INCTAX" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = (varCalendarYear-1)
	;
    -- calculating Other Tax
    SELECT sum(COALESCE(jeli.debit,0)) INTO varOTax
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "OTHTAX" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = varCalendarYear
	;
    SELECT sum(COALESCE(jeli.debit,0)) INTO varOTaxP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.`account` AS ac ON ac.account_id = jeli.account_id
		INNER JOIN H_Accounting.journal_entry  AS je ON je.journal_entry_id = jeli.journal_entry_id
		INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
      
		WHERE ss.statement_section_code = "OTHTAX" and ss.is_balance_sheet_section =  0
		AND YEAR(je.entry_date) = (varCalendarYear-1)
	;

    -- calculating current assets
	SELECT COALESCE(SUM(jeli.debit),0)-COALESCE(SUM(jeli.credit),0) INTO varCurAsset
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.account AS ac ON ac.account_id = jeli.account_id
        INNER JOIN H_Accounting.journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	    
        WHERE ss.statement_section_code = 'CA' AND je.cancelled=0
        AND YEAR(je.entry_date) = varCalendarYear
    ;
   
	 SELECT COALESCE(SUM(jeli.debit),0)-COALESCE(SUM(jeli.credit),0) INTO varCurAssetP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.account AS ac ON ac.account_id = jeli.account_id
        INNER JOIN H_Accounting.journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	    
        WHERE ss.statement_section_code = 'CA' AND je.cancelled=0
        AND YEAR(je.entry_date) = (varCalendarYear-1)
    ;
    -- calculating fixed assets
    SELECT COALESCE(SUM(jeli.debit),0)-COALESCE(SUM(jeli.credit),0) INTO varFixedAsset
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.account AS ac ON ac.account_id = jeli.account_id
        INNER JOIN H_Accounting.journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	    
        WHERE ss.statement_section_code = 'FA' AND je.cancelled=0
        AND YEAR(je.entry_date) = varCalendarYear
	;
    SELECT COALESCE(SUM(jeli.debit),0)-COALESCE(SUM(jeli.credit),0) INTO varFixedAssetP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.account AS ac ON ac.account_id = jeli.account_id
        INNER JOIN H_Accounting.journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	    
        WHERE ss.statement_section_code = 'FA' AND je.cancelled=0
        AND YEAR(je.entry_date) = (varCalendarYear-1)
	;
    -- calculating deferred asset
    SELECT COALESCE(SUM(jeli.debit),0)-COALESCE(SUM(jeli.credit),0) INTO varDefAsset
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.account AS ac ON ac.account_id = jeli.account_id
        INNER JOIN H_Accounting.journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	    
        WHERE ss.statement_section_code = 'DA' AND je.cancelled=0
        AND YEAR(je.entry_date) = varCalendarYear
	;
      SELECT COALESCE(SUM(jeli.debit),0)-COALESCE(SUM(jeli.credit),0) INTO varDefAssetP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.account AS ac ON ac.account_id = jeli.account_id
        INNER JOIN H_Accounting.journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	    
        WHERE ss.statement_section_code = 'DA' AND je.cancelled=0
        AND YEAR(je.entry_date) = (varCalendarYear-1)
	;
    -- calculating current liability
    SELECT COALESCE(SUM(jeli.credit),0)-COALESCE(SUM(jeli.debit),0) INTO varCurLia
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.account AS ac ON ac.account_id = jeli.account_id
        INNER JOIN H_Accounting.journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	    
        WHERE ss.statement_section_code = 'CL' AND je.cancelled=0
        AND YEAR(je.entry_date) = varCalendarYear
	;
    SELECT COALESCE(SUM(jeli.credit),0)-COALESCE(SUM(jeli.debit),0) INTO varCurLiaP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.account AS ac ON ac.account_id = jeli.account_id
        INNER JOIN H_Accounting.journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	    
        WHERE ss.statement_section_code = 'CL' AND je.cancelled=0
        AND YEAR(je.entry_date) = (varCalendarYear-1)
	;
    -- long term liability
    SELECT COALESCE(SUM(jeli.credit),0)-COALESCE(SUM(jeli.debit),0) INTO varLTLia
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.account AS ac ON ac.account_id = jeli.account_id
        INNER JOIN H_Accounting.journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	    
        WHERE ss.statement_section_code = 'LLL' AND je.cancelled=0
        AND YEAR(je.entry_date) = varCalendarYear
	;
    SELECT COALESCE(SUM(jeli.credit),0)-COALESCE(SUM(jeli.debit),0) INTO varLTLiaP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.account AS ac ON ac.account_id = jeli.account_id
        INNER JOIN H_Accounting.journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	    
        WHERE ss.statement_section_code = 'LLL' AND je.cancelled=0
        AND YEAR(je.entry_date) = (varCalendarYear-1)
	;
    -- deferred liability
SELECT COALESCE(SUM(jeli.credit),0)-COALESCE(SUM(jeli.debit),0) INTO varDefLia
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.account AS ac ON ac.account_id = jeli.account_id
        INNER JOIN H_Accounting.journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	    
        WHERE ss.statement_section_code = 'DL' AND je.cancelled=0
        AND YEAR(je.entry_date) = varCalendarYear
        ;
    SELECT COALESCE(SUM(jeli.credit),0)-COALESCE(SUM(jeli.debit),0) INTO varDefLiaP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.account AS ac ON ac.account_id = jeli.account_id
        INNER JOIN H_Accounting.journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	    
        WHERE ss.statement_section_code = 'DL' AND je.cancelled=0
        AND YEAR(je.entry_date) = (varCalendarYear-1)
    ;
       -- Equity
     SELECT COALESCE(SUM(jeli.credit),0)-COALESCE(SUM(jeli.debit),0) INTO varEquity
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.account AS ac ON ac.account_id = jeli.account_id
        INNER JOIN H_Accounting.journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	    
        WHERE ss.statement_section_code = 'EQ' AND je.cancelled=0
        AND YEAR(je.entry_date) = varCalendarYear
    ;
        
    SELECT COALESCE(SUM(jeli.credit),0)-COALESCE(SUM(jeli.debit),0) INTO varEquityP
		FROM H_Accounting.journal_entry_line_item AS jeli
		INNER JOIN H_Accounting.account AS ac ON ac.account_id = jeli.account_id
        INNER JOIN H_Accounting.journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN H_Accounting.statement_section AS ss ON ss.statement_section_id = ac.balance_sheet_section_id
	    
        WHERE ss.statement_section_code = 'EQ' AND je.cancelled=0
        AND YEAR(je.entry_date) = (varCalendarYear-1)
    ;

        
    -- drop temporary table if already exist
	DROP TABLE IF EXISTS H_Accounting.pjarrunakorn2020_tmp;
  
	-- Now we are certain that the table does not exist, we create with the columns that we need
	CREATE TABLE H_Accounting.pjarrunakorn2020_tmp
		(profit_loss_line_number INT, 
		label VARCHAR(50), 
	    amount VARCHAR(50),
        amount_previous_year VARCHAR(50),
        percent_change_YOY VARCHAR(50));
  
  -- insert the a header for the report
  INSERT INTO H_Accounting.pjarrunakorn2020_tmp 
		   (profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
	VALUES (1, 'PROFIT AND LOSS STATEMENT', "In '000s of USD", '','');
  
	-- insert an empty line to create some space between the header and the line items
	INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(2, '', '','','');
    
	-- insert the Total Revenues with its value
	INSERT INTO H_Accounting.pjarrunakorn2020_tmp
			(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
	VALUES 	(3, 'Total Revenues', format(varTotalRevenues / 1000, 2), format(varTotalRevenuesP / 1000, 2),format((((varTotalRevenues-varTotalRevenuesP)/varTotalRevenuesP)*100),2));

    -- insert cogs
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
			(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
	VALUES 	(4, 'COGS', format(IFNULL(varCogs,0) / 1000, 2), format(IFNULL(varCogsP,0) / 1000, 2),'');
    -- insert return/ refund/ discount
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
			(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
	VALUES 	(5, 'Return/Refund/Discount', format(IFNULL(varReturn,0) / 1000, 2), format(IFNULL(varReturnP,0) / 1000, 2),'');
  
	-- insert admin expense
	INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount , amount_previous_year,percent_change_YOY)
		VALUES 	(6, 'Administrative Expenses', format(IFNULL(varAdExp,0) / 1000, 2), format(IFNULL(varAdExpP,0) / 1000, 2),'');
	-- insert selling expense
	INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(7, 'Selling Expenses', format(IFNULL(varSExp,0) / 1000, 2), format(IFNULL(varSExpP,0) / 1000, 2),'');
	-- insert other expense
	INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(8, 'Other Expenses', format(IFNULL(varOExp,0) / 1000, 2), format(IFNULL(varOExpP,0) / 1000, 2),'');
	-- insert other income
	INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(9, 'Other Income', format(IFNULL(varOIncome,0) / 1000, 2), format(IFNULL(varOIncomeP,0) / 1000, 2),'');
	-- calculating EBIT from variables above 
	INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(10, 'EBIT', format((varTotalRevenues-IFNULL(varCogs,0)-IFNULL(varReturn,0)-IFNULL(varAdExp,0)-IFNULL(varSExp,0)-IFNULL(varOExp,0)+varOIncome) / 1000, 2), 
        format((varTotalRevenuesP-IFNULL(varCogsP,0)-IFNULL(varReturnP,0)-IFNULL(varAdExpP,0)-IFNULL(varSExpP,0)-IFNULL(varOExpP,0)+varOIncomeP) / 1000, 2),
        format(((((varTotalRevenues-IFNULL(varCogs,0)-IFNULL(varReturn,0)-IFNULL(varAdExp,0)-IFNULL(varSExp,0)-IFNULL(varOExp,0)+varOIncome))-(varTotalRevenuesP-IFNULL(varCogsP,0)-IFNULL(varReturnP,0)-IFNULL(varAdExpP,0)-IFNULL(varSExpP,0)-IFNULL(varOExpP,0)+varOIncomeP)) / 
        (varTotalRevenuesP-IFNULL(varCogsP,0)-IFNULL(varReturnP,0)-IFNULL(varAdExpP,0)-IFNULL(varSExpP,0)-IFNULL(varOExpP,0)+varOIncomeP)*100), 2)) ;
	-- insert income tax
	INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(11, 'Income Tax', format(IFNULL(varInTax,0) / 1000, 2),format(IFNULL(varInTaxP,0) / 1000, 2),'');
	-- insert other tax
	INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(12, 'Other Tax', format(IFNULL(varOTax,0) / 1000, 2),format(IFNULL(varOTaxP,0) / 1000, 2),'');
	-- calculating net income EBIT - taxes
	INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(13, 'Net Income', format((varTotalRevenues-IFNULL(varCogs,0)-IFNULL(varReturn,0)-IFNULL(varAdExp,0)-IFNULL(varSExp,0)-IFNULL(varOExp,0)+varOIncome-IFNULL(varInTax,0)-IFNULL(varOTax,0))/ 1000, 2),
        format((varTotalRevenuesP-IFNULL(varCogsP,0)-IFNULL(varReturnP,0)-IFNULL(varAdExpP,0)-IFNULL(varSExpP,0)-IFNULL(varOExpP,0)+varOIncomeP-IFNULL(varInTaxP,0)-IFNULL(varOTaxP,0))/ 1000, 2),
        format(((((varTotalRevenues-IFNULL(varCogs,0)-IFNULL(varReturn,0)-IFNULL(varAdExp,0)-IFNULL(varSExp,0)-IFNULL(varOExp,0)+varOIncome-IFNULL(varInTax,0)-IFNULL(varOTax,0))-
        (varTotalRevenuesP-IFNULL(varCogsP,0)-IFNULL(varReturnP,0)-IFNULL(varAdExpP,0)-IFNULL(varSExpP,0)-IFNULL(varOExpP,0)+varOIncomeP-IFNULL(varInTaxP,0)-IFNULL(varOTaxP,0)))/
        (varTotalRevenuesP-IFNULL(varCogsP,0)-IFNULL(varReturnP,0)-IFNULL(varAdExpP,0)-IFNULL(varSExpP,0)-IFNULL(varOExpP,0)+varOIncomeP-IFNULL(varInTaxP,0)-IFNULL(varOTaxP,0)))*100),2));
	-- insert space
	INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(14, '', '','','');
	-- insert the a header for the report
	INSERT INTO H_Accounting.pjarrunakorn2020_tmp 
		   (profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES (15, 'BALANCE SHEET STATEMENT', "In '000s of USD", '','');
	-- insert space
	INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(16, '', '','','');
	-- current asset
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(17, 'Current Asset', format(IFNULL( varCurAsset,0) / 1000, 2),format(IFNULL(varCurAssetP,0) / 1000, 2),'');
	-- fixed asset
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(18, 'Fixed Asset', format(IFNULL(varFixedAsset,0) / 1000, 2),format(IFNULL(varFixedAssetP,0) / 1000, 2),'');
	-- deferred asset
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(19, 'Deferred Asset', format(IFNULL(varDefAsset,0) / 1000, 2),format(IFNULL(varDefAssetP,0) / 1000, 2),'');
	-- total asset
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(20, 'Total Asset', format((IFNULL(varCurAsset,0)+IFNULL(varDefAsset,0)+IFNULL(varFixedAsset,0))/ 1000, 2),
        format(IFNULL(varCurAssetP + varFixedAssetP + varDefAssetP,0) / 1000, 2),
        format(((((IFNULL(varCurAsset,0)+IFNULL(varDefAsset,0)+IFNULL(varFixedAsset,0))-(IFNULL(varCurAssetP + varFixedAssetP + varDefAssetP,0)))/(IFNULL(varCurAssetP + varFixedAssetP + varDefAssetP,0)))*100),2));
	-- current liability
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(21, 'Current Liability', format(IFNULL( varCurLia,0) / 1000, 2),format(IFNULL(varCurLiaP,0) / 1000, 2),'');
        
	  -- Long-Term liability
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(22, 'Long-Term Liability', format(IFNULL( varLTLia,0) / 1000, 2),format(IFNULL(varLTLiaP,0) / 1000, 2),'');
        
	  -- Deferred liability
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(23, 'Deferred Liability', format(IFNULL( varDefLia,0) / 1000, 2),format(IFNULL(varDefLiaP,0) / 1000, 2),'');
	 --  Total Liability
     INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(24, 'Total Liability', format(IFNULL( varCurLia+ varLTLia + varDefLia,0) / 1000, 2),
        format(IFNULL(varLTLiaP + varCurLiaP + varDefLiaP,0) / 1000, 2),
        format(((((IFNULL( varCurLia+ varLTLia + varDefLia,0))-(IFNULL(varLTLiaP + varCurLiaP + varDefLiaP,0)))/(IFNULL(varLTLiaP + varCurLiaP + varDefLiaP,0)))*100) , 2));
        
	 -- Equity
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(25, 'Equity', format(IFNULL( varEquity,0) / 1000, 2),format(IFNULL(varEquityP,0) / 1000, 2),format((((IFNULL( varEquity,0)-IFNULL(varEquityP,0))/IFNULL(varEquityP,0))*100),2));
	-- Total L+E
	 INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(26, 'Total Liability and Equity', format((IFNULL( varEquity,0)+IFNULL( varCurLia,0)+IFNULL( varDefLia,0)+IFNULL( varLTLia,0))/ 1000, 2),
        format((IFNULL( varEquityP,0)+IFNULL( varCurLiaP,0)+IFNULL( varDefLiaP,0)+IFNULL( varLTLiaP,0))/ 1000, 2),
        format(((((IFNULL( varEquity,0)+IFNULL( varCurLia,0)+IFNULL( varDefLia,0)+IFNULL( varLTLia,0))-(IFNULL( varEquityP,0)+IFNULL( varCurLiaP,0)+IFNULL( varDefLiaP,0)+IFNULL( varLTLiaP,0)))/(IFNULL( varEquityP,0)+IFNULL( varCurLiaP,0)+IFNULL( varDefLiaP,0)+IFNULL( varLTLiaP,0)))*100), 2));
	-- insert space 
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(27, '','','','');
	-- Ratios heading
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(28, 'RATIOS','','','');
	-- insert space 
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(29, '','','','');
	-- net profit margin
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(30, 'Net profit margin',
        format(((varTotalRevenues-IFNULL(varCogs,0)-IFNULL(varReturn,0)-IFNULL(varAdExp,0)-IFNULL(varSExp,0)-IFNULL(varOExp,0)+varOIncome-IFNULL(varInTax,0)-IFNULL(varOTax,0))/varTotalRevenues),2),'','');
	-- return on asset 
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(31, 'Return on assets',
        format(((varTotalRevenues-IFNULL(varCogs,0)-IFNULL(varReturn,0)-IFNULL(varAdExp,0)-IFNULL(varSExp,0)-IFNULL(varOExp,0)+varOIncome-IFNULL(varInTax,0)-IFNULL(varOTax,0))/(IFNULL(varCurAsset,0)+IFNULL(varDefAsset,0)+IFNULL(varFixedAsset,0))),2),'','');
	-- return on equity
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(32, 'Return on equity',
        format(((varTotalRevenues-IFNULL(varCogs,0)-IFNULL(varReturn,0)-IFNULL(varAdExp,0)-IFNULL(varSExp,0)-IFNULL(varOExp,0)+varOIncome-IFNULL(varInTax,0)-IFNULL(varOTax,0))/(IFNULL( varEquity,0))),2),'','');
	-- Total liabilities ratio 
    INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(33, 'Total Liabilities Ratio', 
        format((IFNULL( varCurLia+ varLTLia + varDefLia,0))/(IFNULL(varCurAsset,0)+IFNULL(varDefAsset,0)+IFNULL(varFixedAsset,0)), 2),'',  '');

	-- current ratio
     INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(34, 'Current Ratio ', 
        format((IFNULL(varCurAsset,0))/(IFNULL( varCurLia,0)), 2), '', '');
    -- total asset turnover
     INSERT INTO H_Accounting.pjarrunakorn2020_tmp
				(profit_loss_line_number, label, amount, amount_previous_year,percent_change_YOY)
		VALUES 	(35, 'Total Asset Turnover', 
        format((IFNULL(varTotalRevenues,0))/(IFNULL(varCurAsset,0)+IFNULL(varDefAsset,0)+IFNULL(varFixedAsset,0)), 2), '', '');

	
	
END $$
DELIMITER ;
# THE LINE ABOVES CHANGES BACK OUR DELIMETER TO OUR USUAL ;

CALL H_Accounting.sp_pjarrunakorn2020 (2017);

SELECT * FROM H_Accounting.pjarrunakorn2020_tmp;




