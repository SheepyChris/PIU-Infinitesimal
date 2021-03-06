local bannerFirst = true;
if GetUserPref("UserPrefWheelPriority") == "Banner" then
	--Don't need to assign, since it's already true
	--bannerFirst = true;
elseif GetUserPref("UserPrefWheelPriority") == "Background" then
	bannerFirst = false;
else --Auto
	if GAMESTATE:GetCurrentGame():GetName() == "pump" then
		bannerFirst = true;
	else
		bannerFirst = false; --Prioritize jackets for every other game mode
	end;
end;

--local total = 0
return Def.ActorFrame {
	OnCommand=cmd(diffusealpha,1;zoom,1);
	PlayerJoinedMessageCommand=cmd(playcommand,"On");

	-- banners
	Def.Banner {
		Name="SongBanner";
		InitCommand=cmd(diffusealpha,1);
		SetMessageCommand=function(self,params)
			self:stoptweening();
			local song = params.Song;
			local path;
			if song then
				if bannerFirst then
					path = song:GetBannerPath();
					if not path then
						path = song:GetBackgroundPath();
					end;
				else
					path = song:GetBackgroundPath();
					if not path then
						path = song:GetBannerPath();
					end;
				end;

			end;
			if not path then path = THEME:GetPathG("Common","fallback banner") end
			self:Load(path);
			self:scaletoclipped(288,162);
			--self:scaletoclipped(300,300);
		end;
	};

	LoadActor(THEME:GetPathG("","SongFrame"))..{
			InitCommand=function(self)
					self:diffusealpha(1)
					:zoom(0.178,0.178)
					end;
	};
};
