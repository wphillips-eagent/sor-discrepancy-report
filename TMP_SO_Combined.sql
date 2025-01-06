USE EAGENT_HOTFILES_SD;

SELECT
    'TMP' AS [From],
    T.NIC,  -- Keep NIC from TMP
    T.SRN,
    T.MKE,
    T.MKET,
    T.ORI,
    T.ATR,
    T.NAM,
    T.SEX,
    T.RAC,
    T.ETN,
    T.POB,
    -- Handle DOB in MM-DD-YY format
    CASE
        WHEN TRY_CONVERT(DATE, REPLACE(T.DOB, '-', '/'), 101) IS NOT NULL
        THEN CONVERT(VARCHAR(10), TRY_CONVERT(DATE, REPLACE(T.DOB, '-', '/'), 101), 101)
        ELSE NULL
    END AS DOB,
    -- Handle ORD in MM-DD-YY format
    CASE
        WHEN TRY_CONVERT(DATE, REPLACE(T.ORD, '-', '/'), 101) IS NOT NULL
        THEN CONVERT(VARCHAR(10), TRY_CONVERT(DATE, REPLACE(T.ORD, '-', '/'), 101), 101)
        ELSE NULL
    END AS ORD,
    T.ERD,
    T.SXP,
    T.HGT,
    T.WGT,
    T.EYE,
    T.HAI,
    T.FBI,
    T.SKN,
    T.SMT,
    T.FPC,
    T.MNU,
    T.SOC,
    T.OLN,
    T.OLS,
    T.OLY,
    T.CRR,
    -- Handle CON in MM-DD-YY format
    CASE
        WHEN TRY_CONVERT(DATE, REPLACE(T.CON, '-', '/'), 101) IS NOT NULL
        THEN CONVERT(VARCHAR(10), TRY_CONVERT(DATE, REPLACE(T.CON, '-', '/'), 101), 101)
        ELSE NULL
    END AS CON,
    T.TIR,
    T.JUV,
    T.PLC,
    T.AOV,
    T.SOV,
    T.ROV,
    T.OCA,
    T.SID,
    T.LKI,
    T.LKA,
    T.MIS,
    T.LIC,
    T.LIS,
    T.LIY,
    T.LIT,
    T.VIN,
    T.VYR,
    T.VMA,
    T.VMO,
    T.VST,
    T.VCO,
    T.VOW,
    T.OFS,
    T.CMC,
    T.DNA,
    T.DLO,
    T.CTZ,
    T.[ADD],
    -- Handle BDA and EDA in MM-DD-YY format
--     CASE
--         WHEN TRY_CONVERT(DATE, REPLACE(T.BDA, '-', '/'), 101) IS NOT NULL
--         THEN CONVERT(VARCHAR(10), TRY_CONVERT(DATE, REPLACE(T.BDA, '-', '/'), 101), 101)
--         ELSE NULL
--     END AS BDA,
    T.BDA,
    CASE
        WHEN TRY_CONVERT(DATE, REPLACE(T.EDA, '-', '/'), 101) IS NOT NULL
        THEN CONVERT(VARCHAR(10), TRY_CONVERT(DATE, REPLACE(T.EDA, '-', '/'), 101), 101)
        ELSE NULL
    END AS EDA,
    T.SNU,
    T.SNA,
    T.CTY,
    T.COU,
    T.STA,
    T.ZIP,
    T.TNO,
    T.TNT,
    T.EML,
    T.IID,
    T.SHN,
    T.EMP,
    T.OCP,
    T.PLN,
    T.PLT,
    T.REG,
    T.RES,
    T.REY,
    T.BHN,
    T.BYR,
    T.BMA,
    T.BTY,
    T.BMO,
    T.BCO,
    T.BLE,
    T.PRO,
    T.HUL,
    T.HSP,
    T.HPT,
    T.BNM,
    T.CGD,
    T.VLN,
    T.VLD,
    T.STS,
    -- Handle DTE in datetime2 format
    CASE
        WHEN TRY_CONVERT(DATETIME, T.DTE) IS NOT NULL
        THEN CONVERT(VARCHAR(10), T.DTE, 101)
        ELSE NULL
    END AS DTE,
    T.DLU,
    TRY_CONVERT(DATE, T.DCL, 101) AS DCL,
    TRY_CONVERT(DATE, T.DOC, 101) AS DOC,
    T.SUP,
    T.PDT
INTO TMP_SO
FROM TMP T
WHERE T.NIC IN (SELECT NIC FROM SO)

UNION ALL

SELECT
    'SO' AS [From],
    S.NIC,  -- Keep NIC from SO
    S.SRN,
    NULL AS MKE, -- Placeholder for missing column
    NULL AS MKET, -- Placeholder for missing column
    S.ORI,
    NULL AS ATR, -- Placeholder for missing column
    S.NAM,
    S.SEX,
    S.RAC,
    S.ETN,
    S.POB,
    -- Handle S.DOB
    CASE
        WHEN TRY_CONVERT(DATE, REPLACE(S.DOB, '-', '/'), 101) IS NOT NULL
        THEN CONVERT(VARCHAR(10), TRY_CONVERT(DATE, REPLACE(S.DOB, '-', '/'), 101), 101)
        ELSE NULL
    END AS DOB,
    -- Handle S.ORD
    CASE
        WHEN TRY_CONVERT(DATE, REPLACE(S.ORD, '-', '/'), 101) IS NOT NULL
        THEN CONVERT(VARCHAR(10), TRY_CONVERT(DATE, REPLACE(S.ORD, '-', '/'), 101), 101)
        ELSE NULL
    END AS ORD,
        -- Continue for remaining columns
    S.ERD,
    S.SXP,
    S.HGT,
    S.WGT,
    S.EYE,
    S.HAI,
    S.FBI,
    S.SKN,
    S.SMT,
    S.FPC,
    S.MNU,
    S.SOC,
    S.OLN,
    S.OLS,
    S.OLY,
    S.CRR,
    CASE
        WHEN TRY_CONVERT(DATE, REPLACE(S.CON, '-', '/'), 101) IS NOT NULL
        THEN CONVERT(VARCHAR(10), TRY_CONVERT(DATE, REPLACE(S.CON, '-', '/'), 101), 101)
        ELSE NULL
    END AS CON,
    NULL AS TIR,
    S.JUV,
    S.PLC,
    S.AOV,
    S.SOV,
    S.ROV,
    S.OCA,
    S.SID,
    S.LKI,
    S.LKA,
    S.MIS,
    S.LIC,
    S.LIS,
    S.LIY,
    S.LIT,
    S.VIN,
    S.VYR,
    S.VMA,
    S.VMO,
    S.VST,
    S.VCO,
    S.VOW,
    S.OFS,
    S.CMC,
    S.DNA,
    S.DLO,
    S.CTZ,
    S.ADR AS [ADD],
--     CASE
--         WHEN TRY_CONVERT(DATE, REPLACE(S.BDA, '-', '/'), 101) IS NOT NULL
--         THEN CONVERT(VARCHAR(10), TRY_CONVERT(DATE, REPLACE(S.BDA, '-', '/'), 101), 101)
--         ELSE NULL
--     END AS BDA,
    S.BDA,
    CASE
        WHEN TRY_CONVERT(DATE, REPLACE(S.EDA, '-', '/'), 101) IS NOT NULL
        THEN CONVERT(VARCHAR(10), TRY_CONVERT(DATE, REPLACE(S.EDA, '-', '/'), 101), 101)
        ELSE NULL
    END AS EDA,
    S.SNU,
    S.SNA,
    S.CTY,
    S.COU,
    S.STA,
    S.ZIP,
    S.TNO,
    S.TNT,
    S.EML,
    S.IID,
    S.SHN,
    S.EMP,
    S.OCP,
    S.PLN,
    S.PLT,
    S.REG,
    S.RES,
    S.REY,
    S.BHN,
    S.BYR,
    S.BMA,
    S.BTY,
    S.BMO,
    S.BCO,
    S.BLE,
    S.PRO,
    S.HUL,
    S.HSP,
    S.HPT,
    S.BNM,
    S.CGD,
    NULL AS VLN,
    NULL AS VLD,
    S.STS,
    CASE
        WHEN TRY_CONVERT(DATETIME, S.DTE) IS NOT NULL
        THEN CONVERT(VARCHAR(10), S.DTE, 101)
        ELSE NULL
    END AS DTE,
    NULL AS DLU,
    CASE
        WHEN TRY_CONVERT(DATE, REPLACE(S.DCL, '-', '/'), 101) IS NOT NULL
        THEN CONVERT(VARCHAR(10), TRY_CONVERT(DATE, REPLACE(S.DCL, '-', '/'), 101), 101)
        ELSE NULL
    END AS DCL,
    CASE
        WHEN TRY_CONVERT(DATE, REPLACE(S.DOC, '-', '/'), 101) IS NOT NULL
        THEN CONVERT(VARCHAR(10), TRY_CONVERT(DATE, REPLACE(S.DOC, '-', '/'), 101), 101)
        ELSE NULL
    END AS DOC,
    NULL AS SUP,
    NULL AS PDT
FROM SO S
WHERE S.NIC IN (SELECT NIC FROM TMP);

