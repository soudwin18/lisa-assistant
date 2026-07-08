-- reminders_list.applescript
-- Usage: osascript reminders_list.applescript [ListName]
-- ถ้าไม่ส่ง ListName จะแสดง reminder ที่ยังไม่เสร็จทั้งหมด

on run argv
    set listFilter to ""
    if (count of argv) >= 1 then set listFilter to item 1 of argv

    set output to ""

    tell application "Reminders"
        if listFilter is not "" then
            -- แสดงเฉพาะ list ที่ระบุ
            repeat with l in lists
                if name of l is listFilter then
                    set output to output & "📋 " & name of l & ":" & return
                    set incompleteItems to (reminders of l whose completed is false)
                    if (count of incompleteItems) is 0 then
                        set output to output & "  (ว่างเปล่า)" & return
                    else
                        repeat with r in incompleteItems
                            set output to output & "  • " & name of r
                            try
                                set dd to due date of r
                                if dd is not missing value then
                                    set output to output & " [ครบกำหนด: " & (dd as string) & "]"
                                end if
                            end try
                            if body of r is not "" then
                                set output to output & " — " & body of r
                            end if
                            set output to output & return
                        end repeat
                    end if
                    exit repeat
                end if
            end repeat
        else
            -- แสดงทุก list
            repeat with l in lists
                set incompleteItems to (reminders of l whose completed is false)
                if (count of incompleteItems) > 0 then
                    set output to output & "📋 " & name of l & ":" & return
                    repeat with r in incompleteItems
                        set output to output & "  • " & name of r
                        try
                            set dd to due date of r
                            if dd is not missing value then
                                set output to output & " [ครบกำหนด: " & (dd as string) & "]"
                            end if
                        end try
                        set output to output & return
                    end repeat
                end if
            end repeat
        end if

        if output is "" then
            set output to "✅ ไม่มี reminder ที่ค้างอยู่"
        end if
    end tell

    return output
end run
