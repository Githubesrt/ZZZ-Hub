repeat wait() until game:IsLoaded()

local cloneref = cloneref or function(o) return o end
local Players = cloneref(game:GetService("Players"))
local HttpService = cloneref(game:GetService("HttpService"))
local StarterGui = cloneref(game:GetService("StarterGui"))

local LocalPlayer = cloneref(Players.LocalPlayer)

-- Rayfield File System Configuration
local Folder_Configs = {
	Directory = "Rayfield",
	Configs = "Rayfield/Configs"
}

for _, Folder in Folder_Configs do
	if not isfolder(Folder) then
		makefolder(Folder)
	end
end

-- Loader Configuration
local Config = {
	File = "Rayfield/savedkey.txt",
	Title = "Rayfield Hub",
	-- Replace these with your own FREE Linkvertise / Rinku URLs where you share the key!
	Linkvertise = "https://linkvertise.com/your-free-link-here", 
	Rinku = "https://rinku.me/your-free-link-here",
}

-- The static key you specified
local TargetKey = "use-key-everyone-unanimous-mouse-xd123"

-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- This is the main script that runs AFTER the key is successfully verified!
local function InitializeRayfieldHub()
	local Window = Rayfield:CreateWindow({
		Name = Config.Title,
		LoadingTitle = "Rayfield Interface",
		LoadingSubtitle = "Loaded Successfully!",
		ConfigurationSaving = {
			Enabled = true,
			FolderName = "Rayfield",
			FileName = "HubConfig"
		},
		KeySystem = false
	})

	-- Create your actual cheat/features tabs here!
	local MainTab = Window:CreateTab("Main", 4483362458)
	MainTab:CreateSection("Features")
	
	MainTab:CreateButton({
		Name = "Click Me!",
		Callback = function()
			Rayfield:Notify({
				Title = "Hello!",
				Content = "Your free hub is working perfectly!",
				Duration = 5
			})
		end,
	})
end

-- Check if they already have your custom key saved locally
local savedKey = ""
if isfile(Config.File) then
	savedKey = readfile(Config.File):gsub("%s", "")
end

if savedKey == TargetKey then
	InitializeRayfieldHub()
	return
end

-- Initialize Rayfield with the Key System interface using your custom key
local Window = Rayfield:CreateWindow({
	Name = Config.Title,
	LoadingTitle = "Authenticating...",
	LoadingSubtitle = "Free Key System",
	ConfigurationSaving = {
		Enabled = false
	},
	KeySystem = true,
	KeySettings = {
		Title = "Key Verification",
		Subtitle = "Key Required",
		Note = "Grab the access key using the buttons below!",
		FileName = "RayfieldKey",
		SaveKey = true,
		GrabKeyFromUrl = false,
		Key = { TargetKey }, -- Rayfield checks input against your key
		Actions = {
			[1] = {
				Text = "Get Key (Linkvertise)",
				OnPressed = function()
					if setclipboard then
						setclipboard(Config.Linkvertise)
						Rayfield:Notify({
							Title = "Copied",
							Content = "Linkvertise link copied to clipboard!",
							Duration = 5,
							Image = 4483362458,
						})
					end
				end
			},
			[2] = {
				Text = "Get Key (Rinku)",
				OnPressed = function()
					if setclipboard then
						setclipboard(Config.Rinku)
						Rayfield:Notify({
							Title = "Copied",
							Content = "Rinku link copied to clipboard!",
							Duration = 5,
							Image = 4483362458,
						})
					end
				end
			}
		}
	}
})

-- Save the key to their exploit folder once Rayfield verifies they typed it right
task.spawn(function()
	while task.wait(1) do
		local rayfieldFolder = "Rayfield/KeySettings.txt"
		if isfile(rayfieldFolder) then
			local validated = readfile(rayfieldFolder)
			if validated == TargetKey then
				writefile(Config.File, TargetKey)
				break
			end
		end
	end
end)
