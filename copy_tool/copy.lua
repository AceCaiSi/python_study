local fullPath
local num
local function createFolder( folderPath )
	-- body
	local path = string.gsub(folderPath,"/","\\")
	os.execute("mkdir "..path)
end
local function copyFile(source,destination)
	local f,err = io.open(source, "r")
	if err then
		return
	end
	f:close()
	local f2,err2 = io.open(destination, "w")
	if  not err2 then
		f2:close()
		source = string.gsub(source,"/","\\")
		destination = string.gsub(destination,"/","\\")
		os.execute("copy "..source.." "..destination)
		num = num +1
	else
		local index = string.find(destination, "/")
		local endIndex = string.find(destination, "/",index+1)
		while endIndex do
			index = endIndex
			endIndex = string.find(destination, "/",index+1)
		end
		createFolder(string.sub(destination,1,index-1))
		copyFile(source,destination)
	end
end

local function copyFileTab( fileName )
	-- body
	local f = io.open(fileName)
	local fileContent = {}
	local line = f:read("*l")
	table.insert(fileContent,line)
	while (line) do
		line = f:read("*l")
	table.insert(fileContent,line)
	end
	f:close()
	for k,v in pairs(fileContent) do
		copyFile(fullPath..v,"resultCopy/"..v)
	end
	print("num:",num)
end

local function main()
	-- body
	local obj=io.popen("cd")
	num = 0
	fullPath = arg[1]
	-- fullPath = fullPath .. arg[1] .."/"
	copyFileTab("needCopy.txt")
end
os.execute("rd resultCopy /s /q") 
main()