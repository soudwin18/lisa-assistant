-- reminders_add.applescript
-- Usage: osascript reminders_add.applescript "Title" "Notes" "YYYY-MM-DD HH:MM" "ListName"
-- Notes and due date and list name are optional (pass empty string "" to skip)

on run argv
    set reminderTitle to item 1 of argv
    set reminderNotes to ""
    set reminderDue to ""
    set listName to "Reminders"

    if (count of argv) >= 2 then set reminderNotes to item 2 of argv
    if (count of argv) >= 3 then set reminderDue to item 3 of argv
    if (count of argv) >= 4 then set listName to item 4 of argv

    tell application "Reminders"
        -- หา list ที่ต้องการ ถ้าไม่มีให้ใช้ default
        set targetList to missing value
        repeat with l in lists
            if name of l is listName then
                set targetList to l
                exit repeat
            end if
        end repeat
        if targetList is missing value then
            set targetList to default list
        end if

        -- สร้าง reminder
        set newReminder to make new reminder at end of reminders of targetList
        set name of newReminder to reminderTitle

        if reminderNotes is not "" then
            set body of newReminder to reminderNotes
        end if

        if reminderDue is not "" then
            try
                set dueDate to date reminderDue
                set due date of newReminder to dueDate
                set remind me date of newReminder to dueDate
            end try
        end if
    end tell

    return "✅ เพิ่ม reminder แล้ว: " & reminderTitle
end run
