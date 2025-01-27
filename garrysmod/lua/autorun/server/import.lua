-- Конфигурация базы данных (вводить свои данные здесь)
local databaseHost = "mysql.retrime.ru"
local databasePort = 3306
local databaseName = "s1_gas"
local databaseUser = "u1_ofQpdPt9Id"
local databasePassword = "pYRbsB.+McbktJaIxbIZTXn@"

-- Путь к файлу резервной копии
local backupFilePath = "data/mysqlbackup/" .. databaseName .. "_backup.txt"

-- Функция для импорта данных из файла в базу данных
local function ImportDatabase()
    -- Создаём подключение к базе данных
    local db = mysqloo.connect(databaseHost, databaseUser, databasePassword, databaseName, databasePort)

    db:connect()

    db.onConnected = function()
        print("[MySQL Restore] Connected to the database!")

        -- Проверяем, существует ли файл
        if not file.Exists("mysqlbackup/" .. databaseName .. "_backup.txt", "DATA") then
            print("[MySQL Restore] Backup file not found!")
            return
        end

        -- Читаем данные из файла
        local serializedData = file.Read("mysqlbackup/" .. databaseName .. "_backup.txt", "DATA")
        local allData = util.JSONToTable(serializedData)

        if not allData then
            print("[MySQL Restore] Failed to parse backup file!")
            return
        end

        -- Очищаем таблицы и вставляем данные
        for tableName, tableData in pairs(allData) do
            local deleteQuery = db:query("DELETE FROM " .. tableName)

            deleteQuery.onSuccess = function()
                print("[MySQL Restore] Cleared table: " .. tableName)

                for _, row in ipairs(tableData) do
                    -- Собираем имена колонок и значения
                    local columns = {}
                    local values = {}

                    for columnName, value in pairs(row) do
                        if columnName and value ~= nil then
                            table.insert(columns, columnName)
                            table.insert(values, "'" .. tostring(value):gsub("'", "\\'") .. "'") -- Экранирование кавычек
                        end
                    end

                    -- Проверяем, есть ли данные для вставки
                    if #columns > 0 and #values > 0 then
                        -- Формируем строку с именами колонок и значениями
                        local columnsStr = table.concat(columns, ", ")
                        local valuesStr = table.concat(values, ", ")

                        -- Генерируем запрос для вставки данных
                        local insertQueryStr = string.format("INSERT INTO %s (%s) VALUES (%s)", tableName, columnsStr, valuesStr)
                        local insertQuery = db:query(insertQueryStr)

                        insertQuery.onError = function(_, err)
                            print("[MySQL Restore] Error inserting into '" .. tableName .. "': " .. err)
                        end

                        insertQuery:start()
                    else
                        print("[MySQL Restore] Skipped empty row in table: " .. tableName)
                    end
                end
            end

            deleteQuery.onError = function(_, err)
                print("[MySQL Restore] Error clearing table '" .. tableName .. "': " .. err)
            end

            deleteQuery:start()
        end
    end

    db.onConnectionFailed = function(_, err)
        print("[MySQL Restore] Failed to connect to the database: " .. err)
    end
end

-- Команда для импорта данных
concommand.Add("mysql_import", function(ply)
    if IsValid(ply) and not ply:IsAdmin() then
        ply:ChatPrint("You do not have permission to use this command.")
        return
    end

    ImportDatabase()
end)