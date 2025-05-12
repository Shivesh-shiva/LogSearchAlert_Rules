resource_group_name = "ci-test-rg"
 
location = "central india"
 
 
live_rg = "ec-neu-rsg"
 
log_alrt = {
  la_Rld_disk_space = {
    name                    = "DIsk Space greater Than 90 Percentage|| <compl07rl-name>"
    severity                = 0
    query                   = <<-QUERY
      Perf
| where ObjectName == "LogicalDisk" and CounterName == "% Free Space"
|where Computer in ('<compl07-name>')
| summarize (TimeGenerated, Free_Space_Percent)=arg_max(TimeGenerated, CounterValue) by Computer, InstanceName
| where strlen(InstanceName) ==2 and InstanceName contains ":"
|where Free_Space_Percent <10
      QUERY
    metric_measure_column   = "Free_Space_Percent"
    time_aggregation_method = "Average"
    evaluation_frequency    = "PT5M"
    window_duration         = "PT5M"
    operator                = "LessThan"
    threshold               = 10
    dimension_name          = "InstanceName"
    dimension_operator      = "Include"
    dimension_value         = ["*"]
    resource_id_column      = "Don't split"
    # minimum_failing_periods_to_trigger_alert = 1
    # number_of_evaluation_periods             = 1
    description  = "DIsk Space >90 %"
    display_name = "DIsk Space Greature_than 90%"
    # query_time_range_override                = "PT1H"
 
  },
  la_sp_disk_space = {
    name                    = "DIsk Space greater Than 90 Percentage|| l07-sp"
    severity                = 0
    query                   = <<-QUERY
      Perf
| where ObjectName == "LogicalDisk" and CounterName == "% Free Space"
|where Computer in ('l07-sp')
| summarize (TimeGenerated, Free_Space_Percent)=arg_max(TimeGenerated, CounterValue) by Computer, InstanceName
| where strlen(InstanceName) ==2 and InstanceName contains ":"
|where Free_Space_Percent <10
      QUERY
    metric_measure_column   = "Free_Space_Percent"
    time_aggregation_method = "Average"
    evaluation_frequency    = "PT5M"
    window_duration         = "PT10M"
    operator                = "LessThan"
    threshold               = 10
    dimension_name          = "InstanceName"
    dimension_operator      = "Include"
    dimension_value         = ["*"]
    resource_id_column      = "Don't split"
    description  = "Disk space used >90 %"
    display_name = "DIsk Space used Greature_than 90%"
 
  },
  la_file_disk_space = {
    name                    = "DIsk Space greater Than 90 Percentage|| l07-gi-Fl"
    severity                = 0
    query                   = <<-QUERY
      Perf
| where ObjectName == "LogicalDisk" and CounterName == "% Free Space"
|where Computer in ('l07-gi-FSrv')
| summarize (TimeGenerated, Free_Space_Percent)=arg_max(TimeGenerated, CounterValue) by Computer, InstanceName
| where strlen(InstanceName) ==2 and InstanceName contains ":"
|where Free_Space_Percent <10
      QUERY
    metric_measure_column   = "Free_Space_Percent"
    time_aggregation_method = "Average"
    window_duration         = "PT10M"
    operator                = "LessThan"
    threshold               = 10
    evaluation_frequency    = "PT5M"
    dimension_name          = "InstanceName"
    dimension_operator      = "Include"
    dimension_value         = ["*"]
    resource_id_column      = "Don't split"
    description  = "Disk space used >90 %"
    display_name = "DIsk Space used Greature_than 90%"
 
  },
  la_Slr_disk_space = {
    name                    = "DIsk Space greater Than 90 Percentage|| l07-gi-Soil"
    severity                = 0
    query                   = <<-QUERY
      Perf
| where ObjectName == "Logical Disk" and CounterName == "% Used Space" and InstanceName != "_Total"
| where Computer in ('l07-gi-SrVM')
| where CounterValue > 90
| summarize ConsumedSpace = max(CounterValue) by Computer, InstanceName, bin(TimeGenerated, 10m)
      QUERY
    metric_measure_column   = "ConsumedSpace"
    time_aggregation_method = "Total"
    window_duration         = "PT5M"
    operator                = "GreaterThan"
    threshold               = 90
    evaluation_frequency    = "PT5M"
    dimension_name          = "InstanceName"
    dimension_operator      = "Include"
    dimension_value         = ["*"]
    resource_id_column      = "Don't split"
    description  = "Disk space used >90 %"
    display_name = "DIsk Space used Greature_than 90%"
 
  },
  la_Rd_memory = {
    name                    = "Memory Greater Than 90 Percentage || l07-rl$"
    severity                = 0
    query                   = <<-QUERY
      Perf
| where ObjectName == "Memory" and CounterName == "% Committed Bytes In Use"
| where Computer in ('l07-rl$')
| summarize AggregatedValue = avg(CounterValue) by Computer, bin(TimeGenerated, 10m)
| where AggregatedValue > 90
      QUERY
    metric_measure_column   = "AggregatedValue"
    time_aggregation_method = "Average"
    window_duration         = "PT10M"
    operator                = "GreaterThan"
    threshold               = 90
    evaluation_frequency    = "PT10M"
    dimension_name          = "Computer"
    dimension_operator      = "Include"
    dimension_value         = ["*"]
    resource_id_column      = "Don't split"
    description  = "Memory >90 %"
    display_name = "Menory Greature_than 90%"
 
  },
  la_Sp_memory = {
    name                    = "Memory Greater Than 90 Percentage || l07-sp"
    severity                = 0
    query                   = <<-QUERY
      Perf
| where ObjectName == "Memory" and CounterName == "% Committed Bytes In Use"
| where Computer in ('l07-sp')
| summarize AggregatedValue = avg(CounterValue) by Computer, bin(TimeGenerated, 10m)
| where AggregatedValue > 90
      QUERY
    metric_measure_column   = "AggregatedValue"
    time_aggregation_method = "Average"
    window_duration         = "PT5M"
    operator                = "GreaterThan"
    threshold               = 90
    evaluation_frequency    = "PT5M"
    dimension_name          = "Computer"
    dimension_operator      = "Include"
    dimension_value         = ["*"]
    resource_id_column      = "Don't split"
    description  = "Memory used >90 %"
    display_name = "Menory used Greature_than 90%"
 
  },
  la_File_memory = {
    name                    = "Memory Greater Than 90 Percentage || l07-gi-Fl"
    severity                = 0
    query                   = <<-QUERY
      Perf
| where ObjectName == "Memory" and CounterName == "% Committed Bytes In Use"
| where Computer in ('l07-gi-Fl')
| summarize AggregatedValue = avg(CounterValue) by Computer, bin(TimeGenerated, 10m)
| where AggregatedValue > 90
      QUERY
    metric_measure_column   = "AggregatedValue"
    time_aggregation_method = "Average"
    window_duration         = "PT5M"
    operator                = "GreaterThan"
    threshold               = 90
    evaluation_frequency    = "PT5M"
    dimension_name          = "Computer"
    dimension_operator      = "Include"
    dimension_value         = ["*"]
    resource_id_column      = "Don't split"
    description  = "Memory used >90 %"
    display_name = "Menory used Greature_than 90%"
 
  },
  la_Slr_memory = {
    name                    = "Memory Greater Than 90 Percentange || l07-gi-SrVM"
    severity                = 0
    query                   = <<-QUERY
      Perf
| where TimeGenerated > ago(30m)
| where  CounterName == "% Used Memory"
| where Computer in ('l07-gi-SrVM')
| project TimeGenerated, CounterName, CounterValue, Computer
| summarize UsedMemory = avg(CounterValue) by CounterName, bin(TimeGenerated, 1m), Computer
| where UsedMemory > 90
      QUERY
    metric_measure_column   = "UsedMemory"
    time_aggregation_method = "Average"
    window_duration         = "PT5M"
    operator                = "GreaterThan"
    threshold               = 90
    evaluation_frequency    = "PT5M"
    dimension_name          = "Computer"
    dimension_operator      = "Include"
    dimension_value         = ["*"]
    resource_id_column      = "Don't split"
    description  = "Memory used >90 %"
    display_name = "Menory used Greature_than 90%"
 
  }
}
