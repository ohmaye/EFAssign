extends Controller

const COLUMN_NAMES  = Constants.BY_COURSE_COLUMN_NAMES
const KEY = Constants.BY_COURSE_KEY

func _ready():
    # Enable Intensive/General
    GlobalVars.intensive_checkbox.disabled = false
    GlobalVars.general_checkbox.disabled = false

    var intensive = "Intensive" if GlobalVars.intensive_checkbox.button_pressed else ""
    var general = "General" if GlobalVars.general_checkbox.button_pressed else ""
    var sql_stmt = sql % [intensive, general, intensive, general]

    var db = AssignDB.db
    var result = db.query(sql_stmt)

    # If there are no results, return
    if not result:
        return
        
    var query_info = QueryInfo.new("demand", COLUMN_NAMES, db.query_result, KEY )

    $Table.render(query_info)


const sql = """
-- Main query for pivot table
SELECT course,
       SUM(CASE WHEN time_slot = 'Mon01' THEN 1 ELSE 0 END) AS Mon01,
       SUM(CASE WHEN time_slot = 'Mon02' THEN 1 ELSE 0 END) AS Mon02,
       SUM(CASE WHEN time_slot = 'Mon03' THEN 1 ELSE 0 END) AS Mon03,
       SUM(CASE WHEN time_slot = 'Wed01' THEN 1 ELSE 0 END) AS Wed01,
       SUM(CASE WHEN time_slot = 'Wed02' THEN 1 ELSE 0 END) AS Wed02,
       SUM(CASE WHEN time_slot = 'Wed03' THEN 1 ELSE 0 END) AS Wed03,
       SUM(CASE WHEN time_slot = 'Wed04' THEN 1 ELSE 0 END) AS Wed04,
       SUM(CASE WHEN time_slot = 'Wed05' THEN 1 ELSE 0 END) AS Wed05,
       -- Total for each row (course)
       SUM(CASE WHEN time_slot IN ('Mon01', 'Mon02', 'Mon03', 'Wed01', 'Wed02', 'Wed03', 'Wed04', 'Wed05') THEN 1 ELSE 0 END) AS Total
FROM (
    SELECT Mon01 AS course, 'Mon01' AS time_slot, program FROM demand WHERE Mon01 IS NOT NULL AND Mon01 != ''
    UNION ALL
    SELECT Mon02 AS course, 'Mon02' AS time_slot, program FROM demand WHERE Mon02 IS NOT NULL AND Mon02 != ''
    UNION ALL
    SELECT Mon03 AS course, 'Mon03' AS time_slot, program FROM demand WHERE Mon03 IS NOT NULL AND Mon03 != ''
    UNION ALL
    SELECT Wed01 AS course, 'Wed01' AS time_slot, program FROM demand WHERE Wed01 IS NOT NULL AND Wed01 != ''
    UNION ALL
    SELECT Wed02 AS course, 'Wed02' AS time_slot, program FROM demand WHERE Wed02 IS NOT NULL AND Wed02 != ''
    UNION ALL
    SELECT Wed03 AS course, 'Wed03' AS time_slot, program FROM demand WHERE Wed03 IS NOT NULL AND Wed03 != ''
    UNION ALL
    SELECT Wed04 AS course, 'Wed04' AS time_slot, program FROM demand WHERE Wed04 IS NOT NULL AND Wed04 != ''
    UNION ALL
    SELECT Wed05 AS course, 'Wed05' AS time_slot, program FROM demand WHERE Wed05 IS NOT NULL AND Wed05 != ''
)
WHERE program IN ('%s', '%s')
GROUP BY course

-- Add the row for column totals using a UNION ALL
UNION ALL

SELECT 'Total' AS course,
       SUM(CASE WHEN time_slot = 'Mon01' THEN 1 ELSE 0 END) AS Mon01,
       SUM(CASE WHEN time_slot = 'Mon02' THEN 1 ELSE 0 END) AS Mon02,
       SUM(CASE WHEN time_slot = 'Mon03' THEN 1 ELSE 0 END) AS Mon03,
       SUM(CASE WHEN time_slot = 'Wed01' THEN 1 ELSE 0 END) AS Wed01,
       SUM(CASE WHEN time_slot = 'Wed02' THEN 1 ELSE 0 END) AS Wed02,
       SUM(CASE WHEN time_slot = 'Wed03' THEN 1 ELSE 0 END) AS Wed03,
       SUM(CASE WHEN time_slot = 'Wed04' THEN 1 ELSE 0 END) AS Wed04,
       SUM(CASE WHEN time_slot = 'Wed05' THEN 1 ELSE 0 END) AS Wed05,
       -- Total across all columns (time slots)
       SUM(CASE WHEN time_slot IN ('Mon01', 'Mon02', 'Mon03', 'Wed01', 'Wed02', 'Wed03', 'Wed04', 'Wed05') THEN 1 ELSE 0 END) AS Total
FROM (
    SELECT Mon01 AS course, 'Mon01' AS time_slot, program FROM demand WHERE Mon01 IS NOT NULL AND Mon01 != ''
    UNION ALL
    SELECT Mon02 AS course, 'Mon02' AS time_slot, program FROM demand WHERE Mon02 IS NOT NULL AND Mon02 != ''
    UNION ALL
    SELECT Mon03 AS course, 'Mon03' AS time_slot, program FROM demand WHERE Mon03 IS NOT NULL AND Mon03 != ''
    UNION ALL
    SELECT Wed01 AS course, 'Wed01' AS time_slot, program FROM demand WHERE Wed01 IS NOT NULL AND Wed01 != ''
    UNION ALL
    SELECT Wed02 AS course, 'Wed02' AS time_slot, program FROM demand WHERE Wed02 IS NOT NULL AND Wed02 != ''
    UNION ALL
    SELECT Wed03 AS course, 'Wed03' AS time_slot, program FROM demand WHERE Wed03 IS NOT NULL AND Wed03 != ''
    UNION ALL
    SELECT Wed04 AS course, 'Wed04' AS time_slot, program FROM demand WHERE Wed04 IS NOT NULL AND Wed04 != ''
    UNION ALL
    SELECT Wed05 AS course, 'Wed05' AS time_slot, program FROM demand WHERE Wed05 IS NOT NULL AND Wed05 != ''
) WHERE program IN ('%s', '%s')"""