-- reminders_complete.applescript
-- Usage: osascript reminders_complete.applescript "Title" [ListName]
-- ทำเครื่องหมายว่า reminder เสร็จแล้ว (ค้นจากชื่อ)

on run argv
    if (count of argv) < 1 then
        return "❌ ต้องระบุชื่อ reminder"
    end if

    set searchTitle to item 1 of argv
    set listFilter to ""
    if (count of argv) >= 2 then set listFilter to item 2 of argv

    set found to false

    tell application "Reminders"
        repeat with l in lists
            if listFilter is "" or name of l is listFilter then
                repeat with r in (reminders of l whose completed is false)
                    if name of r is searchTitle then
                        set completed of r to true
                        set found to true
                        exit repeat
                    end if
                end repeat
            end if
            if found then exit repeat
        end repeat
    end tell

    if found then
        return "✅ ทำเครื่องหมายเสร็จแล้ว: " & searchTitle
    else
        return "❌ ไม่พบ reminder ชื่อ: " & searchTitle
    end if
end run
