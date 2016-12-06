
DELETE FROM T_Report_Group
INSERT INTO T_Report_Group (Report_Group_Label) VALUES('Others')
INSERT INTO T_Report_Group (Report_Group_Label) VALUES(' WEIGHT STATUS')
INSERT INTO T_Report_Group (Report_Group_Label) VALUES('BDD REPORT')
INSERT INTO T_Report_Group (Report_Group_Label) VALUES('System Integration')
INSERT INTO T_Report_Group (Report_Group_Label) VALUES('MAFU')
INSERT INTO T_Report_Group (Report_Group_Label) VALUES('INDUSTRIAL')
INSERT INTO T_Report_Group (Report_Group_Label) VALUES('MSN Definition')
INSERT INTO T_Report_Group (Report_Group_Label) VALUES('ELCODATA')
INSERT INTO T_Report_Group (Report_Group_Label) VALUES('EYDL')
DELETE FROM t_dbactions
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT '3DQM Extract from System View','SELECT SUBSTRING(tmpsv_DS.BWTPARTNUMBER, 2, LEN(tmpsv_DS.BWTPARTNUMBER) - 1) AS [FIN-DS id], tmpsv_DSMSNRANGE.DSMSNList, tmpsv_PN.FSCM AS [FSCM], tmpsv_PN.PARTNUMBER AS [Part number], tmpsv_PN.EQUIPMENTMODEL AS [NSEDB Equipment model Counter Reference] FROM tmpsv_DS INNER JOIN tmpsv_PN ON tmpsv_PN.BIDA2A2 = tmpsv_DS.IDPN INNER JOIN tmpsv_DSMSNRANGE ON tmpsv_DSMSNRANGE.BIDA2A2=tmpsv_ds.BIDA2A2',null,null,null,null,null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='Others'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT '3DQM Global Report','SELECT FIN, FunctionnalDesignation AS [Functional Designation], InstallationResp AS [Installation Design Responsibility], ATACode AS [Sub ATA Reference], PN AS [Equipment Part Number], CounterRef AS [Equipment Model Counter Reference], CounterMaturity AS [Equipment Maturity State], FINCategory AS [FIN Category], DSEffectivity AS [MSN Specific] FROM R_ATA JOIN R_FIN_CI ON idr_ata = id_ata JOIN R_FIN_DS ON idr_fin = id_fin JOIN R_Equipment ON id_equip = idr_equip LEFT JOIN ( SELECT CounterRef, CounterMaturity, COUNTER__EQUIPMENT_EQUIPMENT_idr FROM DBWPF150.dbo.T_LINK_COUNTER__EQUIPMENT JOIN DBWPF150.dbo.T_COUNTER ON COUNTER_id = COUNTER__EQUIPMENT_COUNTER_idr JOIN DBWPF150.dbo.T_INVARIANT ON INVARIANT_id = COUNTER_INVARIANT_idr WHERE CounterToBeUsed = ''yes'' AND InvariantProgram = ''A400M'' ) MODEL ON MODEL.COUNTER__EQUIPMENT_EQUIPMENT_idr = R_Equipment.PN',null,null,null,null,null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='Others'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'Redundant BITE LRU Code','SELECT [Redundant BITE LRU Code], FIN FROM R_FIN_CI JOIN ( SELECT bite_lru_code, ''Code : '' + bite_lru_code AS [Redundant BITE LRU Code] FROM R_FIN_CI WHERE bite_lru_code <> '''' AND bite_lru_code IS NOT NULL GROUP BY bite_lru_code HAVING COUNT(id_fin)>1 ) AS DoubleBITE ON R_FIN_CI.bite_lru_code = DoubleBITE.bite_lru_code ORDER BY [Redundant BITE LRU Code]','- List all Redundant BITE LRU Codes in the database',null,null,null,null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='Others'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'System View Equipment models','SELECT PARTNUMBER AS [PART NUMBER], COUNTERREF AS [COUNTER REFERENCE], tmpsv_EQUIPMENTMODEL.STATESTATE AS [MODEL STATE] FROM tmpsv_PN LEFT JOIN tmpsv_EQUIPMENTMODEL ON tmpsv_PN.IDMODEL = tmpsv_EQUIPMENTMODEL.IDA2A2 ORDER BY PARTNUMBER','- List of System View equipments with associated models',null,null,null,null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='Others'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'MSN XX Definition','sp_MSNDefinition #','- Definition of a given MSN (SI + series)','MSN_definition.php','Enter the number of MSN :#num_msn',null,null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='Others'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'CHIFS_DL','SELECT [FIN CI], SYSTEM_NAME, STDA_SW_RANK, LRU_TYPE_NAME, LRU_POSITION, THW_ID_1, THW_ID_2, THW_ID_3, THW_ID_4, [Reported Designation], [DL PROTOCOL], [LI For THW_ID_1], [LIO For THW_ID_1], [LI For THW_ID_2], [LIO For THW_ID_2], [LI For THW_ID_3], [LIO For THW_ID_3], [LI For THW_ID_4], [LIO For THW_ID_4] FROM ( SELECT 0 ORD, ''#================================================================================ # ## SCD_DM Name: DL_EXTRACT ## SCD_DM Reference: NA ## SCD_DM Version: NA ## Last Modification Date: NA ## Tool Name: pse ## Tool Version: ## SCD_DM specification document: SCD specification document ## SCD_DM specification document reference: LXXRQ0601172 ## SCD_DM specification document version: 01 ## CRC: NA ## Author : NA # #================================================================================ #Begin'' AS [FIN CI], NULL AS SYSTEM_NAME, NULL AS STDA_SW_RANK, NULL AS LRU_TYPE_NAME, NULL AS LRU_POSITION, NULL AS THW_ID_1, NULL AS THW_ID_2, NULL AS THW_ID_3, NULL AS THW_ID_4, NULL AS [Reported Designation], NULL AS [DL PROTOCOL], NULL AS [LI For THW_ID_1], NULL AS [LIO For THW_ID_1], NULL AS [LI For THW_ID_2], NULL AS [LIO For THW_ID_2], NULL AS [LI For THW_ID_3], NULL AS [LIO For THW_ID_3], NULL AS [LI For THW_ID_4], NULL AS [LIO For THW_ID_4] UNION SELECT 1 ORD, ''#FIN;SYSTEM_NAME;STDA_SW_RANK;LRU_TYPE_NAME;LRU_POSITION;THW_ID_1;THW_ID_2;THW_ID_3;THW_ID_4;Reported Designation;DL PROTOCOL;LI For THW_ID_1;Lio For THW_ID_1;LI For THW_ID_;Lio For THW_ID_2;LI For THW_ID_3;Lio For THW_ID_3;LI For THW_ID_4;Lio For THW_ID_4'' AS [FIN CI], NULL AS SYSTEM_NAME, NULL AS STDA_SW_RANK, NULL AS LRU_TYPE_NAME, NULL AS LRU_POSITION, NULL AS THW_ID_1, NULL AS THW_ID_2, NULL AS THW_ID_3, NULL AS THW_ID_4, NULL AS [Reported Designation], NULL AS [DL PROTOCOL], NULL AS [LI For THW_ID_1], NULL AS [LIO For THW_ID_1], NULL AS [LI For THW_ID_2], NULL AS [LIO For THW_ID_2], NULL AS [LI For THW_ID_3], NULL AS [LIO For THW_ID_3], NULL AS [LI For THW_ID_4], NULL AS [LIO For THW_ID_4] UNION SELECT 3 ORD, ''#End'' AS [FIN CI], NULL AS SYSTEM_NAME, NULL AS STDA_SW_RANK, NULL AS LRU_TYPE_NAME, NULL AS LRU_POSITION, NULL AS THW_ID_1, NULL AS THW_ID_2, NULL AS THW_ID_3, NULL AS THW_ID_4, NULL AS [Reported Designation], NULL AS [DL PROTOCOL], NULL AS [LI For THW_ID_1], NULL AS [LIO For THW_ID_1], NULL AS [LI For THW_ID_2], NULL AS [LIO For THW_ID_2], NULL AS [LI For THW_ID_3], NULL AS [LIO For THW_ID_3], NULL AS [LI For THW_ID_4], NULL AS [LIO For THW_ID_4] UNION SELECT 2 ORD, R_FIN_CI.FIN AS [FIN CI], SYSTEM_NAME AS SYSTEM_NAME, STDA_SW_RANK AS STDA_SW_RANK, LRU_TYPE_NAME AS LRU_TYPE_NAME, LRU_POSITION AS LRU_POSITION, THW_ID_1 AS THW_ID_1, THW_ID_2 AS THW_ID_2, THW_ID_3 AS THW_ID_3, THW_ID_4 AS THW_ID_4, STDA_DESIGNATION AS [Reported Designation], DL_PROTOCOL AS [DL PROTOCOL], LITHW_ID_1 AS [LI For THW_ID_1], LIOTHW_ID_1 AS [LIO For THW_ID_1], LITHW_ID_2 AS [LI For THW_ID_2], LIOTHW_ID_2 AS [LIO For THW_ID_2], LITHW_ID_3 AS [LI For THW_ID_3], LIOTHW_ID_3 AS [LIO For THW_ID_3], LITHW_ID_4 AS [LI For THW_ID_4], LIOTHW_ID_4 AS [LIO For THW_ID_4] FROM R_ATA JOIN R_FIN_CI ON R_FIN_CI.idr_ata = R_ATA.id_ata WHERE R_FIN_CI.BITEConfReport = ''Yes'' ) TMP ORDER BY ORD, [FIN CI]','- CHIFS FIN list',' ',' ','V1.0',' ',report_group_id FROM T_REPORT_GROUP WHERE report_group_label='Others'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'CHIFS_FIN','SELECT ATA, [Functional Designation], [FIN CI], [FIN Configuration Reported], [Associated FIN CI], [Link Type], [FIN Category] FROM ( SELECT 0 ORD, ''#Begin'' ATA, NULL AS [Functional Designation], NULL AS [FIN CI], NULL AS [FIN Configuration Reported], NULL AS [Associated FIN CI], NULL AS [Link Type], NULL AS [FIN Category] UNION SELECT 1 ORD, ''#ATA;Functional Designation;FIN CI;FIN Configuration Reported;Associated FIN CI;Link Type;FIN Category'' ATA, NULL AS [Functional Designation], NULL AS [FIN CI], NULL AS [FIN Configuration Reported], NULL AS [Associated FIN CI], NULL AS [Link Type], NULL AS [FIN Category] UNION SELECT 3 ORD, ''#End'' ATA, NULL AS [Functional Designation], NULL AS [FIN CI], NULL AS [FIN Configuration Reported], NULL AS [Associated FIN CI], NULL AS [Link Type], NULL AS [FIN Category] UNION SELECT 2 ORD, ATACode AS ATA, R_FIN_CI.FunctionnalDesignation AS [Functional Designation], R_FIN_CI.FIN AS [FIN CI], CASE WHEN R_FIN_CI.BITEConfReport = ''Yes'' THEN ''Y'' ELSE ''N'' END AS [FIN Configuration Reported], ASSFIN.FIN AS [Associated FIN CI], ASSFIN.link_type AS [Link Type], R_FIN_CI.FINCategory AS [FIN Category] FROM R_ATA JOIN R_FIN_CI ON R_FIN_CI.idr_ata = R_ATA.id_ata LEFT JOIN ( SELECT FIN, R_FIN_LINK.idr_fin_link, R_FIN_LINK.link_type FROM R_FIN_CI JOIN R_FIN_LINK ON R_FIN_LINK.id_fin_link = R_FIN_CI.id_fin WHERE link_type = ''SOFTWARE/HARDWARE'' ) ASSFIN ON ASSFIN.idr_fin_link = R_FIN_CI.id_fin WHERE R_FIN_CI.finci_status = ''DESIGNATION_OK'' ) TMP ORDER BY ORD, [FIN CI]','- CHIFS FIN list',' ',' ','V1.0',' ',report_group_id FROM T_REPORT_GROUP WHERE report_group_label='Others'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'Weight CDBTs Report','sp_WEIGHTREPORT #msn-obs#','- Weight CDBTs Report','Weight_Report.php','Enter MSN :#MSN;Enter OBS : #&OBS:select BNAME from tmpsv_OBS order by BNAME','<b><u> CAUTION </u> : Please note that after a change, your report will be updated each night and available corrected the day after. </b><br><br><dd>The weight report is associated to an aircraft effectivity to minimise the report size. The basic aircraft(CSA) is the same for each aircraft. It is recommended to choose an effectivity after the first EIS to avoid instrumented A/Cs. For option extraction, it is necessary to prior refer to your TLAR Option/Aircraft customisation table to find the right effectivity. <br><dd>If one effectivity is mandatory for the extraction, the CDBT field can be empty and your generated report will provide you with all CDBTs weight data information for one effectivity.<br><dd>The database is live, and does not represent any specific baseline.Weight Baseline data is managed by exporting and capturing into an independent report as defined in System Development Plans. <br><dd>Only, SERIAL Design Solution DS are taken in account.','MSN',report_group_id FROM T_REPORT_GROUP WHERE report_group_label=' WEIGHT STATUS'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'Option / MOD - Cross table list','select modreference as MOD,option_reference as [Option reference],option_name as [Option name] from t_option inner join t_link_mod_option on id_option=mod_option_option_idr inner join t_mod on id_mod=mod_option_mod_idr','- This Cross table list gives the link between Exhibit P options and their introduction modification.','Weight_Cross_Table_MOD_Option.php',null,null,null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label=' WEIGHT STATUS'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'Calculated CDBT Mass (Mixed)',null,'- Distributed per ACMT and CMIT','Weight_OBS_pdf.php','Enter MSN :#MSN;Enter OBS : #&OBS:select BNAME from tmpsv_OBS order by BNAME','<b><u> CAUTION </u> : Please note that after a change, your report will be updated each night and available corrected the day after. </b><br><br><dd>The PDF weight report of <b><u>Calculated Mass CDBT (Mixed)</u></b> is associated to an aircraft effectivity to minimise the report size. The basic aircraft (CSA) is the same for each aircraft. It is recommended to choose an effectivity after the first EIS to avoid instrumented A/Cs. For option extraction, it is necessary to prior refer to your TLAR Option/Aircraft customisation table to find the right effectivity.<br /><br />If one effectivity is mandatory for the extraction, the CDBT field can be empty and your generated report will provide you with all CDBTs weight data information for one effectivity.<br /><br />This PDF report is calculated from the Excel Weight CDBT''s report , you can find in the Weight Status window. As the database is live, and does not represent any specific baseline and Weight Baseline data is managed by exporting and capturing into an independent report as defined in System Development Plans , we recommend you to extract in the same time as this PDF report , its associated Excel Weight CDBT''s report.</dd>','MSN',report_group_id FROM T_REPORT_GROUP WHERE report_group_label=' WEIGHT STATUS'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'Calculated CDBT Mass (Mixed) into ATA',null,'- Distributed into ATA per installation configuration criteria','Weight_ATA_pdf.php','Enter MSN :#MSN;Enter OBS : #&OBS:select BNAME from tmpsv_OBS order by BNAME','<b><u> CAUTION </u> : Please note that after a change, your report will be updated each night and available corrected the day after. </b><br><br><dd>The PDF weight report of <b><u>Calculated Mass CDBT (Mixed) into ATA</u></b> is associated to an aircraft effectivity to minimise the report size. The basic aircraft (CSA) is the same for each aircraft. It is recommended to choose an effectivity after the first EIS to avoid instrumented A/Cs. For option extraction, it is necessary to prior refer to your TLAR Option/Aircraft customisation table to find the right effectivity.<br /><br />If one effectivity is mandatory for the extraction, the CDBT field can be empty and your generated report will provide you with all CDBTs weight data information for one effectivity.<br /><br />This PDF report is calculated from the Excel Weight CDBT''s report , you can find in the Weight Status window. As the database is live, and does not represent any specific baseline and Weight Baseline data is managed by exporting and capturing into an independent report as defined in System Development Plans , we recommend you to extract in the same time as this PDF report , its associated Excel Weight CDBT''s report .<br /><br />Note that this report provided as TBC list : the uncompleted data FIN-CI list if extract is performed for a CDBT.</dd>','MSN',report_group_id FROM T_REPORT_GROUP WHERE report_group_label=' WEIGHT STATUS'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'BDD LRU data export','SELECT MAX(R_ATA.ATACode) AS ATA, R_FIN_CI.FIN, SUBSTRING(MAX(R_FIN_CI.FunctionnalDesignation),0,54) AS [Functional Designation], MIN(R_FIN_CI.finci_status) AS [Functional Designation Status], SUBSTRING(MAX(R_FIN_DS.InstallationPanel),0,6) AS [Installation panel], MAX(R_FIN_DS.InstallationZone) AS [Installation zone], MAX(R_FIN_CI.AccessDoor) AS [Acces door], R_FIN_CI.bite_lru_code AS Code, MAX(R_FIN_CI.BITESystem) AS System FROM R_FIN_CI LEFT OUTER JOIN R_ATA ON R_FIN_CI.idr_ata = R_ATA.id_ata LEFT OUTER JOIN R_FIN_DS ON R_FIN_DS.idr_fin = R_FIN_CI.id_fin WHERE (R_FIN_CI.bite_lru_code IS NOT NULL) AND (R_FIN_CI.bite_lru_code <> '''') AND (R_FIN_DS.ds_type = 0 OR R_FIN_DS.ds_type IS NULL) GROUP BY R_FIN_CI.bite_lru_code, R_FIN_CI.FIN ORDER BY R_FIN_CI.bite_lru_code','- Export to BDD data base','export_csv.php',null,null,null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='BDD REPORT'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'System & Installation Designers report for System Integration (SyDDR & Installation Section, Zone, Panel & CDBT Report)',null,'Provide installation location and reference data for System Hardware Mechanical Integration.','System_integration.php','Enter MSN :#MSN; Enter FINDS Type : #&TYPEDS:select distinct DSTYPE from tmpsv_DS order by DSTYPE; Enter FINCI Definition Responsability OBS (from Primes System): #&OBS:select BNAME from tmpsv_OBS order by BNAME;Enter Installation Section (from Primes System): #&SECTION:select choicevalue from t_choicelist where choicelist=''Sections'' order by 1; Enter Installation Zone (from Primes System): #&Zone:select Uniqueid+''/''+designation from tmpsv_location where loctype=''Zone'';Enter Installation Panel : #&PANEL:select Uniqueid from tmpsv_location where loctype=''Panel''; Enter SIRDocument reference (in progress, please don''t use) : #SIRD; Enter EIRDocument reference (in progress, please don''t use): #EIRD; Enter FINCI Installation Responsibility OBS (From Primes SSI): #OBSPSSI; Enter Installation Section (from Primes SSI): #SECTIONPSSI','The SyDDR & Installation Section, Zone, Panel Report is associated to an aircraft effectivity to minimise the report size. It is based on databank attribute requested for SyDDR using APEDD extract with additional attributes introduced by the management into configuration.<br>The Basic aircraft (CSA) is the same for each aircraft. It is recommended to choose an effectivity after the first EIS to avoid instrumented A/Cs.<br>For Option extraction, it is necessary to prior refer to your TLAR Option/Aircraft customisation table to find the right effectivity.<br>If one effectivity is mandatory for the extraction, all the other fields can be empty and your generated report will provide you with all installation data information for one effectivity.<br>This database is live, and does not represent any specific baseline. Installation Baseline data is managed by exporting and capturing into an independent report as defined in the respective System Development Plans.<br>Via the FINDS type, you can distinguish SERIAL and Development Design Solutions.','MSN',report_group_id FROM T_REPORT_GROUP WHERE report_group_label='System Integration'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'MAFU FCP general report','sp_MAFUFCPGeneralReport #''CR_CL'',''MP_CL'',''CR_Status'',''MP_Status'',''CR_Linvolved''#','- CR, MP, TRS, SubTRS, MOD, CIN�','MAFU_A400M_FCPGeneralReport.php','CR Change Leader : #&CR_CL:SELECT user_surname + '' '' + user_first_name FROM T_USER INNER JOIN T_LINK_ROLE_USER ON T_USER.user_id = T_LINK_ROLE_USER.idr_user INNER JOIN T_USER_ROLE ON idr_user_role = id_role WHERE name_role = ''MAFU Change Leader'' ORDER BY user_surname#; MP Change Leader : #&MP_CL:SELECT user_surname + '' '' + user_first_name FROM T_USER INNER JOIN T_LINK_ROLE_USER ON T_USER.user_id = T_LINK_ROLE_USER.idr_user INNER JOIN T_USER_ROLE ON idr_user_role = id_role WHERE name_role = ''MAFU Change Leader'' ORDER BY user_surname#; CR STATUS : #&CR_Status:SELECT ''CANCELLED'' UNION SELECT ''FULLY COVERED'' UNION SELECT ''IN EVALUATION'' UNION SELECT ''IN INVESTIGATION'' UNION SELECT ''IN INITIALISATION'' ORDER BY 1#; MP STATUS : #&MP_Status:SELECT DISTINCT MPStatus FROM T_MP WHERE MPStatus is not null ORDER BY 1#; CR Leader or Involved ? : #&CR_Linvolved:SELECT ''LEADER'' UNION SELECT ''INVOLVED'' UNION SELECT ''NOT INVOLVED'' UNION SELECT ''POTENTIALLY IMPACTED''ORDER BY 1','Select the change leader''s name to see all the items for which he is the leader or concerned by. No selection = all items',null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='MAFU'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'MAFU CR Agenda','MAFUNextMeeting','- Export the schedule of the next meeting for CR with choice of type of meeting','MAFU_A400M_meeting_excel_export.php','Choose the meeting : #&meetingName:SELECT ''SYS CCC'' UNION SELECT ''PROG CCC'' UNION SELECT ''CCB'' UNION SELECT ''CR received impact statement'' ORDER BY 1','<b><u>This report retrieve meetings of the current week</u></b>',null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='MAFU'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'MAFU Delta -1','EXECUTE[MAFU_Delta1]','- Delta -1 follow up',null,null,null,null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='MAFU'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'MAFU CR MoM','MAFULastMoM','- Export the last Minute of Meeting for CR with choice of dates','MAFU_A400M_MoM_meeting_excel_export.php','Choose the meeting : #&meetingName:SELECT ''SYS CCC'' UNION SELECT ''PROG CCC'' UNION SELECT ''CCB'' UNION SELECT ''CR received impact statement'' ORDER BY 1;From (dd/mm/yyyy) :#dateBegining;To (dd/mm/yyyy) :#dateEnd','<b><u>All the folowing fields are mandatory</u></b>',null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='MAFU'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'MAFU MP Agenda','MAFUNextMeetingMP','- Export the schedule of the next meeting for MP with choice of type of meeting','MAFU_A400M_meetingMP_excel_export.php','Choose the meeting : #&meetingName:SELECT ''SYS CCC'' UNION SELECT ''PROG CCC'' UNION SELECT ''CCB'' ORDER BY 1','<b><u>This report retrieve meetings of the current week</u></b>',null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='MAFU'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'MAFU MP MoM','MAFULastMoMMP','- Export the last Minute of Meeting for MP with choice of dates','MAFU_A400M_MoM_meeting_excel_export.php','Choose the meeting : #&meetingName:SELECT ''SYS CCC'' UNION SELECT ''PROG CCC'' UNION SELECT ''CCB'' ORDER BY 1;From (dd/mm/yyyy) :#dateBegining;To (dd/mm/yyyy) :#dateEnd','<b><u>All the folowing fields are mandatory</u></b>',null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='MAFU'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'MAFU CR with wrong linked ATA in ICC or ERoom','SELECT RequestReference AS [CR REFERENCE], RequestTitle AS [CR TITLE], OriginatorACMT AS [Originator ACMT] FROM T_REQUEST WHERE (IsATAMissing = ''1'')','- CR with ATA to be munually linked',null,null,null,null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='MAFU'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'MAFU ACMT SYS FCP KPIs report - MP&MOD register','MAFUCRMPMOD',null,'MAFU_A400M_CRMPMOD.php',null,null,null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='MAFU'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'MAFU ACMT SYS FCP KPIs report - CR received','SELECT DISTINCT T_REQUEST.RequestReference AS [CR Reference], T_REQUEST.OriginatorACMT AS [Originator ACMT], CASE WHEN T_MEETING.meetComment LIKE (''%Impacted%'') THEN CONVERT(varchar,T_MEETING.meetDate,103) ELSE '''' END AS [Meeting date], T_REQUEST.Linvold AS [Leader or Involved ?] FROM T_REQUEST LEFT OUTER JOIN T_MEETING ON T_REQUEST.id_request = T_MEETING.idr_request WHERE (T_REQUEST.OriginatorACMT <> ''SYS'') OR (T_REQUEST.OriginatorACMT IS NULL)',null,null,null,null,null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='MAFU'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'ELCODATA Atributes properties','sp_MGAttributsReport','- List of ELCODATA attributes properties: Rights for each role, Maturity Gate for which it is mandatory, List of choices, Group',' ',' ','- List of ELCODATA attributes properties: Rights for each role, Maturity Gate for which it is mandatory, List of choices, Group',' ',report_group_id FROM T_REPORT_GROUP WHERE report_group_label='ELCODATA'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'A400M extract data from migration','sp_extract_migration','Data extracted from the last migration for A400M',' ',' ','Data extracted from the last migration for A400M',' ',report_group_id FROM T_REPORT_GROUP WHERE report_group_label='ELCODATA'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'Global MSN Definition','sp_MSN_Definition DBWVE120,#''1'',''2'',''3'',''4'',''5'',''6'',''7'',''8'',''9'',''10'',''11'',''12'',''13'',''14'',''15'',''16'',''17'',''18'',''19'',''20'',''21'',''22'',''23'',''24'',''25'',''26'',''27'',''80'',''28'',''29'',''30'',''31'',''32'',''33'',''34'',''83'',''84'',''35'',''76'',''77'',''81'',''36'',''37'',''38'',''39'',''40'',''41'',''42'',''43'',''44'',''45'',''46'',''47'',''48'',''49'',''50'',''51'',''52'',''53'',''54'',''55'',''56'',''57'',''58'',''59'',''60'',''61'',''62'',''63'',''85'',''86'',''64'',''78'',''79'',''82'',''65'',''66'',''67'',''68'',''69'',''70'',''71'',''72'',''73'',''74'',''75''#','- CSV format','export_csv.php','MSN :#1#;SUBATA-DS Name :#2#;FIN-CI Name :#3#;FIN-CI Status :#4#;FIN-CI Category :#5#;FIN-CI Functional Designation :#6#;FIN-CI Definition Resp. NatCo :#7#;FIN-CI Design Focal Point :#8#;FIN-CI Installation Site :#9#;FIN-CI Provisioning Site :#10#;FIN-CI Installation Design Resp :#11#;FIN-CI OBS :#12#;FIN-CI WCL Code :#13#;FIN-CI AC/ICD Root File Name :#14#;FIN-CI ICD Folder Name :#15#;Serial FIN-DS CA :#16#;Serial FIN-DS Name :#17#;Serial FIN-DS Purchase Quantity :#18#;Serial FIN-DS State :#19#;Serial FIN-DS Effectivity :#20#;Serial FIN-DS AIR Recorded :#21#;Serial FIN-DS Installation Zone :#22#;Serial FIN-DS Installation Section :#23#;Serial FIN-DS Installation Panel :#24#;Serial FIN-DS provisioning type :#25#;Serial FIN-DS ANSI Code :#26#;Serial FIN-DS Loading type :#27#;Serial DS REQUIREMENT Stacking :#80#;Serial REQUIREMENT Stacking :#28#;Serial REQUIREMENT State :#29#;Serial NSEDB PN :#30#;Serial NSEDB CMS :#31#;Serial NSEDB DAL :#32#;Serial NSEDB Supplier Technological Designation :#33#;Serial NSEDB PTS Document Reference :#34#;Serial NSEDB PTS Reference Issue :#83#;Serial NSEDB DDP Document Reference :#84#;Serial NSEDB DDP Reference Issue :#35#;Serial NSEDB State :#76#;Serial NSEDB Calculated Weight Grammes :#77#;Serial NSEDB Estimated Weight Grammes :#81#;Serial NSEDB RFI RFP PTS Guaranteed Weigh Grammes :#36#;Serial NSEDB For ground use only :#37#;Serial NSEDB Serialisation :#38#;Serial NSEDB Acceptance sheet weighed weight :#39#;Serial NSEDB AC/ICD Folder Version :#40#;Serial SUPPLIER FSCM :#41#;Serial SUPPLIER Name :#42#;Serial Model Reference :#43#;Serial Model Maturity :#44#;MP :#45#;MOD :#46#;Development FIN-DS CA :#47#;Development FIN-DS Name :#48#;Development FIN-DS Purchase Quantity :#49#;Development FIN-DS State :#50#;Development FIN-DS Effectivity :#51#;Development FIN-DS AIR Recorded :#52#;Development FIN-DS Installation Zone :#53#;Development FIN-DS Installation Section :#54#;Development FIN-DS Installation Panel :#55#;Development FIN-DS provisioning type :#56#;Development FIN-DS ANSI Code :#57#;Development FIN-DS Loading type :#58#;Development NSEDB PN :#59#;Development NSEDB CMS :#60#;Development NSEDB DAL :#61#;Development NSEDB Supplier Technological Designation :#62#;Development NSEDB PTS Document Reference :#63#;Development NSEDB PTS Reference Issue :#85#;Development NSEDB DDP Document Reference :#86#;Development NSEDB DDP Reference Issue :#64#;Development NSEDB State :#78#;Development NSEDB Calculated Weight Grammes :#79#;Development NSEDB Estimated Weight Grammes :#82#;Serial NSEDB RFI RFP PTS Guaranteed Weigh Grammes :#65#;Development NSEDB For ground use only :#66#;Development NSEDB Serialisation :#67#;Development NSEDB Acceptance sheet weighed weight :#68#;Development NSEDB AC/ICD Folder Version :#69#;Development SUPPLIER FSCM :#70#;Development SUPPLIER Name :#71#;Development Model Reference :#72#;Development Model Maturity :#73#;SI Reference :#74#;SI State :#75#','V1.0 All FIN, Both Effective FIN-DS (Serial + dev)',null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='MSN Definition'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'Consolidated MSN Definition','sp_Consolidated_MSN_Definition DBWVE120,#''1'',''2'',''3'',''4'',''5'',''6'',''7'',''8'',''9'',''10'',''11'',''12'',''13'',''14'',''15'',''16'',''17'',''18'',''19'',''20'',''21'',''22'',''23'',''24'',''25'',''26'',''27'',''28'',''30'',''31'',''32'',''33'',''34'',''83'',''84'',''35'',''76'',''77'',''81'',''36'',''37'',''38'',''39'',''40'',''41'',''42'',''43'',''44'',''45'',''46'',''74'',''75''#','- CSV format','export_csv.php','MSN :#1#;SUBATA-DS Name :#2#;FIN-CI Name :#3#;FIN-CI Status :#4#;FIN-CI Category :#5#;FIN-CI Functional Designation :#6#;FIN-CI Definition Resp. NatCo :#7#;FIN-CI Design Focal Point :#8#;FIN-CI Installation Site :#9#;FIN-CI Provisioning Site :#10#;FIN-CI Installation Design Resp :#11#;FIN-CI OBS :#12#;FIN-CI WCL Code :#13#;FIN-CI AC/ICD Root File Name :#14#;FIN-CI ICD Folder Name :#15#;Serial FIN-DS CA :#16#;FIN-DS Name :#17#;FIN-DS Purchase Quantity :#18#;FIN-DS State :#19#;FIN-DS Effectivity :#20#;FIN-DS AIR Recorded :#21#;FIN-DS Installation Zone :#22#;FIN-DS Installation Section :#23#;FIN-DS Installation Panel :#24#;FIN-DS provisioning type :#25#;FIN-DS ANSI Code :#26#;FIN-DS Loading type :#27#;REQUIREMENT Stacking :#28#;NSEDB PN :#30#;NSEDB CMS :#31#;NSEDB DAL :#32#;NSEDB Supplier Technological Designation :#33#;NSEDB PTS Document Reference :#34#;NSEDB PTS Reference Issue :#83#;NSEDB DDP Document Reference :#84#;NSEDB DDP Reference Issue :#35#;NSEDB State :#76#;NSEDB Calculated Weight Grammes :#77#;NSEDB Estimated Weight Grammes :#81#;NSEDB RFI RFP PTS Guaranteed Weigh Grammes :#36#;NSEDB For ground use only :#37#;NSEDB Serialisation :#38#;NSEDB Acceptance sheet weighed weight :#39#;NSEDB AC/ICD Folder Version :#40#;SUPPLIER FSCM :#41#;SUPPLIER Name :#42#;Model Reference :#43#;Model Maturity :#44#;MP :#45#;MOD :#46#;SI Reference :#74#;SI State :#75#','Only FIN having 1 FIN-DS effective (Serial or Dev), Only 1 DS FIN-DS (Dev else Serial)',null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='MSN Definition'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'Consolidated MSN Definition for MIS','sp_Consolidated_MSN_Definition_for_MIS DBWVE120,#''1''#','- CSV format','export_csv.php','MSN :#1#','Only FIN having 1 FIN-DS effective (Serial or Dev), Only 1 DS FIN-DS (Dev else Serial), including Filters for MIS',null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='MSN Definition'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'Modification on Equipment PN reference','sp_ModificationOnPN ''#beginDate#'',''#endDate#''','- Identify all Equipments in System View when for the same CMS, the Part Number has changed.',null,'Enter a start date (dd/mm/yyyy) :#beginDate#;Enter a end date (dd/mm/yyyy) :#endDate#',null,'beginDate,endDate',report_group_id FROM T_REPORT_GROUP WHERE report_group_label='EYDL'
INSERT INTO T_dbactions (label,command,comments,template_page,parameters,report_commentary,mandatory_fields,report_group_idr) SELECT 'EIRD Report','sp_EIRD_Report DBWVE120,#1#','- List of equipment models per MSN',null,'MSN :#1#','List of equipment models per MSN',null,report_group_id FROM T_REPORT_GROUP WHERE report_group_label='EYDL'