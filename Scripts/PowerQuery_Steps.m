let
    Source = healthcare_dataset,
    #"Capitalized Each Word" = Table.TransformColumns(Source,{{"Name", Text.Proper, type text}}),
    #"Trimmed Text" = Table.TransformColumns(#"Capitalized Each Word",{{"Name", Text.Trim, type text}, {"Gender", Text.Trim, type text}, {"Medical Condition", Text.Trim, type text}, {"Doctor", Text.Trim, type text}, {"Hospital", Text.Trim, type text}, {"Insurance Provider", Text.Trim, type text}, {"Admission Type", Text.Trim, type text}, {"Medication", Text.Trim, type text}, {"Test Results", Text.Trim, type text}}),
    #"Cleaned Text" = Table.TransformColumns(#"Trimmed Text",{{"Name", Text.Clean, type text}, {"Gender", Text.Clean, type text}, {"Medical Condition", Text.Clean, type text}, {"Doctor", Text.Clean, type text}, {"Hospital", Text.Clean, type text}, {"Insurance Provider", Text.Clean, type text}, {"Admission Type", Text.Clean, type text}, {"Medication", Text.Clean, type text}, {"Test Results", Text.Clean, type text}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Cleaned Text",{{"Room Number", type text}, {"Billing Amount", type number}}),
    #"Rounded Off" = Table.TransformColumns(#"Changed Type",{{"Billing Amount", each Number.Round(_, 2), type number}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Rounded Off",{{"Discharge Date", type date}, {"Date of Admission", type date}, {"Age", Int64.Type}}),
    #"Removed Duplicates" = Table.Distinct(#"Changed Type1", {"Name", "Gender", "Blood Type", "Medical Condition", "Date of Admission", "Doctor", "Hospital", "Insurance Provider", "Billing Amount", "Room Number", "Admission Type", "Discharge Date", "Medication", "Test Results"}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Removed Duplicates",{{"Billing Amount", Currency.Type}}),
    #"Added Conditional Column" = Table.AddColumn(#"Changed Type2", "Billing status", each if [Billing Amount] < 0 then "Negative(refund/adjustment)" else "Normal"),
    #"Added Custom" = Table.AddColumn(#"Added Conditional Column", "length of stay(Day)", each Duration.Days([Discharge Date] - [Date of Admission])),
    #"Changed Type3" = Table.TransformColumnTypes(#"Added Custom",{{"length of stay(Day)", Int64.Type}, {"Billing status", type text}}),
    #"Added Custom1" = Table.AddColumn(#"Changed Type3", "Age Group", each if [Age] < 35 then "18-34" else if [Age] < 50 then "35-49" else if [Age] < 65 then "50-64" else "65+"),
    #"Changed Type4" = Table.TransformColumnTypes(#"Added Custom1",{{"Age Group", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type4",{{"length of stay(Day)", "Length of Stay(Day)"}, {"Billing status", "Billing Status"}}),
    #"Added Index" = Table.AddIndexColumn(#"Renamed Columns", "Index", 1, 1, Int64.Type),
    #"Renamed Columns1" = Table.RenameColumns(#"Added Index",{{"Index", "Admission ID"}}),
    #"Reordered Columns" = Table.ReorderColumns(#"Renamed Columns1",{"Admission ID", "Name", "Age", "Gender", "Blood Type", "Medical Condition", "Date of Admission", "Doctor", "Hospital", "Insurance Provider", "Billing Amount", "Room Number", "Admission Type", "Discharge Date", "Medication", "Test Results", "Billing Status", "Length of Stay(Day)", "Age Group"}),
    #"Removed Columns" = Table.RemoveColumns(#"Reordered Columns",{"Name"})
in
    #"Removed Columns"