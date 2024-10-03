extends Controller

const COLUMN_NAMES  = Constants.BY_LEVEL_COLUMN_NAMES
const KEY = Constants.BY_LEVEL_KEY

func _ready():
	Signals.data_changed.connect(_on_data_changed)
	_load_data_and_render()


func _on_data_changed():
	_load_data_and_render() 


func _load_data_and_render():
	var intensive = "Intensive" if GlobalVars.show_intensive else ""
	var general = "General" if GlobalVars.show_general else ""
	var sql_stmt = sql.format([intensive, general])

	var db = AppDB.db
	var result = db.query(sql_stmt)

	# If there are no results, return
	if not result:
		return

	# Show Total Entries
	get_parent().get_node("%TotalLbl").text = "( Total: %d )" % db.query_result.size()
		
	var query_info = QueryInfo.new("demand_view", Utils.filtered_columns(COLUMN_NAMES), db.query_result, KEY )   

	$Table.render(query_info)


const sql = """
SELECT course, level,
	   SUM(CASE WHEN time_slot = 'Mon01' THEN 1 ELSE 0 END) AS Mon01,
	   SUM(CASE WHEN time_slot = 'Mon02' THEN 1 ELSE 0 END) AS Mon02,
	   SUM(CASE WHEN time_slot = 'Mon03' THEN 1 ELSE 0 END) AS Mon03,
	   SUM(CASE WHEN time_slot = 'Wed01' THEN 1 ELSE 0 END) AS Wed01,
	   SUM(CASE WHEN time_slot = 'Wed02' THEN 1 ELSE 0 END) AS Wed02,
	   SUM(CASE WHEN time_slot = 'Wed03' THEN 1 ELSE 0 END) AS Wed03,
	   SUM(CASE WHEN time_slot = 'Wed04' THEN 1 ELSE 0 END) AS Wed04,
	   SUM(CASE WHEN time_slot = 'Wed05' THEN 1 ELSE 0 END) AS Wed05,
	   -- Total for each course and level (row total)
	   SUM(CASE WHEN time_slot IN ('Mon01', 'Mon02', 'Mon03', 'Wed01', 'Wed02', 'Wed03', 'Wed04', 'Wed05') THEN 1 ELSE 0 END) AS Total
FROM (
	SELECT Mon01 AS course, level, 'Mon01' AS time_slot FROM demand_view WHERE Mon01 IS NOT NULL AND Mon01 != '' AND program IN ('{0}', '{1}')
	UNION ALL
	SELECT Mon02 AS course, level, 'Mon02' AS time_slot FROM demand_view WHERE Mon02 IS NOT NULL AND Mon02 != '' AND program IN ('{0}', '{1}')
	UNION ALL
	SELECT Mon03 AS course, level, 'Mon03' AS time_slot FROM demand_view WHERE Mon03 IS NOT NULL AND Mon03 != '' AND program IN ('{0}', '{1}')
	UNION ALL
	SELECT Wed01 AS course, level, 'Wed01' AS time_slot FROM demand_view WHERE Wed01 IS NOT NULL AND Wed01 != '' AND program IN ('{0}', '{1}')
	UNION ALL
	SELECT Wed02 AS course, level, 'Wed02' AS time_slot FROM demand_view WHERE Wed02 IS NOT NULL AND Wed02 != '' AND program IN ('{0}', '{1}')
	UNION ALL
	SELECT Wed03 AS course, level, 'Wed03' AS time_slot FROM demand_view WHERE Wed03 IS NOT NULL AND Wed03 != '' AND program IN ('{0}', '{1}')
	UNION ALL
	SELECT Wed04 AS course, level, 'Wed04' AS time_slot FROM demand_view WHERE Wed04 IS NOT NULL AND Wed04 != '' AND program IN ('{0}', '{1}')
	UNION ALL
	SELECT Wed05 AS course, level, 'Wed05' AS time_slot FROM demand_view WHERE Wed05 IS NOT NULL AND Wed05 != '' AND program IN ('{0}', '{1}')
)
GROUP BY course, level
ORDER BY course, level;
"""
