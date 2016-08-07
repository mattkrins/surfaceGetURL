## surface.GetURL()

#### About:
This is a simple Garry's Mod helper function to hot-load images from a web URL for use in your rendering operations.

#### Installation:
Place the file cl_surfaceGetURL.lua into your *garrysmod/lua/autorun/client/* folder.

You could also put it into a gamemode module if the code supports it. For example: *gamemodes/DarkRP/gamemode/modules/cl_surfaceGetURL/cl_surfaceGetURL.lua*

#### Arguments:
- **string** The URL of the image/page to download.
- **number** The height of the image/page in pixels.
- **number** The width of the image/page in pixels.
- **number** The number of seconds of downloading before timing out (Default: 1).

#### Returns:
- **IMaterial** The material after downloading **or** *Material("error")*

#### Example:
```lua
local DPanel = vgui.Create( "DPanel" )
DPanel:SetSize( 336, 280 )
DPanel:Center()
DPanel.Paint = function()
	local WebMaterial = surface.GetURL("http://www.lipsum.com/images/banners/black_336x280.gif", 336, 280)
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( WebMaterial )
	surface.DrawTexturedRect( 0, 0, WebMaterial:Width(), WebMaterial:Height() )
end
```
**Result:**

![Result](https://cloud.githubusercontent.com/assets/2367602/17459932/b99e6e76-5c92-11e6-8196-23d8ae567b1f.png)

#### Usage:
To use this helper function you will need to either call surface.GetURL from inside a render hook/function like such: 
```lua
local WebMaterial = surface.GetURL("http://www.lipsum.com/images/banners/black_336x280.gif", 336, 280) // This will give you an error because it has not had time to download the image.
YourPanel.Paint = function()
	local WebMaterial = surface.GetURL("http://www.lipsum.com/images/banners/black_336x280.gif", 336, 280) // This will work because the returned data is updated when the image has downloaded.
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( WebMaterial )
	surface.DrawTexturedRect( 0, 0, WebMaterial:Width(), WebMaterial:Height() )
end
```

Or you will need to pre-load the materials before you need to access them, such as when the gamemode is initialised:
```lua
local Delay = 0
local YourMaterials = {
	{"http://www.lipsum.com/images/banners/black_336x280.gif", 336, 280}
}
hook.Add( "Initialize", "some_unique_name", function()
	for _,v in pairs(YourMaterials) do
		Delay = Delay + 0.2 // load a bit slower for performance
		timer.Simple( Delay, function() surface.GetURL(v[1], v[2], v[3]) end )
	end
end )

local WebMaterial = surface.GetURL("http://www.lipsum.com/images/banners/black_336x280.gif", 336, 280) // This will work because we have already pre-downloaded the image above.
YourPanel.Paint = function()
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( WebMaterial )
	surface.DrawTexturedRect( 0, 0, WebMaterial:Width(), WebMaterial:Height() )
end
```

*For more information on how to use downloaded materials, please read ![gmod](http://wiki.garrysmod.com/favicon.ico) [this article](http://wiki.garrysmod.com/page/Category:IMaterial).*

#### Support:
Please direct all your questions to the GitHub issue tracker:
https://github.com/mattkrins/surfaceGetURL/issues