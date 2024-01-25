script_version('2')
script_name("AdminTools")
-- script v is "28.03.2023"
script_properties('work-in-pause')
local dlstatus = require('moonloader').download_status
require "lib.moonloader" 
local ev = require 'lib.samp.events'
raknet = require("lib.samp.raknet")
function update()
    local raw = "https://raw.githubusercontent.com/gozhelnikovtraxat/UpdateArenaTools/main/AutoUpdate.json"
    local dlstatus = require('moonloader').download_status
    local requests = require('requests')
    local f = {}
    function f:getLastVersion()
        local response = requests.get(raw)
        if response.status_code == 200 then
            return decodeJson(response.text)['last']
        else
            return 'UNKNOWN'
        end
    end
    function f:download()
        local response = requests.get(raw)
        if response.status_code == 200 then
            downloadUrlToFile(decodeJson(response.text)['url'], thisScript().path, function (id, status, p1, p2)
                print('Скачиваю '..decodeJson(response.text)['url']..' в '..thisScript().path)
                if status == dlstatus.STATUSEX_ENDDOWNLOAD then
                    sampAddChatMessage('Скрипт обновлен, перезагрузка...', -1)
                    thisScript():reload()
                end
            end)
        else
            sampAddChatMessage('Ошибка, невозможно установить обновление, код: '..response.status_code, -1)
        end
    end
    return f
end



local toHide = false

local weapons = require 'game.weapons'
local mem = require 'memory'
local memory = require 'memory'
local keys = require "vkeys"
local imgui = require 'imgui'
local encoding = require 'encoding'
local cjson = require "cjson"
local requests = require 'requests'
local effil = require "effil"
local font_flag = require('moonloader').font_flag
colors = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\ArenaTools\\color.png")
authors = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\ArenaTools\\authors.png")
local inicfg = require 'inicfg'
local fa = require 'fAwesome5'
local dlstatus = require('moonloader').download_status
encoding.default = 'CP1251'
u8 = encoding.UTF8
local rid
local LOAD_IMAGES           = {
	KILL_LIST       = {}
}
local editPositionKillList  = false 
font = renderCreateFont(Tahoma, 13, 13)
local Matrix3X3 = require "matrix3x3"
local vkeys = require 'vkeys'
local leavePlayers          = {}
local regPlayers          = {}
local connectPlayers          = {}
local adminsPlayers = {}
local killInfo              = {}
local imadd = require "imgui_addons"
local Vector3D = require "vector3d"
accept = false
local ffi = require 'ffi'
local boost = 0.02
local admall = false
local givepun = false
local counter = {}
local script_cursor = false
local windowCoordinates     = {getScreenResolution()}
local cfg = inicfg.load({
	main = {
		formaplus = false,
		volume = 99,
		shmax = 200,
		shsmooth = 85,
		speed2 = 0,
		perehodik = false,
		slapinrecon = false,
		chatipoff = false,
		autob = false,
		logging = false,
		antitp = true,
		notfinchat = true,
		delinchat = false,
		spectatekill = true,
		underb = true,
		showIDKiller = true,
		showIDKilled = true,
		otschecker = 15,
		adminsotschecker = 15,
		afkinchecker = true,
		adminsafkinchecker = true,
		playersChecker = true,
		adminsChecker = false,
		invisible = false,
		stylechecker = 5,
		adminsstylechecker = 5,
		warningtk = true,
		removeip = true,
		autounban = true,
		autopiar = false,

		styleinformation = 1,

		clickwarp = true,
		regi = true,
		autooff = true,
		onzero = true,
		fontchecker = 'Arial',
		QuitFontChecker = 'Arial',
		ConnectFontChecker = 'Arial',
		RegFontChecker = 'Arial',
		adminsfontchecker = 'Arial',
		FontKill = 'Arial',
		infammo = false,
		noreload = false,
		speedhack = false,
		lovlyareporta = false,
		formbell = false,
		geniumlvl = true,
		geniumaccept = true,
		deletereklama = false,
		logform = true,
		deleteac = true,
		redesign = true,
		deleteot = false,
		nopf4 = true,
		nopf5 = true,
		radarinrecon = false,
		deleteactions = false,
		spawnonset = false,
		inforeport = true,
		stylerecon = 1,
		stylereg = 1,
		styleadmin = 1,
		stylelovlyareporta = 1,
		stylekilllist = 2,
		nobike = true,
		gm = true,
		myreason = false,
		airbrake = false,
		killlist = true,
		speed_airbrake = 1,
		autologin = false,
		autoadm = false,
		trueform = true,
		autoaz = false,
		showpass = false,
		showakkpass = false,
		menurecon = true,
		menurecon1 = true,
		house = true,
		car = false,
		theme = 'dark',
		numberbind = 0,
		dm = 90, 
		flood = 20,
		timeoutmy1 = 500,
		timeoutmy2 = 500,
		timeoutmy3 = 500,
		timeoutmy4 = 500,
		timeoutzawita = 500,
		timeoutdonate = 500,
		timeoutrules = 500,
		timeoutdiscord = 500,
		timeoutgroup = 500,
		db = 90,
		oskrod = 300,

		logbanipoff = true,
		logbanoff = true,
		logjailoff = true,
		logmuteoff = true,
		logunbanip = true,
		logunban = true,
		logunjail = true,
		logunmute = true,

		offamulet = true,

		leaveChecker            = false,
		connectChecker            = false,
		regChecker            = false,
		leaveIndent             = 11,
		leaveLines              = 6,
		leaveSize               = 9,
		leaveStyle              = 15,
		connectIndent             = 11,
		adminsIndent 				= 12,
		connectLines              = 6,
		adminsLines = 6,
		connectSize               = 9,
		connectStyle              = 15,
		
		regIndent             = 11,
		regLines              = 6,
		regSize               = 9,
		regStyle              = 15,
		dbk = 600,
		upomrod = 300,
		ncop = 120,
		cheat = 3000,
		strochek = 5,
		deleteslap = false,
		deleteadminchat = false,
		deleteban = false,
		deleteanticheat = false,
		deletespec = false,
		deleteplveh = false,
		deletemute = false,
		deletewarn = false,
		deletepm = false,
		deletejail = false,
		deleteclad = false,
		ntune = 120,
		oskadm = 300,
		nead = 60,
		mdm = 5,
		sendgoodplay = tostring(u8'/ao Администрация Arizona RP желает Вам приятной игры на просторах нашего сервера!'),
		cmdHouse = 'ohome',
		cmdBusiness = 'obiz',
		nameaudioforform = 'form.mp3',
		adminrab = tostring(u8'Админы работаем! Отвечаем на репорт, проводим слеты, капчи.'),
		infopunish = tostring(u8'Если вы не согласны с наказанием - обратитесь на форум нашего сервера.'),
		infopunish1 = tostring(u8'Ссылочка на наш форум - *** ссылка *** | Приятной игры!'),
		kapchas = '',
		present = '',
		formis = '',
		akkpass = '',
		admpass = '',
		myserver = 1,
		reportzavse = 0,
		reportzaday = 0,
		nakazaniyaday = 0,
		nakazaniyavse = 0,
		formsday = 0,
		formsvse = 0,
		arank = 9,
		fracid = 1,
		zapusk4 = 0,
		timeopra = 2999,
		rounding = 8,
		buttonrounding = 8,
		skinid = 1,
		intid = 1,
		fraclogin = false,
		skinlogin = false,
		times = 1,
		posX = 1000,
		typedm = 'jail', 
		sizechecker = 12,
		adminssizechecker = 12,
		typeflood = 'mute', 
		typedb = 'jail', 
		typedbk = 'jail', 
		typeupom = 'mute', 
		typeosk = 'mute', 
		typenead = 'mute', 
		typentune = 'jail', 
		typecheat = 'jail', 
		typencop = 'jail', 
		typeoskadm = 'mute', 
		typemdm = 'ban', 
		posY = 800,
		bindtime = 120,
		coloradminchat = '9ACD32',
		twocoloradminchat = '89E31E',
		stockcolorchecker = 'CE8631',
		adminsstockcolorchecker = "CE8631",
		afkcolorchecker = 'B5B6B5',
		colorreport = 'EA4444',
		twocolorreport = 'F8EBCD',
		colorforms = '606160',
		twocolorforms = 'E3C47F',
		maxLinesInKillList      = 5,
		indentKillListX         = math.floor(0.00260416666 * windowCoordinates[1]),
		indentKillListY         = math.floor(0.0074074074 * windowCoordinates[2]),
		iconSizeKillListX        = math.floor(0.0185185 * windowCoordinates[2]),
		iconSizeKillListY        = math.floor(0.0185185 * windowCoordinates[2]),
		give_nrg_report = 'Уважаемый {nick_rep}, выдал Вам НРГ!',
		slezhka_author = 'Уважаемый {nick_rep}, спешу на помощь!',
		slezhka_narush = 'Уважаемый {nick_rep}, вступаю в слежку за нарушителем!',
		give_license = 'Уважаемый {nick_rep}, выдал Вам лицензии!',
		spawn_player = 'Уважаемый {nick_rep}, заспавнил Вас!',
		health_player = 'Уважаемый {nick_rep}, выдал Вам ХП!',
		pereslat_adm = 'Уважаемый {nick_rep}, передал ваш репорт администрации!',
		ftradeKey = encodeJson({}),
		ffloodkey = encodeJson({VK_J}),
		facceptform = encodeJson({VK_G}),
		fopentools = encodeJson({VK_F2}),
		fopenpunish = encodeJson({}),
		fairbrake = encodeJson({VK_RSHIFT}),
		fjspeedup = encodeJson({VK_OEM_PLUS}),
		fspeeddown = encodeJson({VK_OEM_MINUS}),
		upair = encodeJson({VK_OEM_PLUS}),
		fjspeeddown = encodeJson({VK_OEM_MINUS}),
		fvzaim = encodeJson({}),
		fopencbiz = encodeJson({}),
		fopenchome = encodeJson({}),
		ftpaz = encodeJson({}),
		fchecker = encodeJson({}),
		fopenmenutp = encodeJson({}),
		fgm = encodeJson({}),
		freoff = encodeJson({}),
		fvizualrep = encodeJson({}),
		farep = encodeJson({}),
		fopenreport = encodeJson({VK_4}),
		flastreport = encodeJson({}),
		fnorules = encodeJson({}),
		fspecrep = encodeJson({}),
		fperedam = encodeJson({}),
		fslap = encodeJson({}),
		famember = encodeJson({}),
		fspeclast = encodeJson({}),
		fopenmap = encodeJson({}),
		flovlyareporta = encodeJson({}),
		fjetpack = encodeJson({}),
		fspecauthor = encodeJson({}),
		mylvladmin = 0,
		mylvlfd = 0,
		targetState = "player",
		adminsAlign = 3,
		align = 3,
		aligntwo = 3,
		alignthree = 3,
		alignfour = 3,
		circleRadius = 250
	},
	fonts                       = {
		killListSize            = 9,
		killListStyle           = 15
	},
	formssettings = {
		forma_rmute = true,
		forma_unrmute = true,
		forma_mute = true,
		forma_jail = true,
		forma_slap = true,
		forma_kick = true,
		forma_ban = true,
		forma_unban = true,
		forma_banip = true,
		forma_setadmtag = true,
		forma_plveh = true,
		forma_warn = true,
		forma_flip = true,
		forma_freeze = true,
		forma_unfreeze = true,
		forma_pm = true,
		forma_spplayer = true,
		forma_sethp = true,
		forma_unjail = true,
		forma_weap = true,
		forma_unmute = true,
		forma_spcar = true,
		forma_getip = true,
		forma_pgetip = true,
		forma_unwarn = true,
		forma_givegun = true,
		forma_removetune = true,
		forma_delbname = true,
		forma_delhname = true,
		forma_warnoff = true,
		forma_setgangzone = true,
		forma_makeleader = true,
		forma_sban = true,
		forma_unbanip = true,
		forma_jailoff = true,
		forma_muteoff = true,
		forma_skick = true,
		forma_setskin = true,
		forma_uval = true,
		forma_ao = true,
		forma_vv = true,
		forma_deladmtag = true,
		forma_banoff = true,
		forma_agl = true,
		forma_setname = true,
		forma_banipoff = true,
		forma_veh = true,
		forma_agiveskin = true,
		forma_giveitem = true,
		forma_acceptadmin = true,
		forma_awarn = true,
		forma_unjailoff = true,
		forma_asellbiz = true,
		forma_asellhouse = true,
		forma_setarmour = true,
		forma_unmuteoff = true,
		autoforma_slap = false,
		autoforma_jail = false,
		autoforma_kick = false,
		autoforma_ban = false,
		autoforma_unban = false,
		autoforma_banip = false,
		autoforma_setadmtag = false,
		autoforma_plveh = false,
		autoforma_warn = false,
		autoforma_flip = false,
		autoforma_freeze = false,
		autoforma_unfreeze = false,
		autoforma_pm = false,
		autoforma_spplayer = false,
		autoforma_sethp = false,
		autoforma_unjail = false,
		autoforma_weap = false,
		autoforma_unmute = false,
		autoforma_spcar = false,
		autoforma_getip = false,
		autoforma_pgetip = false,
		autoforma_unwarn = false,
		autoforma_givegun = false,
		autoforma_removetune = false,
		autoforma_delbname = false,
		autoforma_delhname = false,
		autoforma_warnoff = false,
		autoforma_setgangzone = false,
		autoforma_makeleader = false,
		autoforma_sban = false,
		autoforma_unbanip = false,
		autoforma_jailoff = false,
		autoforma_muteoff = false,
		autoforma_mute = false,
		autoforma_rmute = false,
		autoforma_unrmute = false,
		autoforma_skick = false,
		autoforma_setskin = false,
		autoforma_uval = false,
		autoforma_ao = false,
		autoforma_vv = false,
		autoforma_deladmtag = false,
		autoforma_banoff = false,
		autoforma_agl = false,
		autoforma_setname = false,
		autoforma_banipoff = false,
		autoforma_veh = false,
		autoforma_agiveskin = false,
		autoforma_giveitem = false,
		autoforma_acceptadmin = false,
		autoforma_awarn = false,
		autoforma_unjailoff = false,
		autoforma_asellbiz = false,
		autoforma_asellhouse = false,
		autoforma_setarmour = false,
		autoforma_unmuteoff = false,

		notf_slap = false,
		notf_jail = false,
		notf_kick = false,
		notf_ban = false,
		notf_unban = false,
		notf_banip = false,
		notf_setadmtag = false,
		notf_plveh = false,
		notf_warn = false,
		notf_flip = false,
		notf_freeze = false,
		notf_unfreeze = false,
		notf_pm = false,
		notf_spplayer = false,
		notf_sethp = false,
		notf_unjail = false,
		notf_weap = false,
		notf_unmute = false,
		notf_spcar = false,
		notf_getip = false,
		notf_pgetip = false,
		notf_unwarn = false,
		notf_givegun = false,
		notf_removetune = false,
		notf_delbname = false,
		notf_delhname = false,
		notf_warnoff = false,
		notf_setgangzone = false,
		notf_makeleader = false,
		notf_sban = false,
		notf_unbanip = false,
		notf_jailoff = false,
		notf_muteoff = false,
		notf_mute = false,
		notf_skick = false,
		notf_setskin = false,
		notf_uval = false,
		notf_ao = false,
		notf_vv = false,
		notf_deladmtag = false,
		notf_banoff = false,
		notf_agl = false,
		notf_setname = false,
		notf_banipoff = false,
		notf_veh = false,
		notf_agiveskin = false,
		notf_giveitem = false,
		notf_acceptadmin = false,
		notf_awarn = false,
		notf_unjailoff = false,
		notf_asellbiz = false,
		notf_asellhouse = false,
		notf_setarmour = false,
		notf_unmuteoff = false,
		notf_rmute = false,
		notf_unrmute = false
	},
	 config = {
		staticObjectMy = 29056040,
		dinamicObjectMy = 90139629,
		pedPMy = 18629728,
		carPMy = 62825729,
		staticObject = 29056040,
		dinamicObject = 90139629,
		pedP = 18629728,
		carP = 62825729,
		colorPlayerI = 23222712,
		drawMyBullets = true,
		drawBullets = true,
		cbEndMy = true,
		cbEnd = true,
		showPlayerInfo = false,
		onlyId = true,
		onlyNick = true,
		timeRenderMyBullets = 10,
		timeRenderBullets = 10, 
		sizeOffMyLine = 1,
		sizeOffLine = 1,
		sizeOffMyPolygonEnd = 1,
		sizeOffPolygonEnd = 1,
		rotationMyPolygonEnd = 10, 
		rotationPolygonEnd = 10, 
		degreeMyPolygonEnd = 50,
		degreePolygonEnd = 50, 
		maxLineMyLimit = 30,
		maxLineLimit = 30
	},
	coloradmchat = {
		r = 137,
		g = 227,
		b = 30,
	},
	twocoloradmchat = {
		r = 137,
		g = 227,
		b = 30,
	},
	ignore = {},
	BizIgnore = {},
	HomeIgnore = {},
	stockcolorchecker = {
		r = 206,
		g = 134,
		b = 49,
	},
	adminsstockcolorchecker ={
		r = 206,
		g=134,
		b=49,
	},
	afkcolorchecker = {
		r = 181,
		g = 182,
		b = 181,
	},
	colorreport = {
		r = 234,
		g = 68,
		b = 68,
	},
	twocolorreport = {
		r = 248,
		g = 235,
		b = 205,
	},
	colorforms = {
		r = 96,
		g = 97,
		b = 96,
	},
	twocolorforms = {
		r = 227,
		g = 196,
		b = 127,
	},
	spawncords = {
	x = 1,
	y = 2,
	z = 3
	},
	statTimers = {
		state = false,
		clock = true,
		sesOnline = true,
		sesAfk = true, 
		sesFull = true,
  		dayOnline = true,
  		dayAfk = true,
  		dayFull = true,
		reportsDay = true,
		reportsVse = true,        
		nakazaniyaDay = true,
		nakazaniyaVse = true,
		formsDay = true,
		reportnow = true,
		formsVse = true,
		nowTime = true,
		weekOnline = true,
  		weekAfk = true,
  		weekFull = true
	},
	leavePosition               = {
		x = windowCoordinates[1] + 60,
		y = windowCoordinates[2] + 320
	},
	connectPosition               = {
		x = windowCoordinates[1] + 100,
		y = windowCoordinates[2] + 200
	},
	adminsPosition    			= {
		x = windowCoordinates[1] + 110,
		y = windowCoordinates[2] + 220
	},
	RegPosition               = {
		x = windowCoordinates[1] + 300,
		y = windowCoordinates[2] + 300
	},
	checkerPosition             = {
		x = windowCoordinates[1] + 200,
		y = windowCoordinates[2] - 100
	},
	punishcheckerPosition      = {
		x = windowCoordinates[1]+200,
		y = windowCoordinates[2]-100
	},
	adminscheckerPosition             = {
		x = windowCoordinates[1] + 200,
		y = windowCoordinates[2] - 100
	},
	onDay = {
		today = os.date("%a"),
		online = 0,
		afk = 0,
		full = 0
	},
	onWeek = {
		week = 1,
		online = 0,
		afk = 0,
		full = 0
	},
	killListPosition            = {
		x = windowCoordinates[1] - 350,
		y = windowCoordinates[2] - 40
	},
	myWeekOnline = {
		[0] = 0,
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 0,
		[5] = 0,
		[6] = 0
	},
	pos = {
		x = 1,
		y = 522,
		x2 = 0,
		y2 = 540,
		x3 = 742,
		y3 = 980,
		x4 = 500,
		y4 = 500,
		x5 = 500,
		y5 = 500
	},
	Settings = {
	font = 'Arial',
	size = 12,
	distance = 20,
	mode = 1,
	style = 12,
	renderText = true
  },
	autoopra = {
		status = false,
		business = false,
		house = false,
		uved = false,
		myreasonhouse = 'опра дом №{idhouse}',
		myreasonbiz = 'опра биз №{idbiz}',
		settingbiz = true,
		settinghouse = true
	},
	reportname = {},
	reportotvet = {},
	reportstyle = {}
}, "AdminToolsKing\\AdminTools.ini")

reason_settings_report = {
	[1] = imgui.ImBuffer(tostring(u8(cfg.main.give_nrg_report)), 256),
	[2] = imgui.ImBuffer(tostring(u8(cfg.main.slezhka_author)), 256),
	[4] = imgui.ImBuffer(tostring(u8(cfg.main.slezhka_narush)), 256),	
	[5] = imgui.ImBuffer(tostring(u8(cfg.main.give_license)), 256),
	[6] = imgui.ImBuffer(tostring(u8(cfg.main.spawn_player)), 256),
	[7] = imgui.ImBuffer(tostring(u8(cfg.main.health_player)), 256),
	[9] = imgui.ImBuffer(tostring(u8(cfg.main.pereslat_adm)), 256)
}

local volume = imgui.ImInt(cfg.main.volume)
local shmax = imgui.ImInt(cfg.main.shmax)
local shsmooth = imgui.ImInt(cfg.main.shsmooth)
local speed2 = imgui.ImInt(cfg.main.speed2)



reason_autoopra = {
	[1] = imgui.ImBuffer(tostring(u8(cfg.autoopra.myreasonhouse)), 256),
	[2] = imgui.ImBuffer(tostring(u8(cfg.autoopra.myreasonbiz)), 256)
}

local to = imgui.ImBool(cfg.statTimers.state)
local nowTime123 = os.date("%H:%M:%S", os.time())
local settings123 = imgui.ImBool(false)
local myOnline = imgui.ImBool(false)
local pos = false
local sesOnline = imgui.ImInt(0)
local sesAfk = imgui.ImInt(0)
local sesFull = imgui.ImInt(0)
local dayFull = imgui.ImInt(cfg.onDay.full)
local my_font = renderCreateFont("Tahoma", 10, FCR_BOLD + FCR_BORDER)
local mybinder1 = imgui.ImBuffer(1024)
local mybinder2 = imgui.ImBuffer(1024)
local mybinder3 = imgui.ImBuffer(1024)
local mybinder4 = imgui.ImBuffer(1024)
local zawitabinder = imgui.ImBuffer(1024)
local donatebinder = imgui.ImBuffer(1024)
local rulesbinder = imgui.ImBuffer(1024)
local discordbinder = imgui.ImBuffer(1024)
local groupbinder = imgui.ImBuffer(1024)
posX123 = imgui.ImInt(cfg.pos.x)
posY123 = imgui.ImInt(cfg.pos.y)
posX456 = imgui.ImInt(cfg.pos.x3)
posY456 = imgui.ImInt(cfg.pos.y3)
posX789 = imgui.ImInt(cfg.adminscheckerPosition.x)
posY789 = imgui.ImInt(cfg.adminscheckerPosition.y)
posX999 = imgui.ImInt(cfg.checkerPosition.x)
posY999 = imgui.ImInt(cfg.checkerPosition.y)
posX10 = imgui.ImInt(cfg.punishcheckerPosition.x)
posY10 = imgui.ImInt(cfg.punishcheckerPosition.y)

posX228 = imgui.ImInt(cfg.pos.x4)
posY228 = imgui.ImInt(cfg.pos.y4)
posX333 = imgui.ImInt(cfg.pos.x5)
posY333 = imgui.ImInt(cfg.pos.y5)
--posX777 = imgui.ImInt(cfg.pos.x7)
--posY777 = imgui.ImInt(cfg.pos.y7)

local fonts1 = { 
	circle = renderCreateFont("Arial", 11, FCR_BOLD + FCR_SHADOW)
}
popupslezhka = imgui.ImBool(true)
moonimgui_text_buffer = imgui.ImBuffer('', 256)
show_checkip2 = false
show_checkip3 = false
MAX_DISTANCE = 2000.0
local checkautooprabiz = imgui.ImBool(cfg.autoopra.settingbiz)
local checkautooprahouse = imgui.ImBool(cfg.autoopra.settinghouse)
local checkautooprauved = imgui.ImBool(cfg.autoopra.uved)
local menusel = imgui.ImInt(1)
local checker_selected = imgui.ImInt(1)
local kill_selected = imgui.ImInt(1)
local windowCoordinates     = {getScreenResolution()}


local pizdas = 1
local selectgroup = 1
local selector_pos = imgui.ImInt(0)


local selector_list = {
fa.ICON_FA_USER_COG..u8' Settings',
fa.ICON_FA_PALETTE..u8' Color Palette',
fa.ICON_FA_KEYBOARD..u8' Key Bindings',
fa.ICON_FA_BAN..u8' Punishment Management',
fa.ICON_FA_ROBOT..u8' Surveillance [Recon]',
fa.ICON_FA_DESKTOP..u8' Checkers and Tools',
fa.ICON_FA_SKULL_CROSSBONES..u8' Kill List',
fa.ICON_FA_CLIPBOARD..u8' Quick Commands',
fa.ICON_FA_HANDSHAKE..u8' Admin Chat Forms',
fa.ICON_FA_LIGHTBULB..u8' Report Responses',
fa.ICON_FA_CAMERA..u8' Auto-Disapproval',
fa.ICON_FA_SKULL..u8' Bullet Tracing',
fa.ICON_FA_INFO_CIRCLE..u8' Script Author Information'
}

local Radio = {
	['sesOnline'] = cfg.statTimers.sesOnline,
	['sesAfk'] = cfg.statTimers.sesAfk,
	['sesFull'] = cfg.statTimers.sesFull,
	['dayOnline'] = cfg.statTimers.dayOnline,
	['dayAfk'] = cfg.statTimers.dayAfk,
	['dayFull'] = cfg.statTimers.dayFull,
	['reportsDay'] = cfg.statTimers.reportsDay,
	['reportsVse'] = cfg.statTimers.reportsVse,
	['nakazaniyaDay'] = cfg.statTimers.nakazaniyaDay,
	['nakazaniyaVse'] = cfg.statTimers.nakazaniyaVse,
	['formsDay'] = cfg.statTimers.formsDay,
	['reportnow'] = cfg.statTimers.reportnow,
	['formsVse'] = cfg.statTimers.formsVse,
	['nowTime'] = cfg.statTimers.nowTime,
	['weekOnline'] = cfg.statTimers.weekOnline,
	['weekAfk'] = cfg.statTimers.weekAfk,
	['weekFull'] = cfg.statTimers.weekFull
}

keyShow = VK_M
reduceZoom = true

local menuPtr = 0x00BA6748

local tWeekdays = {
	[0] = 'Воскресенье',
	[1] = 'Понедельник', 
	[2] = 'Вторник', 
	[3] = 'Среда', 
	[4] = 'Четверг', 
	[5] = 'Пятница', 
	[6] = 'Суббота'
}

local spec_id = -1

fractions = {
	{u8'Полиция ЛС',1543.4702,-1675.3417,13.5463,269.6526},
	{u8'Областная полиция',634.2316,-572.0031,16.3359,89.4022},
	{u8'ФБР',-2452.8354,503.9023,30.0814,90.7232},
	{u8'Полиция СФ',-1605.5938,719.8052,11.9767,181.8999},
	{u8'Больница ЛС',1179.0513,-1323.3345,14.1503,89.0809},
	{u8'Правительство',1495.1583,-1284.2275,14.5310,0.2762},
	{u8'ТСР ЛВ',-12.3242,1880.9875,17.6982,359.7662},
	{u8'Больница СФ',-2668.9612,635.8420,14.4531,358.9167},
	{u8'Автошкола',-2040.8459,-84.7864,35.4024,240.2197},
	{u8'СМИ ЛС',1654.0095,-1657.4438,22.5156,3.0646},
	{u8'Grove Street',2495.3672,-1686.2423,13.5141,180.3683},
	{u8'Los Santos Vagos',2791.7153,-1617.9684,10.9219,253.5807},
	{u8'East Side Ballas',2000.6921,-1108.6322,26.7737,91.0997},
	{u8'Varrios Los Actecas',2522.2488,-2002.0557,13.5469,331.4223},
	{u8'The Rifa',2185.7681,-1811.2325,13.5469,180.2577},
	{u8'Русская мафия',941.4848,1730.9229,8.8516,88.1602},
	{u8'Якудза',-2460.0029,135.0315,35.1719,133.6574},
	{u8'Ла Коса Ностра',1461.7233,2773.3672,10.8203,90.0215},
	{u8'Байкеры',-2189.1516,-2351.4141,30.6250,41.9276},
	{u8'Армия ЛС',2731.0066,-2447.8936,17.5937,179.3509},
	{u8'Центральный банк',1473.1865,-1738.4867,13.5469,193.0428},
	{u8'Больница ЛВ',1606.7427,1821.3120,10.8203,184.813},
	{u8'Полиция ЛВ',2287.1809,2427.3298,10.8203,1.6715},
	{u8'СМИ ЛВ',2637.6292,1179.7631,10.8203,358.5604},
	{u8'Night Wolves',2472.9592,-1421.0908,28.8392,180.9914},
	{u8'СМИ СФ',-1941.2107,463.7813,35.1719,181.763},
	{u8'Армия СФ',-1369.7841,498.7395,11.1953,86.9582}
}

locations = {
{u8'Автосалон ЛС', -484.0909,-557.7690,25.5634},
{u8'Ферма новичков', -86.9788,88.2501,3.1172},
{u8'Автосалон ЛВ', 947.2376,2185.3940,10.8203},
{u8'Спавн LS №2', 2219.6565,-1146.2649,25.7819},
{u8'Центральный рынок', 1125.7731,-1425.4581,15.7969},
{u8'ВайнВуд', 1383.2190,-894.9438,37.1505},
{u8'Информационный центр', -2238.2156,575.6461,35.1719},
{u8'Аммо LS', 1363.6930,-1279.8029,13.5469},
{u8'Спавн LS №1', 1759.4504,-1900.2614,13.6300},
{u8'Завод для МП', 2508.1938,2767.6387,10.8203},
{u8'Шахта', 522.3231,885.0934,-37.4623},
{u8'Автосалон СФ', -2663.9944,-1.8084,4.3267},
{u8'Казино ЛВ', 2030.6858,998.3827,10.8203},
{u8'Автозавод', 1576.6055,713.8749,10.8203},
{u8'Автосалон СФ поддельных авто (нелегалки)', -2466.1277,2251.1570,4.7997},
{u8'Спавн LV №1', 2844.6235,1291.8997,11.3906},
{u8'Спавн LV №2', -71.9333,1224.7753,19.6904},
{u8'Спавн SF', -1986.2416,147.1740,27.6875},
{u8'Автобазар', -2136.6956,-750.2112,32.0234},
{u8'Лес', -1649.5634,-2237.9788,30.1431},
{u8'Банк LV', 2375.4661,2316.0024,8.1406},
{u8'Центральный Банк', 1469.8745,-1743.1466,13.5469},
{u8'Заброшенный аэропорт', 376.8152,2511.9451,16.5445},
{u8'Центр занятости', 1287.5400,-1275.4004,13.5407}
}
		
local ftradeKey = {
	v = decodeJson(cfg.main.ftradeKey)
}

local ffloodkey = {
	v = decodeJson(cfg.main.ffloodkey)
}

local fopentools = {
	v = decodeJson(cfg.main.fopentools)
}

local fopenpunish = {
	v = decodeJson(cfg.main.fopenpunish)
}

local fairbrake = {
	v = decodeJson(cfg.main.fairbrake)
}

local fspeedup = {
	v = decodeJson(cfg.main.fspeedup)
}

local fjspeedup = {
	v = decodeJson(cfg.main.fjspeedup)
}

local fspeeddown = {
	v = decodeJson(cfg.main.fspeeddown)
}

local upair = {
	v = decodeJson(cfg.main.upair)
}

local fjspeeddown = {
	v = decodeJson(cfg.main.fjspeeddown)
}

local fvzaim = {
	v = decodeJson(cfg.main.fvzaim)
}

local ftpaz = {
	v = decodeJson(cfg.main.ftpaz)
}

local fopencbiz = {
	v = decodeJson(cfg.main.fopencbiz)
}

local fopenchome = {
	v = decodeJson(cfg.main.fopenchome)
}

local fchecker = {
	v = decodeJson(cfg.main.fchecker)
}

local fopenmenutp = {
	v = decodeJson(cfg.main.fopenmenutp)
}


local fgm = {
	v = decodeJson(cfg.main.fgm)
}

local freoff = {
	v = decodeJson(cfg.main.freoff)
}

local fvizualrep = {
	v = decodeJson(cfg.main.fvizualrep)
}

local farep = {
	v = decodeJson(cfg.main.farep)
}

local flastreport = {
	v = decodeJson(cfg.main.flastreport)
}

local fnorules = {
	v = decodeJson(cfg.main.fnorules)
}

local fspecrep = {
	v = decodeJson(cfg.main.fspecrep)
}


local fperedam = {
	v = decodeJson(cfg.main.fperedam)
}

local fslap = {
	v = decodeJson(cfg.main.fslap)
}

local famember = {
	v = decodeJson(cfg.main.famember)
}


local fspeclast = {
	v = decodeJson(cfg.main.fspeclast)
}

local fopenmap = {
	v = decodeJson(cfg.main.fopenmap)
}

local flovlyareporta = {
	v = decodeJson(cfg.main.flovlyareporta)
}

local fjetpack = {
	v = decodeJson(cfg.main.fjetpack)
}

local fspecauthor = {
	v = decodeJson(cfg.main.fspecauthor)
}

local fopenreport = {
	v = decodeJson(cfg.main.fopenreport)
}

local facceptform = {
	v = decodeJson(cfg.main.facceptform)
}

forma_mute = imgui.ImBool(cfg.formssettings.forma_mute)
forma_rmute = imgui.ImBool(cfg.formssettings.forma_rmute)
forma_unrmute = imgui.ImBool(cfg.formssettings.forma_unrmute)
forma_jail = imgui.ImBool(cfg.formssettings.forma_jail)
forma_slap = imgui.ImBool(cfg.formssettings.forma_slap)
forma_kick = imgui.ImBool(cfg.formssettings.forma_kick)
forma_ban = imgui.ImBool(cfg.formssettings.forma_ban)
forma_unban = imgui.ImBool(cfg.formssettings.forma_unban)
forma_banip = imgui.ImBool(cfg.formssettings.forma_banip)
forma_setadmtag = imgui.ImBool(cfg.formssettings.forma_setadmtag)
forma_plveh = imgui.ImBool(cfg.formssettings.forma_plveh)
forma_warn = imgui.ImBool(cfg.formssettings.forma_warn)
forma_flip = imgui.ImBool(cfg.formssettings.forma_flip)
forma_freeze = imgui.ImBool(cfg.formssettings.forma_freeze)
forma_pm = imgui.ImBool(cfg.formssettings.forma_pm)
forma_spplayer = imgui.ImBool(cfg.formssettings.forma_spplayer)
forma_sethp = imgui.ImBool(cfg.formssettings.forma_sethp)
forma_unjail = imgui.ImBool(cfg.formssettings.forma_unjail)
forma_weap = imgui.ImBool(cfg.formssettings.forma_weap)
forma_unmute = imgui.ImBool(cfg.formssettings.forma_unmute)
forma_spcar = imgui.ImBool(cfg.formssettings.forma_spcar)
forma_getip = imgui.ImBool(cfg.formssettings.forma_getip)
forma_pgetip = imgui.ImBool(cfg.formssettings.forma_pgetip)
forma_unwarn = imgui.ImBool(cfg.formssettings.forma_unwarn)
forma_givegun = imgui.ImBool(cfg.formssettings.forma_givegun)
forma_removetune = imgui.ImBool(cfg.formssettings.forma_removetune)
forma_delbname = imgui.ImBool(cfg.formssettings.forma_delbname)
forma_delhname = imgui.ImBool(cfg.formssettings.forma_delhname)
forma_warnoff = imgui.ImBool(cfg.formssettings.forma_warnoff)
forma_setgangzone = imgui.ImBool(cfg.formssettings.forma_setgangzone)
forma_makeleader = imgui.ImBool(cfg.formssettings.forma_makeleader)
forma_sban = imgui.ImBool(cfg.formssettings.forma_sban)
forma_unbanip = imgui.ImBool(cfg.formssettings.forma_unbanip)
forma_jailoff = imgui.ImBool(cfg.formssettings.forma_jailoff)
forma_muteoff = imgui.ImBool(cfg.formssettings.forma_muteoff)
forma_skick = imgui.ImBool(cfg.formssettings.forma_skick)
forma_setskin = imgui.ImBool(cfg.formssettings.forma_setskin)
forma_uval = imgui.ImBool(cfg.formssettings.forma_uval)
forma_ao = imgui.ImBool(cfg.formssettings.forma_ao)
forma_vv = imgui.ImBool(cfg.formssettings.forma_vv)
forma_deladmtag = imgui.ImBool(cfg.formssettings.forma_deladmtag)
forma_banoff = imgui.ImBool(cfg.formssettings.forma_banoff)
forma_agl = imgui.ImBool(cfg.formssettings.forma_agl)
forma_setname = imgui.ImBool(cfg.formssettings.forma_setname)
forma_banipoff = imgui.ImBool(cfg.formssettings.forma_banipoff)
forma_veh = imgui.ImBool(cfg.formssettings.forma_veh)
forma_agiveskin = imgui.ImBool(cfg.formssettings.forma_agiveskin)
forma_giveitem = imgui.ImBool(cfg.formssettings.forma_giveitem)
forma_acceptadmin = imgui.ImBool(cfg.formssettings.forma_acceptadmin)
forma_awarn = imgui.ImBool(cfg.formssettings.forma_awarn)
forma_unjailoff = imgui.ImBool(cfg.formssettings.forma_unjailoff)
forma_asellbiz = imgui.ImBool(cfg.formssettings.forma_asellbiz)
forma_asellhouse = imgui.ImBool(cfg.formssettings.forma_asellhouse)
forma_setarmour = imgui.ImBool(cfg.formssettings.forma_setarmour)
forma_unmuteoff = imgui.ImBool(cfg.formssettings.forma_unmuteoff)

autoforma_rmute = imgui.ImBool(cfg.formssettings.autoforma_rmute)
autoforma_unrmute = imgui.ImBool(cfg.formssettings.autoforma_unrmute)
autoforma_slap = imgui.ImBool(cfg.formssettings.autoforma_slap)
autoforma_jail = imgui.ImBool(cfg.formssettings.autoforma_jail)
autoforma_mute = imgui.ImBool(cfg.formssettings.autoforma_mute)
autoforma_kick = imgui.ImBool(cfg.formssettings.autoforma_kick)
autoforma_ban = imgui.ImBool(cfg.formssettings.autoforma_ban)
autoforma_unban = imgui.ImBool(cfg.formssettings.autoforma_unban)
autoforma_banip = imgui.ImBool(cfg.formssettings.autoforma_banip)
autoforma_setadmtag = imgui.ImBool(cfg.formssettings.autoforma_setadmtag)
autoforma_plveh = imgui.ImBool(cfg.formssettings.autoforma_plveh)
autoforma_warn = imgui.ImBool(cfg.formssettings.autoforma_warn)
autoforma_flip = imgui.ImBool(cfg.formssettings.autoforma_flip)
autoforma_freeze = imgui.ImBool(cfg.formssettings.autoforma_freeze)
autoforma_pm = imgui.ImBool(cfg.formssettings.autoforma_pm)
autoforma_spplayer = imgui.ImBool(cfg.formssettings.autoforma_spplayer)
autoforma_sethp = imgui.ImBool(cfg.formssettings.autoforma_sethp)
autoforma_unjail = imgui.ImBool(cfg.formssettings.autoforma_unjail)
autoforma_weap = imgui.ImBool(cfg.formssettings.autoforma_weap)
autoforma_unmute = imgui.ImBool(cfg.formssettings.autoforma_unmute)
autoforma_spcar = imgui.ImBool(cfg.formssettings.autoforma_spcar)
autoforma_getip = imgui.ImBool(cfg.formssettings.autoforma_getip)
autoforma_pgetip = imgui.ImBool(cfg.formssettings.autoforma_pgetip)
autoforma_unwarn = imgui.ImBool(cfg.formssettings.autoforma_unwarn)
autoforma_givegun = imgui.ImBool(cfg.formssettings.autoforma_givegun)
autoforma_removetune = imgui.ImBool(cfg.formssettings.autoforma_removetune)
autoforma_delbname = imgui.ImBool(cfg.formssettings.autoforma_delbname)
autoforma_delhname = imgui.ImBool(cfg.formssettings.autoforma_delhname)
autoforma_warnoff = imgui.ImBool(cfg.formssettings.autoforma_warnoff)
autoforma_setgangzone = imgui.ImBool(cfg.formssettings.autoforma_setgangzone)
autoforma_makeleader = imgui.ImBool(cfg.formssettings.autoforma_makeleader)
autoforma_sban = imgui.ImBool(cfg.formssettings.autoforma_sban)
autoforma_unbanip = imgui.ImBool(cfg.formssettings.autoforma_unbanip)
autoforma_jailoff = imgui.ImBool(cfg.formssettings.autoforma_jailoff)
autoforma_muteoff = imgui.ImBool(cfg.formssettings.autoforma_muteoff)
autoforma_skick = imgui.ImBool(cfg.formssettings.autoforma_skick)
autoforma_setskin = imgui.ImBool(cfg.formssettings.autoforma_setskin)
autoforma_uval = imgui.ImBool(cfg.formssettings.autoforma_uval)
autoforma_ao = imgui.ImBool(cfg.formssettings.autoforma_ao)
autoforma_vv = imgui.ImBool(cfg.formssettings.autoforma_vv)
autoforma_deladmtag = imgui.ImBool(cfg.formssettings.autoforma_deladmtag)
autoforma_banoff = imgui.ImBool(cfg.formssettings.autoforma_banoff)
autoforma_agl = imgui.ImBool(cfg.formssettings.autoforma_agl)
autoforma_setname = imgui.ImBool(cfg.formssettings.autoforma_setname)
autoforma_banipoff = imgui.ImBool(cfg.formssettings.autoforma_banipoff)
autoforma_veh = imgui.ImBool(cfg.formssettings.autoforma_veh)
autoforma_agiveskin = imgui.ImBool(cfg.formssettings.autoforma_agiveskin)
autoforma_giveitem = imgui.ImBool(cfg.formssettings.autoforma_giveitem)
autoforma_acceptadmin = imgui.ImBool(cfg.formssettings.autoforma_acceptadmin)
autoforma_awarn = imgui.ImBool(cfg.formssettings.autoforma_awarn)
autoforma_unjailoff = imgui.ImBool(cfg.formssettings.autoforma_unjailoff)
autoforma_asellbiz = imgui.ImBool(cfg.formssettings.autoforma_asellbiz)
autoforma_asellhouse = imgui.ImBool(cfg.formssettings.autoforma_asellhouse)
autoforma_setarmour = imgui.ImBool(cfg.formssettings.autoforma_setarmour)
autoforma_unmuteoff = imgui.ImBool(cfg.formssettings.autoforma_unmuteoff)

notf_rmute = imgui.ImBool(cfg.formssettings.notf_rmute)
notf_unrmute = imgui.ImBool(cfg.formssettings.notf_unrmute)
notf_slap = imgui.ImBool(cfg.formssettings.notf_slap)
notf_jail = imgui.ImBool(cfg.formssettings.notf_jail)
notf_mute = imgui.ImBool(cfg.formssettings.notf_mute)
notf_kick = imgui.ImBool(cfg.formssettings.notf_kick)
notf_ban = imgui.ImBool(cfg.formssettings.notf_ban)
notf_unban = imgui.ImBool(cfg.formssettings.notf_unban)
notf_banip = imgui.ImBool(cfg.formssettings.notf_banip)
notf_setadmtag = imgui.ImBool(cfg.formssettings.notf_setadmtag)
notf_plveh = imgui.ImBool(cfg.formssettings.notf_plveh)
notf_warn = imgui.ImBool(cfg.formssettings.notf_warn)
notf_flip = imgui.ImBool(cfg.formssettings.notf_flip)
notf_freeze = imgui.ImBool(cfg.formssettings.notf_freeze)
notf_pm = imgui.ImBool(cfg.formssettings.notf_pm)
notf_spplayer = imgui.ImBool(cfg.formssettings.notf_spplayer)
notf_sethp = imgui.ImBool(cfg.formssettings.notf_sethp)
notf_unjail = imgui.ImBool(cfg.formssettings.notf_unjail)
notf_weap = imgui.ImBool(cfg.formssettings.notf_weap)
notf_unmute = imgui.ImBool(cfg.formssettings.notf_unmute)
notf_spcar = imgui.ImBool(cfg.formssettings.notf_spcar)
notf_getip = imgui.ImBool(cfg.formssettings.notf_getip)
notf_pgetip = imgui.ImBool(cfg.formssettings.notf_pgetip)
notf_unwarn = imgui.ImBool(cfg.formssettings.notf_unwarn)
notf_givegun = imgui.ImBool(cfg.formssettings.notf_givegun)
notf_removetune = imgui.ImBool(cfg.formssettings.notf_removetune)
notf_delbname = imgui.ImBool(cfg.formssettings.notf_delbname)
notf_delhname = imgui.ImBool(cfg.formssettings.notf_delhname)
notf_warnoff = imgui.ImBool(cfg.formssettings.notf_warnoff)
notf_setgangzone = imgui.ImBool(cfg.formssettings.notf_setgangzone)
notf_makeleader = imgui.ImBool(cfg.formssettings.notf_makeleader)
notf_sban = imgui.ImBool(cfg.formssettings.notf_sban)
notf_unbanip = imgui.ImBool(cfg.formssettings.notf_unbanip)
notf_jailoff = imgui.ImBool(cfg.formssettings.notf_jailoff)
notf_muteoff = imgui.ImBool(cfg.formssettings.notf_muteoff)
notf_skick = imgui.ImBool(cfg.formssettings.notf_skick)
notf_setskin = imgui.ImBool(cfg.formssettings.notf_setskin)
notf_uval = imgui.ImBool(cfg.formssettings.notf_uval)
notf_ao = imgui.ImBool(cfg.formssettings.notf_ao)
notf_vv = imgui.ImBool(cfg.formssettings.notf_vv)
notf_deladmtag = imgui.ImBool(cfg.formssettings.notf_deladmtag)
notf_banoff = imgui.ImBool(cfg.formssettings.notf_banoff)
notf_agl = imgui.ImBool(cfg.formssettings.notf_agl)
notf_setname = imgui.ImBool(cfg.formssettings.notf_setname)
notf_banipoff = imgui.ImBool(cfg.formssettings.notf_banipoff)
notf_veh = imgui.ImBool(cfg.formssettings.notf_veh)
notf_agiveskin = imgui.ImBool(cfg.formssettings.notf_agiveskin)
notf_giveitem = imgui.ImBool(cfg.formssettings.notf_giveitem)
notf_acceptadmin = imgui.ImBool(cfg.formssettings.notf_acceptadmin)
notf_awarn = imgui.ImBool(cfg.formssettings.notf_awarn)
notf_unjailoff = imgui.ImBool(cfg.formssettings.notf_unjailoff)
notf_asellbiz = imgui.ImBool(cfg.formssettings.notf_asellbiz)
notf_asellhouse = imgui.ImBool(cfg.formssettings.notf_asellhouse)
notf_setarmour = imgui.ImBool(cfg.formssettings.notf_setarmour)
notf_unmuteoff = imgui.ImBool(cfg.formssettings.notf_unmuteoff)
local autoformaq = "false"
addIgnore = imgui.ImBuffer(256)
addIgnorePr = imgui.ImBuffer(256)
buffer2 = imgui.ImInt(cfg.main.dm)
buffer3 = imgui.ImInt(cfg.main.flood)
buffer36 = imgui.ImInt(cfg.main.timeoutmy1)
buffer37 = imgui.ImInt(cfg.main.timeoutmy2)
buffer40 = imgui.ImInt(cfg.main.timeoutmy3)
buffer41 = imgui.ImInt(cfg.main.timeoutmy4)
buffer42 = imgui.ImInt(cfg.main.timeoutzawita)
buffer43 = imgui.ImInt(cfg.main.timeoutdonate)
buffer44 = imgui.ImInt(cfg.main.timeoutrules)
buffer45 = imgui.ImInt(cfg.main.timeoutdiscord)
buffer46 = imgui.ImInt(cfg.main.timeoutgroup)
buffer4 = imgui.ImInt(cfg.main.db)
buffer5 = imgui.ImInt(cfg.main.oskrod)
buffer6 = imgui.ImInt(cfg.main.dbk)
buffer7 = imgui.ImInt(cfg.main.upomrod)
buffer8 = imgui.ImInt(cfg.main.ncop)
buffer9 = imgui.ImInt(cfg.main.cheat)
stroki = imgui.ImInt(cfg.main.strochek)
buffer10 = imgui.ImInt(cfg.main.ntune)
buffer11 = imgui.ImInt(cfg.main.nead)
buffer12 = imgui.ImInt(cfg.main.oskadm)
buffer13 = imgui.ImInt(cfg.main.mdm)
buffer27 = imgui.ImBuffer(tostring(cfg.main.kapchas), 256)
buffer27.v = string.gsub(tostring(buffer27.v), '"', '')
buffer28 = imgui.ImBuffer(tostring(cfg.main.present), 256)
buffer28.v = string.gsub(tostring(buffer28.v), '"', '')
buffer34 = imgui.ImBuffer('', 256)
bufferaye = imgui.ImBuffer('', 256)
buffer38 = imgui.ImBuffer('', 256)
buffer35 = imgui.ImBuffer('', 256)
buffer55 = imgui.ImBuffer(tostring(cfg.main.akkpass), 65535)
buffer55.v = string.gsub(tostring(buffer55.v), '"', '')
fontwh = imgui.ImBuffer(tostring(cfg.Settings.font), 65535)
fontwh.v = string.gsub(tostring(fontwh.v), '"', '')
fontchecker = imgui.ImBuffer(tostring(cfg.main.fontchecker), 65535)
fontchecker.v = string.gsub(tostring(fontchecker.v), '"', '')
QuitFontChecker = imgui.ImBuffer(tostring(cfg.main.QuitFontChecker), 65535)
QuitFontChecker.v = string.gsub(tostring(QuitFontChecker.v), '"', '')
ConnectFontChecker = imgui.ImBuffer(tostring(cfg.main.ConnectFontChecker), 65535)
ConnectFontChecker.v = string.gsub(tostring(ConnectFontChecker.v), '"', '')
RegFontChecker = imgui.ImBuffer(tostring(cfg.main.RegFontChecker), 65535)
FontKill = imgui.ImBuffer(tostring(cfg.main.FontKill), 65535)
RegFontChecker.v = string.gsub(tostring(RegFontChecker.v), '"', '')

adminsfontchecker = imgui.ImBuffer(tostring(cfg.main.adminsfontchecker), 65535)
adminsfontchecker.v = string.gsub(tostring(adminsfontchecker.v), '"', '')

FontKill.v = string.gsub(tostring(FontKill.v), '"', '')
buffer56 = imgui.ImBuffer(tostring(cfg.main.admpass), 65535)
buffer56.v = string.gsub(tostring(buffer56.v), '"', '')
myserver = imgui.ImBuffer(tostring(cfg.main.myserver), 65535)
myserver.v = string.gsub(tostring(myserver.v), '"', '')
buffer58 = imgui.ImInt(cfg.main.arank)
buffer73 = imgui.ImInt(cfg.main.fracid)
buffer71 = imgui.ImInt(cfg.Settings.size)
PlayersBufferSize = imgui.ImInt(cfg.main.sizechecker)
PlayersBufferStyle = imgui.ImInt(cfg.main.stylechecker)
PlayersBufferOffset = imgui.ImInt(cfg.main.otschecker)
adminsBufferSize = imgui.ImInt(cfg.main.adminssizechecker)
adminsBufferStyle = imgui.ImInt(cfg.main.adminsstylechecker)
adminsBufferOffset = imgui.ImInt(cfg.main.adminsotschecker)
LeaveBufferSize = imgui.ImInt(cfg.main.leaveSize)
LeaveBufferStyle = imgui.ImInt(cfg.main.leaveStyle)
LeaveBufferOffset = imgui.ImInt(cfg.main.leaveIndent)
LeaveBufferLines = imgui.ImInt(cfg.main.leaveLines)
ConnectBufferSize = imgui.ImInt(cfg.main.connectSize)
ConnectBufferStyle = imgui.ImInt(cfg.main.connectStyle)
ConnectBufferOffset = imgui.ImInt(cfg.main.connectIndent)
ConnectBufferLines = imgui.ImInt(cfg.main.connectLines)

adminsBufferLines = imgui.ImInt(cfg.main.adminsLines)

KillBufferIndentX = imgui.ImInt(cfg.main.indentKillListX) 
KillBufferIndentY = imgui.ImInt(cfg.main.indentKillListY) 


KillBufferIconSizeX = imgui.ImInt(cfg.main.iconSizeKillListX) 
KillBufferIconSizeY = imgui.ImInt(cfg.main.iconSizeKillListY) 

KillBufferFontStyle = imgui.ImInt(cfg.fonts.killListStyle) 
KillBufferSize = imgui.ImInt(cfg.fonts.killListSize) 

RegBufferSize = imgui.ImInt(cfg.main.regSize)
RegBufferStyle = imgui.ImInt(cfg.main.regStyle)
RegBufferOffset = imgui.ImInt(cfg.main.regIndent)
RegBufferLines = imgui.ImInt(cfg.main.regLines)
buffer72 = imgui.ImInt(cfg.Settings.style)
buffer70 = imgui.ImInt(cfg.Settings.distance)
buffer54 = imgui.ImInt(cfg.main.bindtime)
buffer59 = imgui.ImInt(cfg.main.timeopra)
buffer74 = imgui.ImInt(cfg.main.rounding)
buffer75 = imgui.ImInt(cfg.main.buttonrounding)
buffer76 = imgui.ImInt(cfg.main.skinid)
buffer77 = imgui.ImInt(cfg.main.intid)
buffer84 = imgui.ImBuffer(tostring(cfg.main.my2), 256)
buffer84.v = string.gsub(tostring(buffer84.v), '"', '')
buffer85 = imgui.ImBuffer(tostring(cfg.main.my3), 256)
buffer85.v = string.gsub(tostring(buffer85.v), '"', '')
buffer86 = imgui.ImBuffer(tostring(cfg.main.my4), 256)
buffer86.v = string.gsub(tostring(buffer86.v), '"', '')
buffer87 = imgui.ImBuffer(tostring(cfg.main.my5), 256)
buffer87.v = string.gsub(tostring(buffer87.v), '"', '')
buffer88 = imgui.ImBuffer(tostring(cfg.main.my6), 256)
buffer88.v = string.gsub(tostring(buffer88.v), '"', '')
buffer89 = imgui.ImBuffer(tostring(cfg.main.my7), 256)
buffer89.v = string.gsub(tostring(buffer89.v), '"', '')
goodplay = imgui.ImBuffer(tostring(cfg.main.sendgoodplay), 256)
goodplay.v = string.gsub(tostring(goodplay.v), '"', '')
cmdHouse = imgui.ImBuffer(tostring(cfg.main.cmdHouse), 256)
cmdHouse.v = string.gsub(tostring(cmdHouse.v), '"', '')
cmdBusiness = imgui.ImBuffer(tostring(cfg.main.cmdBusiness), 256)
cmdBusiness.v = string.gsub(tostring(cmdBusiness.v), '"', '')
nameaudio = imgui.ImBuffer(tostring(cfg.main.nameaudioforform), 256)
nameaudio.v = string.gsub(tostring(nameaudio.v), '"', '')
fludadm = imgui.ImBuffer(tostring(cfg.main.adminrab), 256)
fludadm.v = string.gsub(tostring(fludadm.v), '"', '')
buffer90 = imgui.ImBuffer(tostring(cfg.main.typedm), 256)
buffer90.v = string.gsub(tostring(buffer90.v), '"', '')
buffer91 = imgui.ImBuffer(tostring(cfg.main.typeflood), 256)
buffer91.v = string.gsub(tostring(buffer91.v), '"', '')
buffer92 = imgui.ImBuffer(tostring(cfg.main.typedb), 256)
buffer92.v = string.gsub(tostring(buffer92.v), '"', '')
buffer93 = imgui.ImBuffer(tostring(cfg.main.typedbk), 256)
buffer93.v = string.gsub(tostring(buffer93.v), '"', '')
buffer94 = imgui.ImBuffer(tostring(cfg.main.infopunish), 256)
buffer94.v = string.gsub(tostring(buffer94.v), '"', '')
buffer95 = imgui.ImBuffer(tostring(cfg.main.infopunish1), 256)
buffer95.v = string.gsub(tostring(buffer95.v), '"', '')
buffer96 = imgui.ImBuffer(tostring(cfg.main.typeupom), 256)
buffer96.v = string.gsub(tostring(buffer96.v), '"', '')
buffer97 = imgui.ImBuffer(tostring(cfg.main.typeosk), 256)
buffer97.v = string.gsub(tostring(buffer97.v), '"', '')
buffer98 = imgui.ImBuffer(tostring(cfg.main.typenead), 256)
buffer98.v = string.gsub(tostring(buffer98.v), '"', '')
buffer99 = imgui.ImBuffer(tostring(cfg.main.typentune), 256)
buffer99.v = string.gsub(tostring(buffer99.v), '"', '')
buffer100 = imgui.ImBuffer(tostring(cfg.main.typecheat), 256)
buffer100.v = string.gsub(tostring(buffer100.v), '"', '')
buffer101 = imgui.ImBuffer(tostring(cfg.main.typencop), 256)
buffer101.v = string.gsub(tostring(buffer101.v), '"', '')
buffer102 = imgui.ImBuffer(tostring(cfg.main.typeoskadm), 256)
buffer102.v = string.gsub(tostring(buffer102.v), '"', '')
buffer103 = imgui.ImBuffer(tostring(cfg.main.typemdm), 256)
buffer103.v = string.gsub(tostring(buffer103.v), '"', '')
ffi.cdef[[
struct stKillEntry
{
	char					szKiller[25];
	char					szVictim[25];
	uint32_t				clKillerColor; // D3DCOLOR
	uint32_t				clVictimColor; // D3DCOLOR
	uint8_t					byteType;
} __attribute__ ((packed));

struct stKillInfo
{
	int						iEnabled;
	struct stKillEntry		killEntry[5];
	int 					iLongestNickLength;
  	int 					iOffsetX;
  	int 					iOffsetY;
	void			    	*pD3DFont; // ID3DXFont
	void		    		*pWeaponFont1; // ID3DXFont
	void		   	    	*pWeaponFont2; // ID3DXFont
	void					*pSprite;
	void					*pD3DDevice;
	int 					iAuxFontInited;
	void 		    		*pAuxFont1; // ID3DXFont
	void 			    	*pAuxFont2; // ID3DXFont
} __attribute__ ((packed));
]]
 getBonePosition = ffi.cast("int (__thiscall*)(void*, float*, int, bool)", 0x5E4280)

local messageChangeMode = {
  [1] = 'игровых названий транспорта',
  [2] = 'системных названий файлов транспорта',
}
local reportnow = 0
local withID = {{}, {}}
timeout = imgui.ImInt(500)
local text_buffer1 = imgui.ImBuffer(65535)
local text_command = imgui.ImBuffer(65535)
local addPlayerInChecker = imgui.ImBuffer(65535)
local when_captcha = imgui.ImInt(1)
local formsall = 0
local style_information = imgui.ImInt(cfg.main.styleinformation)
local style_controlpanel = imgui.ImInt(cfg.main.stylerecon)
local style_reg = imgui.ImInt(cfg.main.stylereg)
local style_admin = imgui.ImInt(cfg.main.styleadmin)
local style_lovlyareporta = imgui.ImInt(cfg.main.stylelovlyareporta)
local style_killlist = imgui.ImInt(cfg.main.stylekilllist)
local style_wallhackoncar = imgui.ImInt(cfg.Settings.mode)
mc = "{009D00}"
sc = "{00C235}"
wc = "{FFFFFF}"
ec = "{BE3D3D}"
lc = "{ACFF00}"
yc = "{E0BF23}"

r, g, b = imgui.ImColor(cfg.coloradmchat.r, cfg.coloradmchat.g, cfg.coloradmchat.b):GetFloat4()
r10, g10, b10 = imgui.ImColor(cfg.colorreport.r, cfg.colorreport.g, cfg.colorreport.b):GetFloat4()
r11, g11, b11 = imgui.ImColor(cfg.colorforms.r, cfg.colorforms.g, cfg.colorforms.b):GetFloat4()
r12, g12, b12 = imgui.ImColor(cfg.twocolorreport.r, cfg.twocolorreport.g, cfg.twocolorreport.b):GetFloat4()
r13, g13, b13 = imgui.ImColor(cfg.twocoloradmchat.r, cfg.twocoloradmchat.g, cfg.twocoloradmchat.b):GetFloat4()
r15, g15, b15 = imgui.ImColor(cfg.stockcolorchecker.r, cfg.stockcolorchecker.g, cfg.stockcolorchecker.b):GetFloat4()
r17, g17, b17 = imgui.ImColor(cfg.adminsstockcolorchecker.r, cfg.adminsstockcolorchecker.g, cfg.adminsstockcolorchecker.b):GetFloat4()
r16, g16, b16 = imgui.ImColor(cfg.afkcolorchecker.r, cfg.afkcolorchecker.g, cfg.afkcolorchecker.b):GetFloat4()
r14, g14, b14 = imgui.ImColor(cfg.twocolorforms.r, cfg.twocolorforms.g, cfg.twocolorforms.b):GetFloat4()
coloradmchat = imgui.ImFloat3(r, g, b)
twocoloradmchat = imgui.ImFloat3(r13, g13, b13)
stockcolorchecker = imgui.ImFloat3(r15, g15, b15)
adminsstockcolorchecker = imgui.ImFloat3(r17,g17,b17)
afkcolorchecker = imgui.ImFloat3(r16, g16, b16)
colorreport = imgui.ImFloat3(r10, g10, b10)
twocolorreport = imgui.ImFloat3(r12, g12, g12)
colorforms = imgui.ImFloat3(r11, g11, b11)
twocolorforms = imgui.ImFloat3(r14, g14, b14)

local elements = {
	checkbox = {
		drawMyBullets = imgui.ImBool(cfg.config.drawMyBullets),
		drawBullets = imgui.ImBool(cfg.config.drawBullets),
		cbEndMy = imgui.ImBool(cfg.config.cbEndMy),
		cbEnd = imgui.ImBool(cfg.config.cbEnd),
		showPlayerInfo = imgui.ImBool(cfg.config.showPlayerInfo),
		onlyId = imgui.ImBool(cfg.config.onlyId),
		onlyNick = imgui.ImBool(cfg.config.onlyNick)
	},
	int = {
		timeRenderMyBullets = imgui.ImInt(cfg.config.timeRenderMyBullets),
		timeRenderBullets = imgui.ImInt(cfg.config.timeRenderBullets),
		sizeOffMyLine = imgui.ImInt(cfg.config.sizeOffMyLine),
		sizeOffLine = imgui.ImInt(cfg.config.sizeOffLine),
		sizeOffMyPolygonEnd = imgui.ImInt(cfg.config.sizeOffMyPolygonEnd),
		sizeOffPolygonEnd = imgui.ImInt(cfg.config.sizeOffPolygonEnd),
		rotationMyPolygonEnd = imgui.ImInt(cfg.config.rotationMyPolygonEnd),
		rotationPolygonEnd = imgui.ImInt(cfg.config.rotationPolygonEnd),
		degreeMyPolygonEnd = imgui.ImInt(cfg.config.degreeMyPolygonEnd),
		degreePolygonEnd = imgui.ImInt(cfg.config.degreePolygonEnd),
		maxLineMyLimit = imgui.ImInt(cfg.config.maxLineMyLimit),
		maxLineLimit = imgui.ImInt(cfg.config.maxLineLimit)
	}
}

ErrorMessage = true
bEvents, se = pcall(require, "lib.samp.events")
bImgui, imgui = pcall(require, "imgui")
bRa = doesFileExist(getWorkingDirectory().."\\reload_all.lua")
tLog = {}
logBut = {
			["selected"] = 1,
			["clicked"] = {
				["last"] = nil,
				["time"] = nil
			},
			["buttons"] = {
				"Автонаказание",
				"Логи за сессию",
				"Логи за всё время",
				"Белый список",
				"Прочее"
			}
		}

local bulletSync = {lastId = 0, maxLines = elements.int.maxLineLimit.v}
for i = 1, bulletSync.maxLines do
	bulletSync[i] = { other = {time = 0, t = {x,y,z}, o = {x,y,z}, type = 0, color = 0, id = -1, colorText = 0}}
end

local bulletSyncMy = {lastId = 0, maxLines = elements.int.maxLineMyLimit.v}
for i = 1, bulletSyncMy.maxLines do
	bulletSyncMy[i] = { my = {time = 0, t = {x,y,z}, o = {x,y,z}, type = 0, color = 0}}
end

function getserial()
	local ffi = require("ffi")
	ffi.cdef[[
	int __stdcall GetVolumeInformationA(
	const char* lpRootPathName,
	char* lpVolumeNameBuffer,
	uint32_t nVolumeNameSize,
	uint32_t* lpVolumeSerialNumber,
	uint32_t* lpMaximumComponentLength,
	uint32_t* lpFileSystemFlags,
	char* lpFileSystemNameBuffer,
	uint32_t nFileSystemNameSize
	);
	]]
	local serial = ffi.new("unsigned long[1]", 0)
	ffi.C.GetVolumeInformationA(nil, nil, 0, serial, nil, nil, nil, 0)
	return serial[0]
end

function getCapitalLetter(text, mode)
	local num = 0
	local a = {}
	local b = tostring(text)

	if mode == 1 then
		string_world = 'ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ'
	elseif mode == 2 then
		string_world = 'QWERTYUIOPASDFGHJKLZXCVBNM'
	elseif mode == 3 then
		string_world = 'ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮQWERTYUIOPASDFGHJKLZXCVBNM'
	end

	for i = 1, #b do
		a[#a + 1] = b:sub(i, i)
	end

	for k, v in pairs(a) do
		if string.find(string_world, v, nil, true) then
			num = num + 1
		end
	end

	return num
end

function explode_argb(argb)
	local a = bit.band(bit.rshift(argb, 24), 0xFF)
	local r = bit.band(bit.rshift(argb, 16), 0xFF)
	local g = bit.band(bit.rshift(argb, 8), 0xFF)
	local b = bit.band(argb, 0xFF)
	return a, r, g, b
end

local staticObject = imgui.ImFloat4( imgui.ImColor( explode_argb(cfg.config.staticObject) ):GetFloat4() )    
local dinamicObject = imgui.ImFloat4( imgui.ImColor( explode_argb(cfg.config.dinamicObject) ):GetFloat4() )   
local pedP = imgui.ImFloat4( imgui.ImColor( explode_argb(cfg.config.pedP) ):GetFloat4() )   
local carP = imgui.ImFloat4( imgui.ImColor( explode_argb(cfg.config.carP) ):GetFloat4() ) 
local staticObjectMy = imgui.ImFloat4( imgui.ImColor( explode_argb(cfg.config.staticObjectMy) ):GetFloat4() )    
local dinamicObjectMy = imgui.ImFloat4( imgui.ImColor( explode_argb(cfg.config.dinamicObjectMy) ):GetFloat4() )   
local pedPMy = imgui.ImFloat4( imgui.ImColor( explode_argb(cfg.config.pedPMy) ):GetFloat4() )   
local carPMy = imgui.ImFloat4( imgui.ImColor( explode_argb(cfg.config.carPMy) ):GetFloat4() )  
local colorPlayerI = imgui.ImFloat4( imgui.ImColor( explode_argb(cfg.config.colorPlayerI) ):GetFloat4() )

local fonttr = renderCreateFont("Arial", 10, 1);


changelog = {
	[0] = {
		['date'] = '20.02.2022',
		['ver'] = 'Patch 8.0',
		['info'] = {
			'Добавлена отправка репорта на Enter',
			'Добавлено удаление флуда от /ot',
			'Добавлено автоматическое принятие форм с индивидуальной настройкой',
			"Добавлена возможность изменения скорости JetPack'a",
			'В репорт добавлены стоковые кнопки "Флип", "ТП к автору репорта"',
			'Добавлена возможность логгирования принятых форм в файл AcceptForms',
			'Список команд перенесён в отдельное окно (/helpa)',
			'Добавлено звуковое оповещение при получении форм с индивидуальной настройкой для каждой команды',
			'Добавлен редизайн списка администрации (/admins)',
			'Добавлено автозакрытие диалога от античита',
			'Добавлено автоматическое принятие форм с индивидуальной настройкой для каждой команды',
			'Добавлена возможность изменения закругления углов кнопок и интерфейса',
			'Убраны темы "Красная", "Зеленая", добавлена "Тёмно-зеленая" тема',
			'Добавлены команды: \n{E78284}/tpm {84A6E7}- телепорт по метке,\n{E78284}/tpm 1 {84A6E7}- телепорт по маркеру, \n{E78284}/arep {84A6E7}- починка транспорта, в котором вы сидите, \n{E78284}/ammo {84A6E7}- пополнение склада амуниций, \n{E78284}/clr [кол-во строк] {84A6E7}- визуальная очистка чата, \n{E78284}/admall {84A6E7}- список всей администрации сервера, \n{E78284}/color {84A6E7}- таблица IDoв цветов, \n{E78284}/cal [пример] {84A6E7}- калькулятор, \n{E78284}/crd {84A6E7}- скопировать координаты на которых вы находитесь, \n{E78284}/rek_off {84A6E7}- отключить/включить сообщения "Подозрение на рекламу", \n{E78284}/ab {84A6E7}- сокращение команды /asellbiz, \n{E78284}/ah {84A6E7}- сокращение команды /asellhouse',
			'Добавлено автоматическое отключение автоопровержения при выходе в AFK',
			'Добавлена возможность регулирования времени деморгана при запросе опровержения на ловлю имущества',
			"Добавлено оповещение при включении/выключении WallHack'a",
			"Добавлены дополнительные клавиши для полета на AirBrak'e: левый шифт - вниз, пробел - вверх",
		},
		['patches'] = {
		['show'] = false,
			['info'] = {
				"Исправлена проблема GodMod'a",
				'Из репорта убраны кнопки "Частые вопросы", "Уровни работ"',
				'Исправлена кодировка при копировании дискорда разработчика',
				'Исправлена отправка собственного биндера №1 в визуальный чат',
				'Исправлен краш скрипта при отправке собственного биндера №4 через команду /my4',
				'Исправлен невидимый скролл-бар в малиновой теме',
				'Изменен прицнцип работы автоопровержения, теперь сообщения о ловле видны в чате [by kotofeev]',
				'Исправлена скорость AirBrake при полете вверх/вниз (была в 2 раза меньше настоящей)',
				'Исправлено аннулирование статистики каждые сутки',
			}
		}
	},
	[1] = {
		['date'] = '22.02.2022',
		['ver'] = 'Patch 8.3',
		['info'] = {
			'Теперь при выборе кнопки "ТП к игроку" (в репорте) скрипт автоматически будет отвечать ему, что вы попробуете помочь',
		},
		['patches'] = {
		['show'] = false,
			['info'] = {
				'Исправлена краш скрипта при входе в слежку по нику (пример: /re mishka"',
				'Исправлено ежедневное обнуление пункта статистики "Онлайн за неделю"',
				'Исправлен краш скрипта, когда при первом входе в новый день он вылетал',
				'Исправлена подсказка в пункте "Переход слежки на > и <" (не показывалась)',
			}
		}
	},
	[2] = {
		['date'] = '29.03.2022',
		['ver'] = 'Patch 9.0',
		['info'] = {
			'Добавлены следующие софты: AntiAFK, бесконечные патроны, отсутствие перезарядки, SpeedHack',
			'Добавлена автоматическая ловля репорта с тремя способами ловли: по тексту в чате/по надписи "REPORT ++"/обычный флуд /ot',
			'Добавлено затемнение при открытии дополнительного окна в Тёмно-зелёной теме',
			'Добавлена возможность вручную запрашивать опровержение на ловлю дома/бизнеса с возможностью изменения команды',
			'Убрано центрирование текста в статистике',
			'Добавлена команда /online для просмотра недельного онлайна',
			'Добавлен предосмотр вида окна статистики в меню ее настроек',
			'Теперь функции, связанные с перекрашиванием сообщением в чате, не будут работать в AFK для улучшения производительности',
			'Теперь при автоматическом принятии формы количество принятых форм в статистике будет увеличиваться',
			'Добавлена рандомная генерация капчи в /capcha',
			'Убрано КД между отправкой сообщений в тулсе в связи с его удалением на стороне сервера',
			'Добавлен бинд для быстрого открытия карты',
			'Возвращено уведомление администратору при неудачной выдаче формы (игрок уже в машине/деморгане/муте/не забанен/правильная подача формы)',
			'Добавлена проверка на наличие файла со списком команд/навигации (используется в окне репорта)',
		},
		['patches'] = {
		['show'] = false,
			['info'] = {
				'(Возможно) исправлен краш скрипта при открытии репорта',
				'Исправлен баг с размером подсказок у функций',
			}
		}
	},
	[3] = {
		['date'] = '13.03.2022',
		['ver'] = 'Global Patch 10',
		['info'] = {
			'Добавлен кликварп ',
'Добавлена функция скрытия ИП адресов ',
'Добавлена возможность выключения клавиши F5 ',
'Добавлена возможность включать/выключать показ ИДов игроков в килл листе ',
'Добавлена невидимка (инвиз) ',
'Добавлены чекер игроков, чекер отключений, чекер подключений, чекер регистраций с гибкой настройкой ',
'Добавлены трейсера своих и чужих пуль с гибкой настройкой ',
'Максимальный коэффицент ускорения спидхаком теперь 300 (было 100) ',
'Добавлен авточек данных (ИПов) при пробитии /getip (в тестовом режиме) ',
'Возвращен ВХ на транспорт, теперь без багов, используйте /carnames для настройки режима показа названия авточек ',
'Добавлена автореклама с возможностью выбора рекламного биндера и интервалом рекламы ',
'Добавлены варнинги на тимкилл ',
'Убрано антиAFK ',
'Убрана возможность изменения большинства цветов чата (нахуй надо) ',
'Убран малиновый стиль ',
'Добавлены стили: красный, розовый (фулл копия диллса) ',
'Добавлена возможность изменения биндов: открыть карту, включить/выключить автоловлю репорта, открыть меню выдачи наказаний, включить/выключить аирбрейк, повысить/понизить скорость аирбрейка, взаимодействовать с игроками в радиусе, телепортироваться в админ-зону ',
'Переделан пункт "выдача наказаний" ',
'Исправлено изменение позиции меню быстрых наказаний ',
'Команда для активации окна настроек изменена на /amenu ',
'Очень круто изменен дизайн пункта "Информация" ',
'Изменена цветовая гамма сообщений от скрипта ',
'Убраны лишние пункты редактирования ответа на репорт (было редактирование несуществующих пунктов) ',
'В "Главное > Основное" оставлены кнопки только для отправки биндов, остальное взаимодействие через команды ',
'Теперь если бинд клавиши отсутствует, то вместо"No" показывается "Отсутствует" ',
'Изменен дизайн переключателя ',
'Исправлен краш скрипта при отправке несуществующего репорта в админчат (не ток репорта) ',
'Добавлена возможность принятия формы на banipoff ',
'Теперь выбранный пункт в меню соответственно подсвечивается ',
'Теперь у доп. окон для редактирования биндов есть заголовки ',
'В главное меню добавлена кнопка для сохранения конфига скрипта ',
'Теперь конфиг скрипта хранится в папке скрипта, а не в папке config для всего мунлоадера (путь: moonloader/config/AdminToolsKing/AdminTools.ini) '
		},
		['patches'] = {
		['show'] = false,
			['info'] = {
				"Исправлен краш при открытии репорта (терь 100 процентов)"
			}
		}
	},
	[4] = {
		['date'] = '13.03.2022',
		['ver'] = 'Patch 10.6',
		['info'] = {
			'Текст кликварпа при наведении на транспорт переведен на русский',
			'Добавлена возможность настройки типа показа названия авто в ВХ на транспорт',
			'Добавлены бинды для повышения/понижения скорости ДжетПака',
			'Добавлены черная, фиолетовая темы',
			'Изменен способ шифрования содержимего скрипта'
		},
		['patches'] = {
		['show'] = false,
			['info'] = {
				'Исправлен краш при открытии настроек наказания "ИЗП"',
				'Исправлена автонастройка форм под уровень адм. (скрипт крашился если админка была 3, 6 уровней)',
			}
		}
	}
}

ChangePosWindow = imgui.ImBool(false)
ChangePosWindowTwo = imgui.ImBool(false)
ChangePosWindowThree = imgui.ImBool(false)
ChangePosWindowFour = imgui.ImBool(false)
ChangePosWindowFive = imgui.ImBool(false)
ChangePosWindowSeven = imgui.ImBool(false)
ChangePosWindowEight = imgui.ImBool(false)

local J_ = {
	PLAYERS_CHECKER = {
		{
			"Requiem_Devil"
		}, "SettingsPlayerChecker" }
}
local adminsJ_ = {
	ADMINS_CHECKER = {
		{
			"YarikVL"
		}, "SettingsAdminsChecker"
	}
}
local adminsTable = {
	{id=-1,nick="",job="",warns=-1,rep=-1},
}
function explode_argb(argb)
	local a = bit.band(bit.rshift(argb, 24), 0xFF)
	local r = bit.band(bit.rshift(argb, 16), 0xFF)
	local g = bit.band(bit.rshift(argb, 8), 0xFF)
	local b = bit.band(argb, 0xFF)
	return a, r, g, b
end


mcx = 0x0087FF
local sX, sY = getScreenResolution()
iterator = false
seconditerator = false
myrepa = nil
mybufferrepa = nil
MainWindow = imgui.ImBool(false)
AmemberWindow = imgui.ImBool(false)
TeleportWindow = imgui.ImBool(false)
CaptchaWindow = imgui.ImBool(false)
HelpWindow = imgui.ImBool(false)
myOnline = imgui.ImBool(false)
ChangeLogWindow = imgui.ImBool(false)
InteractionWindow = imgui.ImBool(false)
ReconWindow = imgui.ImBool(false)
PunishWindow = imgui.ImBool(false)
InfoWindow = imgui.ImBool(false)
local reconusers_state = imgui.ImBool(false)
ReportWindow = imgui.ImBool(false)
ColorsWindow = imgui.ImBool(false)
local tttttt = imgui.ImInt(cfg.main.mylvladmin)
local ttttttt = imgui.ImInt(cfg.main.mylvlfd)
reason_autoopra_house = imgui.ImBuffer(tostring(cfg.autoopra.myreasonhouse), 56)
reason_autoopra_biz = imgui.ImBuffer(tostring(cfg.autoopra.myreasonbiz), 56)

local function createNewJsonTable(table)
	if not doesFileExist(getWorkingDirectory().."\\AdminToolsKing\\"..table[2]..".json") then
	   	local f = io.open(getWorkingDirectory().."\\AdminToolsKing\\"..table[2]..".json", 'w+')
	   	if f then
		  	f:write(encodeJson(table[1])):close()
		end
   	else
	   	local f = io.open(getWorkingDirectory().."\\AdminToolsKing\\"..table[2]..".json", "r")
	   	if f then
		 	table[1] = decodeJson(f:read("*a"))
		 	f:close()
	   	end
	end
end

createNewJsonTable(adminsJ_.ADMINS_CHECKER)
createNewJsonTable(J_.PLAYERS_CHECKER)
pathOffLog = getWorkingDirectory().."\\AdminToolsKing\\Логи\\AutoOpraLogs.txt"
log_full = {}
tag = '{E78284}[AdminTools] {84A6E7}'
pinktag = '{E78284}[AdminTools] {FF4578}'
tag1 = "{E78284}[AdminTools] {84A6E7}"
local text_buffer = imgui.ImBuffer(256)
local text_buffer_rep = imgui.ImBuffer(256)
local text_buffer_age = imgui.ImBuffer(256)
local text_buffer_name = imgui.ImBuffer(256)
local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
local weekFull = imgui.ImInt(cfg.onWeek.full)
local fontsize = nil
local changePositionRecon = false
stop = 0
started = 0
active_report = 0
active_report2 = 0
local quitReason = {
	"вылет & краш",
	"вышел из игры",
	"кик & бан"
}

inputreportaddname = imgui.ImBuffer(30)
inputreportaddotvet = imgui.ImBuffer(256)
comboStylereport = imgui.ImInt(1)
retpor_text_edit = false



local sw, sh = getScreenResolution()

	local tServers = {
		'46.174.53.98', -- king
		'46.174.53.98', -- king
		'46.174.53.98' -- king
	}
	function checkServer(ip)
		for k, v in pairs(tServers) do
			if v == ip then 
				return true
			end
		end
		return false
	end
	function random(x, y)
	u = u + 1
	if x ~= nil and y ~= nil then
		return math.floor(x +(math.random(math.randomseed(os.time()+u))*999999 %y))
	else
		return math.floor((math.random(math.randomseed(os.time()+u))*100))
	end
end
	
--function main()
--	if not isSampfuncsLoaded() or not isSampLoaded() then
--		return
--	end
--	while not isSampAvailable() do
--		wait(100)
--	end
--
--	-- вырежи тут, если хочешь отключить проверку обновлений
--	-- вырежи тут, если хочешь отключить проверку обновлений
--   
--	-- дальше идёт ваш код
--end
ImgForAuthor = "https://raw.githubusercontent.com/gozhelnikovtraxat/UpdateArenaTools/main/IMG_4237.png"

function LoadTextureFunc()
	textureImgForAuthor = imgui.CreateTextureFromFile(getWorkingDirectory() .. '/AdminToolsKing/IMG_4237.png')
end
function main()
		
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

	local server, port = sampGetCurrentServerAddress();
	while server ~= "194.147.32.61" do wait(15);
		sampAddChatMessage("TOOLS ARENA DOES NOT WORK ON THIS SERVER, ONLY ON ARENA: 194.147.32.61:7777", -1);
		sampAddChatMessage("SCRIPT DEVELOPER: GOZHELNIIKOV, LAST - FAKE", -1);
	end

	if not doesFileExist(getWorkingDirectory() .. '/AdminToolsKing/IMG_4237.png') then
		downloadUrlToFile(ImgForAuthor, getWorkingDirectory() .. '/AdminToolsKing/IMG_4237.png', function (id, status, p1, p2)
			if status == dlstatus.STATUSEX_ENDDOWNLOAD then
				LoadTextureFunc()
				sampAddChatMessage('СКАЧАЛЛЛЛЛЛЛЛ', -1)
			end
		end)
	else
		LoadTextureFunc()
	end

	local lastver = update():getLastVersion()
    sampAddChatMessage('Скрипт загружен, версия: '..lastver, -1)
    if thisScript().version ~= lastver then
		sampAddChatMessage('Вышло обновление скрипта ('..thisScript().version..' -> '..lastver..'). Скрипт обновляется!', -1)
        update():download()
    end


	--cfg.main.zapusk4 = cfg.main.zapusk4 + 1	
	--if cfg.main.zapusk4 == 1 then
	--	ChangeLogWindow.v = true
	--end


		

	fontForRender = renderCreateFont(cfg.Settings.font, cfg.Settings.size, cfg.Settings.style, FCR_BOLD + FCR_BORDER)
	leave = renderCreateFont(cfg.main.QuitFontChecker, cfg.main.leaveSize, cfg.main.leaveStyle, FCR_BOLD + FCR_BORDER)
	connect = renderCreateFont(cfg.main.ConnectFontChecker, cfg.main.connectSize, cfg.main.connectStyle, FCR_BOLD + FCR_BORDER)
	--admincheck = renderCreateFont(cfg.main.ConnectFontChecker, cfg.main.connectSize, cfg.main.connectStyle, FCR_BOLD + FCR_BORDER)
	reg = renderCreateFont(cfg.main.RegFontChecker, cfg.main.regSize, cfg.main.regStyle, FCR_BOLD + FCR_BORDER)
	fonts = { 
	playersChecker = renderCreateFont(cfg.main.fontchecker, cfg.main.sizechecker, cfg.main.stylechecker, FCR_BOLD + FCR_SHADOW),
}
fonts123 = { 
	killList         = renderCreateFont(cfg.main.FontKill, cfg.fonts.killListSize, cfg.fonts.killListStyle),
}	
	
	fonts456 = {
		adminsChecker = renderCreateFont(cfg.main.adminsfontchecker, cfg.main.adminssizechecker, cfg.main.adminsstylechecker, FCR_BOLD + FCR_SHADOW)
	}

	regcommands()
	  for k,v in pairs(IMAGES.KILL_LIST) do 
		LOAD_IMAGES.KILL_LIST[k] = renderLoadTextureFromFile(IMAGES.KILL_LIST[k])
	end
	kill = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr())
	klavisha = checkNameKlavisha(cfg.main.fopentools)
	checkKey()
	local _, myid = sampGetPlayerIdByCharHandle(playerPed)
	mynick = sampGetPlayerNickname(myid)
	lua_thread.create(time)
	lua_thread.create(autoPiar)
	lua_thread.create(checkstate)
	lua_thread.create(ajailThread)
	lua_thread.create(autoAdmins)
	thread = lua_thread.create_suspended(thread_function)
	initializeRender()

	loadbinders()
	local withOutID = {
	[1] = {
	  "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
	  "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter",
	  "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Article Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo",
	  "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer #2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed",
	  "Yankee", "Caddy", "Solair", "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow",
	  "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage",
	  "Dozer", "Maverick", "NewsChopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
	  "Boxville #1", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher Lure", "SuperGT", "Elegant", "Journey", "Bike",
	  "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000",
	  "Cement Truck", "Tow Truck", "Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight",
	  "Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada",
	  "Yosemite", "Windsor", "Monster A", "Monster B", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
	  "Freight Flat Trailer", "Streak Trailer", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "News Van",
	  "Tug", " Petrol Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "FreightBox", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LS:PD Cruiser", "SF:PD Cruiser",
	  "LV:PD Cruiser", "Police Ranger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale Shit", "Sadler Shit", "Luggage A", "Luggage B", "Stairs", "Boxville #2", "Tiller",
	  "Utility Trailer"
	},

	[2] = {
	  'landstal', 'bravura', 'buffalo', 'linerun', 'peren', 'sentinel', 'dumper', 'firetruk', 'trash', 'stretch', 'manana', 'infernus', 'voodoo', 'pony', 'mule', 'cheetah', 
	  'ambulan', 'leviathn', 'moonbeam', 'esperant', 'taxi', 'washing', 'bobcat', 'mrwhoop', 'bfinject', 'hunter', 'premier', 'enforcer', 'securica', 'banshee', 'predator',
	  'bus', 'rhino', 'barracks', 'hotknife', 'artict1', 'previon', 'coach', 'cabbie', 'stallion', 'rumpo', 'rcbandit', 'romero', 'packer', 'monster', 'admiral', 'squalo',
	  'seaspar', 'pizzaboy', 'tram', 'artict2', 'turismo', 'speeder', 'reefer', 'tropic', 'flatbed', 'yankee', 'caddy', 'solair', 'topfun', 'skimmer', 'pcj600', 'faggio',
	  'freeway', 'rcbaron', 'rcraider', 'glendale', 'oceanic', 'sanchez', 'sparrow', 'patriot', 'quad', 'coastg', 'dinghy', 'hermes', 'sabre', 'rustler', 'zr350', 'walton',
	  'regina', 'comet', 'bmx', 'burrito', 'camper', 'marquis', 'baggage', 'dozer', 'maverick', 'vcnmav', 'rancher', 'fbiranch', 'virgo', 'greenwoo', 'jetmax', 'hotring', 
	  'sandking', 'blistac', 'polmav', 'boxville', 'benson', 'mesa', 'rcgoblin', 'hotrina', 'hotrinb', 'bloodra/bloodrb', 'rnchlure', 'supergt', 'elegant', 'journey', 'bike',
	  'mtbike', 'beagle', 'cropdust', 'stunt', 'petro', 'rdtrain', 'nebula', 'majestic', 'buccanee', 'shamal', 'hydra', 'fcr900', 'nrg500', 'copbike', 'cement', 'towtruck', 
	  'fortune', 'cadrona', 'fbitruck', 'willard', 'forklift', 'tractor', 'combine', 'feltzer', 'remingtn', 'slamvan', 'blade', 'freight', 'streak', 'vortex', 'vincent', 
	  'bullet', 'clover', 'sadler', 'firela', 'hustler', 'intruder', 'primo', 'cargobob', 'tampa', 'sunrise', 'merit', 'utility', 'nevada', 'yosemite', 'windsor', 'monstera', 
	  'monsterb', 'uranus', 'jester', 'sultan', 'stratum', 'elegy', 'raindanc', 'rctiger', 'flash', 'tahoma', 'savanna', 'bandito', 'freiflat', 'streakc', 'kart', 'mower',
	  'duneride', 'sweeper', 'broadway', 'tornado', 'at400', 'dft30', 'huntley', 'stafford', 'bf400', 'newsvan', 'tug', 'petrotr', 'emperor', 'wayfarer', 'euros', 'hotdog',
	  'club', 'freibox', 'artict3', 'androm', 'dodo', 'rccam', 'launch', 'copcarla', 'copcarsf', 'copcarvg', 'copcarru', 'picador', 'swatvan', 'alpha', 'phoenix', 'glenshit', 'sadlshit',
	  'bagboxa', 'bagboxb', 'tugstair', 'boxburg', 'farmtr1', 'utiltr1'
	}
  }
  
  local functionsReg = {
	{'carnames', function(param)
		if param:find('^%d') and tonumber(param) <= 2 then
		  if tonumber(param) ~= tonumber(cfg.Settings.mode) then
			for k, v in pairs(messageChangeMode) do
			  if (param + 1) == k then
				sampAddChatMessage(string.format("Вы включили отображение %s.", v), -1)
				cfg.Settings.mode = (k - 1); inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini"); break
			  end
			end
		  else
			sampAddChatMessage(string.format('В данный момент итак включено отображение %s [{1E90FF}%d{FFFFFF}].', messageChangeMode[param + 1], param), -1)
		  end
		else
		  sampAddChatMessage(string.format('Такого параметра не существует! Количество доступных параметров: {1E90FF}%d{FFFFFF}.', #messageChangeMode), -1)
		  for k, v in pairs(messageChangeMode) do
			sampAddChatMessage(string.format('[{1E90FF}%d{FFFFFF}] - Отображение %s.', (k - 1), v), -1)
		  end
		end
	end},

  }
  
  for _, v in pairs(functionsReg) do
	  sampRegisterChatCommand(v[1], v[2])
  end


  for i = 1, #withOutID do
	for k, _ in pairs(withOutID[i]) do
	  withID[i][k + 399] = withOutID[i][k]
	end
	withOutID[i] = {}
  end

lua_thread.create(renderCarNames)
		
	if cfg.onDay.today ~= os.date("%a") then 
	 		cfg.onDay.today = os.date("%a")
	 		cfg.onDay.online = 0
			cfg.onDay.full = 0
			cfg.onDay.afk = 0
			dayFull.v = 0
			cfg.main.reportzaday = 0
			cfg.main.nakazaniyaday = 0 
			cfg.main.formsday = 0 
		end

		if cfg.onWeek.week ~= number_week() then
			cfg.onWeek.week = number_week()
	 		cfg.onWeek.online = 0
			cfg.onWeek.full = 0
			cfg.onWeek.afk = 0
			weekFull.v = 0
			for _, v in pairs(cfg.myWeekOnline) do v = 0 end   			
		end

local function get_id_by_nick(nick)
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED);
		if tostring(nick) == sampGetPlayerNickname(myid) then return myid; end
		for i = 0, 1000 do if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == tostring(nick) then return i; end end
		return 0;
	end
	local kill_info = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr());
	for i = 0, 4 do
		if ffi.string(kill_info.killEntry[i].szKiller) ~= nil and ffi.string(kill_info.killEntry[i].szKiller) ~= "" and kill_info.killEntry[i].byteType > -1 and kill_info.killEntry[i].byteType < 47 then
			local killer_nick = ffi.string(kill_info.killEntry[i].szKiller);
			local killer_id = get_id_by_nick(killer_nick);
			local killed_nick = ffi.string(kill_info.killEntry[i].szVictim);
			local killed_id = get_id_by_nick(killed_nick);
	
			local line = {
				killer = (not cfg.main.showIDKiller) and killer_nick or string.format('%s[%d]', killer_nick, killer_id), 
				killerColor = sampGetPlayerColor(killer_id), 
				killer_id = killer_id,
				killed_id = killed_id,
				killed = (not cfg.main.showIDKilled) and killed_nick or string.format('%s[%d]', killed_nick, killed_id), 
				killedColor = sampGetPlayerColor(killed_id), 
				timeKill = os.date("%H:%M:%S"),
				reason = kill_info.killEntry[i].byteType
			} 
			table.insert(killInfo, line)
		end
	end
		
		while true do
		CodeList()
		wait(0)
		
		cccc()
		
		
		CodeList2()
		
		if cfg.main.leaveChecker then 
			local x, y = cfg.leavePosition.x, cfg.leavePosition.y
			renderFontDrawTextAlign(leave, "Чекер выходов: ", cfg.leavePosition.x, cfg.leavePosition.y, -1, cfg.main.aligntwo)
			for k,v in pairs(leavePlayers) do
				y = y + cfg.main.leaveIndent
				renderFontDrawTextAlign(leave, "{"..leavePlayers[k].playerColor.."}["..leavePlayers[k].timeQuit.."] "..leavePlayers[k].nickname.."["..leavePlayers[k].id.."] отключился. Причина: "..leavePlayers[k].reason, x, y, -1, cfg.main.aligntwo)
				if k > tonumber(cfg.main.leaveLines) then
					table.remove(leavePlayers, 1)
				end
			end
			
		end
		if cfg.main.connectChecker then
			local x, y = cfg.connectPosition.x, cfg.connectPosition.y
			renderFontDrawTextAlign(connect, "Чекер входов: ", cfg.connectPosition.x, cfg.connectPosition.y, -1, cfg.main.alignthree)
			for k,v in pairs(connectPlayers) do
				y = y + cfg.main.connectIndent
				renderFontDrawTextAlign(connect, "{"..connectPlayers[k].playerColor.."}["..connectPlayers[k].timeJoin.."] "..connectPlayers[k].nickname.."["..connectPlayers[k].id.."] подключился.", x, y, -1, cfg.main.alignthree)
				if k > tonumber(cfg.main.connectLines) then
					table.remove(connectPlayers, 1)
				end
			end
		end
		
		if cfg.main.adminsChecker then
			local x, y = cfg.adminsPosition.x, cfg.adminsPosition.y
			--renderFontDrawTextAlign(admins, "Чекер администрации: ", cfg.adminsPosition.x, cfg.adminsPosition.y, -1, cfg.main.adminsAlign)
			for k,v in pairs(adminsPlayers) do
				y = y + cfg.main.adminsotschecker
				--renderFontDrawTextAlign(admins, "{"..adminsPlayers[k].playerColor.."}["..adminsPlayers[k].timeJoin.."] "..adminsPlayers[k].nickname.."["..adminsPlayers[k].id.."] подключился.", x, y, -1, cfg.main.adminsAlign)
				if k > tonumber(cfg.main.adminsLines) then
					table.remove(adminsPlayers, 1)
				end
			end
		end

		if cfg.main.regChecker then
					local x, y = cfg.RegPosition.x, cfg.RegPosition.y
			renderFontDrawTextAlign(reg, "Чекер регистраций: ", cfg.RegPosition.x, cfg.RegPosition.y, -1, cfg.main.alignfour)
			for k,v in pairs(regPlayers) do
				y = y + cfg.main.regIndent
				renderFontDrawTextAlign(reg, "{FFFFFF}["..regPlayers[k].timeReg.."] "..regPlayers[k].nickname.."["..regPlayers[k].id.."] зарегистрировался | IP: "..regPlayers[k].ip1..".xx.xxx."..regPlayers[k].ip4.."", x, y, -1, cfg.main.alignfour)
				if k > tonumber(cfg.main.regLines) then
					table.remove(regPlayers, 1)
				end
			end
		end
		
		if isPlayerPlaying(playerHandle) then
	  if isKeyCheckAvailable() and isKeysDown(fopenmap.v) then
		writeMemory(menuPtr + 0x33, 1, 1, false) 
		wait(100)
		writeMemory(menuPtr + 0x15C, 1, 1, false) 
		writeMemory(menuPtr + 0x15D, 1, 5, false) 
		if reduceZoom then
		  writeMemory(menuPtr + 0x64, 4, representFloatAsInt(300.0), false)
		end
	  end
	end
			
			if isPlayerUsingJetpack(PLAYER_HANDLE) then
			local cx, cy = windowCoordinates[1] / 2, windowCoordinates[2] / 2
			klavisha = checkNameKlavisha(cfg.main.fjspeedup)
			klavisha1 = checkNameKlavisha(cfg.main.fjspeeddown)
			renderFontDrawText(my_font, 'Изменение скорости: {E78284}'..klavisha..' {84A6E7}и {E78284}'..klavisha1..'\n{84A6E7}Текущая скорость: {E78284}'..boost, cx + 500, windowCoordinates[2] - 32, 0xFF84A6E7)
			if isKeysDown(fjspeedup.v) then
				if boost + 0.03 > 0.7 then
				sampAddChatMessage(tag..'Это максимальная скорость джетпака!', -1)
				else
				boost = boost + 0.03
				end
			end
			if isKeysDown(fjspeeddown.v) then
				if boost - 0.03 < 0.02 then
					sampAddChatMessage(tag..'Это минимальная скорость джетпака!', -1)
				else
					boost = boost - 0.03
				end
			end
			mem.setfloat(0x863984, boost, true)
		else
			mem.setfloat(0x863984, 0.008, true)
		end

		   connectwithplayer()

		
		
		--isPos()
		
		if cfg.main.nopf4 then
		mem.write(sampGetBase()+0x797E, 0, 1, true)
		end
		
		if cfg.main.nopf5 then
		mem.fill(sampGetBase() + 0x71369, 0x00, 1, true)
		end
		
		if cfg.main.radarinrecon then
		 memory.write(sampGetBase() + 643864, 37008, 2, true)
		else
		memory.write(sampGetBase() + 643864, 3956, 2, true)
		end
		
		if wasKeyPressed(38) and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() and cfg.main.slapinrecon and ReconWindow.v then
		sampSendChat('/slap '..spec_id..' 1')
		end
		
		if wasKeyPressed(40) and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() and cfg.main.slapinrecon and ReconWindow.v then
		sampSendChat('/slap '..spec_id..' 2')
		end
		
			if wasKeyPressed(188) and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() and cfg.main.perehodik and ReconWindow.v then
						lua_thread.create(function ()
			if spec_id - 1 < 0 then
				sampAddChatMessage(tag..'Прошлый ID не в сети, используйте только >> NEXT', -1)

				return
			end

			testnext = spec_id - 1

			while not sampIsPlayerConnected(testnext) or sampGetPlayerScore(testnext) == 0 do
				wait(0)

				if testnext - 1 < 0 then
					sampAddChatMessage(tag..'Прошлый ID не в сети, используйте только >> NEXT', -1)

					return
				end

				testnext = testnext - 1
			end

			sampSendChat("/re " .. testnext)
		end)
		end
		
					if wasKeyPressed(190) and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() and cfg.main.perehodik and ReconWindow.v then
						lua_thread.create(function ()
			if spec_id + 1 > 999 then
				sampAddChatMessage(tag..'Следующий ID не в сети, используйте только << BACK', -1)

				return
			end

			testnext = spec_id + 1

			while not sampIsPlayerConnected(testnext) or sampGetPlayerScore(testnext) == 0 do
				wait(0)

				if testnext + 1 > 999 then
					sampAddChatMessage(tag..'Следующий ID не в сети, используйте только << BACK', -1)

					return
				end

				testnext = testnext + 1
			end

			sampSendChat("/re " .. testnext)
		end)
		end
		
		if sampGetGamestate() ~= 3 and cfg.main.lovlyareporta then 
		sampAddChatMessage(tag..'Автоловля репорта выключена, так как вы находитесь в статусе "Подключение к серверу"', -1)
		cfg.main.lovlyareporta = false
		end
		
		if sampGetGamestate() ~= 3 and cfg.main.autopiar then 
		sampAddChatMessage(tag..'Автореклама выключена, так как вы находитесь в статусе "Подключение к серверу"', -1)
		cfg.main.autopiar = false
		end
		
		if cfg.main.lovlyareporta and style_lovlyareporta.v == 3 and not isGamePaused() and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() and not ReportWindow.v then 
		if sampGetGamestate() ~= 3 then 
		sampAddChatMessage(tag..'Нельзя включить автоловлю репорта при подключении к серверу!', -1)
		else
		sampSendChat('/ot')
		end
		end
		
		if not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(ftradeKey.v) then
				sampSendChat('/apanel')
			end
		end
		
		
		
		loadbinds()
		
		imgui.ShowCursor = MainWindow.v or AmemberWindow.v or TeleportWindow.v or ReportWindow.v or CaptchaWindow.v or HelpWindow.v or ChangeLogWindow.v or InteractionWindow.v or ColorsWindow.v or ChangePosWindow.v or ReconWindow.v or PunishWindow.v or InfoWindow.v or ChangePosWindowTwo.v or myOnline.v or ChangePosWindowThree.v or ChangePosWindowFour.v or ChangePosWindowFive.v or ChangePosWindowSeven.v or ChangePosWindowEight.v
		
	   imgui.Process = MainWindow.v or AmemberWindow.v or TeleportWindow.v or ReportWindow.v or ChangePosWindow.v or CaptchaWindow.v or HelpWindow.v or ChangeLogWindow.v or InteractionWindow.v or ReconWindow.v or ColorsWindow.v or to.v or PunishWindow.v or InfoWindow.v or ChangePosWindowTwo.v or myOnline.v or ChangePosWindowThree.v or ChangePosWindowFour.v or reconusers_state.v or ChangePosWindowFive.v or ChangePosWindowSeven.v or ChangePosWindowEight.v
		
		 local oTime = os.time()
		if elements.checkbox.drawBullets.v then
			for i = 1, bulletSync.maxLines do
				if bulletSync[i].other.time >= oTime then
					local result, wX, wY, wZ, wW, wH = convert3DCoordsToScreenEx(bulletSync[i].other.o.x, bulletSync[i].other.o.y, bulletSync[i].other.o.z, true, true)
					local resulti, pX, pY, pZ, pW, pH = convert3DCoordsToScreenEx(bulletSync[i].other.t.x, bulletSync[i].other.t.y, bulletSync[i].other.t.z, true, true)
					if result and resulti then
						local xResolution = mem.getuint32(0x00C17044)
						if wZ < 1 then
							wX = xResolution - wX
						end
						if pZ < 1 then
							pZ = xResolution - pZ
						end 
						if elements.checkbox.showPlayerInfo.v then
							if bulletSync[i].other.id ~= -1 then 
								if sampIsPlayerConnected(bulletSync[i].other.id) then
									if elements.checkbox.onlyId.v and elements.checkbox.onlyNick.v then
										renderFontDrawText(fonttr, sampGetPlayerNickname(bulletSync[i].other.id)..'['..bulletSync[i].other.id..']', wX + 0.5, wY, bulletSync[i].other.colorText, false)
									elseif elements.checkbox.onlyId.v then
										renderFontDrawText(fonttr, '['..bulletSync[i].other.id..']', wX + 0.5, wY, bulletSync[i].other.colorText, false)
									elseif elements.checkbox.onlyNick.v then
										renderFontDrawText(fonttr, sampGetPlayerNickname(bulletSync[i].other.id), wX + 0.5, wY, bulletSync[i].other.colorText, false)
									end
								end
							end
						end
						renderDrawLine(wX, wY, pX, pY, elements.int.sizeOffLine.v, bulletSync[i].other.color)
						if elements.checkbox.cbEnd.v then
							renderDrawPolygon(pX, pY-1, 3 + elements.int.sizeOffPolygonEnd.v, 3 + elements.int.sizeOffPolygonEnd.v, 1 + elements.int.rotationPolygonEnd.v, elements.int.degreePolygonEnd.v, bulletSync[i].other.color)
						end
					end
				end
			end
		end
				if elements.checkbox.drawMyBullets.v then
			for i = 1, bulletSyncMy.maxLines do
				if bulletSyncMy[i].my.time >= oTime then
					local result, wX, wY, wZ, wW, wH = convert3DCoordsToScreenEx(bulletSyncMy[i].my.o.x, bulletSyncMy[i].my.o.y, bulletSyncMy[i].my.o.z, true, true)
					local resulti, pX, pY, pZ, pW, pH = convert3DCoordsToScreenEx(bulletSyncMy[i].my.t.x, bulletSyncMy[i].my.t.y, bulletSyncMy[i].my.t.z, true, true)
					if result and resulti then
						local xResolution = mem.getuint32(0x00C17044)
						if wZ < 1 then
							wX = xResolution - wX
						end
						if pZ < 1 then
							pZ = xResolution - pZ
						end 
						renderDrawLine(wX, wY, pX, pY, elements.int.sizeOffMyLine.v, bulletSyncMy[i].my.color)
						if elements.checkbox.cbEndMy.v then
							renderDrawPolygon(pX, pY-1, 3 + elements.int.sizeOffMyPolygonEnd.v, 3 + elements.int.sizeOffMyPolygonEnd.v, 1 + elements.int.rotationMyPolygonEnd.v, elements.int.degreeMyPolygonEnd.v, bulletSyncMy[i].my.color)
						end
					end
				end
			end
		end 
		
			if sampGetGamestate() ~= 3 then
			if ReconWindow.v or PunishWindow.v or InfoWindow.v then
			ReconWindow.v = false
			PunishWindow.v = false
			InfoWindow.v = false
			end
			end
			
		
		if ReconWindow.v then
			for i = 2063, 2130 do
			sampTextdrawDelete(i)
			end
			sampTextdrawDelete(2048)
		end
		
		
		if wasKeyPressed(VK_RETURN) and ReportWindow.v and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) and not sampIsChatInputActive() then
			local otvet = text_buffer_rep.v
			sampSendDialogResponse(6370, 1, _, u8:decode(otvet))
			text_buffer_rep.v = ''
			ReportWindow.v = false
		end
		
			local isInVeh = isCharInAnyCar(playerPed)
	local veh = nil
	if isInVeh then veh = storeCarCharIsInNoSave(playerPed) end
		
		
	if cfg.main.gm then
  			setCharProofs(playerPed, true, true, true, true, true)
  			writeMemory(0x96916E, 1, 1, false)	
		if isInVeh then
		setCarProofs(veh, true, true, true, true, true)
		end
	else
 			setCharProofs(playerPed, false, false, false, false, false)
  			writeMemory(0x96916E, 1, 0, false)	
		if isInVeh then
		setCarProofs(veh, false, false, false, false, false)
		end			
	end
			
			
		if cfg.main.nobike then
			setCharCanBeKnockedOffBike(playerPed, true)
		else
			setCharCanBeKnockedOffBike(playerPed, false)
		end		
	

		if cfg.main.infammo then
			mem.write(0x969178, 1, 1, true)
		else
			mem.write(0x969178, 0, 1, false)
		end
		
		if cfg.main.noreload then
			local weapon = getCurrentCharWeapon(PLAYER_PED)
			local nbs = raknetNewBitStream()
			raknetBitStreamWriteInt32(nbs, weapon)
			raknetBitStreamWriteInt32(nbs, 0)
			raknetEmulRpcReceiveBitStream(22, nbs)
			raknetDeleteBitStream(nbs)
		end
		
		if cfg.main.speedhack then
			if isCharInAnyCar(PLAYER_PED) and isKeyDown(VK_LMENU) then
				if getCarSpeed(storeCarCharIsInNoSave(PLAYER_PED)) * 2.01 <= shmax.v then
					local cVecX, cVecY, cVecZ = getCarSpeedVector(storeCarCharIsInNoSave(PLAYER_PED))
					local heading = getCarHeading(storeCarCharIsInNoSave(PLAYER_PED))
					local turbo = fps_correction() / shsmooth.v
					local xforce, yforce, zforce = turbo, turbo, turbo
					local Sin, Cos = math.sin(-math.rad(heading)), math.cos(-math.rad(heading))
					if cVecX > -0.01 and cVecX < 0.01 then xforce = 0.0 end
					if cVecY > -0.01 and cVecY < 0.01 then yforce = 0.0 end
					if cVecZ < 0 then zforce = -zforce end
					if cVecZ > -2 and cVecZ < 15 then zforce = 0.0 end
					if Sin > 0 and cVecX < 0 then xforce = -xforce end
					if Sin < 0 and cVecX > 0 then xforce = -xforce end
					if Cos > 0 and cVecY < 0 then yforce = -yforce end
					if Cos < 0 and cVecY > 0 then yforce = -yforce end
					applyForceToCar(storeCarCharIsInNoSave(PLAYER_PED), xforce * Sin, yforce * Cos, zforce / 2, 0.0, 0.0, 0.0)
				end
			end
		end

		
		if not report_name then
			report_name = 'Ne_Opredeleno'
			nick_rep = report_name:gsub('_', ' ') 
		end
		
		
		
		if report_id == nil then
			report_id = 0
		end
		
		if id_rep == nil then
			id_rep = 0
		end
		
		if cfg.main.offamulet then
			list = {1276}
			tbl = getAllObjects()
			for k,v in ipairs(tbl) do
				if doesObjectExist(v) then
					for _,z in ipairs(list) do
						if getObjectModel(v) == z then
							setObjectVisible(v, true)
						end
					end
				end
			end
		else
			list = {1276}
			tbl = getAllObjects()
			for k,v in ipairs(tbl) do
				if doesObjectExist(v) then
					for _,z in ipairs(list) do
						if getObjectModel(v) == z then
							setObjectVisible(v, false)
						end
					end
				end
			end
		end
		
		kbinds()
		
		if not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(flovlyareporta.v) then
			if sampGetGamestate() ~= 3 then 
			sampAddChatMessage(tag..'Нельзя включить автоловлю репорта при подключении к серверу!', -1)
			else
				cfg.main.lovlyareporta = not cfg.main.lovlyareporta
				sampAddChatMessage(tag..'Автоловля репорта '..(cfg.main.lovlyareporta and 'включена' or 'выключена'), -1)
			end
			end
		end
		
		
		
		if cfg.main.airbrake then 
			if isKeysDown(fairbrake.v) then
			if not sampIsChatInputActive() then
			printStringNow("~w~GOZHELNIKOV "..(enAirBrake and "~b~OFF" or "~g~ON"), 2000)
				enAirBrake = not enAirBrake
				if enAirBrake then
					local posX, posY, posZ = getCharCoordinates(playerPed)
					airBrkCoords = {posX, posY, posZ, 0.0, 0.0, getCharHeading(playerPed)}
				end
			end
			end
		end
		
			if wasKeyPressed(VK_F9) then
			if not sampIsChatInputActive() then
			printStringNow("~w~KILL LIST "..(cfg.main.killlist and "~b~OFF" or "~g~ON"), 2000)
				cfg.main.killlist = not cfg.main.killlist
			end
			end
		
		if enAirBrake then
		local cx, cy = windowCoordinates[1] / 2, windowCoordinates[2] / 2
		klavisha = checkNameKlavisha(cfg.main.upair)
		klavisha1 = checkNameKlavisha(cfg.main.fspeeddown)
		renderFontDrawText(my_font, 'Изменение скорости: {E78284}'..klavisha..' {84A6E7} и {E78284}'..klavisha1..'\n{84A6E7}Текущая скорость: {E78284}'..cfg.main.speed_airbrake, cx + 500, windowCoordinates[2] - 32, 0xFF84A6E7)
			if isCharInAnyCar(playerPed) then heading = getCarHeading(storeCarCharIsInNoSave(playerPed))
			else heading = getCharHeading(playerPed) end
			local camCoordX, camCoordY, camCoordZ = getActiveCameraCoordinates()
			local targetCamX, targetCamY, targetCamZ = getActiveCameraPointAt()
			local angle = getHeadingFromVector2d(targetCamX - camCoordX, targetCamY - camCoordY)
			if isCharInAnyCar(playerPed) then difference = 0.79 else difference = 1.0 end
			setCharCoordinates(playerPed, airBrkCoords[1], airBrkCoords[2], airBrkCoords[3] - difference)
			if not isSampfuncsConsoleActive() and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() then
				if isKeyDown(VK_W) then
				airBrkCoords[1] = airBrkCoords[1] + cfg.main.speed_airbrake * math.sin(-math.rad(angle))
				airBrkCoords[2] = airBrkCoords[2] + cfg.main.speed_airbrake * math.cos(-math.rad(angle))
				if not isCharInAnyCar(playerPed) then setCharHeading(playerPed, angle)
				else setCarHeading(storeCarCharIsInNoSave(playerPed), angle) end
				elseif isKeyDown(VK_S) then
					airBrkCoords[1] = airBrkCoords[1] - cfg.main.speed_airbrake * math.sin(-math.rad(heading))
					airBrkCoords[2] = airBrkCoords[2] - cfg.main.speed_airbrake * math.cos(-math.rad(heading))
				end
				if isKeyDown(VK_A) then
					airBrkCoords[1] = airBrkCoords[1] - cfg.main.speed_airbrake * math.sin(-math.rad(heading - 90))
					airBrkCoords[2] = airBrkCoords[2] - cfg.main.speed_airbrake * math.cos(-math.rad(heading - 90))
				elseif isKeyDown(VK_D) then
					airBrkCoords[1] = airBrkCoords[1] - cfg.main.speed_airbrake * math.sin(-math.rad(heading + 90))
					airBrkCoords[2] = airBrkCoords[2] - cfg.main.speed_airbrake * math.cos(-math.rad(heading + 90))
				end
				if isKeyDown(VK_UP) or isKeyDown(VK_SPACE) then airBrkCoords[3] = airBrkCoords[3] + cfg.main.speed_airbrake end
				if isKeyDown(VK_DOWN) and airBrkCoords[3] or isKeyDown(VK_LSHIFT) and airBrkCoords[3] > -95.0 then airBrkCoords[3] = airBrkCoords[3] - cfg.main.speed_airbrake end
				if isKeysDown(upair.v) then
					if cfg.main.speed_airbrake + 0.2 > 10.0 then
						sampAddChatMessage(tag..'Это максимальная скорость!', -1)
					else
						cfg.main.speed_airbrake = cfg.main.speed_airbrake + 0.2
					end
				end
				if isKeysDown(fspeeddown.v) then
					if cfg.main.speed_airbrake - 0.2 < 0.2 then
						sampAddChatMessage(tag..'Это минимальная скорость!', -1)
					else
						cfg.main.speed_airbrake = cfg.main.speed_airbrake - 0.2
					end
				end
			end
		end	
		
		
		
		if not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(fopenmenutp.v) then
				TeleportWindow.v = not TeleportWindow.v
				imgui.Process = TeleportWindow.v
			end
		end
		
		


 
		
		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(fgm.v) then
				cfg.main.gm = not cfg.main.gm 
			end
		end
	
		
		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) and ReconWindow.v then
			if isKeysDown(freoff.v) then
				sampSendChat('/reoff')
			end
		end
		
		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(fvizualrep.v) then
				if nickplayer == nil or idplayer == nil or report_text == nil or textplayer == nil then
				sampAddChatMessage(tag..'За текущую сессию вы не ответили ни на один репорт!', -1)
				else
				sampAddChatMessage('--------------------------------------------------------------------', 0xFFCDAD00)
				sampAddChatMessage('Репорт от {90EE90}' .. nickplayer .. '[' .. idplayer .. ']', 0xFFCD5C5C)
				sampAddChatMessage('Суть репорта: {90EE90}' .. report_text, 0xFFCD5C5C)
				sampAddChatMessage('Ваш ответ: {90EE90}'.. textplayer, 0xFFCD5C5C)
				sampAddChatMessage('За сегодня ответов: {90EE90}'.. cfg.main.reportzaday, 0xFFCD5C5C)
				sampAddChatMessage('--------------------------------------------------------------------', 0xFFCDAD00)
				end
			end
		end

		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(farep.v) then
			if nickplayer == nil or idplayer == nil or report_text == nil or textplayer == nil then
				sampAddChatMessage(tag..'За текущую сессию вы не ответили ни на один репорт!', -1)
				else
				sampSendChat("/a Репорт от {84A6E7}" .. nickplayer .. "[" .. idplayer .. "]")
				sampSendChat("/a Суть репорта: {84A6E7}" .. report_text)
				sampSendChat("/a Мой ответ: {84A6E7}".. textplayer)
				end
			end
		end

		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(flastreport.v) then
			if report_id == nil then
			sampAddChatMessage(tag..'За текущую сессию вы не ответили ни на один репорт!', -1)
			else
				sampSetChatInputEnabled(true)
				sampSetChatInputText("/pm "..report_id.." ")
			end
			end
		end

		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(fnorules.v) then
				if report_id == nil then
					sampAddChatMessage(tag..'За текущую сессию вы не ответили ни на один репорт!', -1)
				else
					sampSendChat("/pm "..report_id.." 0 Игрок, на которого вы жаловались, не нарушает.")
				end
			end
		end
			
		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) and ReportWindow.v  then
			if isKeysDown(fspecrep.v) then
				local template = u8:decode(reason_settings_report[4].v)
				local template = template:gsub('{nick_rep}', nick_rep)
				local template = template:gsub('{my_id}', my_id)
				local template = template:gsub('{id_rep}', id_rep)
				local template = template:gsub('{my_name}', my_name)
				sampSendDialogResponse(6370, 1, _, template)
				text_buffer_rep.v = ''
				ReportWindow.v = false
			end
		end

		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) and ReportWindow.v then
			if isKeysDown(fperedam.v) then
				local template = u8:decode(reason_settings_report[9].v)
				local template = template:gsub('{nick_rep}', nick_rep) 
				local template = template:gsub('{my_id}', my_id)
				local template = template:gsub('{id_rep}', id_rep)
				local template = template:gsub('{my_name}', my_name) 
				sampSendDialogResponse(6370, 1, _, template)
				sampSendChat("/a >>> [РЕПОРТ] ".. report_name .."[".. report_id .."]: " .. report_text.. " ")
				text_buffer_rep.v = ''
				ReportWindow.v = false
			end
		end

		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(fslap.v) then
			local _, myid = sampGetPlayerIdByCharHandle(playerPed)
			mynick = sampGetPlayerNickname(myid)
				sampSendChat('/slap '..myid..' 1')
			end
		end

			
		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(famember.v) then
				AmemberWindow.v = not AmemberWindow.v
				imgui.Process = AmemberWindow.v
			end
		end

		themeSettings()

		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(fspeclast.v) then
				if report_id == nil then
					sampAddChatMessage(tag..'За текущую сессию вы не ответили ни на один репорт!', -1)
				else
					sampSendChat( '/re '..report_id)
				end
			end
		end

		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(fjetpack.v) then
				sampSendChat('/jp')
			end
		end

		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) and ReportWindow.v then
			if isKeysDown(fspecauthor.v) then
				local template = u8:decode(reason_settings_report[2].v)
				local template = template:gsub('{nick_rep}', nick_rep) 
				local template = template:gsub('{my_id}', my_id)
				local template = template:gsub('{id_rep}', id_rep)
				local template = template:gsub('{my_name}', my_name) 
				sampSendDialogResponse(6370, 1, _, template)
				sampSendChat('/re ' .. report_id)
				text_buffer_rep.v = ''
				ReportWindow.v = false
			end
		end

		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() and not ReportWindow.v then
			if isKeysDown(fopenreport.v) then
				sampSendChat("/ot")
			end
		end
		
		
		if isKeysDown(facceptform.v) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() and cfg.main.trueform then
			if active_report == 2 then					
			lua_thread.create(function()
				sampSendChat("/"..cmd.." "..paramssss)
				status("true", 1)	
				sampAddChatMessage("[AdminTools] {"..cfg.main.twocolorforms.."}Форма >> {"..cfg.main.colorforms.."}/"..cmd.." "..paramssss.." {"..cfg.main.twocolorforms.."}<< выдана!", "0xFF"..cfg.main.colorforms)
				local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//AcceptForms.txt", 'a')
				f:write('['..os.date("%d.%m.%Y %X", os.time())..'] Форма: /'..cmd..' '..paramssss..' | Отправитель: '..admin_nick..' | Тип принятия формы: вручную\n')
				f:close()
				cfg.main.formsday = cfg.main.formsday + 1
				cfg.main.formsvse = cfg.main.formsvse + 1
				active_report2 = 1
				autoformaq = "false"
				wait (502)
				sampSendChat("/a [ARENA-TOOLS] ~ Forma [+]")
				wait (502)
				sampAddChatMessage("{00BFFF}[Arena-TOOLS] - Успешно принятая форма от: " .. admin_nick .. "{FFFFFF}")	
				acceptforma = "true"
			end)
			end
		end
		

		if ReconWindow.v and wasKeyPressed(VK_SPACE) and not sampIsChatInputActive() and not sampIsDialogActive() then
			sampSendChat('/re '..spec_id..'')
			printStringNow('UPDATE RECON', 1000)
		end

		end
end



local fsClock = nil
function imgui.BeforeDrawFrame()
		if fa_font == nil then
		local font_config = imgui.ImFontConfig()
		font_config.MergeMode = true

		fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 17.0, font_config, fa_glyph_ranges)
	end
	if minimalfont == nil then minimalfont = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 15.0, font_config, fa_glyph_ranges) end
	if fontsize == nil then
		fontsize = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 20.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
	end
	if fs16 == nil then fs16 = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 16.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) end
	if fs20 == nil then fs20 = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 20.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) end
	if fs40 == nil then fs40 = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 40.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) end
	if fs80 == nil then fs80 = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 80.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) end
	if infoFs == nil then infoFs = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 35.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) end
	if fsClock == nil then
		fsClock = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 25.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
	end
end
function imgui.OnDrawFrame()
local X, Y = getScreenResolution()
	local colours = {u8'Розовый', u8'Зелёный', u8'Красный', u8'Фиолетовый', u8'Чёрный', u8"Белый"}
	local binds = {u8'Защита аккаунта', u8'Множитель доната', u8'Правила сервера', u8'Дискорд', u8'Паблик', u8'Собственный №1', u8'Собственный №2', u8'Собственный №3', u8'Собственный №4'}
	if MainWindow.v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(900, 550), 1)
		imgui.Begin(fa.ICON_FA_TOOLS..u8' ARZ ARENA | TOOLS '..fa.ICON_FA_TOOLS, MainWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoSavedSettings) 	
		imgui.PushStyleColor(imgui.Col.ChildWindowBg, imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.Button]))
		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.Button]))
		imgui.BeginChild("ChildWindow", imgui.ImVec2(190, -1), true)
			 if  imgui.Button(fa.ICON_FA_SYNC_ALT..u8'', imgui.ImVec2(54, 27)) then
			sampAddChatMessage(tag..'Скрипт перезагружен.', -1)
			imgui.ShowCursor = false
			thisScript():reload()
	   end
	   imgui.Hint('reloadss', u8'Перезапустить скрипт')
	   imgui.SameLine()
	   if  imgui.Button(fa.ICON_FA_POWER_OFF..u8'', imgui.ImVec2(54, 27)) then
			sampAddChatMessage(tag..'Скрипт успешно выгружен, для запуска используйте комбинацию клавиш CTRL + R.', -1)
			imgui.ShowCursor = false
		thisScript():unload()
	   end
	   imgui.Hint('off12322', u8'Выключить скрипт')
	   imgui.SameLine()
	   if  imgui.Button(fa.ICON_FA_SAVE..u8'', imgui.ImVec2(54, 27)) then
			sampAddChatMessage(tag..'Настройки скрипта успешно сохранены.', -1)
			inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
	   end
	   imgui.Hint('saves', u8'Сохранить настройки')
		imgui.CustomMenu(selector_list, menusel, imgui.ImVec2(160, 30), 0.2, true)
		imgui.EndChild()
		imgui.PopStyleColor(2)
		imgui.SameLine()
		if menusel.v == 12 then
			SettingsTraicer()
		end
		if menusel.v == 1 then
			imgui.BeginChild("ChildWindow1", imgui.ImVec2(-1, -1), true) 
			imgui.Columns(2, _, false)
			local _, myid = sampGetPlayerIdByCharHandle(playerPed)
			mynick = sampGetPlayerNickname(myid)
			imgui.Text(u8'Ваш ник: '..mynick..'['..myid..']')
			imgui.Text(u8'Ваш LVL администрирования:')
			imgui.SameLine()
			imgui.PushItemWidth(20)
			if imgui.InputInt('##asdasdadsadsdasdas',tttttt, 0) then 
				cfg.main.mylvladmin = tttttt.v 
			end
			if cfg.main.mylvladmin == 8 then 
				imgui.Text(u8'Ваш LVL фулл доступа:')
				imgui.SameLine()
				imgui.PushItemWidth(20)
				if imgui.InputInt('##asdasdadsadsdasdasda',ttttttt, 0) then 
					cfg.main.mylvlfd = ttttttt.v 
				end
			end
			imgui.PopItemWidth()
			imgui.Text(u8'Ваш сервер:')
			imgui.SameLine()
			imgui.PushItemWidth(20) 
			if imgui.InputText('##adasdmyserver', myserver) then 
				cfg.main.myserver = string.format('%s', tostring(myserver.v)) 
			end 
			imgui.PopItemWidth()
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('asd5', u8'Укажите номер сервера:\nARENA — ARENA')
			if imgui.ToggleButton(u8'NoBike', imgui.ImBool(cfg.main.nobike)) then 
				cfg.main.nobike = not cfg.main.nobike 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa11', u8'Вы никогда не будете падать с двухколесного транспорта')
			if imgui.ToggleButton(u8'GodMode', imgui.ImBool(cfg.main.gm)) then 
				cfg.main.gm = not cfg.main.gm 
			end 
				imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa12', u8'Вы будете защищены от пуль, а транспорт от повреждений')
			if imgui.ToggleButton(u8'AirBrake', imgui.ImBool(cfg.main.airbrake)) then 
				cfg.main.airbrake = not cfg.main.airbrake 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa13', u8'Аналог метлы, только в разы быстрее\nВкл./выкл.: R.SHIFT\nУскорение: Num +\nЗамедление:Num -')
			if imgui.ToggleButton(u8'Принятие форм из админ-чата', imgui.ImBool(cfg.main.trueform)) then
					cfg.main.trueform = not cfg.main.trueform
			end
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa15', u8'Выполнение наказаний от мл. администрации')
			if imgui.ToggleButton(u8'Фракция при авторизации', imgui.ImBool(cfg.main.fraclogin)) then 
				cfg.main.fraclogin = not cfg.main.fraclogin 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa3', u8'Введите ID фракции в которую вы будете вступать при авторизации\nФункция доступна с 4+ LVL')
			if cfg.main.fraclogin then
				imgui.SameLine()
				imgui.PushItemWidth(100)
				imgui.InputInt(u8("##adsjaxsss213123123123dsasdadsj"), buffer73)
				cfg.main.fracid = string.format('%s', tostring(buffer73.v)) 
				imgui.PopItemWidth()
				if buffer73.v <= 0 then
					buffer73.v = 1
				elseif buffer73.v >= 28 then
					buffer73.v = 27
				end
			end
			if imgui.ToggleButton(u8'Скин при авторизации', imgui.ImBool(cfg.main.skinlogin)) then 
				cfg.main.skinlogin = not cfg.main.skinlogin 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa2', u8'Введите ID скина который будет выдаваться при авторизации\nФункция доступна с 4+ LVL')
			if cfg.main.skinlogin then
				imgui.SameLine()
				imgui.PushItemWidth(100)
				imgui.InputInt(u8("##adsjaxsss213123123123qwedsasdadsj"), buffer76)
				cfg.main.skinid = string.format('%s', tostring(buffer76.v)) 
				imgui.PopItemWidth()
				if buffer76.v <= 0 then
					buffer76.v = 1
				elseif buffer76.v >= 389 then
					buffer76.v = 388
				end
				end
			--if imgui.ToggleButton(u8'Интерьер при авторизации', imgui.ImBool(cfg.main.intlogin)) then 
			--	cfg.main.intlogin = not cfg.main.intlogin 
			--end 
			--imgui.SameLine()
			--imgui.PushFont(minimalfont)
			--imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			--imgui.PopFont()
			--imgui.Hint('helpa4', u8'Введите ID интерьера в который вы будете телепортироваться при авторизации')
			--if cfg.main.intlogin then
			--	imgui.SameLine()
			--	imgui.PushItemWidth(100)
			--	imgui.InputInt(u8("##adsjaxsss213123123123qwedsqweqweqweasdadsj"), buffer77)
			--	cfg.main.intid = string.format('%s', tostring(buffer77.v)) 
			--	imgui.PopItemWidth()
			--	if buffer77.v <= 0 then
			--		buffer77.v = 1
			--	elseif buffer77.v >= 146 then
			--		buffer77.v = 145
			--	end
			--end
			if imgui.ToggleButton(u8'Автовход в аккаунт', imgui.ImBool(cfg.main.autologin)) then
				cfg.main.autologin = not cfg.main.autologin
			end
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa1', u8'Для работы данной функции укажите свой пароль от аккаунта в соответствующем пункте.\nПри подключении на сервер скрипт сам моментально введет пароль')
			if cfg.main.autologin then
			imgui.SameLine()
				if cfg.main.showakkpass then
					imgui.PushItemWidth(100) 
				if imgui.InputText('##adsdasdasdas2', buffer55) then 
					cfg.main.akkpass = string.format('%s', tostring(buffer55.v)) 
				end 
				imgui.PopItemWidth()
					imgui.SameLine()
					if imgui.EyeSlashButton() then
						cfg.main.showakkpass = not cfg.main.showakkpass
					end
				else
					imgui.PushItemWidth(100) 
				if imgui.InputText('##adsdasdasdas2', buffer55, imgui.InputTextFlags.Password) then 
					cfg.main.akkpass = string.format('%s', tostring(buffer55.v)) 
				end 
				imgui.PopItemWidth()
					imgui.SameLine()
					if imgui.EyeButton() then
						cfg.main.showakkpass = not cfg.main.showakkpass
					end
				end
					end	
			if imgui.ToggleButton(u8'Автовход в админку', imgui.ImBool(cfg.main.autoadm)) then
				cfg.main.autoadm = not cfg.main.autoadm
			end
				imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa16', u8'При авторизации на сервер скрипт автоматически введет пароль от админки')			
			if cfg.main.autoadm then
				imgui.SameLine()
				if cfg.main.showpass then
					imgui.PushItemWidth(50) 
					if imgui.InputText('##adsdasdasdashh2', buffer56) then 
						cfg.main.admpass = string.format('%s', tostring(buffer56.v)) 
					end 
					imgui.PopItemWidth()
					imgui.SameLine()
					if imgui.EyeSlashButton() then
						cfg.main.showpass = not cfg.main.showpass
					end
				else
					imgui.PushItemWidth(50) 
					if imgui.InputText('##adsdasdasdashh2', buffer56, imgui.InputTextFlags.Password) then 
						cfg.main.admpass = string.format('%s', tostring(buffer56.v)) 
					end 
					imgui.PopItemWidth()
					imgui.SameLine()
					if imgui.EyeButton() then
						cfg.main.showpass = not cfg.main.showpass
					end
				end
				end
			if imgui.ToggleButton(u8'Телепорт в АЗ при входе', imgui.ImBool(cfg.main.autoaz)) then
				cfg.main.autoaz = not cfg.main.autoaz
			end
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa17', u8'При входе в админку скрипт автоматически телепортируется в /AZ')
			if imgui.ToggleButton(u8'Автоловля репорта', imgui.ImBool(cfg.main.lovlyareporta)) then
				cfg.main.lovlyareporta = not cfg.main.lovlyareporta
			end
			if imgui.SettingsButton() then imgui.OpenPopup(u8'Настройка автоловли репорта') end
			if imgui.BeginPopupModal(u8'Настройка автоловли репорта', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
				imgui.CenterText(u8'Выберите способ:')
			if imgui.RadioButton(u8"По тексту в чате", style_lovlyareporta, 1) then
			cfg.main.stylelovlyareporta = 1
			end
			if imgui.RadioButton(u8'По надписи "REPORT ++"', style_lovlyareporta, 2) then
				cfg.main.stylelovlyareporta = 2
			end
			if imgui.RadioButton(u8'Обычный флуд /ot', style_lovlyareporta, 3) then
				cfg.main.stylelovlyareporta = 3
			end
			if imgui.ToggleButton(u8'Автоматически выключать после ловли 1 репорта', imgui.ImBool(cfg.main.autooff)) then 
				cfg.main.autooff = not cfg.main.autooff 
			end 
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
			if imgui.ToggleButton(u8'Бесконечные патроны', imgui.ImBool(cfg.main.infammo)) then 
				cfg.main.infammo = not cfg.main.infammo 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa2313842381', u8'При стрельбе у вас не будут тратиться патроны, они станут бесконечными')
			if imgui.ToggleButton(u8'Скрывать IP адреса', imgui.ImBool(cfg.main.removeip)) then 
				cfg.main.removeip = not cfg.main.removeip 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa113', u8'ИПы в сообщениях будут заменяться таким образом: 93.хх.хх.186\nПолезная функция, ведь на опрах больше не будет ИПов игроков/админов')
			if imgui.ToggleButton(u8'Ноп F5', imgui.ImBool(cfg.main.nopf5)) then 
				cfg.main.nopf5 = not cfg.main.nopf5 
				if not cfg.main.nopf5 then
				sampAddChatMessage('[Информация] После перезахода в игру клавиша F5 снова будет работаспособа', 14628149)
				end
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa211221', u8'Отключает работу клавиши F5')
			if imgui.ToggleButton(u8'Невидимка', imgui.ImBool(cfg.main.invisible)) then 
				cfg.main.invisible = not cfg.main.invisible 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('invisibleasddsaw', u8'Вы не будете видны другим игрокам\nпомогает при слежке за каптами и т.п.')
			--if imgui.ToggleButton(u8'Чекер игроков', imgui.ImBool(cfg.main.playersChecker)) then 
			--	cfg.main.playersChecker = not cfg.main.playersChecker 
			--end 
			--if imgui.ToggleButton(u8'Чекер администрации [OFF SISTEM]', imgui.ImBool(cfg.main.leaveChecker)) then 
			--	cfg.main.leaveChecker = not cfg.main.leaveChecker 
			--end 
			--		imgui.SameLine()
			--imgui.PushFont(minimalfont)
			--imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			--imgui.PopFont()
			--imgui.Hint('helpa14', u8'Чекер администрации, выводит список админов на экран.')
			--if imgui.ToggleButton(u8"Трейсер своих пуль", elements.checkbox.drawMyBullets) then
			--	cfg.config.drawMyBullets = elements.checkbox.drawMyBullets.v 
			--	 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			--end
			if imgui.SettingsButton() then menusel.v = 2 end
			if imgui.ToggleButton(u8'Свечение сетов +50', imgui.ImBool(cfg.main.offamulet)) then 
				cfg.main.offamulet = not cfg.main.offamulet 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpsadjdsaqa18', u8'Данная функция визуально отключает свечение сетов +50 и выше')
			if imgui.ToggleButton(u8'Логгирование действий', imgui.ImBool(cfg.main.logging)) then 
				cfg.main.logging = not cfg.main.logging 
			end 

			if imgui.SettingsButton() then imgui.OpenPopup(fa.ICON_FA_COGS..u8' Логгирование действий')  end
			if imgui.BeginPopupModal(fa.ICON_FA_COGS..u8' Логгирование действий', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
			if imgui.ToggleButton(u8'Логгирование выдачи блокировок IP в оффлайне', imgui.ImBool(cfg.main.logbanipoff)) then 
				cfg.main.logbanipoff = not cfg.main.logbanipoff 
			end 
			if imgui.ToggleButton(u8'Логгирование выдачи блокировок в оффлайне', imgui.ImBool(cfg.main.logbanoff)) then 
				cfg.main.logbanoff = not cfg.main.logbanoff 
			end 
			if imgui.ToggleButton(u8'Логгирование выдачи деморганов в оффлайне', imgui.ImBool(cfg.main.logjailoff)) then 
				cfg.main.logjailoff = not cfg.main.logjailoff 
			end 
			if imgui.ToggleButton(u8'Логгирование выдачи заглушек в оффлайне', imgui.ImBool(cfg.main.logmuteoff)) then 
				cfg.main.logmuteoff = not cfg.main.logmuteoff 
			end 
			if imgui.ToggleButton(u8'Логгирование разблокировок IP', imgui.ImBool(cfg.main.logunbanip)) then 
				cfg.main.logunbanip = not cfg.main.logunbanip 
			end 
			if imgui.ToggleButton(u8'Логгирование разблокировок', imgui.ImBool(cfg.main.logunban)) then 
				cfg.main.logunban = not cfg.main.logunban 
			end 
			if imgui.ToggleButton(u8'Логгирование выпусков из деморгана', imgui.ImBool(cfg.main.logunjail)) then 
				cfg.main.logunjail = not cfg.main.logunjail 
			end 
			if imgui.ToggleButton(u8'Логгирование снятий заглушек', imgui.ImBool(cfg.main.logunmute)) then 
				cfg.main.logunmute = not cfg.main.logunmute 
			end 
			if imgui.Button(u8'Закрыть', imgui.ImVec2(-1, 25)) then
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
			if imgui.ToggleButton(u8'Автовключение антиТП', imgui.ImBool(cfg.main.antitp)) then 
				cfg.main.antitp = not cfg.main.antitp 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('antitps ', u8'При входе под админку у вас автоматически будет\nвключаться /antitp')
			imgui.NextColumn()
			if imgui.ToggleButton(u8'Переход слежки на << и >>', imgui.ImBool(cfg.main.perehodik)) then 
				cfg.main.perehodik = not cfg.main.perehodik 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('heloa388433', u8'При нажатии кнопки > или < вы перейдете в слежку за следующим или прошлым игроком')
			if imgui.ToggleButton(u8'Авто nRP (/b) чат', imgui.ImBool(cfg.main.autob)) then 
				cfg.main.autob = not cfg.main.autob 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa18  ', u8'Весь текст будет отправляться в nRP (/b) чат')
			if imgui.ToggleButton(u8'Информация после ответа /ot', imgui.ImBool(cfg.main.inforeport)) then 
				cfg.main.inforeport = not cfg.main.inforeport 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa19', u8'Данная функция включает сообщение с информацией о ответе на последний репорт.')
			if imgui.ToggleButton(u8"Информация/статистика", to) then
				cfg.statTimers.state = to.v
			end		
			if imgui.SettingsButton() then imgui.OpenPopup(u8'Настройка информации и статистики') end
			if imgui.BeginPopupModal(u8'Настройка информации и статистики', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
				kotofeevstatsadm()
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
			if imgui.ToggleButton(u8'Спавниться на /spawnset', imgui.ImBool(cfg.main.spawnonset)) then 
				cfg.main.spawnonset = not cfg.main.spawnonset 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa20', u8'При входе на сервер вы будете автоматически спавниться на установленном месте')
			if imgui.ToggleButton(u8'Ноп F4', imgui.ImBool(cfg.main.nopf4)) then 
				cfg.main.nopf4 = not cfg.main.nopf4 
				if not cfg.main.nopf4 then
				sampAddChatMessage('[Информация] После перезахода в игру клавиша F4 снова будет работаспособа', 14628149)
				end
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa21', u8'Отключает работу клавиши F4, при частом попадании в больку отключите функцию и перезайдите')
			if imgui.ToggleButton(u8'Радар в реконе', imgui.ImBool(cfg.main.radarinrecon)) then 
				cfg.main.radarinrecon = not cfg.main.radarinrecon 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa22', u8'Данная функция включает отображение худа/радара в реконе')
			if imgui.ToggleButton(u8'Удаление строк в чате', imgui.ImBool(cfg.main.deleteactions)) then 
				cfg.main.deleteactions = not cfg.main.deleteactions 
			end 

			if imgui.SettingsButton() then imgui.OpenPopup(fa.ICON_FA_COGS..u8' Удаление действий в чате')  end
			if imgui.BeginPopupModal(fa.ICON_FA_COGS..u8' Удаление действий в чате', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
			if imgui.ToggleButton(u8"Удаление строк о слапах", imgui.ImBool(cfg.main.deleteslap)) then
				cfg.main.deleteslap = not cfg.main.deleteslap 
			end
			if imgui.ToggleButton(u8"Удаление строк о банах", imgui.ImBool(cfg.main.deleteban)) then
				cfg.main.deleteban = not cfg.main.deleteban 
			end
			if imgui.ToggleButton(u8"Удаление строк о выдаче временного тс", imgui.ImBool(cfg.main.deleteplveh)) then
				cfg.main.deleteplveh = not cfg.main.deleteplveh 
			end
			if imgui.ToggleButton(u8"Удаление строк о блокировке чата", imgui.ImBool(cfg.main.deletemute)) then
				cfg.main.deletemute = not cfg.main.deletemute 
			end
			if imgui.ToggleButton(u8"Удаление строк о выдаче варна", imgui.ImBool(cfg.main.deletewarn)) then
				cfg.main.deletewarn = not cfg.main.deletewarn 
			end
			if imgui.ToggleButton(u8"Удаление строк о выдаче деморгана", imgui.ImBool(cfg.main.deletejail)) then
				cfg.main.deletejail = not cfg.main.deletejail 
			end
			if imgui.ToggleButton(u8"Удаление строк о сообщении игроку", imgui.ImBool(cfg.main.deletepm)) then
				cfg.main.deletepm = not cfg.main.deletepm 
			end
			if imgui.ToggleButton(u8"Удаление строк админ-чата", imgui.ImBool(cfg.main.deleteadminchat)) then
				cfg.main.deleteadminchat = not cfg.main.deleteadminchat 
			end
			if imgui.ToggleButton(u8"Удаление строк о находке клада", imgui.ImBool(cfg.main.deleteclad)) then
				cfg.main.deleteclad = not cfg.main.deleteclad 
			end
			if imgui.ToggleButton(u8"Удаление строк от АнтиЧита", imgui.ImBool(cfg.main.deleteanticheat)) then
				cfg.main.deleteanticheat = not cfg.main.deleteanticheat 
			end
			if imgui.ToggleButton(u8"Удаление строк о начале слежки", imgui.ImBool(cfg.main.deletespec)) then
				cfg.main.deletespec = not cfg.main.deletespec 
			end
			if imgui.Button(u8'Закрыть', imgui.ImVec2(-1, 25)) then
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
			if imgui.ToggleButton(u8'Удалять флуд в чат от /ot', imgui.ImBool(cfg.main.deleteot)) then 
				cfg.main.deleteot = not cfg.main.deleteot 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa23', u8'Данная функция отключает сообщения в чате об отсутствии репорта')
			if imgui.ToggleButton(u8'Автозакрытие диалога от античита', imgui.ImBool(cfg.main.deleteac)) then 
				cfg.main.deleteac = not cfg.main.deleteac 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa25', u8'Данная функция автоматически закрывает диалог о кике от античита (7+ LVL)')
			if imgui.ToggleButton(u8'Логгирование принятых форм в файл', imgui.ImBool(cfg.main.logform)) then 
				cfg.main.logform = not cfg.main.logform 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa26', u8'Данная функция логгирует все принятые формы в отдельный файл, дабы сократить случаи подставы')
			if imgui.ToggleButton(u8'Автоустановка уровня админки', imgui.ImBool(cfg.main.geniumlvl)) then 
				cfg.main.geniumlvl = not cfg.main.geniumlvl 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa27', u8'При входе в админку скрипт будет автоматически устанавливать уровень администратора на серверный')
			if imgui.ToggleButton(u8'Автоматическая выдача аццепта (себе)', imgui.ImBool(cfg.main.geniumaccept)) then 
				cfg.main.geniumaccept = not cfg.main.geniumaccept 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa28', u8'Данная функция автоматически выдаст вам аццепт, если его запросит сервер (7+ LVL)')
			if imgui.ToggleButton(u8'Отсутствие перезарядки', imgui.ImBool(cfg.main.noreload)) then 
				cfg.main.noreload = not cfg.main.noreload 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa2311384122381', u8'При стрельбе у вас автоматически будет скроллиться оружие, тем самым отсутствовать перезарядка')
			if imgui.ToggleButton(u8'SpeedHack', imgui.ImBool(cfg.main.speedhack)) then 
				cfg.main.speedhack = not cfg.main.speedhack 
			end 
			if imgui.SettingsButton() then imgui.OpenPopup(u8"Настройка SpeedHack'a") end
			if imgui.BeginPopupModal(u8"Настройка SpeedHack'a", MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
				imgui.Text(u8'Максимальная скорость:')
				imgui.SameLine()
				imgui.PushItemWidth(150)
				imgui.SliderInt(u8'##3huec', shmax, 80, 300)
				imgui.PopItemWidth()
				imgui.Text(u8'Плавность:')
				imgui.SameLine()
				imgui.PushItemWidth(150)
				imgui.SliderInt(u8'##hueczjasdjasd', shsmooth, 5, 150)
				imgui.PopItemWidth()
				cfg.main.shmax = shmax.v
				cfg.main.shsmooth = shsmooth.v
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				
				imgui.EndPopup()
			end
			if imgui.ToggleButton(u8'Авточек регов (/getip)', imgui.ImBool(cfg.main.regi)) then 
				cfg.main.regi = not cfg.main.regi 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('helpa1122311384122381', u8'При прописывании /getip скрипт автоматически будет определять местоположение и выводить в /a либо локальный чат')
			if imgui.SettingsButton() then imgui.OpenPopup(u8"Настройка проверки регов") end
			if imgui.BeginPopupModal(u8"Настройка проверки регов", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
			imgui.TextColoredRGB('{84A6E7}Куда отправлять данные?')
			if imgui.RadioButton(u8"В адм. чат", style_reg, 1) then
			cfg.main.stylereg = 1
			end
			if imgui.RadioButton(u8"В локальный чат", style_reg, 2) then
				cfg.main.stylereg = 2
			end
			if cfg.main.stylereg == 1 then
			imgui.TextColoredRGB('{84A6E7}В каких случаях отправлять в /a?')
					if imgui.RadioButton(u8"Только при принятии формы", style_admin, 1) then
						cfg.main.styleadmin = 2
					end
					if imgui.RadioButton(u8"Всегда (даже если не по форме)", style_admin, 2) then
						cfg.main.styleadmin = 2
					end
				end
			if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
			if imgui.ToggleButton(u8'WallHack на транспорт', imgui.ImBool(cfg.Settings.renderText)) then 
				cfg.Settings.renderText = not cfg.Settings.renderText
				inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end 
			if imgui.SettingsButton() then imgui.OpenPopup(u8'Настройки | WallHack на транспорт') end
			settingswallhackoncar()
			if imgui.ToggleButton(u8'Автореклама', imgui.ImBool(cfg.main.autopiar)) then 
				cfg.main.autopiar = not cfg.main.autopiar 
				sendpiar()
			end 
			if imgui.SettingsButton() then imgui.OpenPopup(fa.ICON_FA_COGS..u8' Настройки | Автореклама')  end
			if imgui.BeginPopupModal(fa.ICON_FA_COGS..u8' Настройки | Автореклама', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
			imgui.Text(fa.ICON_FA_COFFEE..u8' Выберите бинд для рекламы:')    
			imgui.SameLine()	
			imgui.PushItemWidth(150)
			imgui.Combo('##1',result1,binds, #binds) 
			imgui.PopItemWidth()
			if result1.v == 0 then 
				cfg.main.numberbind = 0
			elseif result1.v == 1 then 
				cfg.main.numberbind = 1
			elseif result1.v == 2 then 
				cfg.main.numberbind = 2
			elseif result1.v == 3 then 
				cfg.main.numberbind = 3
			elseif result1.v == 4 then 
				cfg.main.numberbind = 4
			elseif result1.v == 5 then 
				cfg.main.numberbind = 5
			elseif result1.v == 6 then 
				cfg.main.numberbind = 6
			elseif result1.v == 7 then 
				cfg.main.numberbind = 7
			elseif result1.v == 8 then 
				cfg.main.numberbind = 8
			end
			imgui.Text(u8'Интервал между рекламой:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
				imgui.InputInt(u8("##asdsad"), buffer54)
				cfg.main.bindtime = string.format('%s', tostring(buffer54.v)) 
				imgui.PopItemWidth()
				if buffer54.v <= 1 then
					buffer54.v = 1
				elseif buffer54.v >= 1800 then
					buffer54.v = 1800
				end
				imgui.SameLine()
				imgui.Text(u8'сек.')
			if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
				imgui.CloseCurrentPopup()
			end
				imgui.EndPopup()
			end
			if imgui.ToggleButton(u8'Варнинги на ТК', imgui.ImBool(cfg.main.warningtk)) then 
				cfg.main.warningtk = not cfg.main.warningtk 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('warningtkss', u8'Если игрок убьет своего напарника по организации, то скрипт оповестит вас об этом в чате')
			if imgui.ToggleButton(u8'Чекер подключений', imgui.ImBool(cfg.main.connectChecker)) then 
				cfg.main.connectChecker = not cfg.main.connectChecker 
			end 
			if imgui.ToggleButton(u8'Чекер регистраций', imgui.ImBool(cfg.main.regChecker)) then 
				cfg.main.regChecker = not cfg.main.regChecker 
			end 
			 if imgui.ToggleButton(u8"Трейсер чужих пуль", elements.checkbox.drawBullets) then
				cfg.config.drawBullets = elements.checkbox.drawBullets.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end
			if imgui.SettingsButton() then menusel.v = 2 end

			
			if imgui.ToggleButton(u8'Отображать /b над головой', imgui.ImBool(cfg.main.underb)) then 
				cfg.main.underb = not cfg.main.underb 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('underbq', u8'Отображает весь текст, написанный в /b чат над головой игрока')
			if imgui.ToggleButton(u8'Слежка по килл-листу', imgui.ImBool(cfg.main.spectatekill)) then 
				cfg.main.spectatekill = not cfg.main.spectatekill 
			end 
			imgui.SameLine()
			imgui.PushFont(minimalfont)
			imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.PopFont()
			imgui.Hint('spectatekillaa', u8'При нажатии по никнейму игрока в килл-листе\nвы автоматически перейдете в слежку за ним')
			imgui.Columns(1)
			imgui.Separator()
						if imgui.Button(u8'Защита аккаунта', imgui.ImVec2(200, 22)) then 
						lua_thread.create(function ()
				for cikk22 in zawitabinder.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer42.v))
				end
			end)
			end 
						if imgui.SettingsButton() then imgui.OpenPopup(fa.ICON_FA_COGS..u8' Настройки | Защита аккаунта')  end
			if imgui.BeginPopupModal(fa.ICON_FA_COGS..u8' Настройки | Защита аккаунта', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.AlwaysAutoResize) then
										imgui.InputTextMultiline('##kotofee1vnoyob', zawitabinder, imgui.ImVec2(650, 250))
imgui.Text(u8'Задержка между отправкой строк:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjasdawqxdqsaud14ssj"), buffer42)
			cfg.main.timeoutzawita = string.format('%s', tostring(buffer42.v)) 
			imgui.PopItemWidth()
			if buffer42.v <= 0 then
				buffer42.v = 0
			elseif buffer42.v >= 5001 then
				buffer42.v = 5000
			end
			if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
				local file = io.open(getGameDirectory().."//moonloader//AdminToolsKing//zawitabinder.txt", "w")
				file:write(zawitabinder.v)
				file:close()
				imgui.CloseCurrentPopup()
			end
				imgui.EndPopup()
			end
			imgui.SameLine()
			if imgui.Button(u8'Множитель доната', imgui.ImVec2(200, 22)) then
				lua_thread.create(function ()
				for cikk22 in donatebinder.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer43.v))
				end
			end)
			end 
			if imgui.SettingsButton() then imgui.OpenPopup(fa.ICON_FA_COGS..u8' Настройки | Множитель доната')  end
		if imgui.BeginPopupModal(fa.ICON_FA_COGS..u8' Настройки | Множитель доната', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.AlwaysAutoResize) then
			imgui.InputTextMultiline('##kotofqee1vnoyob', donatebinder, imgui.ImVec2(650, 250))
			imgui.Text(u8'Задержка между отправкой строк:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjasdawqxdqsaudsseqj"), buffer43)
			cfg.main.timeoutdonate = string.format('%s', tostring(buffer43.v)) 
			imgui.PopItemWidth()
			if buffer43.v <= 0 then
				buffer43.v = 0
			elseif buffer43.v >= 5001 then
				buffer43.v = 5000
			end
			if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
				local file = io.open(getGameDirectory().."//moonloader//AdminToolsKing//donatebinder.txt", "w")
				file:write(donatebinder.v)
				file:close()
				imgui.CloseCurrentPopup()
			end
			imgui.EndPopup()
			end
			imgui.SameLine()
			if imgui.Button(u8'Правила сервера', imgui.ImVec2(200, 22)) then 
			lua_thread.create(function ()
				for cikk22 in rulesbinder.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer44.v))
				end
			end)
			end 
						if imgui.SettingsButton() then imgui.OpenPopup(fa.ICON_FA_COGS..u8' Настройки | Правила сервера')  end
						if imgui.BeginPopupModal(fa.ICON_FA_COGS..u8' Настройки | Правила сервера', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.AlwaysAutoResize) then
imgui.InputTextMultiline('##kotofqee1v16noyob', rulesbinder, imgui.ImVec2(650, 250))
			imgui.Text(u8'Задержка между отправкой строк:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##qqqqr"), buffer44)
			cfg.main.timeoutrules = string.format('%s', tostring(buffer44.v)) 
			imgui.PopItemWidth()
			if buffer44.v <= 0 then
				buffer44.v = 0
			elseif buffer44.v >= 5001 then
				buffer44.v = 5000
			end
			if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
				local file = io.open(getGameDirectory().."//moonloader//AdminToolsKing//rulesbinder.txt", "w")
				file:write(rulesbinder.v)
				file:close()
				imgui.CloseCurrentPopup()
			end
				imgui.EndPopup()
			end
			if imgui.Button(u8'Дискорд', imgui.ImVec2(200, 22)) then 
			lua_thread.create(function ()
				for cikk22 in discordbinder.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer45.v))
				end
			end)
			end 
									if imgui.SettingsButton() then imgui.OpenPopup(fa.ICON_FA_COGS..u8' Настройки | Дискорд')  end
						if imgui.BeginPopupModal(fa.ICON_FA_COGS..u8' Настройки | Дискорд', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.AlwaysAutoResize) then
imgui.InputTextMultiline('##eweqewqewdas', discordbinder, imgui.ImVec2(650, 250))
			imgui.Text(u8'Задержка между отправкой строк:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjasdawqxdqsaudssj"), buffer45)
			cfg.main.timeoutdiscord = string.format('%s', tostring(buffer45.v)) 
			imgui.PopItemWidth()
			if buffer45.v <= 0 then
				buffer45.v = 0
			elseif buffer45.v >= 5001 then
				buffer45.v = 5000
			end
			if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
				local file = io.open(getGameDirectory().."//moonloader//AdminToolsKing//discordbinder.txt", "w")
				file:write(discordbinder.v)
				file:close()
				imgui.CloseCurrentPopup()
			end
				imgui.EndPopup()
			end
			imgui.SameLine()
			if imgui.Button(u8'Паблик ВК', imgui.ImVec2(200, 22)) then
			lua_thread.create(function ()
				for cikk22 in groupbinder.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer46.v))
				end
			end)
			end 
												if imgui.SettingsButton() then imgui.OpenPopup(fa.ICON_FA_COGS..u8' Настройки | Паблик ВК')  end
						if imgui.BeginPopupModal(fa.ICON_FA_COGS..u8' Настройки | Паблик ВК', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.AlwaysAutoResize) then
imgui.InputTextMultiline('##eweqquuewqewdas', groupbinder, imgui.ImVec2(650, 250))
			imgui.Text(u8'Задержка между отправкой строк:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjasdawqxdqqsaudssj"), buffer46)
			cfg.main.timeoutgroup = string.format('%s', tostring(buffer46.v)) 
			imgui.PopItemWidth()
			if buffer46.v <= 0 then
				buffer46.v = 0
			elseif buffer46.v >= 5001 then
				buffer46.v = 5000
			end
			if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
				local file = io.open(getGameDirectory().."//moonloader//AdminToolsKing//groupbinder.txt", "w")
				file:write(groupbinder.v)
				file:close()
				imgui.CloseCurrentPopup()
			end
				imgui.EndPopup()
			end
						imgui.SameLine()
		if imgui.Button(u8'Собственный №1', imgui.ImVec2(200, 22)) then 
			lua_thread.create(function ()
				for cikk22 in mybinder1.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer36.v))
				end
			end)
		end 
									if imgui.SettingsButton() then imgui.OpenPopup(fa.ICON_FA_COGS..u8' Настройки | Собственный №1')  end
						if imgui.BeginPopupModal(fa.ICON_FA_COGS..u8' Настройки | Собственный №1', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.AlwaysAutoResize) then
			imgui.InputTextMultiline('##хуй', mybinder1, imgui.ImVec2(650, 250))
			imgui.Text(u8'Задержка между отправкой строк:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjasdaxdsadssj"), buffer36)
			cfg.main.timeoutmy1 = string.format('%s', tostring(buffer36.v)) 
			imgui.PopItemWidth()
			if buffer36.v <= 0 then
				buffer36.v = 0
			elseif buffer36.v >= 5001 then
				buffer36.v = 5000
			end
			if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
				local file = io.open(getGameDirectory().."//moonloader//AdminToolsKing//binder1.txt", "w")
				file:write(mybinder1.v)
				file:close()
				imgui.CloseCurrentPopup()
			end
				imgui.EndPopup()
			end
			if imgui.Button(u8'Собственный №2', imgui.ImVec2(200, 22)) then 
			lua_thread.create(function ()
				for cikk22 in mybinder2.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer37.v))
				end
			end)
			end 
									if imgui.SettingsButton() then imgui.OpenPopup(fa.ICON_FA_COGS..u8' Настройки | Собственный №2')  end
						if imgui.BeginPopupModal(fa.ICON_FA_COGS..u8' Настройки | Собственный №2', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.AlwaysAutoResize) then
imgui.InputTextMultiline('##kotofeevnoob', mybinder2, imgui.ImVec2(650, 250))
			imgui.Text(u8'Задержка между отправкой строк:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjasdaxdsaudssj"), buffer37)
			cfg.main.timeoutmy2 = string.format('%s', tostring(buffer37.v)) 
			imgui.PopItemWidth()
			if buffer37.v <= 0 then
				buffer37.v = 0
			elseif buffer37.v >= 5001 then
				buffer37.v = 5000
			end
			if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
				local file = io.open(getGameDirectory().."//moonloader//AdminToolsKing//binder2.txt", "w")
				file:write(mybinder2.v)
				file:close()
				imgui.CloseCurrentPopup()
			end
				imgui.EndPopup()
			end
									imgui.SameLine()
			if imgui.Button(u8'Собственный №3', imgui.ImVec2(200, 22)) then 
			lua_thread.create(function ()
				for cikk22 in mybinder3.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer40.v))
				end
			end)
			end 
									if imgui.SettingsButton() then imgui.OpenPopup(fa.ICON_FA_COGS..u8' Настройки | Собственный №3')  end
						if imgui.BeginPopupModal(fa.ICON_FA_COGS..u8' Настройки | Собственный №3', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.AlwaysAutoResize) then
						imgui.InputTextMultiline('##kotofeevnoyob', mybinder3, imgui.ImVec2(650, 250))
imgui.Text(u8'Задержка между отправкой строк:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjasdaxdqsaudssj"), buffer40)
			cfg.main.timeoutmy3 = string.format('%s', tostring(buffer40.v)) 
			imgui.PopItemWidth()
			if buffer40.v <= 0 then
				buffer40.v = 0
			elseif buffer40.v >= 5001 then
				buffer40.v = 5000
			end
			if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
				local file = io.open(getGameDirectory().."//moonloader//AdminToolsKing//binder3.txt", "w")
				file:write(mybinder3.v)
				file:close()
				imgui.CloseCurrentPopup()
			end
				imgui.EndPopup()
			end
									imgui.SameLine()
			if imgui.Button(u8'Собственный №4', imgui.ImVec2(200, 22)) then 
			lua_thread.create(function ()
				for cikk22 in mybinder4.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer41.v))
				end
			end)
			end 
	if imgui.SettingsButton() then imgui.OpenPopup(fa.ICON_FA_COGS..u8' Настройки | Собственный №4')  end
	if imgui.BeginPopupModal(fa.ICON_FA_COGS..u8' Настройки | Собственный №4', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.AlwaysAutoResize) then
						imgui.InputTextMultiline('##kotofee1vnoyob', mybinder4, imgui.ImVec2(650, 250))
imgui.Text(u8'Задержка между отправкой строк:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##хуйоыавоыавывф"), buffer41)
			cfg.main.timeoutmy4 = string.format('%s', tostring(buffer41.v)) 
			imgui.PopItemWidth()
			if buffer41.v <= 0 then
				buffer41.v = 0
			elseif buffer41.v >= 5001 then
				buffer41.v = 5000
			end
			if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
				local file = io.open(getGameDirectory().."//moonloader//AdminToolsKing//binder4.txt", "w")
				file:write(mybinder4.v)
				file:close()
				imgui.CloseCurrentPopup()
			end
		imgui.EndPopup()
	end
			imgui.EndChild() 		
		end
		if menusel.v == 8 then
			imgui.BeginChild("ChildWindow3", imgui.ImVec2(-1, -1), true) 
	if imgui.Button(u8'Настройки уведомления о правильной подаче жалобы', imgui.ImVec2(-1, 25)) then
	imgui.OpenPopup(fa.ICON_FA_COGS..u8' Настройки | Уведомление о подаче жалобы')
	end
							if imgui.BeginPopupModal(fa.ICON_FA_COGS..u8' Настройки | Уведомление о подаче жалобы', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
imgui.PushItemWidth(610) 
imgui.InputText(u8"##351355555", buffer94) 
cfg.main.infopunish = string.format('%s', tostring(buffer94.v)) 
imgui.PopItemWidth()
imgui.PushItemWidth(610) 
imgui.InputText(u8"##355453243351355555", buffer95) 
cfg.main.infopunish1 = string.format('%s', tostring(buffer95.v)) 
imgui.PopItemWidth()
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
if imgui.Button(u8'Flood [/'..cfg.main.typeflood..' '..cfg.main.flood..']', imgui.ImVec2(330, 25)) then
			imgui.OpenPopup(u8'Flood')		
end
			if imgui.BeginPopupModal(u8'Flood', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
				imgui.Text(u8"Укажите команду для выдачи наказания (без /):")
							imgui.PushItemWidth(90) 
							imgui.SameLine()
			imgui.InputText(u8"##1244443555", buffer91) 
			cfg.main.typeflood = string.format('%s', tostring(buffer91.v)) 
			imgui.PopItemWidth()
						imgui.Text(u8'Укажите срок наказания за данное нарушение:') 
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjasdaxdsadsj"), buffer3)
			cfg.main.flood = string.format('%s', tostring(buffer3.v)) 
			imgui.PopItemWidth()
			if buffer3.v <= 0 then
				buffer3.v = 0
			elseif buffer3.v >= 301 then
				buffer3.v = 300
			end
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
imgui.SameLine()
if imgui.Button(u8'DeathMatch [/'..cfg.main.typedm..' '..cfg.main.dm..']', imgui.ImVec2(330, 25)) then
	imgui.OpenPopup(u8'DeathMatch')		
end
			if imgui.BeginPopupModal(u8'DeathMatch', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
				imgui.Text(u8"Укажите команду для выдачи наказания (без /):")
							imgui.PushItemWidth(90) 
							imgui.SameLine()
			imgui.InputText(u8"##1244443", buffer90) 
			cfg.main.typedm = string.format('%s', tostring(buffer90.v)) 
			imgui.PopItemWidth()
						imgui.Text(u8'Укажите срок наказания за данное нарушение:') 
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjaxsssdsasdadsj"), buffer2)
			cfg.main.dm = string.format('%s', tostring(buffer2.v)) 
			imgui.PopItemWidth()
			if buffer2.v <= 0 then
				buffer2.v = 0
			elseif buffer2.v >= 1001 then
				buffer2.v = 1000
			end
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
if imgui.Button(u8'DriveBy [/'..cfg.main.typedb..' '..cfg.main.db..']', imgui.ImVec2(330, 25)) then
		imgui.OpenPopup(u8'DriveBy')		
end
			if imgui.BeginPopupModal(u8'DriveBy', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
				imgui.Text(u8"Укажите команду для выдачи наказания (без /):")
							imgui.PushItemWidth(90) 
							imgui.SameLine()
			imgui.InputText(u8"##12445555443", buffer92) 
			cfg.main.typedb = string.format('%s', tostring(buffer92.v)) 
			imgui.PopItemWidth()
						imgui.Text(u8'Укажите срок наказания за данное нарушение:') 
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsqewedjasdadsj"), buffer4)
			cfg.main.db = string.format('%s', tostring(buffer4.v)) 
			imgui.PopItemWidth()
			if buffer4.v <= 0 then
				buffer4.v = 0
			elseif buffer4.v >= 1001 then
				buffer4.v = 1000
			end
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
imgui.SameLine()
if imgui.Button(u8'DriveBy ковшом [/'..cfg.main.typedbk..' '..cfg.main.dbk..']', imgui.ImVec2(330, 25)) then
			imgui.OpenPopup(u8'DriveBy ковшом')		
end
			if imgui.BeginPopupModal(u8'DriveBy ковшом', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
				imgui.Text(u8"Укажите команду для выдачи наказания (без /):")
							imgui.PushItemWidth(90) 
							imgui.SameLine()
			imgui.InputText(u8"##12445555335443", buffer93) 
			cfg.main.typedbk = string.format('%s', tostring(buffer93.v)) 
			imgui.PopItemWidth()
						imgui.Text(u8'Укажите срок наказания за данное нарушение:') 
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjasdadqsj"), buffer6)
			cfg.main.dbk = string.format('%s', tostring(buffer6.v)) 
			imgui.PopItemWidth()
			if buffer6.v <= 0 then
				buffer6.v = 0
			elseif buffer6.v >= 1001 then
				buffer6.v = 1000
			end
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
imgui.Button(u8'Сбив анимации [warn]', imgui.ImVec2(330, 25))
imgui.SameLine()
if imgui.Button(u8'Упоминание родни [/'..cfg.main.typeupom..' '..cfg.main.upomrod..']', imgui.ImVec2(330, 25)) then
			imgui.OpenPopup(u8'Упоминание родни')		
end
			if imgui.BeginPopupModal(u8'Упоминание родни', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
				imgui.Text(u8"Укажите команду для выдачи наказания (без /):")
							imgui.PushItemWidth(90) 
							imgui.SameLine()
			imgui.InputText(u8"##6666", buffer96) 
			cfg.main.typeupom = string.format('%s', tostring(buffer96.v)) 
			imgui.PopItemWidth()
						imgui.Text(u8'Укажите срок наказания за данное нарушение:') 
			imgui.SameLine()
						imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjacvbsdadsj"), buffer7)
			cfg.main.upomrod = string.format('%s', tostring(buffer7.v)) 
			imgui.PopItemWidth()
			if buffer7.v <= 0 then
				buffer7.v = 0
			elseif buffer7.v >= 301 then
				buffer7.v = 300
			end
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
if imgui.Button(u8'Оскорбление родни [/'..cfg.main.typeosk..' '..cfg.main.oskrod..']', imgui.ImVec2(330, 25)) then
imgui.OpenPopup(u8'Оскорбление родни')				
end
			if imgui.BeginPopupModal(u8'Оскорбление родни', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
				imgui.Text(u8"Укажите команду для выдачи наказания (без /):")
							imgui.PushItemWidth(90) 
							imgui.SameLine()
			imgui.InputText(u8"##66667", buffer97) 
			cfg.main.typeosk = string.format('%s', tostring(buffer97.v)) 
			imgui.PopItemWidth()
						imgui.Text(u8'Укажите срок наказания за данное нарушение:') 
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjqweasdadsj"), buffer5)
			cfg.main.oskrod = string.format('%s', tostring(buffer5.v)) 
			imgui.PopItemWidth()
			if buffer5.v <= 0 then
				buffer5.v = 0
			elseif buffer5.v >= 301 then
				buffer5.v = 300
			end
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
imgui.SameLine()
if imgui.Button(u8'Неадекватное поведение [/'..cfg.main.typenead..' '..cfg.main.nead..']', imgui.ImVec2(330, 25)) then
		imgui.OpenPopup(u8'Неадекватное поведение')	
end
			if imgui.BeginPopupModal(u8'Неадекватное поведение', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
				imgui.Text(u8"Укажите команду для выдачи наказания (без /):")
							imgui.PushItemWidth(90) 
							imgui.SameLine()
			imgui.InputText(u8"##666677", buffer98) 
			cfg.main.typenead = string.format('%s', tostring(buffer98.v)) 
			imgui.PopItemWidth()
						imgui.Text(u8'Укажите срок наказания за данное нарушение:') 
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjaasdsdadsj"), buffer11)
			cfg.main.nead = string.format('%s', tostring(buffer11.v)) 
			imgui.PopItemWidth()
			if buffer11.v <= 0 then
				buffer11.v = 0
			elseif buffer11.v >= 301 then
				buffer11.v = 300
			end
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
if imgui.Button(u8'NonRolePlay тюнинг [/'..cfg.main.typentune..' '..cfg.main.ntune..']', imgui.ImVec2(330, 25)) then
imgui.OpenPopup(u8'NonRolePlay тюнинг')			
end
			if imgui.BeginPopupModal(u8'NonRolePlay тюнинг', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
				imgui.Text(u8"Укажите команду для выдачи наказания (без /):")
							imgui.PushItemWidth(90) 
							imgui.SameLine()
			imgui.InputText(u8"##6666776", buffer99) 
			cfg.main.typentune = string.format('%s', tostring(buffer99.v)) 
			imgui.PopItemWidth()
						imgui.Text(u8'Укажите срок наказания за данное нарушение:') 
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjaqewsdadsj"), buffer10)
			cfg.main.ntune = string.format('%s', tostring(buffer10.v)) 
			imgui.PopItemWidth()
			if buffer10.v <= 0 then
				buffer10.v = 0
			elseif buffer10.v >= 1001 then
				buffer10.v = 1000
			end
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
imgui.SameLine()
if imgui.Button(u8'Использование запрещенных программ [/'..cfg.main.typecheat..' '..cfg.main.cheat..']', imgui.ImVec2(330, 25)) then
imgui.OpenPopup(u8'Использование запрещенных программ')		
end
			if imgui.BeginPopupModal(u8'Использование запрещенных программ', MainWindow,  imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
				imgui.Text(u8"Укажите команду для выдачи наказания (без /):")
							imgui.PushItemWidth(90) 
							imgui.SameLine()
			imgui.InputText(u8"##66667766",buffer100) 
			cfg.main.typecheat = string.format('%s', tostring(buffer100.v)) 
			imgui.PopItemWidth()
						imgui.Text(u8'Укажите срок наказания за данное нарушение:') 
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjqewasdadsj"), buffer9)
			cfg.main.cheat = string.format('%s', tostring(buffer9.v)) 
			imgui.PopItemWidth()
			if buffer9.v <= 0 then
				buffer9.v = 0
			elseif buffer9.v >= 3001 then
				buffer9.v = 3000
			end 
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
if imgui.Button(u8'NonRolePlay полицейский [/'..cfg.main.typencop..' '..cfg.main.ncop..']', imgui.ImVec2(330, 25)) then
imgui.OpenPopup(u8'NonRolePlay полицейский')					
end
			if imgui.BeginPopupModal(u8'NonRolePlay полицейский', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
				imgui.Text(u8"Укажите команду для выдачи наказания (без /):")
							imgui.PushItemWidth(90) 
							imgui.SameLine()
			imgui.InputText(u8"##6666776667", buffer101) 
			cfg.main.typencop = string.format('%s', tostring(buffer101.v)) 
			imgui.PopItemWidth()
						imgui.Text(u8'Укажите срок наказания за данное нарушение:') 
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjasdadjhsj"), buffer8)
			cfg.main.ncop = string.format('%s', tostring(buffer8.v)) 
			imgui.PopItemWidth()
			if buffer8.v <= 0 then
				buffer8.v = 0
			elseif buffer8.v >= 1001 then
				buffer8.v = 1000
			end
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
imgui.SameLine()
if imgui.Button(u8'Оскорбление администрации [/'..cfg.main.typeoskadm..' '..cfg.main.oskadm..']', imgui.ImVec2(330, 25)) then
imgui.OpenPopup(u8'Оскорбление администрации')				
end
			if imgui.BeginPopupModal(u8'Оскорбление администрации', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
				imgui.Text(u8"Укажите команду для выдачи наказания (без /):")
							imgui.PushItemWidth(90) 
							imgui.SameLine()
			imgui.InputText(u8"##66667766676", buffer102) 
			cfg.main.typeoskadm = string.format('%s', tostring(buffer102.v)) 
			imgui.PopItemWidth()
						imgui.Text(u8'Укажите срок наказания за данное нарушение:') 
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adasdasasdsjadsj"), buffer12)
			cfg.main.oskadm = string.format('%s', tostring(buffer12.v)) 
			imgui.PopItemWidth()
			if buffer12.v <= 0 then
				buffer12.v = 0
			elseif buffer12.v >= 301 then
				buffer12.v = 300
			end
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
if imgui.Button(u8'Сбив анимации стрельбы (+С) [warn]', imgui.ImVec2(330, 25)) then
			
end
imgui.SameLine()
if imgui.Button(u8'Массовый DeathMatch [/'..cfg.main.typemdm..' '..cfg.main.mdm..']', imgui.ImVec2(330, 25)) then
			imgui.OpenPopup(u8'Массовый DeathMatch')
end
			if imgui.BeginPopupModal(u8'Массовый DeathMatch', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
				imgui.Text(u8"Укажите команду для выдачи наказания (без /):")
							imgui.PushItemWidth(90) 
							imgui.SameLine()
			imgui.InputText(u8"##666677666766", buffer103) 
			cfg.main.typemdm = string.format('%s', tostring(buffer103.v)) 
			imgui.PopItemWidth()
						imgui.Text(u8'Укажите срок наказания за данное нарушение:') 
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt(u8("##adsjadadsdaeqwadsj"), buffer13)
			cfg.main.mdm = string.format('%s', tostring(buffer13.v)) 
			imgui.PopItemWidth()
			if buffer13.v <= 0 then
				buffer13.v = 1
			elseif buffer13.v >= 300 then
				buffer13.v = 300
			end
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
if imgui.Button(u8'SpawnKill [warn]', imgui.ImVec2(330, 25)) then
			
end
imgui.SameLine()
if imgui.Button(u8'TeamKill [warn]', imgui.ImVec2(330, 25)) then
			
end
imgui.Separator()
	imgui.PushFont(fs16)
	imgui.CenterTextColoredRGB('{A77CD0}Прочее')
	imgui.PopFont()
			imgui.Text(u8"/desc [ID] - удалить описание персонажа") 

			imgui.EndChild() 	
		end
		if menusel.v == 2 then
			imgui.BeginChild("Childdw1", imgui.ImVec2(-1, -1), true) 
			imgui.Text(fa.ICON_FA_COFFEE..u8' Стиль интерфейса:')    
			imgui.SameLine()	
			imgui.PushItemWidth(120)
			imgui.Combo('##1',result,colours, #colours) 
			imgui.PopItemWidth()
			if result.v == 0 then 
				cfg.main.theme = 'pink' pinkTheme()
			elseif result.v == 1 then 
				cfg.main.theme = 'darkgreen' DarkGreen()
			elseif result.v == 2 then 
				cfg.main.theme = 'red' Red()
			elseif result.v == 3 then 
				cfg.main.theme = 'purple' Purple()
			elseif result.v == 4 then 
				cfg.main.theme = 'dark' Dark()
			elseif result.v == 5 then 
				cfg.main.theme = 'White' White()
			end
			imgui.Text(u8'Закругление интерфейса:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				imgui.InputInt(u8("##adsjaxsss213123123123dsas11dadsj"), buffer74)
				cfg.main.rounding = string.format('%s', tostring(buffer74.v)) 
				imgui.PopItemWidth()
				if buffer74.v <= 0 then
					buffer74.v = 0
				elseif buffer74.v >= 25 then
					buffer74.v = 25
				end
			imgui.Text(u8'Закругление кнопок:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				imgui.InputInt(u8("##adsjaxsss2131233123123123dsas11dadsj"), buffer75)
				cfg.main.buttonrounding = string.format('%s', tostring(buffer75.v)) 
				imgui.PopItemWidth()
				if buffer75.v <= 0 then
					buffer75.v = 0
				elseif buffer75.v >= 18 then
					buffer75.v = 18
				end
			imgui.Separator()
			kotofeev()
			imgui.EndChild() 		
		end
		if menusel.v == 4 then
			imgui.BeginChild("Chil12312132132ddw1", imgui.ImVec2(-1, -1), true) 
			imadd.HotKey('##adsads', fopenpunish, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Открыть меню выдачи наказаний')
			if imgui.ToggleButton(u8'Автоматическая выдача разбана', imgui.ImBool(cfg.main.autounban)) then 
				cfg.main.autounban = not cfg.main.autounban 
			end 
			imgui.Text(u8'Укажите задержку между выдачей форм:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
			imgui.InputInt("##adsjasdaxdsadsj", timeout)
			if timeout.v <= 500 then
				timeout.v = 200
			elseif timeout.v >= 15000 then
				timeout.v = 15000
			end
			imgui.PopItemWidth()
			imgui.SameLine()
			imgui.Text(u8'милисек.')
			imgui.Text(u8'Укажите готовые формы:')
			imgui.InputTextMultiline("##inp", text_buffer1, imgui.ImVec2(-1, 375))
			if imgui.Button(u8("Запустить выдачу форм"), imgui.ImVec2(-1, 25)) then
			givepun = true
			lua_thread.create(function ()
				for asdsa in text_buffer1.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(asdsa))
					wait(tonumber(timeout.v))
					formsall = formsall + 1
				end
			givepun = false
			sampAddChatMessage(tag..'Выдача форм окончена, выдано форм всего: {E78284}'..formsall, -1)
			formsall = 0
			end)
			end
			imgui.EndChild() 		
		end
		if menusel.v == 5 then
			imgui.BeginChild("Chil1231213213123213123123132ddw1", imgui.ImVec2(-1, -1), true) 
			
			if imgui.ToggleButton(u8'Переход слежки на << >>', imgui.ImBool(cfg.main.perehodik)) then 
				cfg.main.perehodik = not cfg.main.perehodik 
			end 
			if imgui.ToggleButton(u8'Слап вверх/вниз на /\\ и \\/', imgui.ImBool(cfg.main.slapinrecon)) then 
				cfg.main.slapinrecon = not cfg.main.slapinrecon 
			end 
			if imgui.ToggleButton(u8'Панель взаимодействия с игроком', imgui.ImBool(cfg.main.menurecon1)) then
				cfg.main.menurecon1 = not cfg.main.menurecon1
			end
			if imgui.ToggleButton(u8'Панель быстрой выдачи наказаний', imgui.ImBool(cfg.main.menurecon)) then
				cfg.main.menurecon = not cfg.main.menurecon
			end
			imgui.Text(u8'Местоположение панели взаимодействия с игроком:')
			imgui.SameLine()
			if imgui.Button(fa.ICON_FA_ARROWS_ALT..u8'##panelvzaim') then
			if ReconWindow.v then
			ChangePosWindowTwo.v = true
			else
			sampAddChatMessage(tag..'Зайдите в рекон для получения возможности изменения данного параметра.', -1)
			end
			end
			imgui.Text(u8'Местоположение панели очереди слежки:')
			imgui.SameLine()
			if imgui.Button(fa.ICON_FA_ARROWS_ALT..u8'##ocheredslezhka') then
			if reconusers_state.v then
			ChangePosWindowFour.v = true
			else
			sampAddChatMessage(tag..'Для изменения данного параметра у вас должна быть открыта панель очереди слежки.', -1)
			end
			end
			imgui.Text(u8'Местоположение панели быстрой выдачи наказание:')
			imgui.SameLine()
			if imgui.Button(fa.ICON_FA_ARROWS_ALT..u8'##saddsaejjadd') then
				if PunishWindow.v then
					--changePositionRecon = true
					ChangePosWindowEight.v = true
					--MainWindow.v = false
					--sampAddChatMessage(tag..'Для подтверждения изменения нажмите НЕЕЕ 1, чтобы отменить сохранение - 2.', -1)
				else
					sampAddChatMessage(tag..'Зайдите в рекон для получения возможности изменения данного параметра.', -1)
				end
			end
			imgui.Text(u8'Местоположение информационной панели:')
			imgui.SameLine()
			if imgui.Button(fa.ICON_FA_ARROWS_ALT..u8'##infaslezhka') then
			if InfoWindow.v then
			ChangePosWindowFive.v = true
			else
			sampAddChatMessage(tag..'Для изменения данного параметра у вас должна быть включена информационная панель.', -1)
			end
			end
			imgui.Separator()
			imgui.EndChild() 		
		end
		if menusel.v == 10 then
			imgui.SameLine()
			imgui.BeginChild("ChildWindow12", imgui.ImVec2(-1, -1), true)
				imgui.Text(u8'Тэги:')
	imgui.Text(u8'{id_rep} - ID с репорта')
	imgui.Text(u8'{nick_rep} - NICK с репорта без нижнего подчеркивания')
	imgui.Text(u8'{my_id} - собственный ID')
	imgui.Text(u8'{my_name} - собственный NICK')
	imgui.Separator()
	imgui.Text(u8'Слежу за наруш:')
	imgui.SameLine()
	imgui.PushItemWidth(456)
	if imgui.InputText('##SlezhkaNarush', reason_settings_report[4]) then 
		cfg.main.slezhka_narush = tostring(u8:decode(reason_settings_report[4].v))
	end
	imgui.PopItemWidth()
	imgui.SameLine()
	imadd.HotKey('##lasddnbtreport', fspecrep, {}, 100)
	if #reason_settings_report[4].v == 0 then
		imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.65, 0.20, 0.20, 1.00))
		imgui.PopStyleColor()
	end
	imgui.VoidText(reason_settings_report[4].v, 'Поле не должно быть пустое!')
		imgui.Text(u8'Помочь автору:')
	imgui.SameLine()
	imgui.PushItemWidth(464)
	if imgui.InputText('##SlezhkaAuthor', reason_settings_report[2]) then 
		cfg.main.slezhka_author = string.format('%s', tostring(u8:decode(reason_settings_report[2].v)))
	end
	imgui.PopItemWidth()
	imgui.SameLine()
	imadd.HotKey('##lasddnbtrephhhhort', fspecauthor, {}, 100)
	if #reason_settings_report[2].v == 0 then
		imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.65, 0.20, 0.20, 1.00))
		imgui.PopStyleColor()
	end
	imgui.VoidText(reason_settings_report[2].v, 'Поле не должно быть пустое!')
		imgui.Text(u8'Передал реп. адм:')
	imgui.SameLine()
	imgui.PushItemWidth(445)
	if imgui.InputText('##PereslatA', reason_settings_report[9]) then 
		cfg.main.pereslat_adm = tostring(u8:decode(reason_settings_report[9].v))
	end
	imgui.PopItemWidth()
		imgui.SameLine()
	imadd.HotKey('##lasddnbtrephzzzzzzzzzzzzzzzhhhort', fperedam, {}, 100)
	if #reason_settings_report[9].v == 0 then
		imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.65, 0.20, 0.20, 1.00))
		imgui.PopStyleColor()
	end
	imgui.VoidText(reason_settings_report[9].v, 'Поле не должно быть пустое!')
	imgui.Separator()
	imgui.Text(u8'Выдать игроку НРГ:')
	imgui.SameLine()
	imgui.PushItemWidth(-1)
	if imgui.InputText('##GiveNRG', reason_settings_report[1]) then 
		cfg.main.give_nrg_report = tostring(u8:decode(reason_settings_report[1].v))
	end
	imgui.PopItemWidth()
	if #reason_settings_report[1].v == 0 then
		imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.65, 0.20, 0.20, 1.00))
		imgui.PopStyleColor()
	end
	imgui.VoidText(reason_settings_report[1].v, 'Поле не должно быть пустое!')
	imgui.Text(u8'Выдать лицензии:')
	imgui.SameLine()
	imgui.PushItemWidth(-1)
	if imgui.InputText('##GiveLicense', reason_settings_report[5]) then 
		cfg.main.give_license = tostring(u8:decode(reason_settings_report[5].v))
	end
	imgui.PopItemWidth()
	if #reason_settings_report[5].v == 0 then
		imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.65, 0.20, 0.20, 1.00))
		imgui.PopStyleColor()
	end
	imgui.VoidText(reason_settings_report[5].v, 'Поле не должно быть пустое!')
	imgui.Text(u8'Заспавнить:')
	imgui.SameLine()
	imgui.PushItemWidth(-1)
	if imgui.InputText('##SpawnPlayer', reason_settings_report[6]) then 
		cfg.main.spawn_player = tostring(u8:decode(reason_settings_report[6].v))
	end
	imgui.PopItemWidth()
	if #reason_settings_report[6].v == 0 then
		imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.65, 0.20, 0.20, 1.00))
		imgui.PopStyleColor()
	end
	imgui.VoidText(reason_settings_report[6].v, 'Поле не должно быть пустое!')
	imgui.Text(u8'Выдать ХП:')
	imgui.SameLine()
	imgui.PushItemWidth(-1)
	if imgui.InputText('##HealthPlayer', reason_settings_report[7]) then 
		cfg.main.health_player = tostring(u8:decode(reason_settings_report[7].v))
	end
	imgui.PopItemWidth()
	if #reason_settings_report[7].v == 0 then
		imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.65, 0.20, 0.20, 1.00))
		imgui.PopStyleColor()
	end
	imgui.VoidText(reason_settings_report[7].v, 'Поле не должно быть пустое!')
	imgui.Separator()
	if imgui.Button(u8("Добавить кнопку ответа в репорт"), imgui.ImVec2(-1, 25)) then
		inputreportaddname.v = ""
		inputreportaddotvet.v = ""
		comboStylereport.v = 1
		retpor_text_edit = false
		imgui.OpenPopup(u8("Добавление кнопки"))
	end
			imgui.Separator()

			viborreps = {
				"Моментально",
				"С помощью кнопки ОТПРАВИТЬ"
			}

			for ui, op in pairs(cfg.reportname) do
				imgui.Text(u8("Кнопка: " .. cfg.reportname[ui]))

				imgui.SameLine()

				if imgui.Button(fa.ICON_FA_TRASH .. u8("##" .. ui), imgui.ImVec2(30, 20)) then
					table.remove(cfg.reportname, ui)
					table.remove(cfg.reportotvet, ui)
					table.remove(cfg.reportstyle, ui)
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
				end

				if cfg.reportotvet[ui] then
					imgui.Text(u8("Ответ: " .. cfg.reportotvet[ui]))
					imgui.Text(u8("Отправка: " .. viborreps[tonumber(cfg.reportstyle[ui]) + 1]))
					imgui.Separator()
				end
			end

			if imgui.BeginPopupModal(u8("Добавление кнопки"), _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
				imgui.Text(u8("Отправлять репорт: "))
				imgui.SameLine()
				imgui.PushItemWidth(260)

				if imgui.Combo(u8("##viborf"), comboStylereport, {
					u8("Моментально"),
					u8("Только с помощью кнопки ОТПРАВИТЬ")
				}) then
					comboStylereport.v = comboStylereport.v
				end

				imgui.PopItemWidth()
				imgui.Separator()
				imgui.PushItemWidth(200)
				imgui.InputText("##rfsdfs", inputreportaddname)
				imgui.SameLine()
				imgui.Text(u8("Название кнопки"))
				imgui.Separator()
				imgui.InputText("##rfsdfsr", inputreportaddotvet)
				imgui.SameLine()
				imgui.Text(u8("Ответ по нажатию кнопки"))
				imgui.Separator()
				imgui.PopItemWidth()

				if retpor_text_edit then
					if imgui.Button(u8("Изменить"), imgui.ImVec2(400, 20)) then
						if inputreportaddname.v == "" or inputreportaddname.v == nil or inputreportaddotvet.v == nil or inputreportaddotvet.v == "" then
							imgui.PushStyleColor(imgui.Col.Text, imgui.ImColor(253, 65, 63, 255):GetVec4())
							sampAddChatMessage("[Ошибка] Заполните все пункты!", 15352900)
							imgui.PopStyleColor()
						else
							cfg.reportname[retpor_text_edit] = u8:decode(inputreportaddname.v)
							cfg.reportotvet[retpor_text_edit] = u8:decode(inputreportaddotvet.v)
							cfg.reportstyle[retpor_text_edit] = comboStylereport.v

							sampAddChatMessage("Вы успешно отредактировали кнопку \"" .. u8:decode(inputreportaddname.v) .. "\"", 15352900)

							inputreportaddname.v = ""
							inputreportaddotvet.v = ""
							comboStylereport.v = 1
							retpor_text_edit = false

							imgui.CloseCurrentPopup()
						end
					end
				elseif imgui.Button(u8("Добавить"), imgui.ImVec2(400, 20)) then
					if inputreportaddname.v == "" or inputreportaddname.v == nil or inputreportaddotvet.v == nil or inputreportaddotvet.v == "" then
						imgui.PushStyleColor(imgui.Col.Text, imgui.ImColor(253, 65, 63, 255):GetVec4())
						sampAddChatMessage("[Ошибка] Заполните все пункты!", 15352900)
						imgui.PopStyleColor()
					else
						table.insert(cfg.reportname, u8:decode(inputreportaddname.v))
						table.insert(cfg.reportotvet, u8:decode(inputreportaddotvet.v))
						table.insert(cfg.reportstyle, comboStylereport.v)
						inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
						sampAddChatMessage("Вы успешно добавили кнопку \"" .. u8:decode(inputreportaddname.v) .. "\"", 15352900)

						inputreportaddname.v = ""
						inputreportaddotvet.v = ""
						comboStylereport.v = 1
						retpor_text_edit = false

						imgui.CloseCurrentPopup()
					end
				end

				if imgui.Button(u8("Закрыть"), imgui.ImVec2(400, 20)) then
					imgui.CloseCurrentPopup()
				end

				imgui.EndPopup()
			end
			imgui.EndChild()		
		end
		if menusel.v == 3 then
			imgui.BeginChild("ChildWindow13", imgui.ImVec2(-1, -1), true)
			kotofeev3()
			imgui.EndChild()		
		end
		if menusel.v == 9 then
			imgui.BeginChild("ChildWindow15", imgui.ImVec2(-1, -1), true)
			imgui.Text(u8'Бинд принятия:')
			imgui.SameLine()
			imadd.HotKey('##123123123', facceptform, {}, 100)
			imgui.SameLine()
			imgui.Text(fa.ICON_FA_QUESTION_CIRCLE..u8'')
			imgui.Hint('bindformi', u8'Кнопка принятия формы из админ-чата')
			if imgui.ToggleButton(u8'Оповещение в админ чат по принятию формы', imgui.ImBool(cfg.main.formaplus)) then 
				cfg.main.formaplus = not cfg.main.formaplus
			end 
			imgui.Separator()
			imgui.CenterText(fa.ICON_FA_BELL..u8' Звуковое оповещение '..fa.ICON_FA_BELL)
			imgui.NewLine()
			if imgui.ToggleButton(u8'Звуковое оповещение при получении форм', imgui.ImBool(cfg.main.formbell)) then 
				cfg.main.formbell = not cfg.main.formbell 
			end 
			imgui.Text(u8'Название звукового файла:')
			imgui.SameLine()
			imgui.PushItemWidth(100) 
			imgui.InputText(u8"##1", nameaudio) 
			cfg.main.nameaudioforform = string.format('%s', tostring(nameaudio.v)) 
			imgui.PopItemWidth()
			imgui.Text(u8'Громкость оповещения:')
			imgui.SameLine()
			imgui.PushItemWidth(100) 
			imgui.SliderInt("##sadjsad", volume, 0, 100)
			imgui.PopItemWidth()
			cfg.main.volume = volume.v
			kotofeevformi()
			imgui.EndChild()	
		end
		if menusel.v == 11 then
			imgui.BeginChild("ChildWindow16", imgui.ImVec2(-1, -1), true)
			imgui.CustomBarLogs()
			kotofeevautoopra()
			imgui.EndChild()		
		end
		if menusel.v == 7 then
			imgui.BeginChild("ChildWindow17", imgui.ImVec2(-1, -1), true)
			SettingsKill()
			imgui.EndChild()		
		end
		if menusel.v == 13 then
			imgui.BeginChild("ChildWindow7", imgui.ImVec2(-1, -1), true) 
			imgui.PushFont(fs20)
			imgui.CenterTextColoredRGB('Owner scripts:')
			imgui.PopFont()
			imgui.PushFont(fs80)
			imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize('SASHA GOZHELNIKOV').x) / 2)
			imgui.TextColored(imgui.ImVec4(rainbowtext(4)), 'SASHA GOZHELNIKOV')
			imgui.PopFont()
			imgui.PushFont(fs16)
			imgui.CenterTextColoredRGB('Реализовано для проекта:')
			imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize('Arizona Arena').x) / 2 - 65)
			imgui.TextColored(imgui.ImVec4(rainbowtext(4)), 'Arizona Arena | vk.com/arp_666')
			imgui.PopFont()
			imgui.PushFont(fs16)
			--imgui.CenterTextColoredRGB('Семейное фото:')
			imgui.PopFont()
			imgui.Image(textureImgForAuthor, imgui.ImVec2(670, 335)) 
			imgui.EndChild() 		
		end
		if menusel.v == 6 then
			imgui.BeginChild("ChildWindow712", imgui.ImVec2(-1, -1), true) 
			if imgui.Button(u8'Входы', imgui.ImVec2(131, 40)) then
				checker_selected.v = 1
			end
			imgui.SameLine()
			if imgui.Button(u8'Админы', imgui.ImVec2(131, 40)) then
				checker_selected.v = 2
			end
			imgui.SameLine()
			if imgui.Button(u8'Игроки', imgui.ImVec2(131, 40)) then
				checker_selected.v = 3
			end
			imgui.SameLine()
			if imgui.Button(u8'Регистрации', imgui.ImVec2(131, 40)) then
				checker_selected.v = 4
			end
			imgui.SameLine()
			if imgui.Button(u8'Выходы', imgui.ImVec2(131, 40)) then
				checker_selected.v = 5
			end
			imgui.Separator()
			if checker_selected.v == 1 then
			imgui.PushFont(fs16)
			imgui.CenterTextColoredRGB('{E3C47F}Чекер входов')
			imgui.PopFont()
			if imgui.ToggleButton(u8'Включить чекер подключений', imgui.ImBool(cfg.main.connectChecker)) then 
				cfg.main.connectChecker = not cfg.main.connectChecker 
			end 
			imgui.Text(u8'Размер шрифта:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##asdsadjrejasd"), ConnectBufferSize) then
					cfg.main.connectSize = string.format('%s', tostring(ConnectBufferSize.v))
					connect = renderCreateFont(cfg.main.QuitFontChecker, cfg.main.connectSize, cfg.main.connectStyle, FCR_BOLD + FCR_BORDER)			
				end
				imgui.PopItemWidth()
				if ConnectBufferSize.v <= 6 then
					ConnectBufferSize.v = 6
				elseif ConnectBufferSize.v >= 35 then
					ConnectBufferSize.v = 35
				end
				imgui.Text(u8'Стиль шрифта:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##asfdjsdjdsaaw"), LeaveBufferStyle) then
					cfg.main.connectStyle = string.format('%s', tostring(LeaveBufferStyle.v))
					connect = renderCreateFont(cfg.main.QuitFontChecker, cfg.main.connectSize, cfg.main.connectStyle, FCR_BOLD + FCR_BORDER)			
				end
				imgui.PopItemWidth()
				if LeaveBufferStyle.v < 0 then
					LeaveBufferStyle.v = 0
				end
				imgui.Text(u8'Шрифт чекера:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputText('##ConnectFontChecker', ConnectFontChecker) then 
					cfg.main.ConnectFontChecker = string.format('%s', tostring(ConnectFontChecker.v)) 
					connect = renderCreateFont(cfg.main.ConnectFontChecker, cfg.main.connectSize, cfg.main.connectStyle, FCR_BOLD + FCR_BORDER)		
				end 
				imgui.PopItemWidth()
				imgui.Text(u8'Отступ между строками:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##connectIndent"), ConnectBufferOffset) then
					cfg.main.connectIndent = string.format('%s', tostring(ConnectBufferOffset.v))
					connect = renderCreateFont(cfg.main.ConnectFontChecker, cfg.main.connectSize, cfg.main.connectStyle, FCR_BOLD + FCR_BORDER)			
				end
				imgui.PopItemWidth()
				if ConnectBufferOffset.v <= 0 then
					ConnectBufferOffset.v = 0
				elseif ConnectBufferOffset.v >= 50 then
					ConnectBufferOffset.v = 50
				end
				imgui.Text(u8'Максимум строк:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##connectLines"), ConnectBufferLines) then
					cfg.main.connectLines = string.format('%s', tostring(ConnectBufferLines.v))
					leave = renderCreateFont(cfg.main.ConnectFontChecker, cfg.main.leaveSize, cfg.main.leaveStyle, FCR_BOLD + FCR_BORDER)			
				end
				imgui.PopItemWidth()
				if ConnectBufferLines.v <= 1 then
					ConnectBufferLines.v = 1
				elseif ConnectBufferLines.v >= 15 then
					ConnectBufferLines.v = 15
				end
				imgui.Text(u8'Положение текста:')
				imgui.SameLine()
				if imgui.BoolButton(cfg.main.alignthree == 1, fa.ICON_FA_ALIGN_LEFT, imgui.ImVec2(38, 20)) then
					cfg.main.alignthree = 1
				end
				imgui.Hint('left', u8'По левому краю')
				imgui.SameLine()
				if imgui.BoolButton(cfg.main.alignthree == 2, fa.ICON_FA_ALIGN_CENTER, imgui.ImVec2(38, 20)) then
					cfg.main.alignthree = 2
				end
				imgui.Hint('centre', u8'По центру')
				imgui.SameLine()
				if imgui.BoolButton(cfg.main.alignthree == 3, fa.ICON_FA_ALIGN_RIGHT, imgui.ImVec2(38, 20)) then
					cfg.main.alignthree = 3
				end
				imgui.Hint('right', u8'По правому краю')
				imgui.Text(u8'Местоположение:')
				imgui.SameLine()
				if imgui.Button(fa.ICON_FA_ARROWS_ALT..u8'') then 
				if not editPosition2 then 
					sampAddChatMessage(tag..'Используйте {E78284}ЛКМ {84A6E7}для сохранения позиции чекера.', -1)
					local lastX, lastY = cfg.connectPosition.x, cfg.connectPosition.y
					local open = cfg.main.connectChecker
					editPosition2 = true 
					cfg.main.connectChecker = true 
					MainWindow.v = false
					lua_thread.create(function()
						while editPosition2 do wait(0)
						sampSetCursorMode(CMODE_LOCKCAM)
							local x, y = getCursorPos()
							cfg.connectPosition.x, cfg.connectPosition.y = x, y
							if isKeyDown(VK_LBUTTON) then 
								sampAddChatMessage(tag..'Позиция чекера успешно сохранена.', -1)
								inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
								cfg.main.connectChecker = open 
								editPosition2 = false 
								sampToggleCursor(false)
								break 
							end
						end
					end)
				else 
					sampAddChatMessage("Для начала завершите прошедшее редактирование.", -1)
				end 
				end
			elseif checker_selected.v == 2 then
			imgui.PushFont(fs16)
			imgui.CenterTextColoredRGB('{E3C47F}Чекер администрации')
			imgui.PopFont()

			







			if imgui.ToggleButton(u8'Включить чекер', imgui.ImBool(cfg.main.adminsChecker)) then 
				cfg.main.adminsChecker = not cfg.main.adminsChecker 
			end 
			--imadd.HotKey('##fadminchecker', fchecker, {}, 100)
			--imgui.SameLine()
			--imgui.Text(u8'Включить/выключить чекер')
			if imgui.ToggleButton(u8'Отображать AFK в чекере', imgui.ImBool(cfg.main.adminsafkinchecker)) then 
				cfg.main.adminsafkinchecker = not cfg.main.adminsafkinchecker 
			end 
			imgui.Text(u8'Местоположение:')
			imgui.SameLine()
			if imgui.Button(fa.ICON_FA_ARROWS_ALT..u8"") then
			if not editPosition then 
					sampAddChatMessage(tag..'Используйте {E78284}ЛКМ {84A6E7}для сохранения позиции чекера.', -1)
					local lastX, lastY = cfg.adminscheckerPosition.x, cfg.adminscheckerPosition.y
					local open = cfg.main.adminsChecker
					editPosition = true 
					cfg.main.adminsChecker = true 
					MainWindow.v = false
					lua_thread.create(function()
						while editPosition do wait(0)
						sampSetCursorMode(CMODE_LOCKCAM)
							local x, y = getCursorPos()
							cfg.adminscheckerPosition.x, cfg.adminscheckerPosition.y = x, y
							if isKeyDown(VK_LBUTTON) then 
								sampAddChatMessage(tag..'Позиция чекера успешно сохранена.', -1)
								for k,v in pairs(adminsJ_) do 
									if doesFileExist(getWorkingDirectory().."\\AdminToolsKing\\"..adminsJ_[k][2]..".json") then 
										local f = io.open(getWorkingDirectory().."\\AdminToolsKing\\"..adminsJ_[k][2]..".json", "w+") 
										if f then 
											f:write(encodeJson(adminsJ_[k][1])):close()
										end 
									end 
								end 
								inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
								cfg.main.adminsChecker = open 
								editPosition = false 
								sampToggleCursor(false)
							  
								break 
							end
						end
					end)
				else 
					sampAddChatMessage("Для начала завершите прошедшее редактирование.", -1)
				end
			end
			imgui.Separator()
			imgui.CenterTextColoredRGB('{fe4e4e}Настройки стиля чекера')
			if imgui.ColorEdit3(u8'Стандартный цвет ников', adminsstockcolorchecker, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
				adminsstock_colorchecker()
			end
			imgui.Text(u8'Шрифт чекера:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
			if imgui.InputText('##adminsfontchecker', adminsfontchecker) then 
				cfg.main.adminsfontchecker = string.format('%s', tostring(adminsfontchecker.v)) 
				fonts456 = { 
					adminsChecker = renderCreateFont(cfg.main.adminsfontchecker, cfg.main.adminssizechecker, cfg.main.adminsstylechecker, FCR_BOLD + FCR_SHADOW)
				}
			end 
			imgui.PopItemWidth()
			imgui.Text(u8'Размер шрифта:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
			if imgui.InputInt(u8("##ssswssasss"), adminsBufferSize) then
				cfg.main.adminssizechecker = string.format('%s', tostring(adminsBufferSize.v))
				fonts456 = { 
					adminsChecker = renderCreateFont(cfg.main.adminsfontchecker, cfg.main.adminssizechecker, cfg.main.adminsstylechecker, FCR_BOLD + FCR_SHADOW)
				}				
			end
			imgui.PopItemWidth()
			if adminsBufferSize.v <= 6 then
				adminsBufferSize.v = 6
			elseif adminsBufferSize.v >= 35 then
				adminsBufferSize.v = 35
			end
			imgui.Text(u8'Стиль шрифта:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
			if imgui.InputInt(u8("##ssswqswqssasss"), adminsBufferStyle) then
				cfg.main.adminsstylechecker = string.format('%s', tostring(adminsBufferStyle.v))
				fonts456 = { 
					adminsChecker = renderCreateFont(cfg.main.adminsfontchecker, cfg.main.adminssizechecker, cfg.main.adminsstylechecker, FCR_BOLD + FCR_SHADOW)
				}				
			end
			imgui.PopItemWidth()
			if adminsBufferStyle.v <= 0 then
				adminsBufferStyle.v = 0
			end
			imgui.Text(u8'Отступ между строками:')
			imgui.SameLine()
			imgui.PushItemWidth(100)
			if imgui.InputInt(u8("##asdsadeqqq"), adminsBufferOffset) then
				cfg.main.adminsotschecker = string.format('%s', tostring(adminsBufferOffset.v))
				fonts456 = { 
					adminsChecker = renderCreateFont(cfg.main.adminsfontchecker, cfg.main.adminssizechecker, cfg.main.adminsstylechecker, FCR_BOLD + FCR_SHADOW)
				}				
			end
			imgui.PopItemWidth()
			if adminsBufferOffset.v <= 0 then
				adminsBufferOffset.v = 0
			elseif adminsBufferOffset.v >= 50 then
				adminsBufferOffset.v = 50
			end
			imgui.Text(u8'Положение текста:')
			imgui.SameLine()
			if imgui.BoolButton(cfg.main.adminsAlign == 1, fa.ICON_FA_ALIGN_LEFT, imgui.ImVec2(38, 20)) then
				cfg.main.adminsAlign = 1
			end
			imgui.Hint('left', u8'По левому краю')
			imgui.SameLine()
			if imgui.BoolButton(cfg.main.adminsAlign == 2, fa.ICON_FA_ALIGN_CENTER, imgui.ImVec2(38, 20)) then
				cfg.main.adminsAlign = 2
			end
			imgui.Hint('centre', u8'По центру')
			imgui.SameLine()
			if imgui.BoolButton(cfg.main.adminsAlign == 3, fa.ICON_FA_ALIGN_RIGHT, imgui.ImVec2(38, 20)) then
				cfg.main.adminsAlign = 3
			end
			imgui.Hint('right', u8'По правому краю')
			imgui.Separator()












			elseif checker_selected.v == 3 then
			imgui.PushFont(fs16)
			imgui.CenterTextColoredRGB('{E3C47F}Чекер игроков')
			imgui.PopFont()
			if imgui.ToggleButton(u8'Включить чекер игроков', imgui.ImBool(cfg.main.playersChecker)) then 
				cfg.main.playersChecker = not cfg.main.playersChecker 
			end 
			if imgui.ToggleButton(u8'Отображать AFK в чекере', imgui.ImBool(cfg.main.afkinchecker)) then 
				cfg.main.afkinchecker = not cfg.main.afkinchecker 
			end 
			imadd.HotKey('##fchecker', fchecker, {}, 100)
			imgui.SameLine()
			imgui.Text(u8'Включить/выключить чекер')
			imgui.Text(u8'Местоположение:')
			imgui.SameLine()
			if imgui.Button(fa.ICON_FA_ARROWS_ALT..u8"") then
			if not editPosition then 
					sampAddChatMessage(tag..'Используйте {E78284}ЛКМ {84A6E7}для сохранения позиции чекера.', -1)
					local lastX, lastY = cfg.checkerPosition.x, cfg.checkerPosition.y
					local open = cfg.main.playersChecker
					editPosition = true 
					cfg.main.playersChecker = true 
					MainWindow.v = false
					lua_thread.create(function()
						while editPosition do wait(0)
						sampSetCursorMode(CMODE_LOCKCAM)
							local x, y = getCursorPos()
							cfg.checkerPosition.x, cfg.checkerPosition.y = x, y
							if isKeyDown(VK_LBUTTON) then 
								sampAddChatMessage(tag..'Позиция чекера успешно сохранена.', -1)
								for k,v in pairs(J_) do 
									if doesFileExist(getWorkingDirectory().."\\AdminToolsKing\\"..J_[k][2]..".json") then 
										local f = io.open(getWorkingDirectory().."\\AdminToolsKing\\"..J_[k][2]..".json", "w+") 
										if f then 
											f:write(encodeJson(J_[k][1])):close()
										end 
									end 
								end 
								inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
								cfg.main.playersChecker = open 
								editPosition = false 
								sampToggleCursor(false)
							  
								break 
							end
						end
					end)
				else 
					sampAddChatMessage("Для начала завершите прошедшее редактирование.", -1)
				end
			end
			imgui.Separator()
			imgui.CenterTextColoredRGB('{fe4e4e}Настройки стиля чекера')
			if imgui.ColorEdit3(u8'Стандартный цвет ников', stockcolorchecker, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
				stock_colorchecker()
			end
			if imgui.ColorEdit3(u8'Цвет AFK', afkcolorchecker, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
				afk_colorchecker()
			end
			imgui.Text(u8'Шрифт чекера:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputText('##fontchecker', fontchecker) then 
					cfg.main.fontchecker = string.format('%s', tostring(fontchecker.v)) 
					fonts = { 
						playersChecker = renderCreateFont(cfg.main.fontchecker, cfg.main.sizechecker, cfg.main.stylechecker, FCR_BOLD + FCR_SHADOW)
					}
				end 
				imgui.PopItemWidth()
				imgui.Text(u8'Размер шрифта:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##ssswssas"), PlayersBufferSize) then
					cfg.main.sizechecker = string.format('%s', tostring(PlayersBufferSize.v))
					fonts = { 
						playersChecker = renderCreateFont(cfg.main.fontchecker, cfg.main.sizechecker, cfg.main.stylechecker, FCR_BOLD + FCR_SHADOW)
					}				
				end
				imgui.PopItemWidth()
				if PlayersBufferSize.v <= 6 then
					PlayersBufferSize.v = 6
				elseif PlayersBufferSize.v >= 35 then
					PlayersBufferSize.v = 35
				end
				imgui.Text(u8'Стиль шрифта:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##ssswqswqssas"), PlayersBufferStyle) then
					cfg.main.stylechecker = string.format('%s', tostring(PlayersBufferStyle.v))
					fonts = { 
						playersChecker = renderCreateFont(cfg.main.fontchecker, cfg.main.sizechecker, cfg.main.stylechecker, FCR_BOLD + FCR_SHADOW)
					}				
				end
				imgui.PopItemWidth()
				if PlayersBufferStyle.v <= 0 then
					PlayersBufferStyle.v = 0
				end
				imgui.Text(u8'Отступ между строками:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##asdsadeq"), PlayersBufferOffset) then
					cfg.main.otschecker = string.format('%s', tostring(PlayersBufferOffset.v))
					fonts = { 
						playersChecker = renderCreateFont(cfg.main.fontchecker, cfg.main.sizechecker, cfg.main.stylechecker, FCR_BOLD + FCR_SHADOW)
					}				
				end
				imgui.PopItemWidth()
				if PlayersBufferOffset.v <= 0 then
					PlayersBufferOffset.v = 0
				elseif PlayersBufferOffset.v >= 50 then
					PlayersBufferOffset.v = 50
				end
				imgui.Text(u8'Положение текста:')
				imgui.SameLine()
				if imgui.BoolButton(cfg.main.align == 1, fa.ICON_FA_ALIGN_LEFT, imgui.ImVec2(38, 20)) then
					cfg.main.align = 1
				end
				imgui.Hint('left', u8'По левому краю')
				imgui.SameLine()
				if imgui.BoolButton(cfg.main.align == 2, fa.ICON_FA_ALIGN_CENTER, imgui.ImVec2(38, 20)) then
					cfg.main.align = 2
				end
				imgui.Hint('centre', u8'По центру')
				imgui.SameLine()
				if imgui.BoolButton(cfg.main.align == 3, fa.ICON_FA_ALIGN_RIGHT, imgui.ImVec2(38, 20)) then
					cfg.main.align = 3
				end
				imgui.Hint('right', u8'По правому краю')
				imgui.Separator()
				local width = imgui.GetWindowWidth()
			imgui.SetCursorPosX( width / 2 - 95)
				imgui.BeginChild("ChildWssawwindow", imgui.ImVec2(200, 42), false)
				imgui.CenterText(u8'Добавление игрока')
				imgui.Separator()
			imgui.PushItemWidth(160)
			imgui.InputText(u8"##place_for_nickname", addPlayerInChecker)
			imgui.PopItemWidth()
			imgui.SameLine()
			imgui.Text(fa.ICON_FA_USER_PLUS.." ")
			if imgui.IsItemClicked() then 
			if addPlayerInChecker ~= "" then 
						table.insert(J_.PLAYERS_CHECKER[1], u8:decode(addPlayerInChecker.v))
						addPlayerInChecker.v = ""
						for k,v in pairs(J_) do 
		if doesFileExist(getWorkingDirectory().."\\AdminToolsKing\\"..J_[k][2]..".json") then 
			local f = io.open(getWorkingDirectory().."\\AdminToolsKing\\"..J_[k][2]..".json", "w+") 
			if f then 
				f:write(encodeJson(J_[k][1])):close()
			end 
		end 
	end 
	inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					else
						sampAddChatMessage("Введите никнейм игрока!")
					end
			end
			imgui.EndChild()
			imgui.SetCursorPosX( width / 2 - 95)
			if #J_.PLAYERS_CHECKER[1] == 0 then 
				imgui.CenterText(u8"Пока что вы не добавили ни одного игрока в чекер") 
			end
			for k,v in ipairs(J_.PLAYERS_CHECKER[1]) do 
			imgui.SetCursorPosX( width / 2 - 95)
				imgui.Text(fa.ICON_FA_USER_SLASH.." ")
				if imgui.IsItemClicked() then 
					table.remove(J_.PLAYERS_CHECKER[1], k)
				   for k,v in pairs(J_) do 
		if doesFileExist(getWorkingDirectory().."\\AdminToolsKing\\"..J_[k][2]..".json") then 
			local f = io.open(getWorkingDirectory().."\\AdminToolsKing\\"..J_[k][2]..".json", "w+") 
			if f then 
				f:write(encodeJson(J_[k][1])):close()
			end 
		end 
	end 
	inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
				end
				imgui.SameLine() imgui.Text(u8(v))
			end
			elseif checker_selected.v == 4 then
			imgui.PushFont(fs16)
			imgui.CenterTextColoredRGB('{E3C47F}Чекер регистраций')
			imgui.PopFont()
			if imgui.ToggleButton(u8'Включить чекер регистраций', imgui.ImBool(cfg.main.regChecker)) then 
				cfg.main.regChecker = not cfg.main.regChecker 
			end 
			imgui.Text(u8'Размер шрифта:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##фывуфвывыфу"), RegBufferSize) then
					cfg.main.regSize = string.format('%s', tostring(RegBufferSize.v))
					reg = renderCreateFont(cfg.main.QuitFontChecker, cfg.main.regSize, cfg.main.regStyle, FCR_BOLD + FCR_BORDER)			
				end
				imgui.PopItemWidth()
				if RegBufferSize.v <= 6 then
					RegBufferSize.v = 6
				elseif RegBufferSize.v >= 35 then
					RegBufferSize.v = 35
				end
				imgui.Text(u8'Стиль шрифта:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##RegBufferStyle"), RegBufferStyle) then
					cfg.main.regStyle = string.format('%s', tostring(RegBufferStyle.v))
					reg = renderCreateFont(cfg.main.QuitFontChecker, cfg.main.regSize, cfg.main.regStyle, FCR_BOLD + FCR_BORDER)			
				end
				imgui.PopItemWidth()
				if RegBufferStyle.v < 0 then
					RegBufferStyle.v = 0
				end
				imgui.Text(u8'Шрифт чекера:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputText('##RegFontChecker', RegFontChecker) then 
					cfg.main.RegFontChecker = string.format('%s', tostring(RegFontChecker.v)) 
					reg = renderCreateFont(cfg.main.RegFontChecker, cfg.main.regSize, cfg.main.regStyle, FCR_BOLD + FCR_BORDER)		
				end 
				imgui.PopItemWidth()
				imgui.Text(u8'Отступ между строками:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##RegBufferOffset"), RegBufferOffset) then
					cfg.main.regIndent = string.format('%s', tostring(RegBufferOffset.v))
					reg = renderCreateFont(cfg.main.RegFontChecker, cfg.main.regSize, cfg.main.regStyle, FCR_BOLD + FCR_BORDER)			
				end
				imgui.PopItemWidth()
				if RegBufferOffset.v <= 0 then
					RegBufferOffset.v = 0
				elseif RegBufferOffset.v >= 50 then
					RegBufferOffset.v = 50
				end
				imgui.Text(u8'Максимум строк:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##connectLines"), ConnectBufferLines) then
					cfg.main.connectLines = string.format('%s', tostring(ConnectBufferLines.v))
					leave = renderCreateFont(cfg.main.RegFontChecker, cfg.main.regSize, cfg.main.regStyle, FCR_BOLD + FCR_BORDER)			
				end
				imgui.PopItemWidth()
				if ConnectBufferLines.v <= 1 then
					ConnectBufferLines.v = 1
				elseif ConnectBufferLines.v >= 15 then
					ConnectBufferLines.v = 15
				end
				imgui.Text(u8'Положение текста:')
				imgui.SameLine()
				if imgui.BoolButton(cfg.main.alignfour == 1, fa.ICON_FA_ALIGN_LEFT, imgui.ImVec2(38, 20)) then
					cfg.main.alignfour = 1
				end
				imgui.Hint('left', u8'По левому краю')
				imgui.SameLine()
				if imgui.BoolButton(cfg.main.alignfour == 2, fa.ICON_FA_ALIGN_CENTER, imgui.ImVec2(38, 20)) then
					cfg.main.alignfour = 2
				end
				imgui.Hint('centre', u8'По центру')
				imgui.SameLine()
				if imgui.BoolButton(cfg.main.alignfour == 3, fa.ICON_FA_ALIGN_RIGHT, imgui.ImVec2(38, 20)) then
					cfg.main.alignfour = 3
				end
				imgui.Hint('right', u8'По правому краю')
				imgui.Text(u8'Местоположение:')
				imgui.SameLine()
				if imgui.Button(fa.ICON_FA_ARROWS_ALT..u8'') then 
				if not editPosition3 then 
					sampAddChatMessage(tag..'Используйте {E78284}ЛКМ {84A6E7}для сохранения позиции чекера.', -1)
					local lastX, lastY = cfg.RegPosition.x, cfg.RegPosition.y
					local open = cfg.main.regChecker
					editPosition3 = true 
					cfg.main.regChecker = true 
					MainWindow.v = false
					lua_thread.create(function()
						while editPosition3 do wait(0)
						sampSetCursorMode(CMODE_LOCKCAM)
							local x, y = getCursorPos()
							cfg.RegPosition.x, cfg.RegPosition.y = x, y
							if isKeyDown(VK_LBUTTON) then 
								sampAddChatMessage(tag..'Позиция чекера успешно сохранена.', -1)
								inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
								cfg.main.regChecker = open 
								editPosition3 = false 
								sampToggleCursor(false)
							  
								break 
							end
						end
					end)
				else 
					sampAddChatMessage("Для начала завершите прошедшее редактирование.", -1)
				end 
				end
			elseif checker_selected.v == 5 then
			imgui.PushFont(fs16)
			imgui.CenterTextColoredRGB('{E3C47F}Чекер выходов')
			imgui.PopFont()
			if imgui.ToggleButton(u8'Включить чекер отключений', imgui.ImBool(cfg.main.leaveChecker)) then 
				cfg.main.leaveChecker = not cfg.main.leaveChecker 
			end 
				imgui.Text(u8'Размер шрифта:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##ssswsqssas"), LeaveBufferSize) then
					cfg.main.leaveSize = string.format('%s', tostring(LeaveBufferSize.v))
					leave = renderCreateFont(cfg.main.QuitFontChecker, cfg.main.leaveSize, cfg.main.leaveStyle, FCR_BOLD + FCR_BORDER)			
				end
				imgui.PopItemWidth()
				if LeaveBufferSize.v <= 6 then
					LeaveBufferSize.v = 6
				elseif LeaveBufferSize.v >= 35 then
					LeaveBufferSize.v = 35
				end
				imgui.Text(u8'Стиль шрифта:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##sssqqwqswqssas"), LeaveBufferStyle) then
					cfg.main.leaveStyle = string.format('%s', tostring(LeaveBufferStyle.v))
					leave = renderCreateFont(cfg.main.QuitFontChecker, cfg.main.leaveSize, cfg.main.leaveStyle, FCR_BOLD + FCR_BORDER)			
				end
				imgui.PopItemWidth()
				if LeaveBufferStyle.v < 0 then
					LeaveBufferStyle.v = 0
				end
				imgui.Text(u8'Шрифт чекера:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputText('##QuitFontChecker', QuitFontChecker) then 
					cfg.main.QuitFontChecker = string.format('%s', tostring(QuitFontChecker.v)) 
					leave = renderCreateFont(cfg.main.QuitFontChecker, cfg.main.leaveSize, cfg.main.leaveStyle, FCR_BOLD + FCR_BORDER)		
				end 
				imgui.PopItemWidth()
				imgui.Text(u8'Отступ между строками:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##leaveIndent"), LeaveBufferOffset) then
					cfg.main.leaveIndent = string.format('%s', tostring(LeaveBufferOffset.v))
					leave = renderCreateFont(cfg.main.QuitFontChecker, cfg.main.leaveSize, cfg.main.leaveStyle, FCR_BOLD + FCR_BORDER)			
				end
				imgui.PopItemWidth()
				if LeaveBufferOffset.v <= 0 then
					LeaveBufferOffset.v = 0
				elseif LeaveBufferOffset.v >= 50 then
					LeaveBufferOffset.v = 50
				end
				imgui.Text(u8'Максимум строк:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##leaveLines"), LeaveBufferLines) then
					cfg.main.leaveLines = string.format('%s', tostring(LeaveBufferLines.v))
					leave = renderCreateFont(cfg.main.QuitFontChecker, cfg.main.leaveSize, cfg.main.leaveStyle, FCR_BOLD + FCR_BORDER)			
				end
				imgui.PopItemWidth()
				if LeaveBufferLines.v <= 1 then
					LeaveBufferLines.v = 1
				elseif LeaveBufferLines.v >= 15 then
					LeaveBufferLines.v = 15
				end
				imgui.Text(u8'Положение текста:')
				imgui.SameLine()
				if imgui.BoolButton(cfg.main.aligntwo == 1, fa.ICON_FA_ALIGN_LEFT, imgui.ImVec2(38, 20)) then
					cfg.main.aligntwo = 1
				end
				imgui.Hint('left', u8'По левому краю')
				imgui.SameLine()
				if imgui.BoolButton(cfg.main.aligntwo == 2, fa.ICON_FA_ALIGN_CENTER, imgui.ImVec2(38, 20)) then
					cfg.main.aligntwo = 2
				end
				imgui.Hint('centre', u8'По центру')
				imgui.SameLine()
				if imgui.BoolButton(cfg.main.aligntwo == 3, fa.ICON_FA_ALIGN_RIGHT, imgui.ImVec2(38, 20)) then
					cfg.main.aligntwo = 3
				end
				imgui.Hint('right', u8'По правому краю')
				imgui.Text(u8'Местоположение:')
				imgui.SameLine()
				if imgui.Button(fa.ICON_FA_ARROWS_ALT..u8'') then 
				if not editPosition1 then 
					sampAddChatMessage(tag..'Используйте {E78284}ЛКМ {84A6E7}для сохранения позиции чекера.', -1)
					local lastX, lastY = cfg.leavePosition.x, cfg.leavePosition.y
					local open = cfg.main.leaveChecker
					editPosition1 = true 
					cfg.main.leaveChecker = true 
					MainWindow.v = false
					lua_thread.create(function()
						while editPosition1 do wait(0)
						sampSetCursorMode(CMODE_LOCKCAM)
							local x, y = getCursorPos()
							cfg.leavePosition.x, cfg.leavePosition.y = x, y
							if isKeyDown(VK_LBUTTON) then 
								sampAddChatMessage(tag..'Позиция чекера успешно сохранена.', -1)
								inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
								cfg.main.leaveChecker = open 
								editPosition1 = false 
								sampToggleCursor(false)
							   
								break 
							end
						end
					end)
				else 
					sampAddChatMessage("Для начала завершите прошедшее редактирование.", -1)
				end 
				end
			end
			imgui.EndChild() 		
		end
		imgui.End()
	end

	if AmemberWindow.v then
		imgui.SetNextWindowSize(imgui.ImVec2(320, 400), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8"Выберите организацию", AmemberWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoSavedSettings)
		
		imgui.Text(u8'Укажите ранг:') 
		imgui.SameLine()
		imgui.PushItemWidth(70)
		imgui.InputInt(u8("##adsjaassasasaasasaxsssdsasdadsdsdsdsdsj"), buffer58)
		cfg.main.arank = string.format('%s', tostring(buffer58.v)) 
		imgui.PopItemWidth()
		if buffer58.v <= 0 then
			buffer58.v = 1
		elseif buffer58.v >= 10 then
			buffer58.v = 9
		end
		for i = 1, #fractions do
			if imgui.Button('['..i..'] '..fractions[i][1], imgui.ImVec2(-1, 25)) then
				sampSendChat('/amember '..i..' '..tostring(buffer58.v))
			end
		end
		
		imgui.End()
	end
	
	if TeleportWindow.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(530, 404), imgui.Cond.FirstUseEver)

		imgui.Begin('TP MENU', TeleportWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoSavedSettings)

		imgui.BeginChild("Cindow", imgui.ImVec2(150, -1), true)
		if imgui.BoolButton(pizdas == 1, u8'Избранное', imgui.ImVec2(-1, 25)) then
			pizdas = 1
		end
		if imgui.BoolButton(pizdas == 2, u8'Фракции', imgui.ImVec2(-1, 25)) then
			pizdas = 2
		end
		if imgui.Button(u8'ТП по метке', imgui.ImVec2(-1, 25)) then
			_, x, y, z = getTargetBlipCoordinatesFixed()
			if not _ then 
				sampAddChatMessage(tag.."Метка для телепорта {E78284}не найдена{84A6E7}.", -1)  else setCharCoordinates(PLAYER_PED, x, y, z) 
			end
		end
		if imgui.Button(u8'Телепорт на маркер', imgui.ImVec2(-1, 25)) then
			tpcssss()
		end
		imgui.EndChild()
		imgui.SameLine()
		if pizdas == 1 then
			imgui.BeginChild("Cindow11", imgui.ImVec2(-1, -1), true)
			for i = 1, #locations do
				if imgui.Button(locations[i][1], imgui.ImVec2(-1, 25)) then
					sampSendChat('/vv 0')
					teleportInterior(playerPed, locations[i][2], locations[i][3], locations[i][4], 0)
				end
			end
			imgui.EndChild()
		elseif pizdas == 2 then

			imgui.BeginChild("Cindow222", imgui.ImVec2(-1, -1), true)
			if imgui.BoolButton(selectgroup == 1, u8'Улицы', imgui.ImVec2(165, 30)) then
				selectgroup = 1
			end
			imgui.SameLine()
			if imgui.BoolButton(selectgroup == 2, u8'Спавны', imgui.ImVec2(165, 30)) then
				selectgroup = 2
			end
			imgui.Separator()
			if selectgroup == 2 then
			for i = 1, #fractions do
				if imgui.Button('['..i..'] '..u8('Спавн')..' '..fractions[i][1], imgui.ImVec2(-1, 25)) then
					sampSendChat('/tp '..i)
				end
			end
			elseif selectgroup == 1 then
			for i = 1, #fractions do
				if imgui.Button('['..i..'] '..u8('Улица')..' '..fractions[i][1], imgui.ImVec2(-1, 25)) then
					sampSendChat('/vv 0')
					teleportInterior(playerPed, fractions[i][2], fractions[i][3], fractions[i][4], 0)
				end
			end
			end
			imgui.EndChild()
		end
		imgui.End()
	end


	if HelpWindow.v then
			local sw, sh = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(500, 570), imgui.Cond.FirstUseEver)

		imgui.Begin(u8' Помощь по скрипту', HelpWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoSavedSettings)
		imgui.CenterText(u8'[Команды Admin Tools]')
		imgui.NewLine()
		imgui.TextColoredRGB('{E78284}/rvanka {84A6E7}- выдать блокировку IP за рванку\n{E78284}/rekb {84A6E7}- выдать блокировку IP за рекламу\n{E78284}/cbiz {84A6E7}- открыть отдел коммерции\n{E78284}/chome {84A6E7}- открыть отдел недвижимости\n{E78284}/nick [ID] {84A6E7}- кикнуть игрока с причиной nRP NickName\n{E78284}/om [ID] {84A6E7}- выпустить игрока с причиной "Опровержение отклонено"\n{E78284}/op [ID] {84A6E7}- выпустить игрока с причиной "Опровержение одобрено"\n{E78284}/rlvl [radius] {84A6E7}- узнать уровни игроков в радиусе (полезно для чека пустышек на слете)\n{E78284}/gb {84A6E7}- сокращение команды /gotobiz\n{E78284}/gh {84A6E7}- сокращение команды /gotohouse\n{E78284}/ab {84A6E7}- сокращение команды /asellbiz\n{E78284}/ah {84A6E7}- сокращение команды /asellhouse\n{E78284}/rek_off {84A6E7}- Отключить/Включить сообщения [Подозрение на рекламу]\n{E78284}/crd {84A6E7}- скопировать координаты на которых вы сейчас стоите\n{E78284}/cal [пример]{84A6E7} - калькулятор\n{E78284}/color {84A6E7} - таблица ИДов цветов для покраски авто\n{E78284}/admall {84A6E7} - список всей администрации сервера\n{E78284}/clr [кол-во строк]{84A6E7} - визуально очистить чат\n{E78284}/ammo {84A6E7}- пополнить склад аммуниций\n{E78284}/arep {84A6E7}- починка транспорта в котором вы сидите\n{E78284}/amember {84A6E7}- открыть меню вступления во фракцию\n{E78284}/spawnset {84A6E7}- установить точку спавна\n{E78284}/ss [id player] [id skin] {84A6E7}- выдать вечный скин и заспавнить игрока (для раздач)\n{E78284}/tp {84A6E7}- открыть меню телепорта\n{E78284}/spcarall [sek] {84A6E7}- начать спавн транспорта\n{E78284}/flood [id player] {84A6E7}- выдать наказание за флуд\n{E78284}/rules {84A6E7}- отправить биндер "Правила сервера"\n{E78284}/dm [id player] {84A6E7}- выдать наказание за ДМ\n{E78284}/db [id player] {84A6E7}- выдать наказание за ДБ\n{E78284}/oskrod [id player] {84A6E7}- выдать наказание за оскорбление родных\n{E78284}/sbiv [id player] {84A6E7}- выдать наказание за сбив анимации\n{E78284}/upomrod [id player] {84A6E7}- выдать наказание за упоминание родных\n{E78284}/dbk [id player] {84A6E7}- выдать наказание за ДБ ковшом\n{E78284}/ncop [id player] {84A6E7}- выдать наказание за НРП копа\n{E78284}/cheat [id player] {84A6E7}- выдать наказание за ИЗП\n{E78284}/ntune [id player] {84A6E7}- выдать наказание за НРП тюнинг\n{E78284}/nead [id player] {84A6E7}- выдать наказание за неадекватное поведение\n{E78284}/desc [id player] {84A6E7}- удалить описание и выдать наказание за НРП описание\n{E78284}/protection {84A6E7}- отправить биндер "Защита аккаунта"\n{E78284}/oskadm [id player] {84A6E7}- выдать наказание за оскорбление администрации\n{E78284}/pc [id player] {84A6E7}- выдать наказание за +С\n{E78284}/xdonate {84A6E7}- отправить биндер "Множитель доната"\n{E78284}/mdm [id player] {84A6E7}- выдать наказание за Массовый ДМ\n{E78284}/sk [id player] {84A6E7}- выдать наказание за СК\n{E78284}/tk [id player] {84A6E7}- выдать наказание за ТК\n{E78284}/vk {84A6E7}- отправить биндер "Паблик ВК"\n{E78284}/capcha {84A6E7}- открыть меню универсальной капчи\n{E78284}/discord {84A6E7}- отправить биндер "Дискорд"\n{E78284}/my1 {84A6E7}- отправить биндер "Собственный №1"\n{E78284}/my2 {84A6E7}- отправить биндер "Собственный №2"\n{E78284}/my3 {84A6E7}- отправить биндер "Собственный №3"\n{E78284}/my4 {84A6E7}- отправить биндер "Собственный №4"\n{E78284}/tpcar [id player] [id car] {84A6E7}- телепортировать транспорт к игроку\n{E78284}/amenu {84A6E7}- открыть настройки скрипта\n{E78284}/autoopra, /aopra{84A6E7} - включить автоопровержение\n{E78284}/toolsoff {84A6E7}- принудительно выключить скрипт\n{E78284}/toolsreload {84A6E7}- принудительно перезагрузить скрипт')
		imgui.End()
	end
	
	
	if CaptchaWindow.v then
			local sw, sh = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(400, 290), imgui.Cond.FirstUseEver)

		imgui.Begin(fa.ICON_FA_COGS..u8' Настройки | Капча', CaptchaWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoSavedSettings)
imgui.CenterText(u8'Куда отправлять капчу?')
imgui.RadioButton(u8"В общий чат (/ao)", when_captcha, 1)
imgui.RadioButton(u8"В VIP чат (/vr)", when_captcha, 2)
imgui.Text(u8'Капча:')
imgui.SameLine()
imgui.PushItemWidth(-1) 
imgui.InputText(u8"##40", buffer27) 
cfg.main.kapchas = string.format('%s', tostring(buffer27.v)) 
imgui.PopItemWidth()
imgui.Text(u8'Приз:')
imgui.SameLine()
imgui.PushItemWidth(-1) 
imgui.InputText(u8"##41", buffer28) 
cfg.main.present = string.format('%s', tostring(buffer28.v)) 
imgui.PopItemWidth()
if imgui.Button(u8'Сгенерировать рандомную капчу', imgui.ImVec2(-1, 25)) then
if cfg.main.onzero then
local a = math.random(1000, 9999)..'0'
sampAddChatMessage(tag..'Сгенерирована рандомная капча с окончанием на ноль: '..a, -1)
buffer27.v = a
else
local a = math.random(10000, 99999) 
sampAddChatMessage(tag..'Сгенерирована рандомная капча: '..a, -1)
buffer27.v = a
end
end
if imgui.ToggleButton(u8'Пятый символ в капче должен быть 0', imgui.ImBool(cfg.main.onzero)) then 
				cfg.main.onzero = not cfg.main.onzero 
			end 
imgui.BeginChild("qeuqewiqweiqwe5", imgui.ImVec2(-1, 60), true)
		imgui.PushFont(fontsize)
		imgui.CenterText(u8'Предосмотр:')
		imgui.PopFont()
		if when_captcha.v == 2 then
		imgui.CenterText(u8('/vr Внимание! Капча: "'..u8:decode(cfg.main.kapchas))..u8('". Приз: '..u8:decode(cfg.main.present))..'!')
		else
		imgui.CenterText(u8('/ao Внимание! Капча: "'..u8:decode(cfg.main.kapchas))..u8('". Приз: '..u8:decode(cfg.main.present))..'!')
		end
imgui.EndChild()
if imgui.Button(u8'Отправить капчу', imgui.ImVec2(-1, 25)) then
if when_captcha.v == 2 then
sampSendChat('/vr Внимание! Капча: "'..u8:decode(cfg.main.kapchas)..'". Приз: '..u8:decode(cfg.main.present)..'!')
else
sampSendChat('/ao Внимание! Капча: "'..u8:decode(cfg.main.kapchas)..'". Приз: '..u8:decode(cfg.main.present)..'!')
end
end
imgui.End()
	end
	
	
	if InteractionWindow.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(700, 330), imgui.Cond.FirstUseEver)
		local nick = sampGetPlayerNickname(muteid)
		imgui.Begin(u8("##dasads"), InteractionWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoSavedSettings)
		imgui.PushFont(fontsize)
		imgui.CenterText(u8"Взаимодействие с игроком ".. nick)
		imgui.PopFont()
		imgui.BeginChild("qeuqewiqweiqwe5", imgui.ImVec2(220, 260), true)
		if imgui.Button(u8'Флуд', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/mute '..nick..' '..cfg.main.flood.. ' Флуд')
		end
		imgui.SameLine()
		if imgui.Button(u8'Оск. родных', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/mute '..nick..' '..cfg.main.oskrod.. ' Оскорбление родных')
		end
		if imgui.Button(u8'Упом. родных', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/mute '..nick..' '..cfg.main.upomrod.. ' Упоминание родных')
		end
		imgui.SameLine()
		if imgui.Button(u8'Неадекват', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/mute '..nick..' '..cfg.main.nead.. ' неадекватное поведение')
		end
		if imgui.Button(u8'nRP cop', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/jail '..nick..' '..cfg.main.ncop.. ' nRP cop')
		end
		imgui.SameLine()
		if imgui.Button(u8'DeathMatch', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/jail '..nick..' '..cfg.main.dm.. ' DeathMatch [ДМ]')
		end
		if imgui.Button(u8'DriveBy', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/jail '..nick..' '..cfg.main.db.. ' DriveBy [ДБ]')
		end
		imgui.SameLine()
		if imgui.Button(u8'ИЗП', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/jail '..nick..', '..cfg.main.cheat.. ' ИЗП')
		end
		if imgui.Button(u8'DriveBy ковшом', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/jail '..nick..', '..cfg.main.dbk.. ' DriveBy ковшом')
		end
		imgui.SameLine()
		if imgui.Button(u8'nRP тюнинг', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/jail '..nick..', '..cfg.main.ntune.. ' nRP тюнинг')
		end
		imgui.SameLine()
		if imgui.Button(u8'Массовый DM', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/ban '..nick..', '..cfg.main.mdm.. ' Массовый DM')
		end
		if imgui.Button(u8'+С', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/warn '..nick..', +С')
		end
		imgui.SameLine()
		if imgui.Button(u8'Сбив', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/warn '..nick..', Сбив анимации')
		end
		if imgui.Button(u8'SpawnKill', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/warn '..nick..', СК')
		end
		imgui.SameLine()
		if imgui.Button(u8'Удалить опис.', imgui.ImVec2(100, 25)) then
			sampSendChat('/pm '..nick..', 1 Описание вашего персонажа было удалено. Причина: nRP описание', -1)
			sampSendChat('/adeldesc '..nick..'')
		end
		imgui.EndChild()
		imgui.SameLine()
		imgui.BeginChild("qeuqewiqweiqwe5asd", imgui.ImVec2(230, 260), true)
		imgui.CenterText(u8("") .. nick .. " [" .. muteid .. "]")
		imgui.Separator()
		if imgui.Button(u8'/getip', imgui.ImVec2(-1, 25)) then
			sampSendChat('/getip '..nick)
		end
		if imgui.Button(u8'/slap', imgui.ImVec2(-1, 25)) then
			sampSendChat('/slap '..nick..' 1')
		end
		if imgui.Button(u8'/spplayer', imgui.ImVec2(-1, 25)) then
			sampSendChat('/spplayer '..nick)
		end
		if imgui.Button(u8'/az', imgui.ImVec2(-1, 25)) then
			sampSendChat('/az '..nick)
		end
		if imgui.Button(u8'/pm Вы тут?', imgui.ImVec2(-1, 25)) then
			sampSendChat('/pm '..muteid..' 0 Уважаемый '..nick..', Вы тут? Ответьте "Да" в /b (/n) чат.')
		end
		imgui.Separator()
		imgui.Columns(2, "Columns1", true)
		imgui.Text(u8'Уровень')
		imgui.NextColumn()
		imgui.Text(string.format(u8'%s', sampGetPlayerScore(muteid)))
		imgui.Separator()
		imgui.NextColumn()
		imgui.Text(u8'PING')
		imgui.NextColumn()
		imgui.Text(string.format(u8'%s', sampGetPlayerPing(muteid)))
		imgui.Separator()
		imgui.NextColumn()
		imgui.Text(u8'Здоровье')
		imgui.NextColumn()
		imgui.Text(string.format(u8'%s', sampGetPlayerHealth(muteid)))
		imgui.Separator()
		imgui.NextColumn()
		imgui.Text(u8'Броня')
		imgui.NextColumn()
		imgui.Text(string.format(u8'%s', sampGetPlayerArmor(muteid)))
		imgui.EndChild()
		imgui.SameLine()
		imgui.BeginChild("qeuqewiweeqwqewqweiqwe5asd", imgui.ImVec2(220, 260), true)
		if imgui.Button(u8'Помеха', imgui.ImVec2(100, 25)) then
				sampSendChat('/kick '..nick..' помеха')
		end
		imgui.SameLine()
		if imgui.Button(u8'Тихий кик', imgui.ImVec2(100, 25)) then
				sampSendChat('/skick '..nick)
		end
		if imgui.Button(u8'Выдать NRG-500', imgui.ImVec2(100, 25)) then
				sampSendChat('/plveh '..nick..' 522 1')
		end
		imgui.SameLine()
		if imgui.Button(u8'Флип', imgui.ImVec2(100, 25)) then
				sampSendChat('/flip '..muteid)
		end
		if imgui.Button(u8'TRADE', imgui.ImVec2(100, 25)) then
				sampSendChat('/trade '..muteid)
		end
		imgui.SameLine()
		if imgui.Button(u8'Забрать оружие', imgui.ImVec2(100, 25)) then
				sampSendChat('/weap '..muteid)
		end
		if imgui.Button(u8'Заморозить', imgui.ImVec2(100, 25)) then
				sampSendChat('/freeze '..muteid)
		end
		imgui.SameLine()
		if imgui.Button(u8'Разморозить', imgui.ImVec2(100, 25)) then
				sampSendChat('/unfreeze '..muteid)
		end
		imgui.Separator()
		imgui.EndChild()
		imgui.End()
	end
	
		if ColorsWindow.v then
		local sw, sh = getScreenResolution()
	 imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(480, 270), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'Таблица цветов', ColorsWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.AlwaysAutoResize)
		imgui.Image(colors, imgui.ImVec2(854, 392)) 
imgui.End()
end

if InfoWindow.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowPos(imgui.ImVec2(posX333.v, posY333.v), imgui.Cond.Always)
		imgui.SetNextWindowSize(imgui.ImVec2(350, 236), imgui.Cond.FirstUseEver)
		imgui.Begin('##asdq', InfoWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.NoTitleBar)
		imgui.SameLine()
		local color = ("%06X"):format(bit.band(sampGetPlayerColor(spec_id), 0xFFFFFF))
		imgui.CenterTextColoredRGB('{'..color..'}'..sampGetPlayerNickname(spec_id) ..' ['..spec_id..']')
		imgui.Separator()
		infostate()
imgui.End()
end
	
	
	
		if ChangePosWindow.v then
			lyalyalyalya2()
		end
		if ChangePosWindowTwo.v then
			lyalyalyalya3()
		end
		
		if ChangePosWindowThree.v then
			lyalyalyalya4()
		end
		
		if ChangePosWindowFour.v then
			lyalyalyalya5()
		end

		if ChangePosWindowFive.v then
			lyalyalyalya6()
		end
		if ChangePosWindowSeven.v then
			lyalyalyalya7()
		end
		if ChangePosWindowEight.v then
			lyalyalyalya8()
		end
	if reconusers_state.v then reconusers() end
	
	
	
	
if ReconWindow.v and cfg.main.menurecon1 then 
imgui.ShowCursor = false
if style_controlpanel.v == 1 then
	screenWidth, screenHeight = getScreenResolution()
local nick = sampGetPlayerNickname(spec_id)

	imgui.SetNextWindowPos(imgui.ImVec2(posX456.v, posY456.v), imgui.Cond.Always)
	imgui.SetNextWindowSize(imgui.ImVec2(480, 270), imgui.Cond.FirstUseEver)
	imgui.Begin(u8("##reconPanel2"), _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar)
	imgui.PushStyleVar(imgui.StyleVar.ItemSpacing, imgui.ImVec2(1, 2.5))
	imgui.SetCursorPos(imgui.ImVec2(5, 33))

	if imgui.Button(fa.ICON_FA_BACKWARD..u8""..fa.ICON_FA_BACKWARD, imgui.ImVec2(50, 20)) then
		lua_thread.create(function ()
			if spec_id - 1 < 0 then
				sampAddChatMessage("BACK ID = -1 | Доступно только NEXT", 16711680)

				return
			end

			testnext = spec_id - 1

			while not sampIsPlayerConnected(testnext) or sampGetPlayerScore(testnext) == 0 do
				wait(0)

				if testnext - 1 < 0 then
					sampAddChatMessage("BACK ID = -1 | Доступно только NEXT", 16711680)

					return
				end

				testnext = testnext - 1
			end
			spec_id = testnext
			sampSendChat("/re " .. testnext)
		end)
	end

	imgui.SetCursorPos(imgui.ImVec2(58, 6))

	if imgui.Button(u8("Stats")) then
		sampSendChat("/check " .. spec_id)
	end

	imgui.SameLine()

	if imgui.Button(u8("Реги")) then
		lua_thread.create(function()
			sampSendChat("/getip " .. spec_id)
			wait(900)
			sampSendChat("/pgetip " .. spec_id)
		end)
	end

	imgui.SameLine()

	if imgui.Button(u8("Спавн")) then
		sampSendChat("/spplayer " .. spec_id)
	end

	imgui.SameLine()

	if imgui.Button(u8("UP"), imgui.ImVec2(30, 21)) then
		sampSendChat("/Slap " .. spec_id .. " 1")
	end

	imgui.SameLine()

	if imgui.Button(u8("DOWN")) then
		sampSendChat("/Slap " .. spec_id .. " 2")
	end

	imgui.SameLine()

	if imgui.Button(u8("Разморозить")) then
		sampSendChat("/unfreeze " .. spec_id)
	end

	imgui.SameLine()

	if imgui.Button(u8("Заморозить")) then
		sampSendChat("/freeze " .. spec_id)
	end

	imgui.SetCursorPos(imgui.ImVec2(58, 33))

	if imgui.Button(u8("ТП к себе")) then
		lua_thread.create(function ()
sampSendChat('/reoff')
wait(500)
sampSendChat('/gethere '..spec_id)
		end)
	end

	imgui.SameLine()

	if imgui.Button(u8("Выдать HP")) then
		sampSetChatInputEnabled(true)
		sampSetChatInputText("/sethp " .. spec_id .. " 100")
	end

	imgui.SameLine()

	if imgui.Button(u8("/weap")) then
		sampSendChat("/weap " .. spec_id)
	end

	imgui.SameLine()

	if imgui.Button(u8("Наказания")) then
		sampSendChat("/checkpunish " .. spec_id)
	end

	imgui.SameLine()

	if imgui.Button(u8("Skill gun")) then
		sampSendChat("/checkskills " .. spec_id)
	end

	imgui.SameLine()

	if imgui.Button(u8("/iwep"), imgui.ImVec2(40, 21)) then
		sampSendChat("/iwep " .. spec_id)
	end

	imgui.SameLine(10)
	imgui.SetCursorPos(imgui.ImVec2(415, 33))

	if imgui.Button(fa.ICON_FA_FORWARD..u8""..fa.ICON_FA_FORWARD, imgui.ImVec2(50, 20)) then
		lua_thread.create(function ()
			if spec_id + 1 > 999 then
				sampAddChatMessage("NEXT ID = 1000 | Доступно только BACK", 16711680)

				return
			end

			testnext = spec_id + 1

			while not sampIsPlayerConnected(testnext) or sampGetPlayerScore(testnext) == 0 do
				wait(0)

				if testnext + 1 > 999 then
					sampAddChatMessage("NEXT ID = 1000 | Доступно только BACK", 16711680)

					return
				end

				testnext = testnext + 1
			end
			spec_id = testnext
			sampSendChat("/re " .. testnext)
		end)
end

	imgui.SetCursorPos(imgui.ImVec2(58, 60))

	if imgui.Button(u8("Вы тут?")) then
		sampSendChat('/pm '..spec_id..' 0 Уважаемый '..nick..', Вы тут? Ответьте "Да" в /b (/n) чат.')
	end

	imgui.SameLine()

	if imgui.Button(u8("/plveh")) then
		sampSetChatInputEnabled(true)

		cursorotstup = 8

		if tonumber(spec_id) < 10 then
			cursorotstup = cursorotstup + 1
		elseif tonumber(spec_id) < 100 and tonumber(spec_id) >= 10 then
			cursorotstup = cursorotstup + 2
		elseif tonumber(spec_id) < 1000 and tonumber(spec_id) >= 100 then
			cursorotstup = cursorotstup + 3
		end

		sampSetChatInputText("/plveh " .. spec_id .. "  1")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
	end


	imgui.SameLine()

	if imgui.Button(u8("Флип"), imgui.ImVec2(50, 21)) then
		sampSendChat("/flip " .. spec_id)
	end

	imgui.SameLine()

	if imgui.Button(u8("ТП к игроку")) then
	lua_thread.create(function()
sampSendChat('/reoff')  
wait(900)
sampSendChat('/goto ' .. spec_id)
end)
	end

	imgui.SameLine()

	if imgui.Button(u8("/az")) then
		lua_thread.create(function ()
sampSendChat('/reoff')
wait(900)
sampSendChat('/az '..spec_id)
		end)
	end

	imgui.SameLine()

	if imgui.Button(u8("Обновить")) then
		sampSendChat("/re "..spec_id)	
	end

	imgui.SameLine()

	if imgui.Button(u8("Выйти")) then
		sampSendChat("/reoff")
		ReconWindow.v = false
		PunishWindow.v = false 	
		InfoWindow.v = false 	
	end

	imgui.PopStyleVar()
	imgui.End()
	end
end


if PunishWindow.v and cfg.main.menurecon then
	screenWidth, screenHeight = getScreenResolution()
	
	local nick = sampGetPlayerNickname(spec_id)

	imgui.SetNextWindowPos(imgui.ImVec2(posX10.v, posY10.v), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.SetNextWindowSize(imgui.ImVec2(160, 175), imgui.Cond.FirstUseEver)
	imgui.Begin(u8("Быстрые наказания"), _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoBringToFrontOnFocus + imgui.WindowFlags.NoSavedSettings)
if imgui.Button(u8'Выдать KICK', imgui.ImVec2(-1, 20)) then
imgui.OpenPopup(u8'Наказание KICK')
end
		if imgui.BeginPopupModal(u8'Наказание KICK', PunishWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
if imgui.Button(u8'Указать свою причину', imgui.ImVec2(-1, 20)) then
		sampSetChatInputEnabled(true)
		sampSetChatInputText("/kick " .. spec_id .. " ")
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'Тихий кик', imgui.ImVec2(140, 20)) then
sampSendChat('/skick '..spec_id)
imgui.CloseCurrentPopup()
end
if imgui.Button(u8'Помеха', imgui.ImVec2(140, 20)) then
sampSendChat('/kick '..spec_id..' помеха')
imgui.CloseCurrentPopup()
end
if imgui.Button(u8'Перезайдите (лаги)', imgui.ImVec2(140, 20)) then
sampSendChat('/kick '..spec_id..' перезайдите (лаги)')
imgui.CloseCurrentPopup()
end
if imgui.Button(u8'АФК 50+', imgui.ImVec2(140, 20)) then
sampSendChat('/kick '..spec_id..' AFK 50+')
imgui.CloseCurrentPopup()
end 
if imgui.Button(u8'Закрыть', imgui.ImVec2(140, 20)) then
imgui.CloseCurrentPopup()
end
		imgui.EndPopup()
	end
if imgui.Button(u8'Выдать JAIL', imgui.ImVec2(-1, 20)) then
imgui.OpenPopup(u8'Наказание JAIL')
end
if imgui.BeginPopupModal(u8'Наказание JAIL', PunishWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
if imgui.Button(u8'Указать свою причину', imgui.ImVec2(140, 20)) then
		sampSetChatInputEnabled(true)
		sampSetChatInputText("/jail " .. spec_id .. " ")
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'ДМ', imgui.ImVec2(140, 20)) then
		otstupcursor()
		sampSetChatInputText("/jail " .. spec_id .. "  ДМ")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'ДМ ЗЗ', imgui.ImVec2(140, 20)) then
		otstupcursor()
		sampSetChatInputText("/jail " .. spec_id .. "  ДМ ЗЗ")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'ДБ', imgui.ImVec2(140, 20)) then
		otstupcursor()
		sampSetChatInputText("/jail " .. spec_id .. "  ДБ")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'ДМ слет', imgui.ImVec2(140, 20)) then
otstupcursor()
		sampSetChatInputText("/jail " .. spec_id .. "  ДМ слет")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'ДБ слет', imgui.ImVec2(140, 20)) then
		otstupcursor()
		sampSetChatInputText("/jail " .. spec_id .. "  ДБ слет")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'Закрыть', imgui.ImVec2(140, 20)) then
imgui.CloseCurrentPopup()
end
		imgui.EndPopup()
	end
if imgui.Button(u8'Выдать MUTE', imgui.ImVec2(-1, 20)) then
imgui.OpenPopup(u8'Наказание MUTE')
end
if imgui.BeginPopupModal(u8'Наказание MUTE', PunishWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
if imgui.Button(u8'Указать свою причину', imgui.ImVec2(140, 20)) then
		sampSetChatInputEnabled(true)
		sampSetChatInputText("/mute " .. spec_id .. " ")
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'Оскорбление', imgui.ImVec2(140, 20)) then
		otstupcursor()
		sampSetChatInputText("/mute " .. spec_id .. "  оскорбление")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'Неадекват', imgui.ImVec2(140, 20)) then
otstupcursor()
		sampSetChatInputText("/mute " .. spec_id .. "  неадекватное поведение")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'Транслит', imgui.ImVec2(140, 20)) then
		otstupcursor()
		sampSetChatInputText("/mute " .. spec_id .. "  транслит")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'Упом. родных', imgui.ImVec2(140, 20)) then
		otstupcursor()
		sampSetChatInputText("/mute " .. spec_id .. "  упом. родных")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'Оск. родных', imgui.ImVec2(140, 20)) then
		otstupcursor()
		sampSetChatInputText("/mute " .. spec_id .. "  оск. родных")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'Закрыть', imgui.ImVec2(140, 20)) then
imgui.CloseCurrentPopup()
end
		imgui.EndPopup()
	end
if imgui.Button(u8'Выдать WARN', imgui.ImVec2(-1, 20)) then
imgui.OpenPopup(u8'Наказание WARN')
end
if imgui.BeginPopupModal(u8'Наказание WARN', PunishWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
if imgui.Button(u8'Указать свою причину', imgui.ImVec2(-1, 20)) then
		sampSetChatInputEnabled(true)
		sampSetChatInputText("/warn " .. spec_id .. " ")
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'ДМ ЗЗ', imgui.ImVec2(-1, 20)) then
sampSendChat('/warn '..spec_id..' ДМ ZZ')
end
if imgui.Button(u8'nRP коп', imgui.ImVec2(-1, 20)) then
sampSendChat('/warn '..spec_id..' nRP cop')
end
if imgui.Button(u8'+С', imgui.ImVec2(-1, 20)) then
sampSendChat('/warn '..spec_id..' +С')
end
if imgui.Button(u8'ТК', imgui.ImVec2(-1, 20)) then
sampSendChat('/warn '..spec_id..' ТК')
end
if imgui.Button(u8'СК', imgui.ImVec2(-1, 20)) then
sampSendChat('/warn '..spec_id..' СК')
end
if imgui.Button(u8'Закрыть', imgui.ImVec2(140, 20)) then
imgui.CloseCurrentPopup()
end
		imgui.EndPopup()
	end
if imgui.Button(u8'Выдать BAN', imgui.ImVec2(-1, 20)) then
imgui.OpenPopup(u8'Наказание BAN')
end
if imgui.BeginPopupModal(u8'Наказание BAN', PunishWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
if imgui.Button(u8'Указать свою причину', imgui.ImVec2(-1, 20)) then
   sampSetChatInputEnabled(true)
   sampSetChatInputText("/ban " .. spec_id .. " ")
   imgui.CloseCurrentPopup()
end
if imgui.Button(u8'Ракбот', imgui.ImVec2(-1, 20)) then
		otstupcursor1()
		sampSetChatInputText("/ban " .. spec_id .. "  ракбот")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'Реклама', imgui.ImVec2(-1, 20)) then
otstupcursor1()
		sampSetChatInputText("/ban " .. spec_id .. "  реклама")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'АХК', imgui.ImVec2(-1, 20)) then
otstupcursor1()
		sampSetChatInputText("/ban " .. spec_id .. "  АХК")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
		imgui.CloseCurrentPopup()
end
if imgui.Button(u8'Бот', imgui.ImVec2(-1, 20)) then
otstupcursor1()
		sampSetChatInputText("/ban " .. spec_id .. "  бот")
		sampSetChatInputCursor(cursorotstup, cursorotstup)
		imgui.CloseCurrentPopup()
end 
if imgui.Button(u8'Закрыть', imgui.ImVec2(140, 20)) then
imgui.CloseCurrentPopup()
end
		imgui.EndPopup()
	end
if imgui.Button(u8'Выдать ТСР', imgui.ImVec2(-1, 20)) then
imgui.OpenPopup(u8'Наказание ТСР')
end
if imgui.BeginPopupModal(u8'Наказание ТСР', PunishWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar) then
if imgui.Button(u8'Указать свою причину', imgui.ImVec2(-1, 20)) then
   sampSetChatInputEnabled(true)
   sampAddChatMessage(tag..'На Arizona Arena данная функция не работает!', -1)
   imgui.CloseCurrentPopup()
end
if imgui.Button(u8'Закрыть', imgui.ImVec2(140, 20)) then
imgui.CloseCurrentPopup()
end
		imgui.EndPopup()
	end
	imgui.End()
end
	
	if ChangeLogWindow.v then 
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(730, 700), imgui.Cond.FirstUseEver)

		imgui.Begin('##ChangeLogWindow', ChangeLogWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.ShowBorders)
			imgui.PushFont(infoFs)
			imgui.CenterTextColoredRGB('{E78284}Новое обновление!')
			imgui.PopFont()
				imgui.SameLine()
				local p = imgui.GetCursorScreenPos()
				local s = imgui.CalcTextSize('new')
				imgui.GetWindowDrawList():AddRectFilled(imgui.ImVec2(p.x - 4, p.y + 2), imgui.ImVec2(p.x + s.x + 2, p.y + s.y + 2), 0xFF0000FF, 10, 15)
				imgui.Text('new')
			imgui.CenterTextColoredRGB('{606060}Версия: {868686}'..thisScript().version)
			imgui.PushStyleColor(imgui.Col.ChildWindowBg, imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.ChildWindowBg]))
			imgui.BeginChild('##ChangeLog', imgui.ImVec2(-1, imgui.GetWindowHeight() - 105), true)
				for count = 0, #changelog do
					local count = #changelog - count
					local ver = changelog[count]['ver']
					local date = changelog[count]['date']
					local info = changelog[count]['info']
					local patches = changelog[count]['patches']['info']

					imgui.PushFont(fs20)
					imgui.TextColoredRGB(sc..ver)
					imgui.PopFont()

					imgui.PushTextWrapPos(imgui.GetWindowWidth() - 30)
					for k, v in ipairs(info) do
						imgui.TextColoredRGB('{606060}'..k..') {SSSSSS}'..v) 
					end
					if #info <= 0 then imgui.TextColoredRGB('{505050}(Данная версия не имеет изменений)') end

					if #patches > 0 then
						imgui.TextColoredRGB(sc..'>> Список исправлений ('..#patches..')')
						imgui.Hint('show_patches:'..count, u8('Кликните, что бы '..(changelog[count]['patches']['show'] and 'свернуть' or 'развернуть')))
						if imgui.IsItemClicked() then 
							changelog[count]['patches']['show'] = not changelog[count]['patches']['show']
						end
						if changelog[count]['patches']['show'] then
							local p1 = imgui.GetCursorScreenPos()
							for _, info in ipairs(patches) do
								imgui.SetCursorPosX(40)
								imgui.TextColoredRGB('{909090}'..info)
							end
							local p2 = imgui.GetCursorScreenPos()
							imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p1.x + 20.5, p1.y + 2), imgui.ImVec2(p2.x + 20, p2.y - 2), 0xFF00C235, 2)
						end
					end
					imgui.PopTextWrapPos()

					imgui.NewLine()
				end
			imgui.EndChild()
			imgui.SetCursorPosX((imgui.GetWindowWidth() - 300) / 2)
			
			imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.Border]))
			imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.Button]))
			if imgui.Button(u8'Закрыть окно', imgui.ImVec2(300, 30)) then 
				ChangeLogWindow.v = false 
			end
			imgui.PopStyleColor(3)
		imgui.End()
	end

if ReportWindow.v then 
		local sw, sh = getScreenResolution() 
		imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(465, 215), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'Жалоба/Вопрос', ReportWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.AlwaysAutoResize)
			imgui.Text(u8"Жалоба от: ".. nick_rep .."[".. report_id .."]")
			imgui.SameLine()
			imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(0.92549020051956, 0.6745098233223, 0.6745098233223, 1))
			imgui.Text(fa.ICON_FA_DESKTOP..'')
			imgui.PopStyleColor() 
			imgui.SameLine()
			if imgui.CogButton() then
				sampSendChat('/re '..report_id)
			end
			imgui.Hint('slejkare', u8'Перейти в слежку за автором репорта')
			imgui.SameLine(435)
			imgui.Text(fa.ICON_FA_WRENCH..'')
			imgui.Hint('helpcur', u8'Если у вас забагался курсор, то пофиксить проблему\nможно переведя раскладку на англ. яз., после откройте чат,\nдалее закройте его, и поле ввода снова станет доступно!')
			imgui.Separator()
			imgui.Text(u8:encode(report_text))
			imgui.Separator()     
			local otvet = text_buffer_rep.v
			if len(text_buffer_rep.v) > 55 then 
			imgui.CenterTextColoredRGB('{fe4e4e} Ответ должен содержать не более 70 символов ['..len(text_buffer_rep.v)..'/70]') 
			end
			imgui.PushItemWidth(415)
			if len(text_buffer_rep.v) >= 70 then 
			imgui.InputText(u8'##sfdkdfkdar', text_buffer_rep, imgui.InputTextFlags.ReadOnly)
			else
			imgui.InputText(u8'##sfdkdfkdar', text_buffer_rep, imgui.InputTextFlags.AutoSelectAll)
			end
			imgui.SameLine()
			imgui.Text(fa.ICON_FA_RETWEET..'')
			if len(text_buffer_rep.v) >= 70 then 
			if imgui.Button(u8'Сбросить поле ввода', imgui.ImVec2(444, 20)) then
			text_buffer_rep.v = ''
			end
			end
			imgui.Separator()
			if imgui.Button(fa.ICON_FA_ROBOT..u8' Слежу за наруш', imgui.ImVec2(145, 20)) then
				if report_text:match("(%d+)") ~= nil then  
					if sampIsPlayerConnected(report_text:gmatch("(%d+)")) then 
						local template = u8:decode(reason_settings_report[4].v)
						local template = template:gsub('{nick_rep}', nick_rep) 
						local template = template:gsub('{my_id}', my_id)
						local template = template:gsub('{id_rep}', id_rep)
						local template = template:gsub('{my_name}', my_name) 
						sampSendDialogResponse(6370, 1, _, template)   
						for idjb in report_text:gmatch("(%d+)") do
							if idjb then 
								if sampIsPlayerConnected(idjb) then
									sampSendChat('/re '..idjb ) 
								end
							end
						end						
						text_buffer_rep.v = ''
						reconusers_state.v = true 
						ReportWindow.v = false
					else 
						sampAddChatMessage("{808080}[Слежка] Вы не можете начать следить за нарушителем,т.к не указан айди в репорте или игрок оффлайн.",-1) 
	  				end 
				end 
			end
			imgui.SameLine()
			if imgui.Button(fa.ICON_FA_PEOPLE_CARRY..u8' Помочь автору', imgui.ImVec2(145, 20)) then
				local template = u8:decode(reason_settings_report[2].v)
				
				local template = template:gsub('{nick_rep}', nick_rep) 
				local template = template:gsub('{my_id}', my_id)
				local template = template:gsub('{id_rep}', id_rep)
				local template = template:gsub('{my_name}', my_name) 
				sampSendDialogResponse(6370, 1, _, template)
				text_buffer_rep.v = ''
				ReportWindow.v = false
				sampSendChat('/re ' .. report_id) 
				sampAddChatMessage("[Автоматическая слежка] Вы ушли в слежку за " .. nick_rep .. "[" .. report_id .. "]", 14628149) 
			end
			imgui.SameLine()
			if imgui.Button(fa.ICON_FA_COMMENTS..u8' Переслать в /a чат', imgui.ImVec2(145, 20)) then
			sampSendChat("/a >>> [РЕПОРТ] ".. report_name .."[".. report_id .."]: " .. report_text.. " ")
			end
			if imgui.Button(fa.ICON_FA_MAP_MARKED_ALT..u8' Помощь по GPS', imgui.ImVec2(145, 20)) then
			if not doesFileExist(getGameDirectory()..'//moonloader//AdminToolsKing//gps.json') then
			sampAddChatMessage(tag..'У вас отсутствует файл с навигацией для GPS!', -1)
			else
			imgui.OpenPopup(u8'Помощь по GPS')
			end
			end
				if imgui.BeginPopupModal(u8'Помощь по GPS', ReportWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar) then
				local gps = io.open('moonloader\\AdminToolsKing\\gps.json', 'a+')
	gpsqwd = decodeJson(gps:read('*a'))
	gps:close()
	
		imgui.PushItemWidth(-1)
		imgui.InputText(u8"##4112dasdasadsads4124124124124", buffer34)
		imgui.PopItemWidth()
		if imgui.Button(u8'Закрыть', imgui.ImVec2(510, 25)) then
					imgui.CloseCurrentPopup()
				end
		lua_thread.create(function()
			local search = u8:decode(buffer34.v)
			if search ~= '' then
			searchv = true
			for i, v in ipairs(gpsqwd) do
				local ansi_v = u8:decode(v)
					if ansi_v ~= nil then
				otvetslow = rusLower(ansi_v)
				searchlow = rusLower(search)
							if string.find(otvetslow, searchlow, 1, true) then
										if imgui.Button(v, imgui.ImVec2(510, 25)) then
											sampSendDialogResponse(6370, 1, _, ansi_v)
											text_buffer_rep.v = ''
											imgui.Process = false											
										end
							end
					end
					end
			else
				searchv = false
			end
		
	end)


		for i, v in ipairs(gpsqwd) do
			if not searchv then
		if imgui.Button(v, imgui.ImVec2(510, 25)) then
			local ansi_v = u8:decode(v)
				sampSendDialogResponse(6370, 1, _, ansi_v)
				text_buffer_rep.v = ''
				imgui.Process = false
		end
			end
	end
				imgui.EndPopup()
			end
			imgui.SameLine()
			if imgui.Button(fa.ICON_FA_LEVEL_UP_ALT..u8' ТП к игроку', imgui.ImVec2(145, 20)) then
					sampSendDialogResponse(6370, 1, _, 'Уважаемый игрок, сейчас попробую вам помочь!')                
					text_buffer_rep.v = ''
					ReportWindow.v = false
					sampSendChat('/g ' .. report_id)
			end
			imgui.SameLine()
			if imgui.Button(fa.ICON_FA_TABLET_ALT..u8' Список команд', imgui.ImVec2(145, 20)) then
			if not doesFileExist(getGameDirectory()..'//moonloader//AdminToolsKing//commands.json') then
			sampAddChatMessage(tag..'У вас отсутствует файл со списком команд!', -1)
			else
			imgui.OpenPopup(u8'Список команд')
			end
			end
							if imgui.BeginPopupModal(u8'Список команд', ReportWindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar) then
				local commands = io.open('moonloader\\AdminToolsKing\\commands.json', 'a+')
	commandsqwd = decodeJson(commands:read('*a'))
	commands:close()
	
		imgui.PushItemWidth(-1)
		imgui.InputText(u8"##4112dasdasadsads4124124124124", buffer38)
		imgui.PopItemWidth()
		if imgui.Button(u8'Закрыть', imgui.ImVec2(510, 25)) then
					imgui.CloseCurrentPopup()
				end
		lua_thread.create(function()
			local search = u8:decode(buffer38.v)
			if search ~= '' then
			searchv = true
			for i, v in ipairs(commandsqwd) do
				local ansi_v = u8:decode(v)
					if ansi_v ~= nil then
				otvetslow = rusLower(ansi_v)
				searchlow = rusLower(search)
							if string.find(otvetslow, searchlow, 1, true) then
										if imgui.Button(v, imgui.ImVec2(510, 25)) then
											sampSendDialogResponse(6370, 1, _, ansi_v)
											text_buffer_rep.v = ''
											imgui.Process = false											
										end
							end
					end
					end
			else
				searchv = false
			end
		
	end)

		for i, v in ipairs(commandsqwd) do
			if not searchv then
		if imgui.Button(v, imgui.ImVec2(510, 25)) then
			local ansi_v = u8:decode(v)
				sampSendDialogResponse(6370, 1, _, ansi_v)
				text_buffer_rep.v = ''
				imgui.Process = false
		end
			end
	end
				imgui.EndPopup()
			end
			if imgui.Button(fa.ICON_FA_PALETTE..u8' Таблица цветов', imgui.ImVec2(145, 20)) then
				ColorsWindow.v = not ColorsWindow.v
				imgui.Process = ColorsWindow.v 
			end
			imgui.SameLine()
			if imgui.Button(fa.ICON_FA_CAR_CRASH..u8' Флипнуть', imgui.ImVec2(145, 20)) then
				sampSendChat('/flip '..report_id)
				sampSendDialogResponse(6370, 1, _, 'Уважаемый '..nick_rep..', флипнул Вас.')
				text_buffer_rep.v = ''
				ReportWindow.v = false
			end
			imgui.SameLine()
			peredam()
			if imgui.Button(fa.ICON_FA_MOTORCYCLE..u8' Выдать НРГ', imgui.ImVec2(145, 20)) then
				sampSendChat('/plveh ' .. report_id .. ' 522 1')
				local template = u8:decode(reason_settings_report[1].v)
				local template = template:gsub('{nick_rep}', nick_rep) 
				
				local template = template:gsub('{my_id}', my_id)
				local template = template:gsub('{id_rep}', id_rep)
				local template = template:gsub('{my_name}', my_name) 
				sampSendDialogResponse(6370, 1, _, template)
				text_buffer_rep.v = ''
				ReportWindow.v = false
			end
			imgui.SameLine()
			if imgui.Button(fa.ICON_FA_USER..u8' Заспавнить', imgui.ImVec2(145, 20)) then
				sampSendChat('/spplayer ' .. report_id)
				local template = u8:decode(reason_settings_report[6].v)
				local template = template:gsub('{nick_rep}', nick_rep) 
				
				local template = template:gsub('{my_id}', my_id)
				local template = template:gsub('{id_rep}', id_rep)
				local template = template:gsub('{my_name}', my_name) 
				sampSendDialogResponse(6370, 1, _, template)
				text_buffer_rep.v = ''
				ReportWindow.v = false
			end
			imgui.SameLine()
			if imgui.Button(fa.ICON_FA_MEDKIT..u8' Выдать HP', imgui.ImVec2(145, 20)) then
				sampSendChat('/sethp ' .. report_id .. ' 100')
				local template = u8:decode(reason_settings_report[7].v)
				local template = template:gsub('{nick_rep}', nick_rep) 
				
				local template = template:gsub('{my_id}', my_id)
				local template = template:gsub('{id_rep}', id_rep)
				local template = template:gsub('{my_name}', my_name) 
				sampSendDialogResponse(6370, 1, _, template)
				text_buffer_rep.v = ''
				ReportWindow.v = false
			end
			imgui.Separator()
			reportenter = 0

			for qw, er in pairs(cfg.reportname) do
				if imgui.Button(u8(er), imgui.ImVec2(145, 20)) then
					if cfg.reportstyle[qw] == 0 then
						if cfg.reportotvet[qw] ~= "" then
							sampSendDialogResponse(6370, 1, _, cfg.reportotvet[qw])
							ReportWindow.v = false
						else
							sampAddChatMessage("[Ошибка] Введите ответ. Либо закройте репорт.", 14628149)
						end
					elseif cfg.reportstyle[qw] == 1 then
						text_buffer_rep.v = u8(cfg.reportotvet[qw])
					end
				end
				reportenter = reportenter + 1
				if reportenter == 3 then
					reportenter = 0
				elseif #cfg.reportname ~= qw then
					imgui.SameLine()
				end
			end
			imgui.Separator()
			--imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.090196080505848, 0.52549022436142, 0.52549022436142, 1))
	if imgui.Button(u8'Отправить',imgui.ImVec2(145, 20)) then 
sampSendDialogResponse(6370, 1, _, u8:decode(otvet))
text_buffer_rep.v = ''
ReportWindow.v = false
	end
	imgui.SameLine()
	imgui.SetCursorPosX(308)
	if imgui.Button(u8'Закрыть',imgui.ImVec2(145, 20)) then
	imgui.OpenPopup(u8'Подтверждение закрытия')  
	end
	--imgui.PopStyleColor()
		if imgui.BeginPopupModal(u8'Подтверждение закрытия', ReportWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
		local size = imgui.GetWindowSize()
		btns_sizeX = size.x / 2 - 10
		imgui.Text(u8'Вы действительно хотите закрыть репорт?')
		imgui.Text(u8'Из-за этого можно потерять репутацию.')
		if imgui.Button(u8' Да',imgui.ImVec2(btns_sizeX,20)) then sampSendDialogResponse(6370, 1, _, '>> Skipped >>') ReportWindow.v = false imgui.CloseCurrentPopup()   end
		imgui.SameLine()
		if imgui.Button(u8' Нет', imgui.ImVec2(btns_sizeX, 20)) then
			imgui.CloseCurrentPopup()
		end
		imgui.EndPopup()
	end
			imgui.End()
	end
	
	 if to.v then
		yuiop()
	end
	
	if myOnline.v then 
		imgui.SetNextWindowSize(imgui.ImVec2(400, 230), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(sX / 2, sY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'#WeekOnline', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.ShowBorders + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)
			imgui.SetCursorPos(imgui.ImVec2(15, 10))
			imgui.PushFont(fsClock) imgui.CenterTextColoredRGB('Онлайн за неделю') imgui.PopFont()
			imgui.CenterTextColoredRGB('{0087FF}Всего отыграно: '..get_clock(cfg.onWeek.full))
			imgui.NewLine()
			for day = 1, 6 do 
				imgui.Text(u8(tWeekdays[day])); imgui.SameLine(250)
				imgui.Text(get_clock(cfg.myWeekOnline[day]))
			end 
			
			imgui.Text(u8(tWeekdays[0])); imgui.SameLine(250)
			imgui.Text(get_clock(cfg.myWeekOnline[0]))

			imgui.SetCursorPosX((imgui.GetWindowWidth() - 200) / 2)
			if imgui.Button(u8'Закрыть', imgui.ImVec2(200, 25)) then myOnline.v = false end
		imgui.End()
	end
	
	end
  
  	function getTargetBlipCoordinatesFixed()
		local bool, x, y, z = getTargetBlipCoordinates(); if not bool then return false end
		requestCollision(x, y); loadScene(x, y, z)
		local bool, x, y, z = getTargetBlipCoordinates()
		return bool, x, y, z
	end
  
function flood(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /flood {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
sampSendChat('/'..cfg.main.typeflood..' '..nick..', '..cfg.main.flood.. ' Флуд')
end
end
end


function dm(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /dm {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
sampSendChat('/'..cfg.main.typedm..' '..nick..' '..cfg.main.dm.. ' ДМ')
end
end
end


function sampSetChatInputCursor(slot0, slot1)
	slot5 = require("memory")
	slot7 = getStructElement(sampGetInputInfoPtr(), 8, 4)

	slot5.setint8(slot7 + 286, tonumber(slot0))
	slot5.setint8(slot7 + 281, tonumber(slot1 or slot0))

	return true
end

function db(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /db {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
sampSendChat('/'..cfg.main.typedb..' '..nick..', '..cfg.main.db.. ' ДБ')
end
end
end


function oskrod(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /oskrod {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
sampSendChat('/'..cfg.main.typeosk..' '..nick..', '..cfg.main.oskrod.. ' Оскорбление родных')
end
end
end


function sbiv(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /sbiv {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
sampSendChat('/warn '..nick..', Сбив анимации')
end
end
end


function dbk(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /dbk {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
sampSendChat('/'..cfg.main.typedbk..' '..nick..', '..cfg.main.dbk.. ' ДБ ковшом')
end
end
end


function upomrod(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /upomrod {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
sampSendChat('/'..cfg.main.typeupom..' '..nick..', '..cfg.main.upomrod.. ' Упоминание родных')
end
end
end


function ncop(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /ncop {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
sampSendChat('/'..cfg.main.typencop..' '..nick..', '..cfg.main.ncop.. ' нРП коп')
end
end
end


function cheat(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /cheat {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
sampSendChat('/'..cfg.main.typecheat..' '..nick..', '..cfg.main.cheat.. ' ИЗП')
end
end
end


function ntune(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /ntune {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
sampSendChat('/'..cfg.main.typentune..' '..nick..', '..cfg.main.ntune.. ' нРП тюнинг')
end
end
end


function nead(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /nead {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
sampSendChat('/'..cfg.main.typenead..' '..nick..', '..cfg.main.nead.. ' неадекватное поведение')
end
end
end


function oskadm(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /oskadm {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
sampSendChat('/'..cfg.main.typeoskadm..' '..nick..', '..cfg.main.oskadm.. ' оскорбление адми[н]истрации')
end
end
end


function desc(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /desc {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..nick..', 0 Описание вашего персонажа было удалено. Причина: nRP описание', -1)
sampSendChat('/adeldesc '..nick..'')
end
end
end


function pc(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /pc {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
sampSendChat('/warn '..nick..', +С')
end
end
end

function mdm(id)
if id== nil or id == " " or id == "" then
sampAddChatMessage(tag..'Используйте: /mdm {E78284}[ID]', -1)
else
local result = sampIsPlayerConnected(id)
if not result then
sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
else
local nick = sampGetPlayerNickname(id)
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
sampSendChat('/'..cfg.main.typemdm..' '..nick..', '..cfg.main.mdm.. ' Массовый ДМ')
end
end
end




function sk(id)
	if id== nil or id == " " or id == "" then
		sampAddChatMessage(tag..'Используйте: /sk {E78284}[ID]', -1)
	else
		local result = sampIsPlayerConnected(id)
		if not result then
			sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
		else
			local nick = sampGetPlayerNickname(id)
			sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
			sampSendChat('/warn '..nick..' СК')
		end
	end
end

function tk(id)
	if id== nil or id == " " or id == "" then
		sampAddChatMessage(tag..'Используйте: /tk {E78284}[ID]', -1)
	else
		local result = sampIsPlayerConnected(id)
		if not result then
			sampAddChatMessage(tag.."Игрок не в сети {E78284}& {84A6E7}данный игрок администратор. Возможно Вы ошиблись {E78284}ID'ом", -1)
		else
			local nick = sampGetPlayerNickname(id)
			sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish))
			sampSendChat('/pm '..id..' 0 '..u8:decode(cfg.main.infopunish1))
			sampSendChat('/warn '..nick..' ТК')
		end
	end
end




function spcarall(arg)
if tonumber(arg) and tonumber(arg) >= 5 and tonumber(arg) <= 60 then
lua_thread.create(function()
sampSendChat('/ao [Спавн Транспорта] Уважаемые игроки, через '..arg..' секунд произойдет респавн всего транспорта.')
sampSendChat('/ao [Спавн Транспорта] Займите свой транспорт, в противном случае он пропадет!')
for i = arg,1,-1 do
wait(1000)
printStyledString("Spawn cars through: ~r~"..i, 1000, 5)
end
		spcars = true
		sampSendChat('/apanel')
sampSendChat('/ao [Спавн Транспорта] Спавн транспорта произошел успешно | Приятной игры!')		
	end)
	else
	sampAddChatMessage(tag.."Вы указали неверное время, диапазон [5-60] & спавн транспорта уже идет.", -1)
end
end



function tpcssss()
_, x, y, z = SearchMarker()
if not _ then 
sampAddChatMessage(tag.."Маркер для телепорта {E78284}не найден{84A6E7}.", -1) else setCharCoordinates(PLAYER_PED, x, y, z) end
end

function SearchMarker(posX, posY, posZ)
		local ret_posX = 0.0
		local ret_posY = 0.0
		local ret_posZ = 0.0
		local isFind = false
		for id = 0, 31 do
			local MarkerStruct = 0
			MarkerStruct = 0xC7F168 + id * 56
			local MarkerPosX = representIntAsFloat(readMemory(MarkerStruct + 0, 4, false))
			local MarkerPosY = representIntAsFloat(readMemory(MarkerStruct + 4, 4, false))
			local MarkerPosZ = representIntAsFloat(readMemory(MarkerStruct + 8, 4, false))
			if MarkerPosX ~= 0.0 or MarkerPosY ~= 0.0 or MarkerPosZ ~= 0.0 then
				ret_posX = MarkerPosX
				ret_posY = MarkerPosY
				ret_posZ = MarkerPosZ
				isFind = true
			end
		end
		return isFind, ret_posX, ret_posY, ret_posZ
	end

function ev.onPlayerQuit(id, reason)
	if cfg.main.leaveChecker then 
		table.insert(leavePlayers, {
			nickname        = sampGetPlayerNickname(id), 
			id              = id, 
			reason          = quitReason[reason + 1],
			timeQuit = os.date("%H:%M:%S"),
			playerColor     = bit.tohex(getPlayerColorWithoutAlpha(id))
		})
	end 
end

function ev.onPlayerJoin(id, color, isNpc, nickname)
	if cfg.main.connectChecker and not sampGetGamestate() ~= 3 then 
		table.insert(connectPlayers, {
			nickname        = nickname,
			id              = id, 
			timeJoin = os.date("%H:%M:%S"),
			playerColor     = bit.tohex(getPlayerColorWithoutAlpha(id))
		})
	end 
end

function autoAdmins()
	while true do wait(0)
		if cfg.main.adminsChecker and not sampIsCursorActive() then
			sampSendChat("/admins")
			toHide = true
			wait(50000)
		end
	end
end

function getNick(id)
	local nick = sampGetPlayerNickname(id)
	return nick
end

function ev.onSendChat(message)
	if message:find('(.*)') and cfg.main.autob then
		sampSendChat('/b ' .. message)
		return false
	end
end


function ev.onDisplayGameText(style, time, text)
if cfg.main.lovlyareporta and style_lovlyareporta.v == 2 and not isGamePaused() and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() and text:lower():find('report ++') then 
		sampSendChat('/ot')
		end
if text:lower():find('PLAYER DISCONNECT') then 
ReconWindow.v = false
PunishWindow.v = false
InfoWindow.v = false
end
end

function ev.onShowDialog(id, dialogStyle, dialogTitle, okButtonText, cancelButtonText, dialogText)
if id == 91 and cfg.main.autounban and givepun then
sampSendDialogResponse(91, 0, 0, '')
return false
end
	if dialogTitle:find("Администрация онлайн") and cfg.main.adminsChecker then
		for line in dialogText:gsub('{......}',''):gmatch('([^\n\r]+)') do
			if line:find("(.+)%[(%d+)%]%s+(.+)%s+%[(%d+)/3%]%s+(%d+)") then
				local nickadm,idadm,jobadm,warnsadm,repadm = line:match("(.+)%[(%d+)%]%s+(.+)%s+%[(%d+)/3%]%s+(%d+)")
				addToadminsTable = true
				for i = 1,#adminsTable do
					if adminsTable[i]["id"] == idadm then
						addToadminsTable = false
					end
				end
				if addToadminsTable then
					--sampAddChatMessage('ДОБАВИЛ', -1)
					table.insert(adminsTable,{id=idadm,nick=nickadm,job=jobadm,warns=warnsadm,rep=repadm})
				end
			end
		end
		if toHide then
			--sampAddChatMessage('скрыл', -1)
			toHide = false
			return false
		end
	end
	if id == 265 and spcars then
		sampSendDialogResponse(265, 1, 5, '')
		return false
	end
	
	if id == 265 and closepanel then
		closepanel = false
		return false
	end
 
	if id == 266 and spcars then
		sampSendDialogResponse(266, 1, 0, '')	
		spcars = false		
		return false
	end
	
	if id == 265 and repcar then
		sampSendDialogResponse(265, 1, 4, '')	
		repcar = false			
		return false
	end

	if dialogText:find("(.*)%[(%d+)%]\t(.*)\t{FFFFFF}%[(%d+)%/3%]\t(.*)\t{FFFFFF}") then 
		nickname, id, dolzhka, vigs, repa = dialogText:match("(.*)%[(%d+)%]\t(.*)\t{FFFFFF}%[(%d+)%/3%]\t(.*)\t{FFFFFF}")
	end
	--[[
		Dialog ID:{FFFFFF} 235 
{00BEFC}Dialog Type:{FFFFFF} 0 
{00BEFC}Dialog Caption:{FFFFFF}
{BFBBBA}Основная статистика
{00BEFC}Dialog text:{FFFFFF}
Текущее состояние счета: 		8251594 AZ-Coins

{FFFFFF}Имя: {B83434}[Katsu_Evilmane] 
{FFFFFF}Пол: {B83434}[Мужчина] 
{FFFFFF}Здоровье: {B83434}[100/500]
{FFFFFF}Уровень: {B83434}[10] 
{FFFFFF}Уважение: {B83434}[6/14] 
{FFFFFF}Наличные деньги (SA$): {B83434}[$99883699]
{FFFFFF}Наличные деньги (VC$): {B83434}[$0]
{FFFFFF}Евро: {B83434}[0] 
{FFFFFF}BTC: {B83434}[212]
{FFFFFF}Номер телефона: {B83434}[0] 
{FFFFFF}Деньги в банке: {B83434}[0 BTC]
{FFFFFF}Деньги на депозите: {B83434}[$0]
{FFFFFF}Работа: {B83434}[None]
{FFFFFF}Организация: {B83434}[Ballas]
{FFFFFF}Должность: {B83434}Federal Block(7)

{FFFFFF}Уровень розыска: {B83434}[0] 
{FFFFFF}Законопослушность: {B83434}19/100{FFFFFF}

Защита: {B83434}[-0 урона]{FFFFFF}
Регенерация: {B83434}[0 HP в мин.]{FFFFFF}
Урон: {B83434}[+0 урона]{FFFFFF}
Удача: {B83434}[шанс 0 крит.урона]{FFFFFF}
Макс. HP: {B83434}[+0 макс. HP]{FFFFFF}
Макс. Брони: {B83434}[+0 макс. Брони]{FFFFFF}
Шанс оглушения: {B83434}[+0]{FFFFFF}
Шанс оглушения (оглушающий плод): {FF6347}Неактивен

{FFFFFF}Предупреждения: {B83434}[0]
{FFFFFF}Наркозависимость: {B83434}0 	{529020}[Нет зависимости]
{FFFFFF}Банковская карта: {B83434}[Не имеется]
{FFFFFF}Статус: {B83434}[PREMIUM]
{FFFFFF}Семья: {B83434}Нет
{FFFFFF}Возможность владеть 5-ю бизнесами: {B83434}[НЕТ]{FFFFFF}
{FFFFFF}Возможность владеть 4-я домами: {B83434}[НЕТ]{FFFFFF}
{FFFFFF}Возможность владеть 2-я фермами: {B83434}[НЕТ]{FFFFFF}
{FFFFFF}Возможность владеть 2-я складскими помещениями: {B83434}[НЕТ]{FFFFFF}

{AFAFAF}Mercedes-Benz S600(896)
Статус блокировки: [Открыт] 
Сигнализация: [Выключена] 

{AFAFAF}Maverick(900)
Статус блокировки: [Открыт] 
Сигнализация: [Выключена] 
	]]
	if id == 235 then
		--if dialogText:find("Организация: {B83434}%[(.+)%]\n") then
		--	org = dialogText:match("Организация: {B83434}%[(.+)%]\n")
		--	rank = 0
		--	sampAddChatMessage('org = '..org, -1)
		--end
		--if dialogText:find("{FFFFFF}Организация: {B83434}%[(.*)%]\n{FFFFFF}Должность: {B83434}(.*)%((%d+)%)\n") then
		--	org, namerank, rank = dialogText:match("{FFFFFF}Организация: {B83434}%[(.*)%]\n{FFFFFF}Должность: {B83434}(.*)%((%d+)%)\n")
		--	sampAddChatMessage('org rank'..org..rank, -1)
		--end
		--if dialogText:find("\n{......}Евро: {B83434}%[(%d+)%]\n{......}BTC: {B83434}%[(%d+)%]\n") then
		--	euro, btc = dialogText:match("{......}Евро: {B83434}%[(%d+)%]\n{......}BTC: {B83434}%[(%d+)%]\n")
		--end
		--if dialogText:find("Статус: {......}%[(.+)%]\n") then
		--	vipstatus = dialogText:match("Статус: {......}%[(.+)%]\n")
		--end
		--if dialogText:find("{FFFFFF}Предупреждения: {B83434}%[(.*)%]\n") then
		--	warns = dialogText:match("{FFFFFF}Предупреждения: {B83434}%[(.*)%]\n")
		--end
		--org = "Загрузка"
		--rank = 0
		--euro = "Загрузка"
		--vipstatus = "Загрузка"
		--warns = "Загрузка"
		--btc = "Загрузка"
		--bankbtc = "Загрузка"
		org = nil
		rank = 0
		euro = nil
		vipstatus = nil
		warns = nil
		btc = nil
		bankbtc = nil
		for line in dialogText:gsub('{......}',''):gmatch('([^\n\r]+)') do
			if line:find("Организация: %[(.*)%]") then
				org = line:match("Организация: %[(.*)%]")
			end
			if line:find("Должность: (.*)%((%d+)%)") then
				namerank, rank = line:match("Должность: (.*)%((%d+)%)")
			end
			if line:find("Евро: %[(%d+)%]") then
				euro = line:match("Евро: %[(%d+)%]")
			end
			if line:find("BTC: %[(%d+)%]") then
				btc = line:match("BTC: %[(%d+)%]")
			end
			if line:find("Деньги в банке: %[(%d+) BTC%]") then
				bankbtc = line:match("Деньги в банке: %[(%d+) BTC%]")
			end
			if line:find("Статус: %[(.+)%]") then
				vipstatus = line:match("Статус: %[(.+)%]")
			end
			if line:find("Предупреждения: %[(.*)%]") then
				warns = line:match("Предупреждения: %[(.*)%]")
			end	
			if line:find("Защита: %[%-(%d+) урона%]") then
				protect = line:match("Защита: %[%-(%d+) урона%]")
			end	
			if line:find("Регенерация: %[(%d+) HP в мин.%]") then
				regen = line:match("Регенерация: %[(%d+) HP в мин.%]")
			end	
			if line:find("Урон: %[%+(%d+) урона%]") then
				damag = line:match("Урон: %[%+(%d+) урона%]")
			end	
		
		end
		if showcheck then
			showcheck = false			
			return false
		end
	end
	
	if id == 265 and addammo then
		sampSendDialogResponse(265, 1, 18, '')	
		addammo = false			
		return false
	end
	
	if id == 265 and admall then
		sampSendDialogResponse(265, 1, 0, '')	
		admall = false			
		return false
	end

if id == 6370 then
if cfg.main.autooff and cfg.main.lovlyareporta then
cfg.main.lovlyareporta = false
end
	report_name, report_id, report_text = dialogText:match("Жалоба/Вопрос от: (.*)%[(%d+)%]\n\n{......}(.*)\n\n")
	nick_rep = report_name:gsub('_', ' ') 
	id_rep = report_id
	mynick = sampGetPlayerNickname(myid)
	my_name = mynick:gsub('_', ' ') 
	local _, myid = sampGetPlayerIdByCharHandle(playerPed)
	my_id = myid
	ReportWindow.v = true
	imgui.Process = ReportWindow.v
	else
		ReportWindow.v = false
	end
	
	
	if dialogText:find("Вы были кикнуты") and cfg.main.deleteac then
	return false
	end
	
	
	
	if id == 2 then
	if cfg.main.autologin then
		if dialogText:find('Неверный пароль') then
			sampAddChatMessage(tag..'Вы ввели неверный пароль в настройках, автологин выключен автоматически.', -1)
			cfg.main.autologin = false
		else
			sampSendDialogResponse(2, 1, 65535, cfg.main.akkpass)
			return false
		end
	end
		ReconWindow.v = false
		PunishWindow.v = false
		InfoWindow.v = false
	end
	

	if id == 211 and cfg.main.autoadm then
		sampSendDialogResponse(211, 1, 65535, cfg.main.admpass)
		return false
	end


	if id == 6377 then
		sampSendDialogResponse(6377, 1, 0, '')
		return false
	end
	if id == 6370 then
		return false
	end
end

function ev.onSendCommand(param)
	if param:find('reoff') then
		ReconWindow.v = false
		PunishWindow.v = false 	
		InfoWindow.v = false 	
		reconusers_state.v = false
		sampAddChatMessage("[Recon] Вы покинули слежку.", 14628149)		
	end
	if param:find('re (.*)') then
		spec_id = param:match('re (.*)')
	end
end

function ev.onTogglePlayerSpectating(state)
	if spec_id ~= -1 then
		ReconWindow.v = state
		PunishWindow.v = state
		InfoWindow.v = state
	end
end



function ev.onSpectatePlayer(playerid, camtype)
	spec_id = playerid
end

function ev.onConnectionRejected()
	spec_id = -1
end




function imgui.CenterText(text)
	local width = imgui.GetWindowWidth()
	local calc = imgui.CalcTextSize(text)
	imgui.SetCursorPosX( width / 2 - calc.x / 2 )
	imgui.Text(text)
end


function onScriptTerminate(script, quitGame)
	if script == thisScript() then
		cfg.autoopra.house = false
		cfg.autoopra.business = false
		cfg.autoopra.status = false
		cfg.main.autopiar = false
		inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
		if ErrorMessage and not quitGame then
			local ver = thisScript().version
			local moon = getMoonloaderVersion()
			local sf = isSampfuncsLoaded() and "{E78284}Есть" or "{fe4e4e}Нет"
			local cleo = isCleoLoaded() and "{E78284}Есть" or "{fe4e4e}Нет"
			local date = os.date("%d.%m.%Y %H:%M:%S", os.time())
			local libs = {
				(bImgui and "{E78284}Присутствует ("..imgui._VERSION..")" or "{fe4e4e}Отсутствует"),
				(bEvents and "{E78284}Присутствует" or "{fe4e4e}Отсутствует") 
			}

		end
	end
end

function onQuitGame()		
	cfg.autoopra.house = false
	cfg.autoopra.business = false
	cfg.autoopra.status = false
	cfg.main.lovlyareporta = false
	cfg.main.autopiar = false
	local pStSet = sampGetServerSettingsPtr()
	inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
end


local russian_characters = {
  [168] = 'Ё', [184] = 'ё', [192] = 'А', [193] = 'Б', [194] = 'В', [195] = 'Г', [196] = 'Д', [197] = 'Е', [198] = 'Ж', [199] = 'З', [200] = 'И', [201] = 'Й', [202] = 'К', [203] = 'Л', [204] = 'М', [205] = 'Н', [206] = 'О', [207] = 'П', [208] = 'Р', [209] = 'С', [210] = 'Т', [211] = 'У', [212] = 'Ф', [213] = 'Х', [214] = 'Ц', [215] = 'Ч', [216] = 'Ш', [217] = 'Щ', [218] = 'Ъ', [219] = 'Ы', [220] = 'Ь', [221] = 'Э', [222] = 'Ю', [223] = 'Я', [224] = 'а', [225] = 'б', [226] = 'в', [227] = 'г', [228] = 'д', [229] = 'е', [230] = 'ж', [231] = 'з', [232] = 'и', [233] = 'й', [234] = 'к', [235] = 'л', [236] = 'м', [237] = 'н', [238] = 'о', [239] = 'п', [240] = 'р', [241] = 'с', [242] = 'т', [243] = 'у', [244] = 'ф', [245] = 'х', [246] = 'ц', [247] = 'ч', [248] = 'ш', [249] = 'щ', [250] = 'ъ', [251] = 'ы', [252] = 'ь', [253] = 'э', [254] = 'ю', [255] = 'я',
}
function rusLower(s)
if s ~= nil then
  local strlen = s:len()
  if strlen == 0 then return s end
  s = s:lower()
  local output = ''
  for i = 1, strlen do
	local ch = s:byte(i)
	if ch >= 192 and ch <= 223 then 
	  output = output .. russian_characters[ch+32]
	elseif ch == 168 then 
	  output = output .. russian_characters[184]
	else
	  output = output .. string.char(ch)
	end
  end
  return output
  end
end



function zawita()
lua_thread.create(function ()
				for cikk22 in zawitabinder.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer42.v))
				end
			end)
end


function dx4()
lua_thread.create(function ()
				for cikk22 in donatebinder.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer43.v))
				end
			end)
end


function rules()
lua_thread.create(function ()
				for cikk22 in rulesbinder.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer44.v))
				end
			end)
end

function vk()
lua_thread.create(function ()
				for cikk22 in groupbinder.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer46.v))
				end
			end)
end

function discord()
lua_thread.create(function ()
				for cikk22 in discordbinder.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer45.v))
				end
			end)
end

function ev.onServerMessage(color, text)
if not isGamePaused() then

if text:find("%[(%d+)%] (.*) | Уровень: (%d+) | UID: (%d+) | packetloss: (%d+)%.(%d+) %((.*)%)") then
idspec, nickspec, lvlspec, uidspec, pl, statespec = text:match("%[(%d+)%] (.*) | Уровень: (%d+) | UID: (%d+) | packetloss: (.*) %((.*)%)")
--sampAddChatMessage(idspec..nickspec..lvlspec..pl..statespec, -1)
if statespec == 'с лаунчера' then
	statespec = '{00ff00}Лаунчер'
elseif statespec == 'без лаунчера' then
	statespec = '{fe4e4e}Клиент'
end
	if showid then
		showid = false			
		return false
	end
end



if cfg.main.underb then

if text:find("%(%( Администратор (.*)%[(%d+)%]: {AFAFAF}(.*) {FFE6E6}%)%)") then
		local nickt, idt, t = text:match("%(%( Администратор (.*)%[(%d+)%]: {AFAFAF}(.*) {FFE6E6}%)%)")
		local _, char = sampGetCharHandleBySampPlayerId(idt)
		if _ then
		
			s = "(( {AFAFAF}"..t.." {FFE6E6}))"
			local bs = raknetNewBitStream()
			raknetBitStreamWriteInt16(bs,idt)
			raknetBitStreamWriteInt32(bs,-1)
			raknetBitStreamWriteFloat(bs,15)
			raknetBitStreamWriteInt32(bs,6000)
			raknetBitStreamWriteInt8(bs,#s)
			raknetBitStreamWriteString(bs,s)
			raknetEmulRpcReceiveBitStream(raknet.RPC.CHATBUBBLE,bs)
			raknetDeleteBitStream(bs)
		end
end
	if cfg.main.formaplus then 
		if text:find("Этот игрок уже в ДЕМОРГАНЕ!") and acceptforma then
			sampSendChat("/a [Forma] ".. admin_nick .. ", этот игрок уже в деморгане!")	
			acceptforma = false
		end

		if text:find("Этот игрок не забанен") and acceptforma then
			sampSendChat("/a [Forma] ".. admin_nick .. ", этот игрок не в бане!")	
			acceptforma = false
		end

		if text:find("Невалидная модель") and acceptforma then
			sampSendChat("/a [Forma] ".. admin_nick .. ", такого ID транспорта не существует!")	
			acceptforma = false
		end

		if text:find("Игрок за рулем!") and acceptforma then
			sampSendChat("/a [Forma] ".. admin_nick .. ", игрок за рулем!")
			acceptforma = false	
		end
		
		if text:find("У вас нет доступа к этой команде%!") and acceptforma then
			sampSendChat("/a [Forma] ".. admin_nick .. ", не могу принять вашу форму!")	
			acceptforma = false
		end
		
		if text:find("Игрок онлайн%!") and acceptforma then
			sampSendChat("/a [Forma] ".. admin_nick .. ", игрок онлайн!")	
			acceptforma = false
		end
		
		if text:find("Не больше 30 символов%!") and acceptforma then
			sampSendChat("/a [Forma] ".. admin_nick .. ", в причине больше 30 символов!")	
			acceptforma = false
		end
		
		if text:find("Используй: (.*)") and acceptforma then
			usefull = text:match("Используй: (.*)")
			sampSendChat("/a [Forma] ".. admin_nick .. ", используйте: "..usefull)
			acceptforma = false
		end

		if text:find("Используйте: (.*)") and acceptforma then
			usefull1 = text:match("Используй: (.*)")
			sampSendChat("/a [Forma] ".. admin_nick .. ", используйте: "..usefull1)
			acceptforma = false
		end
		
		if text:find("%[Информация%] {FFFFFF}Используйте: (.*)") and acceptforma then
			usefull12 = text:match("%[Информация%] {FFFFFF}Используйте: (.*)")
			sampSendChat("/a [Forma] ".. admin_nick .. ", используйте: "..usefull12)
			acceptforma = false
		end
		
		if text:find("/muteoff %[nick%] %[time%] %[reason%]") and acceptforma then
			sampSendChat("/a [Forma] ".. admin_nick .. ", используйте: /muteoff [nick] [time] [reason]")
			acceptforma = false
		end

		if text:find("%[Ошибка%] {FFFFFF}Игрок не в машине%!") and acceptforma then
			sampSendChat("/a [Forma] ".. admin_nick .. ", игрок не в машине!")
			acceptforma = false
		end

		if text:find("У этого игрока уже есть бан чата%!") and acceptforma then
			sampSendChat("/a [Forma] ".. admin_nick .. ", у этого игрока есть мут!")
			acceptforma = false
		end
		acceptforma = false
	end

if text:find("(.*)%[(%d+)%] %(%( {FFE6E6}(.*){FFFFFF} %)%)") then
		local nickt, idt, t = text:match("(.*)%[(%d+)%] %(%( {FFE6E6}(.*){FFFFFF} %)%)")
		local _, char = sampGetCharHandleBySampPlayerId(idt)
		if _ then
			
			s = "(( {AFAFAF}"..t.." {FFE6E6}))"
			local bs = raknetNewBitStream()
			raknetBitStreamWriteInt16(bs,idt)
			raknetBitStreamWriteInt32(bs,-1)
			raknetBitStreamWriteFloat(bs,15)
			raknetBitStreamWriteInt32(bs,6000)
			raknetBitStreamWriteInt8(bs,#s)
			raknetBitStreamWriteString(bs,s)
			raknetEmulRpcReceiveBitStream(raknet.RPC.CHATBUBBLE,bs)
			raknetDeleteBitStream(bs)
		end
end
end
end
if cfg.main.logging then
if text:find("Администратор (.*) выпустил игрока (.*), причина: (.*)") and cfg.main.logunjail then
adminnick, playernick, reason = text:match("Администратор (.*) выпустил игрока (.*), причина: (.*)")
local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//UnjailsLogs.txt", 'a')
f:write('['..os.date("%d.%m.%Y %X", os.time())..'] Администратор '..adminnick..' выпустил игрока '..playernick..'. Причина: '..reason..'\n')
f:close()
end

if text:find("Администратор (.*) снял заглушку с игрока (.*), причина: (.*)") and cfg.main.logunmute then
adminnick, playernick, reason = text:match("Администратор (.*) снял заглушку с игрока (.*), причина: (.*)")
local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//UnmutesLogs.txt", 'a')
f:write('['..os.date("%d.%m.%Y %X", os.time())..'] Администратор '..adminnick..' снял заглушку с игрока '..playernick..'. Причина: '..reason..'\n')
f:close()
end

if text:find("Администратор (.*) разбанил игрока (.*), причина: (.*)") and cfg.main.logunban then
adminnick, playernick, reason = text:match("Администратор (.*) разбанил игрока (.*), причина: (.*)")
local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//UnbanLogs.txt", 'a')
f:write('['..os.date("%d.%m.%Y %X", os.time())..'] Администратор '..adminnick..' разбанил игрока '..playernick..'. Причина: '..reason..'\n')
f:close()
end

if text:find("%[A%] (.*)%[(%d+)%] разблокировал IP: (.*)") and cfg.main.logunbanip then
adminnick, adminid, unbanip = text:match("%[A%] (.*)%[(%d+)%] разблокировал IP: (.*)")
local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//UnbanipLogs.txt", 'a')
f:write('['..os.date("%d.%m.%Y %X", os.time())..'] Администратор '..adminnick..' разблокировал IP: '..unbanip..'\n')
f:close()
end

if text:find("Администратор (.*) забанил в оффлайне игрока (.*)%. Причина: (.*)") and cfg.main.logbanoff then
adminnick, playernick, reason = text:match("Администратор (.*) забанил в оффлайне игрока (.*)%. Причина: (.*)")
local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//BanoffLogs.txt", 'a')
f:write('['..os.date("%d.%m.%Y %X", os.time())..'] Администратор '..adminnick..' заблокировал в оффлайне игрока '..playernick..'. Причина: '..reason..'\n')
f:close()
end

if text:find("Администратор (.*) установил в оффлайне (%d+) минут тюрьмы игроку (.*)%. Причина: (.*)") and cfg.main.logjailoff then
adminnick, srok, playernick, reason = text:match("Администратор (.*) установил в оффлайне (%d+) минут тюрьмы игроку (.*)%. Причина: (.*)")
local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//JailoffLogs.txt", 'a')
f:write('['..os.date("%d.%m.%Y %X", os.time())..'] Администратор '..adminnick..' установил в оффлайне '..srok..' минут тюрьмы игроку '..playernick..'. Причина: '..reason..'\n')
f:close()
end

if text:find("Администратор (.*) установил в оффлайне (%d+) минут молчанки игроку (.*)%. Причина: (.*)") and cfg.main.logmuteoff then
adminnick, srok, playernick, reason = text:match("Администратор (.*) установил в оффлайне (%d+) минут молчанки игроку (.*)%. Причина: (.*)")
local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//MuteoffLogs.txt", 'a')
f:write('['..os.date("%d.%m.%Y %X", os.time())..'] Администратор '..adminnick..' установил в оффлайне '..srok..' минут молчанки игроку '..playernick..'. Причина: '..reason..'\n')
f:close()
end

if text:find("Администратор (.*) забанил ip (.*)%. Причина: (.*)") and cfg.main.logbanipoff then
adminnick, banipoffip, reason = text:match("Администратор (.*) забанил ip (.*)%. Причина: (.*)")
local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//BanipoffLogs.txt", 'a')
f:write('['..os.date("%d.%m.%Y %X", os.time())..'] Администратор '..adminnick..' забанил IP '..banipoffip..'. Причина: '..reason..'\n')
f:close()
end
end
if text:find("Приветствуем нового игрока нашего сервера: {FF9900}(.*) {FFFFFF}%(ID: (%d+)%)  {cccccc}IP: (%d+)%.(%d+)%.(%d+)%.(%d+)") then
regnick, regid, ip1, ip2, ip3, ip4 = text:match("Приветствуем нового игрока нашего сервера: {FF9900}(.*) {FFFFFF}%(ID: (%d+)%)  {cccccc}IP: (%d+)%.(%d+)%.(%d+)%.(%d+)")
if cfg.main.regChecker then
table.insert(regPlayers, {
			nickname        = regnick,
			id              = regid, 
			playerColor     = bit.tohex(getPlayerColorWithoutAlpha(id)),
			timeReg = os.date("%H:%M:%S"),
			ip1 = ip1,
			ip4 = ip4
		})
end
if cfg.main.removeip then
sampAddChatMessage('Приветствуем нового игрока нашего сервера: {FF9900}'..regnick..' {ffffff}(ID: '..regid..') {cccccc}IP: '..ip1..'.xx.xx.'..ip4, -1)
return false
end
end
if text:find("Игрок (.*)%[(%d+)%] %[IP: (%d+).(%d+).(%d+).(%d+)%] перевел игроку (.*)%[(%d+)%] %[IP: (%d+).(%d+).(%d+).(%d+)%] на счет $(.*) %[$(.*)%]") then
nickplayer, idplayer, ip1, ip2, ip3, ip4, nickget, idget, ip5, ip6, ip7, ip8, summ, allmoney = text:match("Игрок (.*)%[(%d+)%] %[IP: (%d+).(%d+).(%d+).(%d+)%] перевел игроку (.*)%[(%d+)%] %[IP: (%d+).(%d+).(%d+).(%d+)%] на счет $(.*) %[$(.*)%]")
if cfg.main.removeip then
sampAddChatMessage('{BA2B29}Игрок '..nickplayer..'['..idplayer..'] [IP: '..ip1..'.xx.xx.'..ip4..'] перевел игроку '..nickget..'['..idget..'] [IP: '..ip5..'.xx.xx.'..ip8..'] на счет $'..summ..' [$'..allmoney..']', -1)
return false
end
end

if text:find("%- %- %- %- Совпадение с: (%d+)%.(%d+)%.(%d+)%.(%d+)%. %- %- %- %-") and cfg.main.removeip then
ip1, ip2, ip3, ip4 = text:match("%- %- %- %- Совпадение с: (%d+)%.(%d+)%.(%d+)%.(%d+)%. %- %- %- %-")
sampAddChatMessage('{99CC00}- - - - Совпадение с '..ip1..'.xx.xxx.'..ip4..' - - - -', -1)
return false
end


if text:find("Игрок/админ (.*)%[(%d+)%] зашел %[reg ip:(%d+).(%d+).(%d+).(%d+)%] %-%- %[norm ip: (%d+).(%d+).(%d+).(%d+)%]") then
nickadm, idadm, ip1, ip2, ip3, ip4, ip5, ip6, ip7, ip8 = text:match("Игрок/админ (.*)%[(%d+)%] зашел %[reg ip:(%d+).(%d+).(%d+).(%d+)%] %-%- %[norm ip: (%d+).(%d+).(%d+).(%d+)%]")
if cfg.main.removeip then
sampAddChatMessage('{BA2B29}Лидер/администратор '..nickadm..'['..idadm..'] зашел на сервер. [REG IP: '..ip1..'.xx.xx.'..ip4..'] - [LAST IP: '..ip5..'.xx.xx.'..ip7..']', -1)
return false
end
end
if text:find("Niсk %[(.*)%]  R%-IP %[(.*)%]  IP | A%-IP %[{FF6A78}(.*) | (.*){6ab1ff}%]") then
nickplayer, regip, lastip, xzip = text:match("Niсk %[(.*)%]  R%-IP %[(.*)%]  IP | A%-IP %[{FF6A78}(.*) | (.*){6ab1ff}%]")
if cfg.main.regi then
	sampAddChatMessage(tag..'Начинаю проверять данные, не спеши!', -1)
	ips = {}
	for word in string.gmatch(regip..' '..lastip, "(%d+%p%d+%p%d+%p%d+)") do
		table.insert(ips, { query = word })
	end
	if #ips > 0 then
		data_json = cjson.encode(ips)
		asyncHttpRequest(
			"POST",
			"http://ip-api.com/batch?fields=25305&lang=ru",
			{ data = data_json },
			function(response)
				local rdata = cjson.decode(u8:decode(response.text))
				for i = 1, #rdata do
					if rdata[i]["status"] == "success" then
						local distances =
							distance_cord(
								rdata[1]["lat"],
								rdata[1]["lon"],
								rdata[i]["lat"],
								rdata[i]["lon"]
							)
						if style_reg.v == 1 then
							if style_admin.v == 1 then
								if cmd == 'getip' then
									if cfg.main.removeip then
										sampSendChat('/A [Tools] Проверяю IP: скрыто | №'..i)
									else
										sampSendChat('/A [Tools] Проверяю IP: '..rdata[i]["query"]..' | №'..i)
									end
									sampSendChat('/a ['..i..' IP] Страна: '..rdata[i]["country"]..' | Город: '..rdata[i]["city"]..' | Провайдер: '..rdata[i]["isp"])
									sampSendChat('/a ['..i..' IP] Расстояние от регистрационного: '..distances..'км')
									cmd = "NULL"
								end
							else 
									if cfg.main.removeip then
										sampSendChat('/A [Tools] Проверяю IP: скрыто | №'..i)
									else
										sampSendChat('/A [Tools] Проверяю IP: '..rdata[i]["query"]..' | №'..i)
									end
									sampSendChat('/a ['..i..' IP] Страна: '..rdata[i]["country"]..' | Город: '..rdata[i]["city"]..' | Провайдер: '..rdata[i]["isp"])
									sampSendChat('/a ['..i..' IP] Расстояние от регистрационного: '..distances..'км')
								end
						else
								if cfg.main.removeip then
									sampAddChatMessage(tag..'Проверяю IP: {E78284}скрыто {84A6E7}| {E78284}№'..i, -1)
								else
									sampAddChatMessage(tag..'Проверяю IP: {E78284}'..rdata[i]["query"]..' {84A6E7}| {E78284}№'..i, -1)
								end
								sampAddChatMessage(tag..'['..i..' IP] Страна: '..rdata[i]["country"]..' | Город: '..rdata[i]["city"]..' | Провайдер: '..rdata[i]["isp"], -1)
								sampAddChatMessage(tag..'['..i..' IP] Расстояние от регистрационного: '..distances..'км', -1)
						end
			   end
				end
			end,
			function(err)
				sampAddChatMessage(tag..'Произошла ошибка '..err, -1)
			end
		)
	end
	if cfg.main.removeip then
		sampAddChatMessage(tag..'Игровой никнейм: {E78284}'..nickplayer..'{84A6E7}. REG-IP: {E78284}скрыто {84A6E7}| LAST-IP: {E78284}скрыто', -1)
		return false
	end
end
end


if text:find("(.*) %[(%d+)%] подозревается во зломе, проверьте его и авторизируйте /acceptadmin %[6%+ lvl%]") and cfg.main.geniumaccept then
nickadmina, idadmina = text:match("(.*) %[(%d+)%] подозревается во зломе, проверьте его и авторизируйте /acceptadmin %[6%+ lvl%]")
if nickadmina == mynick then
sampSendChat('/acceptadmin '..idadmina)
end
end

if text:find("%[Подозрение на рекламу%]") and cfg.main.deletereklama then
return false
end
if text:find("Используйте: /tpcor %[x%] %[y%] %[z%]") then
sampAddChatMessage('{E78284}[AdminTools] {FFFFFF}Используйте: /tpc [x] [y] [z]', -1)
return false
end

local reasons = {"deladmtag", "rmute", "unrmute", "slap", "flip", "freeze", "unfreeze", "pm", "spplayer", "sethp", "unjail", "jail", "weap", "unmute", "mute", "spcar", "kick",
	"getip", "pgetip", "plveh", "unban", "ban", "unwarn", "warn", "spcars", "givegun", "removetune", "delbname", "delhname", "warnoff", "setgangzone", "makeleader", "sban", "banip", "unbanip",
	"jailoff","muteoff","skick","setskin","uval","ao","banoff","agl","setname","veh","agiveskin","setadmtag","giveitem","acceptadmin","awarn","unjailoff", "asellbiz", "asellhouse", "setarmour", "unmuteoff"}	

	
		for k,v in ipairs(reasons) do
		if not isGamePaused() then
		if text:match('%[.*%] (%w+_?%w+)%[(%d+)%]%: /'..v..'%s') and cfg.main.trueform then
			admin_nick, admin_id, other = text:match("%[.+%] (%w+_?%w+)%[(%d+)%]%: /"..v.."%s(.*)")
			cmd = v
			paramssss = other
			local _, myid = sampGetPlayerIdByCharHandle(playerPed)
			if not isGamePaused() then
				if cmd == "mute" and cfg.formssettings.autoforma_mute or cmd == "rmute" and cfg.formssettings.autoforma_rmute or cmd == "slap" and cfg.formssettings.autoforma_slap or cmd == "jail" and cfg.formssettings.autoforma_jail or cmd == "kick" and cfg.formssettings.autoforma_kick 
				or cmd == "ban" and cfg.formssettings.autoforma_ban or cmd == "unrmute" and cfg.formssettings.autoforma_unrmute or cmd == "unban" and cfg.formssettings.autoforma_unban 
				or cmd == "banip" and cfg.formssettings.autoforma_banip or cmd == "setadmtag" and cfg.formssettings.autoforma_setadmtag 
				or cmd == "plveh" and cfg.formssettings.autoforma_plveh or cmd == "warn" and cfg.formssettings.autoforma_warn 
				or cmd == "flip" and cfg.formssettings.autoforma_flip or cmd == "freeze" and cfg.formssettings.autoforma_freeze 
				or cmd == "unfreeze" and cfg.formssettings.autoforma_unfreeze or cmd == "pm" and cfg.formssettings.autoforma_pm 
				or cmd == "spplayer" and cfg.formssettings.autoforma_spplayer or cmd == "sethp" and cfg.formssettings.autoforma_sethp 
				or cmd == "unjail" and cfg.formssettings.autoforma_unjail or cmd == "weap" and cfg.formssettings.autoforma_weap 
				or cmd == "unmute" and cfg.formssettings.autoforma_unmute or cmd == "spcar" and cfg.formssettings.autoforma_spcar 
				or cmd == "getip" and cfg.formssettings.autoforma_getip or cmd == "pgetip" and cfg.formssettings.autoforma_pgetip 
				or cmd == "unwarn" and cfg.formssettings.autoforma_unwarn
				or cmd == "givegun" and cfg.formssettings.autoforma_givegun or cmd == "removetune" and cfg.formssettings.autoforma_removetune 
				or cmd == "delbname" and cfg.formssettings.autoforma_delbname or cmd == "delhname" and cfg.formssettings.autoforma_delhname 
				or cmd == "warnoff" and cfg.formssettings.autoforma_warnoff
				or cmd == "setgangzone" and cfg.formssettings.autoforma_setgangzone 
				or cmd == "makeleader" and cfg.formssettings.autoforma_makeleader or cmd == "sban" and cfg.formssettings.autoforma_sban 
				or cmd == "unbanip" and cfg.formssettings.autoforma_unbanip or cmd == "jailoff" and cfg.formssettings.autoforma_jailoff 
				or cmd == "muteoff" and cfg.formssettings.autoforma_muteoff or cmd == "skick" and cfg.formssettings.autoforma_skick 
				or cmd == "setskin" and cfg.formssettings.autoforma_setskin or cmd == "uval" and cfg.formssettings.autoforma_uval 
				or cmd == "ao" and cfg.formssettings.autoforma_ao 
				or cmd == "vv" and cfg.formssettings.autoforma_vv or cmd == "deladmtag" and cfg.formssettings.autoforma_deladmtag
				or cmd == "banoff" and cfg.formssettings.autoforma_banoff or cmd == "agl" and cfg.formssettings.autoforma_agl 
				or cmd == "setname" and cfg.formssettings.autoforma_setname
				or cmd == "veh" and cfg.formssettings.autoforma_veh or cmd == "agiveskin" and cfg.formssettings.autoforma_agiveskin
				or cmd == "giveitem" and cfg.formssettings.autoforma_giveitem or cmd == "acceptadmin" and cfg.formssettings.autoforma_acceptadmin
				or cmd == "awarn" and cfg.formssettings.autoforma_awarn or cmd == "unjailoff" and cfg.formssettings.autoforma_unjailoff 
				or cmd == "asellbiz" and cfg.formssettings.autoforma_asellbiz or cmd == "asellhouse" and cfg.formssettings.autoforma_asellhouse 
				or cmd == "setarmour" and cfg.formssettings.autoforma_setarmour or cmd == "unmuteoff" and cfg.formssettings.autoforma_unmuteoff then
						lua_thread.create(function()
							sampAddChatMessage("[AdminTools] {"..cfg.main.twocolorforms.."}Форма {"..cfg.main.colorforms.. "}/"..cmd.." "..paramssss.." {"..cfg.main.twocolorforms.."} принята автоматически!", "0xFF"..cfg.main.colorforms)
							local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//AcceptForms.txt", 'a')
							f:write('['..os.date("%d.%m.%Y %X", os.time())..'] Форма: /'..cmd..' '..paramssss..' | Отправитель: '..admin_nick..' | Тип принятия формы: автоматически\n')
							f:close()
							cfg.main.formsday = cfg.main.formsday + 1
							cfg.main.formsvse = cfg.main.formsvse + 1
							sampSendChat("/"..cmd.." "..paramssss)
							wait(502)
							sampSendChat("/a [Arena-TOOLS] ~ Forma [+]")
							wait(502)
							sampAddChatMessage("{00BFFF}[Arena-TOOLS] - Успешно принятая форма от: " .. admin_nick .. "{FFFFFF}")	
							acceptforma = true	
						end)
						active_report = 1
						active_report2 = 0
						started = 0
						bbstart = -1
						if cfg.main.formbell then
						if cmd == "mute" and cfg.formssettings.notf_mute or cmd == "slap" and cfg.formssettings.notf_slap or cmd == "jail" and cfg.formssettings.notf_jail or cmd == "kick" and cfg.formssettings.notf_kick 
						or cmd == "ban" and cfg.formssettings.notf_ban or cmd == "rmute" and cfg.formssettings.notf_rmute or cmd == "unban" and cfg.formssettings.notf_unban 
						or cmd == "banip" and cfg.formssettings.notf_banip or cmd == "unrmute" and cfg.formssettings.notf_unrmute or cmd == "setadmtag" and cfg.formssettings.notf_setadmtag 
						or cmd == "plveh" and cfg.formssettings.notf_plveh or cmd == "warn" and cfg.formssettings.notf_warn 
						or cmd == "flip" and cfg.formssettings.notf_flip or cmd == "freeze" and cfg.formssettings.notf_freeze 
						or cmd == "unfreeze" and cfg.formssettings.notf_unfreeze or cmd == "pm" and cfg.formssettings.notf_pm 
						or cmd == "spplayer" and cfg.formssettings.notf_spplayer or cmd == "sethp" and cfg.formssettings.notf_sethp 
						or cmd == "unjail" and cfg.formssettings.notf_unjail or cmd == "weap" and cfg.formssettings.notf_weap 
						or cmd == "unmute" and cfg.formssettings.notf_unmute or cmd == "spcar" and cfg.formssettings.notf_spcar 
						or cmd == "getip" and cfg.formssettings.notf_getip or cmd == "pgetip" and cfg.formssettings.notf_pgetip 

						or cmd == "unwarn" and cfg.formssettings.notf_unwarn
						or cmd == "givegun" and cfg.formssettings.notf_givegun or cmd == "removetune" and cfg.formssettings.notf_removetune 
						or cmd == "delbname" and cfg.formssettings.notf_delbname or cmd == "delhname" and cfg.formssettings.notf_delhname 
						or cmd == "warnoff" and cfg.formssettings.notf_warnoff
						or cmd == "setgangzone" and cfg.formssettings.notf_setgangzone 
						or cmd == "makeleader" and cfg.formssettings.notf_makeleader or cmd == "sban" and cfg.formssettings.notf_sban 
						or cmd == "unbanip" and cfg.formssettings.notf_unbanip or cmd == "jailoff" and cfg.formssettings.notf_jailoff 
						or cmd == "muteoff" and cfg.formssettings.notf_muteoff or cmd == "skick" and cfg.formssettings.notf_skick 
						or cmd == "setskin" and cfg.formssettings.notf_setskin or cmd == "uval" and cfg.formssettings.notf_uval 
						or cmd == "ao" and cfg.formssettings.notf_ao 
						or cmd == "vv" and cfg.formssettings.notf_vv or cmd == "deladmtag" and cfg.formssettings.notf_deladmtag
						or cmd == "banoff" and cfg.formssettings.notf_banoff or cmd == "agl" and cfg.formssettings.notf_agl 
						or cmd == "setname" and cfg.formssettings.notf_setname
						or cmd == "veh" and cfg.formssettings.notf_veh or cmd == "agiveskin" and cfg.formssettings.notf_agiveskin
						or cmd == "giveitem" and cfg.formssettings.notf_giveitem or cmd == "acceptadmin" and cfg.formssettings.notf_acceptadmin
						or cmd == "awarn" and cfg.formssettings.notf_awarn or cmd == "unjailoff" and cfg.formssettings.notf_unjailoff 
						or cmd == "asellbiz" and cfg.formssettings.notf_asellbiz or cmd == "asellhouse" and cfg.formssettings.notf_asellhouse 
						or cmd == "setarmour" and cfg.formssettings.notf_setarmour or cmd == "unmuteoff" and cfg.formssettings.notf_unmuteoff then
							playVolume()
						end	
end						
				else
					autoformaq = "true"
				end
			end
		end
		end
		end


	if autoformaq == "true" then
	for k,v in ipairs(reasons) do
		if text:match("%[.*%] (%w+_?%w+)%[(%d+)%]%: /"..v.."%s") and cfg.main.trueform then
			started = started + 1 
			if started < 2 then
			prikoll = "true"
			admin_nick, admin_id, other = text:match("%[.+%] (%w+_?%w+)%[(%d+)%]%: /"..v.."%s(.*)")
				cmd = v
				paramssss = other
				if stop == 0 then
				if cmd == "mute" and cfg.formssettings.forma_mute or cmd == "jail" and cfg.formssettings.forma_jail or cmd == "rmute" and cfg.formssettings.forma_rmute or cmd == "unrmute" and cfg.formssettings.forma_unrmute
				or cmd == "slap" and cfg.formssettings.forma_slap or cmd == "kick" and cfg.formssettings.forma_kick 
				or cmd == "ban" and cfg.formssettings.forma_ban or cmd == "unban" and cfg.formssettings.forma_unban 
				or cmd == "banip" and cfg.formssettings.forma_banip or cmd == "setadmtag" and cfg.formssettings.forma_setadmtag 
				or cmd == "plveh" and cfg.formssettings.forma_plveh or cmd == "warn" and cfg.formssettings.forma_warn 
				or cmd == "flip" and cfg.formssettings.forma_flip or cmd == "freeze" and cfg.formssettings.forma_freeze 
				or cmd == "unfreeze" and cfg.formssettings.forma_unfreeze or cmd == "pm" and cfg.formssettings.forma_pm 
				or cmd == "spplayer" and cfg.formssettings.forma_spplayer or cmd == "sethp" and cfg.formssettings.forma_sethp 
				or cmd == "unjail" and cfg.formssettings.forma_unjail or cmd == "weap" and cfg.formssettings.forma_weap 
				or cmd == "unmute" and cfg.formssettings.forma_unmute or cmd == "spcar" and cfg.formssettings.forma_spcar 
				or cmd == "getip" and cfg.formssettings.forma_getip or cmd == "pgetip" and cfg.formssettings.forma_pgetip 
				or cmd == "unwarn" and cfg.formssettings.forma_unwarn
				or cmd == "givegun" and cfg.formssettings.forma_givegun or cmd == "removetune" and cfg.formssettings.forma_removetune 
				or cmd == "delbname" and cfg.formssettings.forma_delbname or cmd == "delhname" and cfg.formssettings.forma_delhname 
				or cmd == "warnoff" and cfg.formssettings.forma_warnoff
				or cmd == "setgangzone" and cfg.formssettings.forma_setgangzone 
				or cmd == "makeleader" and cfg.formssettings.forma_makeleader or cmd == "sban" and cfg.formssettings.forma_sban 
				or cmd == "unbanip" and cfg.formssettings.forma_unbanip or cmd == "jailoff" and cfg.formssettings.forma_jailoff 
				or cmd == "muteoff" and cfg.formssettings.forma_muteoff or cmd == "skick" and cfg.formssettings.forma_skick 
				or cmd == "setskin" and cfg.formssettings.forma_setskin or cmd == "uval" and cfg.formssettings.forma_uval 
				or cmd == "ao" and cfg.formssettings.forma_ao 
				or cmd == "vv" and cfg.formssettings.forma_vv or cmd == "deladmtag" and cfg.formssettings.forma_deladmtag
				or cmd == "banoff" and cfg.formssettings.forma_banoff or cmd == "agl" and cfg.formssettings.forma_agl 
				or cmd == "setname" and cfg.formssettings.forma_setname
				or cmd == "veh" and cfg.formssettings.forma_veh or cmd == "agiveskin" and cfg.formssettings.forma_agiveskin
				or cmd == "giveitem" and cfg.formssettings.forma_giveitem or cmd == "acceptadmin" and cfg.formssettings.forma_acceptadmin
				or cmd == "awarn" and cfg.formssettings.forma_awarn or cmd == "unjailoff" and cfg.formssettings.forma_unjailoff 
				or cmd == "asellbiz" and cfg.formssettings.forma_asellbiz or cmd == "asellhouse" and cfg.formssettings.forma_asellhouse 
				or cmd == "setarmour" and cfg.formssettings.forma_setarmour or cmd == "unmuteoff" and cfg.formssettings.forma_unmuteoff then
					klavisha = checkNameKlavisha(cfg.main.facceptform)
					if not isGamePaused() then
						sampAddChatMessage("[AdminTools] {"..cfg.main.twocolorforms.."}Найдена форма >> {"..cfg.main.colorforms.."}/"..cmd.." "..paramssss.." {"..cfg.main.twocolorforms.."}<< Отправитель: {"..cfg.main.colorforms.."}".. admin_nick .. "[" .. admin_id .. "]", "0xFF"..cfg.main.colorforms)
						sampAddChatMessage("[AdminTools] {"..cfg.main.twocolorforms.."}Нажмите клавишу >> {"..cfg.main.colorforms.. "}"..klavisha.." {"..cfg.main.twocolorforms.."}<< чтобы принять форму!", "0xFF"..cfg.main.colorforms)
						lua_thread.create(function()
						for i = 0, 5 do
							if active_report2 == 0 then
								status("false", i)
							else
								status("true", i)
							end
						end
						if prikoll == "true" then
							sampAddChatMessage("[AdminTools] {"..cfg.main.twocolorforms.."}Форма >> {"..cfg.main.colorforms.."}/"..cmd.." "..paramssss.." {"..cfg.main.twocolorforms.."}<< не принята!", "0xFF"..cfg.main.colorforms)
							printStyledString("You missed form", 2000, 4)
							active_report = 1
							active_report2 = 0
							started = 0
							bbstart = -1
							autoformaq = "false"
						end
						end)
					else
						active_report = 1
						active_report2 = 0
						started = 0
						bbstart = -1
						autoformaq = "false"
					end
				else
					active_report = 1
					active_report2 = 0
					started = 0
					bbstart = -1
					autoformaq = "false"
				end
						if cfg.main.formbell then
						if cmd == "mute" and cfg.formssettings.notf_mute or cmd == "unrmute" and cfg.formssettings.notf_unrmute or cmd == "slap" and cfg.formssettings.notf_slap or cmd == "jail" and cfg.formssettings.notf_jail or cmd == "kick" and cfg.formssettings.notf_kick 
						or cmd == "ban" and cfg.formssettings.notf_ban or cmd == "rmute" and cfg.formssettings.notf_rmute or cmd == "unban" and cfg.formssettings.notf_unban 
						or cmd == "banip" and cfg.formssettings.notf_banip or cmd == "setadmtag" and cfg.formssettings.notf_setadmtag 
						or cmd == "plveh" and cfg.formssettings.notf_plveh or cmd == "warn" and cfg.formssettings.notf_warn 
						or cmd == "flip" and cfg.formssettings.notf_flip or cmd == "freeze" and cfg.formssettings.notf_freeze 
						or cmd == "unfreeze" and cfg.formssettings.notf_unfreeze or cmd == "pm" and cfg.formssettings.notf_pm 
						or cmd == "spplayer" and cfg.formssettings.notf_spplayer or cmd == "sethp" and cfg.formssettings.notf_sethp 
						or cmd == "unjail" and cfg.formssettings.notf_unjail or cmd == "weap" and cfg.formssettings.notf_weap 
						or cmd == "unmute" and cfg.formssettings.notf_unmute or cmd == "spcar" and cfg.formssettings.notf_spcar 
						or cmd == "getip" and cfg.formssettings.notf_getip or cmd == "pgetip" and cfg.formssettings.notf_pgetip 
						or cmd == "unwarn" and cfg.formssettings.notf_unwarn
						or cmd == "givegun" and cfg.formssettings.notf_givegun or cmd == "removetune" and cfg.formssettings.notf_removetune 
						or cmd == "delbname" and cfg.formssettings.notf_delbname or cmd == "delhname" and cfg.formssettings.notf_delhname 
						or cmd == "warnoff" and cfg.formssettings.notf_warnoff
						or cmd == "setgangzone" and cfg.formssettings.notf_setgangzone 
						or cmd == "makeleader" and cfg.formssettings.notf_makeleader or cmd == "sban" and cfg.formssettings.notf_sban 
						or cmd == "unbanip" and cfg.formssettings.notf_unbanip or cmd == "jailoff" and cfg.formssettings.notf_jailoff 
						or cmd == "muteoff" and cfg.formssettings.notf_muteoff or cmd == "skick" and cfg.formssettings.notf_skick 
						or cmd == "setskin" and cfg.formssettings.notf_setskin or cmd == "uval" and cfg.formssettings.notf_uval 
						or cmd == "ao" and cfg.formssettings.notf_ao 
						or cmd == "vv" and cfg.formssettings.notf_vv or cmd == "deladmtag" and cfg.formssettings.notf_deladmtag
						or cmd == "banoff" and cfg.formssettings.notf_banoff or cmd == "agl" and cfg.formssettings.notf_agl 
						or cmd == "setname" and cfg.formssettings.notf_setname
						or cmd == "veh" and cfg.formssettings.notf_veh or cmd == "agiveskin" and cfg.formssettings.notf_agiveskin
						or cmd == "giveitem" and cfg.formssettings.notf_giveitem or cmd == "acceptadmin" and cfg.formssettings.notf_acceptadmin
						or cmd == "awarn" and cfg.formssettings.notf_awarn or cmd == "unjailoff" and cfg.formssettings.notf_unjailoff 
						or cmd == "asellbiz" and cfg.formssettings.notf_asellbiz or cmd == "asellhouse" and cfg.formssettings.notf_asellhouse 
						or cmd == "setarmour" and cfg.formssettings.notf_setarmour or cmd == "unmuteoff" and cfg.formssettings.notf_unmuteoff then
							playVolume()
						end
						end
				end
				end
				end
	end
	end
	
if not isGamePaused() then	

	if text:find("%[A%] Администратор (.*)%[(%d+)%] дал поджопник (.*)%[(%d+)%]") and cfg.main.deleteslap and cfg.main.deleteactions then
		return false
	end

	if text:find("%[Жалоба%] от (.*)%[(%d+)%]: {ffffff}(.*)%. Уже {BE2D2D}(%d+){FFFFFF} жалоб!!!") then
		nickp, idp, sute, kolvo = text:match("%[Жалоба%] от (.*)%[(%d+)%]: {ffffff}(.*)%. Уже {BE2D2D}(%d+){FFFFFF} жалоб!!!")
		sampAddChatMessage('[Репорт] от '..nickp..'['..idp..']: {'..cfg.main.twocolorreport..'}'..sute..'. Уже {'..cfg.main.colorreport..'}'..kolvo..' {'..cfg.main.twocolorreport..'}репортов!', '0xFF'..cfg.main.colorreport)
		if cfg.main.lovlyareporta and style_lovlyareporta.v == 1 and not isGamePaused() and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then 
		sampSendChat('/ot')
		end
		reportnow = kolvo
		return false
	end
	if text:find("%[A] (Sasha_Gozhelnikov)%[(%d+)%]: bot check updates") then
		anickname, aid = text:match("%[A] (Sasha_Gozhelnikov)%[(%d+)%]: bot check updates")
				sampSendChat('/a Версия скрипта: 29.03.2023')
	end

		if text:find("%[A] (Sasha_Gozhelnikov)%[(%d+)%]: bot obnova") then
		anickname, aid = text:match("%[A] (Sasha_Gozhelnikov)%[(%d+)%]: bot obnova")
				sampSendChat('/a новая версия скрипта, установить: vk.com/arenagtools')
	end

	if text:find("(.*) %[(.*)%] купил бизнес ID: (.*) по гос. цене за (.*) ms! Капча: %((%d+) | (%d+)%)") and cfg.autoopra.settingbiz then
		bnickp, bidp, bidbiz, bvremya, bcaptcha1, bcaptcha2 = text:match("(.*) %[(.*)%] купил бизнес ID: (.*) по гос. цене за (.*) ms! Капча: %((%d+) | (%d+)%)")
		nick_cutch = bnickp
		idp_cutch = bidp
		id_cutch = bidbiz
		time_cutch = bvremya
		captcha = captcha2
		if not cfg.autoopra.status then
		for _, nick in pairs(cfg.ignore) do
			if bnickp == nick then
				if cfg.main.notfinchat then
					sampAddChatMessage(tag.."Бизнес был куплен игроком из белого списка", -1)
				end
				return false
			end
		end
		sampAddChatMessage(tag .. '{B2D8F4}Используйте команду {F4A8B2}/' .. cmdBusiness.v .. ' {B2D8F4}для запроса опровержения на бизнес {F4A8B2}№' .. bidbiz, -1)
		end
		local f = io.open(getGameDirectory().."\\moonloader\\AdminToolsKing\\Логи\\AutoOpraLogs.txt", 'a')
		f:write(string.format('%s | Игрок '..bnickp..'  бизнес ID: '..bidbiz..' по гос. цене за '..bvremya..' ms! Капча: '..bcaptcha1..'\n', os.date('%d.%m %H:%M', os.time())))
		f:close()
		table.insert(tLog, 1, { 3, os.time(), text, {bnickp, bidbiz, bvremya, bcaptcha1}, {false, nil, nil} } )
		if cfg.autoopra.status then
		for _, nick in pairs(cfg.ignore) do
			if bnickp == nick then
				if cfg.main.notfinchat then
					sampAddChatMessage(tag.."Бизнес был куплен игроком из белого списка", -1)
				end
				if cfg.main.delinchat then
					return false
				end
			end
		end

		if cfg.autoopra.myreasonbiz then
			local template = u8:decode(reason_autoopra[2].v)
			local template = template:gsub('{idbiz}', bidbiz)
			local template = template:gsub('{time}', bvremya)
			local template = template:gsub('{captcha}', bcaptcha1)
			local result = sampIsPlayerConnected(bidp)
			if not result then
				send_rpc_command('/jailoff '..bnickp..' '..cfg.main.timeopra..' '..template)
			else
				send_rpc_command('/jail '..bidp..' '..cfg.main.timeopra..' '..template)
			end
		else
		local result = sampIsPlayerConnected(bidp)
			if not result then
				send_rpc_command('/jailoff '..bnickp..' '..cfg.main.timeopra..' опра бизнес №'..bidbiz)
			else
				send_rpc_command('/jail '..bidp..' '..cfg.main.timeopra..' опра бизнес №'..bidbiz)
			end
		end
		end
	end
	
	local admin, victim, tj = text:match("Администратор ([a-zA-Z_]+).* посадил игрока ([a-zA-Z_]+).* в деморган на %d+ минут")
	for k, box in pairs(tLog) do
		if box[4][1] == victim then 
			tLog[k][5][1], tLog[k][5][2], tLog[k][5][3] = true, tostring(admin), os.time()
		end
	end

	local adminoff, tjoff, victimoff = text:match("Администратор ([A-z_]+) установил в оффлайне (%d+) минут деморгана игроку ([0-9A-z_]+)%.") 
	for k, box in pairs(tLog) do
		if box[4][1] == victimoff then 
			tLog[k][5][1], tLog[k][5][2], tLog[k][5][3] = true, tostring(adminoff), os.time()
		end
	end

	local adminunj, victimunj = text:match("Администратор ([a-zA-Z_]+) выпустил игрока ([a-zA-Z_]+)")
	if adminunj and victimunj then
		for k, box in pairs(tLog) do
			if box[4][1] == victimunj then
				tLog[k][5][1], tLog[k][5][2], tLog[k][5][3] = false, tostring(adminunj), os.time()
			end
		end
	end
	local adminunjoff, victimunjoff = text:match("Администратор ([a-zA-Z_]+) выпустил в оффлайне с деморгана ([a-zA-Z_]+)")
	if adminunjoff and victimunjoff then
		for k, box in pairs(tLog) do
			if box[4][1] == victimunjoff then
				tLog[k][5][1], tLog[k][5][2], tLog[k][5][3] = false, tostring(adminunjoff), os.time()
			end
		end
	end
	
	if text:find("(.*) %[(.*)%] купил дом ID: (.*) по гос. цене за (.*) ms! Капча: %((%d+) | (%d+)%)") and cfg.autoopra.settinghouse then
		nickp, idp, idhouse, vremya, captcha1, captcha2 = text:match("(.*) %[(.*)%] купил дом ID: (.*) по гос. цене за (.*) ms! Капча: %((%d+) | (%d+)%)")
		nick_cutch = nickp
		idp_cutch = idp
		id_cutch = idhouse
		time_cutch = vremya
		captcha = captcha2
		if not cfg.autoopra.status then
		for _, nick in pairs(cfg.ignore) do
			if nickp == nick then
				if cfg.main.notfinchat then
					sampAddChatMessage(tag.."Дом был куплен игроком из белого списка", -1)
				end
				return false
			end
		end
		sampAddChatMessage(tag..'Используйте команду {E78284}/'..cmdHouse.v..' {84A6E7}для запроса опровержения на дом {E78284}№'..idhouse, -1)
		end
		local f = io.open(getGameDirectory().."\\moonloader\\AdminToolsKing\\Логи\\AutoOpraLogs.txt", 'a')
		f:write(string.format('%s | Игрок '..nickp..' купил дом ID: '..idhouse..' по гос. цене за '..vremya..' ms! Капча: '..captcha1..'\n', os.date('%d.%m %H:%M', os.time())))
		f:close()
		table.insert(tLog, 1, { 1, os.time(), text, {nickp, idhouse, vremya, captcha1}, {false, nil, nil} } )
		if cfg.autoopra.status then
		for _, nick in pairs(cfg.ignore) do
			if nickp == nick then
				if cfg.main.notfinchat then
					sampAddChatMessage(tag.."Дом был куплен игроком из белого списка", -1)
				end
				if cfg.main.delinchat then
					return false
				end
			end
		end
		if cfg.autoopra.myreasonhouse then
			local template = u8:decode(reason_autoopra[1].v)
			local template = template:gsub('{idhouse}', idhouse)
			local template = template:gsub('{time}', vremya)
			local template = template:gsub('{captcha}', captcha1)
			local result = sampIsPlayerConnected(idp)
			if not result then
				send_rpc_command('/jailoff '..nickp..' '..cfg.main.timeopra..' '..template)
			else
				send_rpc_command('/jail '..idp..' '..cfg.main.timeopra..' '..template)
			end
		else
			if not result then
				send_rpc_command('/jailoff '..nickp..' '..cfg.main.timeopra..' '..template)
			else
				send_rpc_command('/jail '..idp..' '..cfg.main.timeopra..' '..template)
			end
		end
		end
	end
	
	if text:find("%[MakeAdmin%] .*%[%d+%] установил (%d+) %[.*%] уровень администратора игроку (.*) %(был.*") then
		lvladmin, nickchela = text:match("%[MakeAdmin%] .*%[%d+%] установил (%d+) %[.*%] уровень администратора игроку (.*) %(был.*")

		if MyName() == nickchela then
			sampAddChatMessage("[Внимание] Вам установлен [" .. lvladmin .. "] уровень администрирования!", 14628149)

			cfg.main.mylvladmin = lvladmin
		end
	end

local _, myid = sampGetPlayerIdByCharHandle(playerPed)
		mynick = sampGetPlayerNickname(myid)
	if text:find("Администратор "..mynick.."%[(%d+)%] ответил игроку (.*)%[(%d+)%]:{ffffff} (.*)") and cfg.main.inforeport then
		local _, myid = sampGetPlayerIdByCharHandle(playerPed)
		mynick = sampGetPlayerNickname(myid)
		myidplayer, nickplayer, idplayer, textplayer = text:match("Администратор "..mynick.."%[(%d+)%] ответил игроку (.*)%[(%d+)%]:{ffffff} (.*)")
		cfg.main.reportzaday = cfg.main.reportzaday + 1
		cfg.main.reportzavse = cfg.main.reportzavse + 1
		sampAddChatMessage('------------------------------------------------------------------', 0xFFCDAD00)
		sampAddChatMessage('Репорт от {90EE90}' .. nickplayer .. '[' .. idplayer .. ']', 0xFFCD5C5C)
		sampAddChatMessage('Суть репорта: {90EE90}' .. report_text, 0xFFCD5C5C)
		sampAddChatMessage('Ваш ответ: {90EE90}'.. textplayer, 0xFFCD5C5C)
		sampAddChatMessage('За сегодня ответов: {90EE90}'.. cfg.main.reportzaday, 0xFFCD5C5C)
		sampAddChatMessage('--------------------------------------------------------------------', 0xFFCDAD00)
	end

		local _, myid = sampGetPlayerIdByCharHandle(playerPed)
		mynick = sampGetPlayerNickname(myid)
		if text:find("Администратор "..mynick.."%[(%d+)%] забанил игрока (.*)%[(%d+)%] на (%d+) дней%. Причина:") then
			cfg.main.nakazaniyaday = cfg.main.nakazaniyaday + 1 cfg.main.nakazaniyavse = cfg.main.nakazaniyavse + 1
		end
	
		if text:find("Администратор (.*)%[(%d+)%] забанил игрока (.*)%[(%d+)%] на (%d+) дней%. Причина: (.*)") then
			nickadmin, idadmin, nickp, idp, days, reason = text:match("Администратор (.*)%[(%d+)%] забанил игрока (.*)%[(%d+)%] на (%d+) дней%. Причина: (.*)")
		end

	if text:find("Администратор (.*)%[(%d+)%] забанил игрока (.*)%[(%d+)%] на (%d+) дней%. Причина:") then
		if cfg.main.deleteban and cfg.main.deleteactions then return false end
	end

	if text:find("%[A%] Администратор (.*)%[(%d+)%] выдал временную машину игроку (.*)%[(%d+)%] %[(%d+)%]") and cfg.main.deleteplveh and cfg.main.deleteactions then
		return false
	end

	if text:find("%[A%] (.*)%[(%d+)%]:") and cfg.main.deleteadminchat and cfg.main.deleteactions  then
		return false
	end

	if text:find("Администратор "..mynick.."%[(%d+)%] заглушил игрока (.*)%[(%d+)%] на (%d+) минут%. Причина:") then
		cfg.main.nakazaniyaday = cfg.main.nakazaniyaday + 1 cfg.main.nakazaniyavse = cfg.main.nakazaniyavse + 1
	end
	
	if text:find("Администратор (.*)%[(%d+)%] заглушил игрока (.*)%[(%d+)%] на (%d+) минут%. Причина:") then
		if cfg.main.deletemute and cfg.main.deleteactions  then return false end
	end

	if text:find("Администратор "..mynick.."%[(%d+)%] выдал предупреждение игроку (.*)%[(%d+)%] %[(%d+)/(%d+)%] Причина:") then
		cfg.main.nakazaniyaday = cfg.main.nakazaniyaday + 1 cfg.main.nakazaniyavse = cfg.main.nakazaniyavse + 1
	end
	
	if text:find("Администратор (.*)%[(%d+)%] выдал предупреждение игроку (.*)%[(%d+)%] %[(%d+)/(%d+)%] Причина:") then
		if cfg.main.deletewarn and cfg.main.deleteactions  then return false end
	end

	if text:find("%[A%] (.*)%[(%d+)%] написал игроку (.*)%[(%d+)%]:") and cfg.main.deletepm and cfg.main.deleteactions then
		return false
	end

	if text:find("Администратор "..mynick.."%[(%d+)%] посадил игрока (.*)%[(%d+)%] в деморган на (%d+) минут%. Причина:") then
		cfg.main.nakazaniyaday = cfg.main.nakazaniyaday + 1 cfg.main.nakazaniyavse = cfg.main.nakazaniyavse + 1
	end
	
	if text:find("Администратор (.*)%[(%d+)%] посадил игрока (.*)%[(%d+)%] в деморган на (%d+) минут%. Причина:") then
		if cfg.main.deletejail and cfg.main.deleteactions then return false end
	end

	if text:find("Администратор "..mynick.."%[(%d+)%] кикнул игрока (.*)%[(%d+)%]%. Причина:") then
		cfg.main.nakazaniyaday = cfg.main.nakazaniyaday + 1 cfg.main.nakazaniyavse = cfg.main.nakazaniyavse + 1
	end

	if cfg.main.deleteclad then
	if text:find("<deletewarn> (.*)%[(%d+)%] открыл") or text:find("Предыдущий клад был открыт") then
	return false
	end
	end
	
end
	if text:find("<Warning>")  and cfg.main.deleteanticheat and cfg.main.deleteactions then
		return false
	end
	
	if text:find("%[Античит%]")  and cfg.main.deleteanticheat and cfg.main.deleteactions then
		return false
	end
	
	if text:find("%[A%] (.*)%[(%d+)%] начал следить за (.*)%[(%d+)%]") and cfg.main.deletespec and cfg.main.deleteactions then
		return false
	end

	
	if text:find("Администратор (.*)%[(%d+)%] ответил игроку (.*)%[(%d+)%]:{ffffff} (.*)") then
		nickadmina, idadmina, nickplayer, idplayer, textadmin = text:match("Администратор (.*)%[(%d+)%] ответил игроку (.*)%[(%d+)%]:{ffffff} (.*)")
		sampAddChatMessage('[A] '..nickadmina..'['..idadmina..'] ответил игроку '..nickplayer..'['..idplayer..']: {ffffff}'..textadmin, 0xFFFAAC58)
		return false
	end


   
	if text:find("%[A%] (%w+_?%w+)%[(%d+)%]: (.*)") then
		nickadmina, idadmina, textadmina = text:match("%[A%] (%w+_?%w+)%[(%d+)%]: (.*)")
		sampAddChatMessage('[A] {'..cfg.main.twocoloradminchat..'}'..nickadmina..'['..idadmina..']{'..cfg.main.coloradminchat..'}: '..textadmina, '0xFF'..cfg.main.coloradminchat)
		return false
	end
	
	if text:find("%[A | (.*)%] (.*)%[(%d+)%]: (.*)") then
		tagadmina, nickadmina, idadmina, textadmina = text:match("%[A | (.*)%] (.*)%[(%d+)%]: (.*)")
		sampAddChatMessage('['..tagadmina..'{'..cfg.main.coloradminchat..'}] {'..cfg.main.twocoloradminchat..'}'..nickadmina..'['..idadmina..']{'..cfg.main.coloradminchat..'}: '..textadmina, '0xFF'..cfg.main.coloradminchat)
		return false
	end

	if not isGamePaused() then	
	textWithoutColor = text:gsub("{......}","")
	if textWithoutColor:find("%[Важно%] Хочешь получать бонусы") then
	if cfg.main.autoadm then
		sampSendChat('/apanel')
		closepanel = true
	end
	if cfg.main.spawnonset then
	lua_thread.create(function()
	local _, myid = sampGetPlayerIdByCharHandle(playerPed)
	sampSendChat('/vv 0')
	wait(500)
	setCharCoordinates(playerPed, cfg.spawncords.x, cfg.spawncords.y, cfg.spawncords.z - 1)
	end)
	end
	end
	--На сервере есть инвентарь, используйте клавишу Y для работы с ним.

	if text:find("%[A%] Вы успешно авторизовались как {......}Администратор (%d+)го уровня") and cfg.main.myserver == 3 then
		lvladminki = text:match("%[A%] Вы успешно авторизовались как {......}Администратор (%d+)го уровня")
		if cfg.main.geniumlvl then
			cfg.main.mylvladmin = lvladminki
			tttttt.v = lvladminki
		end
		if cfg.main.mylvladmin == 8 then
			sampAddChatMessage('%[A%] Вы успешно авторизовались как {fe4e4e}Владелец [LVL: '..cfg.main.mylvladmin..' | FullDostup: '..cfg.main.mylvlfd..']', -1)
		else
			sampAddChatMessage('%[A%] Вы успешно авторизовались как Администратор '..lvladminki..'го уровня', -1)	
		end
		lua_thread.create(function()
			if cfg.main.autoaz then
				wait(500)
				sampSendChat('/az')
			end
			if cfg.main.antitp then
				wait(2000)
				sampAddChatMessage('anti tp ON', -1)
				local _, myid = sampGetPlayerIdByCharHandle(playerPed)
				sampSendChat('/antitp '..myid..' 1')
			end
			if cfg.main.fraclogin then
				wait(1000)
				sampAddChatMessage('frac tp ON', -1)
				sampSendChat('/amember '..cfg.main.fracid..' 9')
			end
			if cfg.main.skinlogin then
				wait(5000)
				local _, myid = sampGetPlayerIdByCharHandle(playerPed)
				mynick = sampGetPlayerNickname(myid)
				sampSendChat('/setskin  '..myid..' '..cfg.main.skinid..' 0')
			end
		end)
		return false
	end
	if text:find("%[A%] Вы успешно авторизовались как {......}(.*)") and cfg.main.myserver == 1 or cfg.main.myserver == 2 and text:find("%[A%] Вы успешно авторизовались как {......}(.*)") then
		nameadmin = text:match("%[A%] Вы успешно авторизовались как {......}(.*)")
		--[[if cfg.main.geniumlvl then
			cfg.main.mylvladmin = lvladminki
			tttttt.v = lvladminki
		end]]
		if cfg.main.mylvladmin == 8 then
			sampAddChatMessage('%[A%] Вы успешно авторизовались как {fe4e4e}Начальник [LVL: '..cfg.main.mylvladmin..' | FullDostup: '..cfg.main.mylvlfd..']', -1)
		else
			sampAddChatMessage('%[A%] Вы успешно авторизовались как {00ff00}'..nameadmin, -1)	
		end
		lua_thread.create(function()
			if cfg.main.autoaz then
				wait(500)
				sampSendChat('/az')
			end
			if cfg.main.antitp then
				wait(2000)
				sampAddChatMessage('anti tp ON', -1)
				local _, myid = sampGetPlayerIdByCharHandle(playerPed)
				sampSendChat('/antitp '..myid..' 1')
			end
			if cfg.main.fraclogin then
				wait(1000)
				sampAddChatMessage('frac tp ON', -1)
				sampSendChat('/amember '..cfg.main.fracid..' 9')
			end
			if cfg.main.skinlogin then
				wait(5000)
				local _, myid = sampGetPlayerIdByCharHandle(playerPed)
				mynick = sampGetPlayerNickname(myid)
				sampSendChat('/setskin  '..myid..' '..cfg.main.skinid..' 0')
			end
		end)
		return false
	end
	
end
end



function status(parsasm, ggbc)
	if parsasm == "true" then
	active_report2 = 1
	prikoll = "false"
		if ggbc == 5 then
		active_report2 = 0
		started = 0
		end
		active_report = 1
		printStyledString("Admin form accepted", 2000, 4)
		bbstart = -1
		autoformaq = "false"
	else
	bbstart = -1
	bbstart = bbstart + ggbc
	if bbstart == 0 then
	active_report = 2
	end
		if active_report2 == 0 then
		wait(1000)
		printStyledString("Admin form "..ggbc.." wait~n~by ~r~"..admin_nick.."", 1000, 4)
		end
	end
end


function asyncHttpRequest(method, url, args, resolve, reject)
	local request_thread = effil.thread(function(method, url, args)
		local requests = require"requests"
		local result, response = pcall(requests.request, method, url, args)
		if result then
			response.json, response.xml = nil, nil
			return true, response
		else
			return false, response
		end
	end)(method, url, args)

	if not resolve then
		resolve = function() end
	end
	if not reject then
		reject = function() end
	end
	lua_thread.create(function()
		local runner = request_thread
		while true do
			local status, err = runner:status()
			if not err then
				if status == "completed" then
					local result, response = runner:get()
					if result then
						resolve(response)
					else
						reject(response)
					end
					return
				elseif status == "canceled" then
					return reject(status)
				end
			else
				return reject(err)
			end
			wait(0)
		end
	end)
end


function themeSettings()
 imgui.SwitchContext()
 local style = imgui.GetStyle()
 local ImVec2 = imgui.ImVec2

 style.Alpha = 0.9
 style.WindowPadding = imgui.ImVec2(8, 8)
 style.WindowRounding = cfg.main.rounding
 style.ChildWindowRounding = 0
 style.FramePadding = imgui.ImVec2(5, 3)
 style.FrameRounding = cfg.main.buttonrounding
 style.ItemSpacing = imgui.ImVec2(5, 4)
 style.ItemInnerSpacing = imgui.ImVec2(4, 4)
 style.IndentSpacing = 21
 style.ScrollbarSize = 10.0
 style.ScrollbarRounding = 0
 style.GrabMinSize = 8
 style.GrabRounding = 0
 style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
 style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
end


function join_argb(a, r, g, b)
	local argb = b 
	argb = bit.bor(argb, bit.lshift(g, 8))  
	argb = bit.bor(argb, bit.lshift(r, 16)) 
	argb = bit.bor(argb, bit.lshift(a, 24)) 
	return argb
end


function rainbowtext(speed)
	local r = math.floor(math.sin(os.clock() * speed) * 127 + 128) / 255
	local g = math.floor(math.sin(os.clock() * speed + 2) * 127 + 128) / 255 
	local b = math.floor(math.sin(os.clock() * speed + 4) * 127 + 128) / 255
	return r, g, b, 1
end


function pinkTheme()
		
local style = imgui.GetStyle()
local clrs = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4
clrs[clr.Text] = ImVec4(0.98604649305344, 0.9860365986824, 0.9860365986824, 1)
clrs[clr.TextDisabled] = ImVec4(0.65098041296005, 0.65098041296005, 0.65098041296005, 1)
clrs[clr.WindowBg] = ImVec4(0.16078431904316, 0.14117647707462, 0.1294117718935, 1)
clrs[clr.ChildWindowBg] = ImVec4(0.16078431904316, 0.14117647707462, 0.1294117718935, 1)
clrs[clr.PopupBg] = ImVec4(0.050000000745058, 0.050000000745058, 0.10000000149012, 0.89999997615814)
clrs[clr.Border] = ImVec4(0.74117648601532, 0.41176471114159, 0.74117648601532, 1)
clrs[clr.BorderShadow] = ImVec4(0, 0, 0, 0)
clrs[clr.FrameBg] = ImVec4(0.74117648601532, 0.41176471114159, 0.74117648601532, 1)
clrs[clr.FrameBgHovered] = ImVec4(0.39837744832039, 0.52538156509399, 0.67441856861115, 1)
clrs[clr.FrameBgActive] = ImVec4(0.38823530077934, 0.39607843756676, 0.38823530077934, 1)
clrs[clr.TitleBg] = ImVec4(0.74117648601532, 0.41176471114159, 0.74117648601532, 1)
clrs[clr.TitleBgActive] = ImVec4(0.74117648601532, 0.41176471114159, 0.74117648601532, 1)
clrs[clr.TitleBgCollapsed] = ImVec4(0.74117648601532, 0.41176471114159, 0.74117648601532, 1)
clrs[clr.MenuBarBg] = ImVec4(0.37616011500359, 0.37617623806, 0.6418604850769, 0.80000001192093)
clrs[clr.ScrollbarBg] = ImVec4(0.74117648601532, 0.41176471114159, 0.74117648601532, 1)
clrs[clr.ScrollbarGrab] = ImVec4(0.29019609093666, 0.30196079611778, 0.29019609093666, 1)
clrs[clr.ScrollbarGrabHovered] = ImVec4(0.35813593864441, 0.3581395149231, 0.35813593864441, 1)
clrs[clr.ScrollbarGrabActive] = ImVec4(0.35686272382736, 0.35686275362968, 0.35686272382736, 1)
clrs[clr.ComboBg] = ImVec4(0.20000000298023, 0.20000000298023, 0.20000000298023, 0.99000000953674)
clrs[clr.CheckMark] =ImVec4(0.98604649305344, 0.9860365986824, 0.9860365986824, 1)
clrs[clr.SliderGrab] = ImVec4(0.88235294818878, 0.50588238239288, 0.88235294818878, 1)
clrs[clr.SliderGrabActive] = ImVec4(0.35294118523598, 0.52549022436142, 0.80784314870834, 1)
clrs[clr.Button] = ImVec4(0.74117648601532, 0.41176471114159, 0.74117648601532, 1)
clrs[clr.ButtonHovered] = ImVec4(0.35294118523598, 0.52549022436142, 0.80784314870834, 1)
clrs[clr.ButtonActive] = ImVec4(0.32666304707527, 0.44116094708443, 0.70232558250427, 1)
clrs[clr.Header] = ImVec4(0.74117648601532, 0.41176471114159, 0.74117648601532, 1)
clrs[clr.HeaderHovered] = ImVec4(0.35294118523598, 0.52549022436142, 0.80784314870834, 1)
clrs[clr.HeaderActive] = ImVec4(0.88370889425278, 0.50557059049606, 0.88372093439102, 1)
clrs[clr.Separator] = ImVec4(0.5, 0.5, 0.5, 1)
clrs[clr.SeparatorHovered] = ImVec4(0.58409947156906, 0.58410054445267, 0.69767439365387, 1)
clrs[clr.SeparatorActive] = ImVec4(0.69999998807907, 0.69999998807907, 0.89999997615814, 1)
clrs[clr.ResizeGrip] = ImVec4(1, 1, 1, 0.30000001192093)
clrs[clr.ResizeGripHovered] = ImVec4(1, 1, 1, 0.60000002384186)
clrs[clr.ResizeGripActive] = ImVec4(1, 1, 1, 0.89999997615814)
clrs[clr.CloseButton] = ImVec4(0.47441384196281, 0.47441858053207, 0.47441384196281, 1)
clrs[clr.CloseButtonHovered] = ImVec4(0.59534287452698, 0.59534287452698, 0.59534883499146, 1)
clrs[clr.CloseButtonActive] = ImVec4(0.69999998807907, 0.69999998807907, 0.69999998807907, 1)
clrs[clr.PlotLines] = ImVec4(1, 0.99998998641968, 0.99998998641968, 1)
clrs[clr.PlotLinesHovered] = ImVec4(0.89999997615814, 0.69999998807907, 0, 1)
clrs[clr.PlotHistogram] = ImVec4(0.89999997615814, 0.69999998807907, 0, 1)
clrs[clr.PlotHistogramHovered] = ImVec4(1, 0.60000002384186, 0, 1)
clrs[clr.TextSelectedBg] = ImVec4(0.99998998641968, 0.99998998641968, 1, 0.34999999403954)
clrs[clr.ModalWindowDarkening] = ImVec4(0.20000000298023, 0.20000000298023, 0.20000000298023, 0.96862745285034)
end

function Dark()
local style = imgui.GetStyle()
local clrs = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4

clrs[clr.Text] = ImVec4(1, 1, 1, 1)
clrs[clr.TextDisabled] = ImVec4(0.65098041296005, 0.65098041296005, 0.65098041296005, 1)
clrs[clr.WindowBg] = ImVec4(0.058823529630899, 0.050980392843485, 0.035294119268656, 1)
clrs[clr.ChildWindowBg] = ImVec4(0.058823529630899, 0.050980392843485, 0.035294119268656, 1)
clrs[clr.PopupBg] = ImVec4(0.058823529630899, 0.050980392843485, 0.035294119268656, 1)
clrs[clr.Border] = ImVec4(0.24313725531101, 0.2392156869173, 0.26666668057442, 1)
clrs[clr.BorderShadow] = ImVec4(0.24313725531101, 0.2392156869173, 0.26666668057442, 1)
clrs[clr.FrameBg] = ImVec4(0.098039217293262, 0.094117648899555, 0.082352943718433, 1)
clrs[clr.FrameBgHovered] = ImVec4(0.1348837018013, 0.12908054888248, 0.11167115718126, 1)
clrs[clr.FrameBgActive] = ImVec4(0.16744184494019, 0.15965384244919, 0.13628987967968, 1)
clrs[clr.TitleBg] = ImVec4(0.078431375324726, 0.066666670143604, 0.050980392843485, 1)
clrs[clr.TitleBgActive] = ImVec4(0.078431375324726, 0.066666670143604, 0.050980392843485, 1)
clrs[clr.TitleBgCollapsed] = ImVec4(0.078431375324726, 0.066666670143604, 0.050980392843485, 1)
clrs[clr.MenuBarBg] = ImVec4(0.078431375324726, 0.066666670143604, 0.050980392843485, 1)
clrs[clr.ScrollbarBg] = ImVec4(0.015686275437474, 0.015686275437474, 0.019607843831182, 1)
clrs[clr.ScrollbarGrab] = ImVec4(0.30980390310287, 0.30980390310287, 0.3098039329052, 1)
clrs[clr.ScrollbarGrabHovered] = ImVec4(0.41176468133926, 0.41176468133926, 0.41176471114159, 1)
clrs[clr.ScrollbarGrabActive] = ImVec4(0.50980395078659, 0.50980395078659, 0.50980395078659, 1)
clrs[clr.ComboBg] = ImVec4(0.20000000298023, 0.20000000298023, 0.20000000298023, 0.99000000953674)
clrs[clr.CheckMark] = ImVec4(1, 0.99998998641968, 0.99998998641968, 1)
clrs[clr.SliderGrab] = ImVec4(0.3098039329052, 0.3098039329052, 0.3098039329052, 1)
clrs[clr.SliderGrabActive] = ImVec4(0.39069765806198, 0.36707407236099, 0.36707407236099, 1)
clrs[clr.Button] = ImVec4(0.11162793636322, 0.11162793636322, 0.11162681877613, 1)
clrs[clr.ButtonHovered] = ImVec4(0.1803921610117, 0.17647059261799, 0.16862745583057, 1)
clrs[clr.ButtonActive] = ImVec4(0.28372091054916, 0.28240123391151, 0.2797619998455, 1)
clrs[clr.Header] = ImVec4(0.11372548341751, 0.11372548341751, 0.11372549086809, 1)
clrs[clr.HeaderHovered] = ImVec4(0.44999998807907, 0.44999998807907, 0.89999997615814, 0.80000001192093)
clrs[clr.HeaderActive] = ImVec4(0.52999997138977, 0.52999997138977, 0.87000000476837, 0.80000001192093)
clrs[clr.Separator] = ImVec4(0.5, 0.5, 0.5, 1)
clrs[clr.SeparatorHovered] = ImVec4(0.60000002384186, 0.60000002384186, 0.69999998807907, 1)
clrs[clr.SeparatorActive] = ImVec4(0.69999998807907, 0.69999998807907, 0.89999997615814, 1)
clrs[clr.ResizeGrip] = ImVec4(0.066666670143604, 0.14901961386204, 0.258823543787, 1)
clrs[clr.ResizeGripHovered] = ImVec4(0.17254902422428, 0.39607843756676, 0.66274511814117, 1)
clrs[clr.ResizeGripActive] = ImVec4(0.24705882370472, 0.55686277151108, 0.93333333730698, 1)
clrs[clr.CloseButton] = ImVec4(0.2392156869173, 0.2549019753933, 0.26274511218071, 1)
clrs[clr.CloseButtonHovered] = ImVec4(0.98039215803146, 0.38823530077934, 0.36078432202339, 1)
clrs[clr.CloseButtonActive] = ImVec4(0.98039215803146, 0.38823530077934, 0.36078432202339, 1)
clrs[clr.PlotLines] = ImVec4(1, 1, 1, 1)
clrs[clr.PlotLinesHovered] = ImVec4(0.89999997615814, 0.69999998807907, 0, 1)
clrs[clr.PlotHistogram] = ImVec4(0.89999997615814, 0.69999998807907, 0, 1)
clrs[clr.PlotHistogramHovered] = ImVec4(1, 0.60000002384186, 0, 1)
clrs[clr.TextSelectedBg] = ImVec4(0.15294118225574, 0.26666668057442, 0.39607843756676, 1)
clrs[clr.ModalWindowDarkening] = ImVec4(0.20000000298023, 0.20000000298023, 0.20000000298023, 0.34999999403954)
end
function White()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)

        colors[clr.Text]                   = ImVec4(0.00, 0.00, 0.00, 1.00);
        colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00);
        colors[clr.WindowBg]               = ImVec4(0.86, 0.86, 0.86, 1.00);
        colors[clr.ChildWindowBg]          = ImVec4(0.71, 0.71, 0.71, 1.00);
        colors[clr.PopupBg]                = ImVec4(0.79, 0.79, 0.79, 1.00);
        colors[clr.Border]                 = ImVec4(0.00, 0.00, 0.00, 0.36);
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.10);
        colors[clr.FrameBg]                = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.FrameBgHovered]         = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.FrameBgActive]          = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.TitleBg]                = ImVec4(1.00, 1.00, 1.00, 0.81);
        colors[clr.TitleBgActive]          = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.TitleBgCollapsed]       = ImVec4(1.00, 1.00, 1.00, 0.51);
        colors[clr.MenuBarBg]              = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.ScrollbarBg]            = ImVec4(1.00, 1.00, 1.00, 0.86);
        colors[clr.ScrollbarGrab]          = ImVec4(0.37, 0.37, 0.37, 1.00);
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.60, 0.60, 0.60, 1.00);
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.21, 0.21, 0.21, 1.00);
        colors[clr.ComboBg]                = ImVec4(0.61, 0.61, 0.61, 1.00);
        colors[clr.CheckMark]              = ImVec4(0.42, 0.42, 0.42, 1.00);
        colors[clr.SliderGrab]             = ImVec4(0.51, 0.51, 0.51, 1.00);
        colors[clr.SliderGrabActive]       = ImVec4(0.65, 0.65, 0.65, 1.00);
        colors[clr.Button]                 = ImVec4(0.52, 0.52, 0.52, 0.83);
        colors[clr.ButtonHovered]          = ImVec4(0.58, 0.58, 0.58, 0.83);
        colors[clr.ButtonActive]           = ImVec4(0.44, 0.44, 0.44, 0.83);
        colors[clr.Header]                 = ImVec4(0.65, 0.65, 0.65, 1.00);
        colors[clr.HeaderHovered]          = ImVec4(0.73, 0.73, 0.73, 1.00);
        colors[clr.HeaderActive]           = ImVec4(0.53, 0.53, 0.53, 1.00);
        colors[clr.Separator]              = ImVec4(0.46, 0.46, 0.46, 1.00);
        colors[clr.SeparatorHovered]       = ImVec4(0.45, 0.45, 0.45, 1.00);
        colors[clr.SeparatorActive]        = ImVec4(0.45, 0.45, 0.45, 1.00);
        colors[clr.ResizeGrip]             = ImVec4(0.23, 0.23, 0.23, 1.00);
        colors[clr.ResizeGripHovered]      = ImVec4(0.32, 0.32, 0.32, 1.00);
        colors[clr.ResizeGripActive]       = ImVec4(0.14, 0.14, 0.14, 1.00);
        colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
        colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
        colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
        colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
        colors[clr.PlotLinesHovered]       = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.PlotHistogram]          = ImVec4(0.70, 0.70, 0.70, 1.00);
        colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.TextSelectedBg]         = ImVec4(0.62, 0.62, 0.62, 1.00);
        colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
end
function Purple()
local style = imgui.GetStyle()
local clrs = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4

clrs[clr.Text] = ImVec4(1, 1, 1, 1)
clrs[clr.TextDisabled] = ImVec4(0.60000002384186, 0.60000002384186, 0.60000002384186, 1)
clrs[clr.WindowBg] = ImVec4(0.031372550874949, 0.031372550874949, 0.035294119268656, 1)
clrs[clr.ChildWindowBg] = ImVec4(0.031372550874949, 0.031372550874949, 0.035294119268656, 0.99607843160629)
clrs[clr.PopupBg] = ImVec4(0.031372550874949, 0.031372550874949, 0.035294119268656, 1)
clrs[clr.Border] = ImVec4(0.24705882370472, 0.2392156869173, 0.27450981736183, 1)
clrs[clr.BorderShadow] = ImVec4(0.24705882370472, 0.2392156869173, 0.27450981736183, 1)
clrs[clr.FrameBg] = ImVec4(0.14901961386204, 0.066666670143604, 0.2352941185236, 1)
clrs[clr.FrameBgHovered] = ImVec4(0.3511745929718, 0.14920496940613, 0.56279069185257, 1)
clrs[clr.FrameBgActive] = ImVec4(0.25832152366638, 0.11422391980886, 0.40930235385895, 1)
clrs[clr.TitleBg] = ImVec4(0.30196079611778, 0.12549020349979, 0.52549022436142, 1)
clrs[clr.TitleBgActive] = ImVec4(0.30196079611778, 0.12549020349979, 0.52549022436142, 1)
clrs[clr.TitleBgCollapsed] = ImVec4(0.30196079611778, 0.12549020349979, 0.52549022436142, 1)
clrs[clr.MenuBarBg] = ImVec4(0.30196079611778, 0.12549020349979, 0.52549022436142, 1)
clrs[clr.ScrollbarBg] = ImVec4(0.019607843831182, 0.011764706112444, 0.015686275437474, 1)
clrs[clr.ScrollbarGrab] = ImVec4(0.30980390310287, 0.30980390310287, 0.3098039329052, 1)
clrs[clr.ScrollbarGrabHovered] = ImVec4(0.41176468133926, 0.41176468133926, 0.41176471114159, 1)
clrs[clr.ScrollbarGrabActive] = ImVec4(0.50980395078659, 0.50980395078659, 0.50980395078659, 1)
clrs[clr.ComboBg] = ImVec4(0.031372550874949, 0.031372550874949, 0.035294119268656, 1)
clrs[clr.CheckMark] = ImVec4(1, 1, 1, 1)
clrs[clr.SliderGrab] = ImVec4(0.3927863240242, 0.19703623652458, 0.6418604850769, 1)
clrs[clr.SliderGrabActive] = ImVec4(0.44761645793915, 0.28568956255913, 0.66046512126923, 1)
clrs[clr.Button] = ImVec4(0.2549019753933, 0.078431375324726, 0.49019607901573, 1)
clrs[clr.ButtonHovered] = ImVec4(0.20784313976765, 0.074509806931019, 0.36862745881081, 1)
clrs[clr.ButtonActive] = ImVec4(0.15294118225574, 0.058823529630899, 0.3137255012989, 1)
clrs[clr.Header] = ImVec4(0.1176470592618, 0.11372549086809, 0.1176470592618, 1)
clrs[clr.HeaderHovered] = ImVec4(0.078431375324726, 0.062745101749897, 0.10196078568697, 1)
clrs[clr.HeaderActive] = ImVec4(0.14901961386204, 0.14509804546833, 0.15294118225574, 1)
clrs[clr.Separator] = ImVec4(0.2549019753933, 0.24313725531101, 0.27843138575554, 1)
clrs[clr.SeparatorHovered] = ImVec4(0.2549019753933, 0.24313725531101, 0.27843138575554, 1)
clrs[clr.SeparatorActive] = ImVec4(0.2549019753933, 0.24313725531101, 0.27843138575554, 1)
clrs[clr.ResizeGrip] = ImVec4(0.12549020349979, 0.19215686619282, 0.28235295414925, 1)
clrs[clr.ResizeGripHovered] = ImVec4(0.20000000298023, 0.41568627953529, 0.6745098233223, 1)
clrs[clr.ResizeGripActive] = ImVec4(0.25098040699959, 0.56078433990479, 0.93333333730698, 1)
clrs[clr.CloseButton] = ImVec4(0.34509804844856, 0.258823543787, 0.46274510025978, 1)
clrs[clr.CloseButtonHovered] = ImVec4(0.98039215803146, 0.38823530077934, 0.36078432202339, 1)
clrs[clr.CloseButtonActive] = ImVec4(0.98039215803146, 0.38823530077934, 0.36078432202339, 1)
clrs[clr.PlotLines] = ImVec4(1, 1, 1, 1)
clrs[clr.PlotLinesHovered] = ImVec4(0.89999997615814, 0.69999998807907, 0, 1)
clrs[clr.PlotHistogram] = ImVec4(0.89999997615814, 0.69999998807907, 0, 1)
clrs[clr.PlotHistogramHovered] = ImVec4(1, 0.60000002384186, 0, 1)
clrs[clr.TextSelectedBg] = ImVec4(0.18823529779911, 0.24705882370472, 0.49411764740944, 1)
clrs[clr.ModalWindowDarkening] = ImVec4(0.20000000298023, 0.20000000298023, 0.20000000298023, 0.34999999403954)
end

function Red()
		
local style = imgui.GetStyle()
local clrs = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4

clrs[clr.Text] = ImVec4(1, 0.99998998641968, 0.99998998641968, 1)
clrs[clr.TextDisabled] = ImVec4(0.65098041296005, 0.65098041296005, 0.65098041296005, 1)
clrs[clr.WindowBg] = ImVec4(0.039215687662363, 0.027450980618596, 0.015686275437474, 1)
clrs[clr.ChildWindowBg] = ImVec4(0.039215687662363, 0.027450980618596, 0.015686275437474, 1)
clrs[clr.PopupBg] = ImVec4(0.039215687662363, 0.027450980618596, 0.015686275437474, 1)
clrs[clr.Border] = ImVec4(0.2352941185236, 0.23137255012989, 0.258823543787, 1)
clrs[clr.BorderShadow] = ImVec4(0, 0, 0, 0)
clrs[clr.FrameBg] = ImVec4(0.25098040699959, 0.031372550874949, 0.023529412224889, 1)
clrs[clr.FrameBgHovered] = ImVec4(0.25098040699959, 0.031372550874949, 0.023529412224889, 1)
clrs[clr.FrameBgActive] = ImVec4(0.34883719682693, 0.040226750075817, 0.029204972088337, 1)
clrs[clr.TitleBg] = ImVec4(0.56470590829849, 0.094117648899555, 0.082352943718433, 1)
clrs[clr.TitleBgActive] = ImVec4(0.56470590829849, 0.094117648899555, 0.082352943718433, 1)
clrs[clr.TitleBgCollapsed] = ImVec4(0.56470590829849, 0.094117648899555, 0.082352943718433, 1)
clrs[clr.MenuBarBg] = ImVec4(0.56470590829849, 0.094117648899555, 0.082352943718433, 1)
clrs[clr.ScrollbarBg] = ImVec4(0.031372550874949, 0.023529412224889, 0.019607843831182, 1)
clrs[clr.ScrollbarGrab] = ImVec4(0.30980390310287, 0.30980390310287, 0.3098039329052, 1)
clrs[clr.ScrollbarGrabHovered] = ImVec4(0.41176468133926, 0.41176468133926, 0.41176471114159, 1)
clrs[clr.ScrollbarGrabActive] = ImVec4(0.50980395078659, 0.50980395078659, 0.50980395078659, 1)
clrs[clr.ComboBg] = ImVec4(0.24186044931412, 0.24185802042484, 0.24185802042484, 0.99000000953674)
clrs[clr.CheckMark] = ImVec4(1, 0.99998998641968, 0.99998998641968, 1)
clrs[clr.SliderGrab] = ImVec4(1, 0.99998998641968, 0.99998998641968, 0.30000001192093)
clrs[clr.SliderGrabActive] = ImVec4(1, 0.99998998641968, 0.99998998641968, 1)
clrs[clr.Button] = ImVec4(0.54509806632996, 0.039215687662363, 0.039215687662363, 1)
clrs[clr.ButtonHovered] = ImVec4(0.42745098471642, 0.035294119268656, 0.035294119268656, 1)
clrs[clr.ButtonActive] = ImVec4(0.34509804844856, 0.035294119268656, 0.035294119268656, 1)
clrs[clr.Header] = ImVec4(0.1176470592618, 0.1176470592618, 0.11372549086809, 1)
clrs[clr.HeaderHovered] = ImVec4(0.082352943718433, 0.070588238537312, 0.062745101749897, 1)
clrs[clr.HeaderActive] = ImVec4(0.14901961386204, 0.14901961386204, 0.14509804546833, 1)
clrs[clr.Separator] = ImVec4(0.2352941185236, 0.23137255012989, 0.258823543787, 1)
clrs[clr.SeparatorHovered] = ImVec4(0.2352941185236, 0.23137255012989, 0.258823543787, 1)
clrs[clr.SeparatorActive] = ImVec4(0.2352941185236, 0.23137255012989, 0.258823543787, 1)
clrs[clr.ResizeGrip] = ImVec4(1, 0.99998998641968, 0.99998998641968, 0.30000001192093)
clrs[clr.ResizeGripHovered] = ImVec4(1, 1, 1, 0.60000002384186)
clrs[clr.ResizeGripActive] = ImVec4(1, 1, 1, 0.89999997615814)
clrs[clr.CloseButton] = ImVec4(0.48627451062202, 0.25098040699959, 0.24705882370472, 1)
clrs[clr.CloseButtonHovered] = ImVec4(0.98039215803146, 0.38823530077934, 0.36078432202339, 1)
clrs[clr.CloseButtonActive] = ImVec4(0.98039215803146, 0.38823530077934, 0.36078432202339, 1)
clrs[clr.PlotLines] = ImVec4(1, 1, 1, 1)
clrs[clr.PlotLinesHovered] = ImVec4(0.89999997615814, 0.69999998807907, 0, 1)
clrs[clr.PlotHistogram] = ImVec4(0.89999997615814, 0.69999998807907, 0, 1)
clrs[clr.PlotHistogramHovered] = ImVec4(1, 0.60000002384186, 0, 1)
clrs[clr.TextSelectedBg] = ImVec4(0.2549019753933, 0.22352941334248, 0.35686275362968, 1)
clrs[clr.ModalWindowDarkening] = ImVec4(0.20000000298023, 0.20000000298023, 0.20000000298023, 0.34999999403954)
end

function DarkGreen()
local style = imgui.GetStyle()
local clrs = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4
		clrs[clr.Text] = ImVec4(1, 0.99998998641968, 0.99998998641968, 1)
clrs[clr.TextDisabled] = ImVec4(0.65098041296005, 0.65098041296005, 0.65098041296005, 1)
clrs[clr.WindowBg] = ImVec4(0.035294119268656, 0.04313725605607, 0.035294119268656, 1)
clrs[clr.ChildWindowBg] = ImVec4(0.035294119268656, 0.04313725605607, 0.035294119268656, 1)
clrs[clr.PopupBg] = ImVec4(0.035294119268656, 0.04313725605607, 0.035294119268656, 1)
clrs[clr.Border] = ImVec4(0.2392156869173, 0.24313725531101, 0.27450981736183, 1)
clrs[clr.BorderShadow] = ImVec4(0, 0, 0, 0)
clrs[clr.FrameBg] = ImVec4(0.094117648899555, 0.23137255012989, 0.070588238537312, 1)
clrs[clr.FrameBgHovered] = ImVec4(0.11372549086809, 0.34901961684227, 0.086274512112141, 1)
clrs[clr.FrameBgActive] = ImVec4(0.094117648899555, 0.26274511218071, 0.082352943718433, 1)
clrs[clr.TitleBg] = ImVec4(0.062745101749897, 0.35294118523598, 0.066666670143604, 1)
clrs[clr.TitleBgActive] = ImVec4(0.062745101749897, 0.35294118523598, 0.066666670143604, 1)
clrs[clr.TitleBgCollapsed] = ImVec4(0.062745101749897, 0.35294118523598, 0.066666670143604, 1)
clrs[clr.MenuBarBg] = ImVec4(0.062745101749897, 0.35294118523598, 0.066666670143604, 1)
clrs[clr.ScrollbarBg] = ImVec4(0.015686275437474, 0.023529412224889, 0.011764706112444, 1)
clrs[clr.ScrollbarGrab] = ImVec4(0.30980390310287, 0.30980390310287, 0.3098039329052, 1)
clrs[clr.ScrollbarGrabHovered] = ImVec4(0.41176468133926, 0.41176468133926, 0.41176471114159, 1)
clrs[clr.ScrollbarGrabActive] = ImVec4(0.50980395078659, 0.50980395078659, 0.50980395078659, 1)
clrs[clr.ComboBg] = ImVec4(0.2392156869173, 0.24313725531101, 0.27450981736183, 1)
clrs[clr.CheckMark] = ImVec4(1, 0.99998998641968, 0.99998998641968, 1)
clrs[clr.SliderGrab] = ImVec4(1, 0.99998998641968, 0.99998998641968, 0.30000001192093)
clrs[clr.SliderGrabActive] = ImVec4(0.70697677135468, 0.70696967840195, 0.70696967840195, 1)
clrs[clr.Button] = ImVec4(0.13333334028721, 0.48235294222832, 0.090196080505848, 1)
clrs[clr.ButtonHovered] = ImVec4(0.1176470592618, 0.35686275362968, 0.098039217293262, 1)
clrs[clr.ButtonActive] = ImVec4(0.098039217293262, 0.27058824896812, 0.094117648899555, 1)
clrs[clr.Header] = ImVec4(0.11764705181122, 0.11764705181122, 0.1176470592618, 1)
clrs[clr.HeaderHovered] = ImVec4(0.090196080505848, 0.094117648899555, 0.078431375324726, 1)
clrs[clr.HeaderActive] = ImVec4(0.14901959896088, 0.14901959896088, 0.14901961386204, 1)
clrs[clr.Separator] = ImVec4(0.5, 0.5, 0.5, 1)
clrs[clr.SeparatorHovered] = ImVec4(0.60000002384186, 0.60000002384186, 0.69999998807907, 1)
clrs[clr.SeparatorActive] = ImVec4(0.69999998807907, 0.69999998807907, 0.89999997615814, 1)
clrs[clr.ResizeGrip] = ImVec4(0.074509806931019, 0.16078431904316, 0.25098040699959, 1)
clrs[clr.ResizeGripHovered] = ImVec4(0.17647059261799, 0.40000000596046, 0.65882354974747, 1)
clrs[clr.ResizeGripActive] = ImVec4(0.24705882370472, 0.56078433990479, 0.92941176891327, 1)
clrs[clr.CloseButton] = ImVec4(0.2352941185236, 0.37647059559822, 0.2392156869173, 1)
clrs[clr.CloseButtonHovered] = ImVec4(0.98039215803146, 0.38823530077934, 0.36078432202339, 1)
clrs[clr.CloseButtonActive] = ImVec4(0.98039215803146, 0.38823530077934, 0.36078432202339, 1)
clrs[clr.PlotLines] = ImVec4(1, 1, 1, 1)
clrs[clr.PlotLinesHovered] = ImVec4(0.89999997615814, 0.69999998807907, 0, 1)
clrs[clr.PlotHistogram] = ImVec4(0.89999997615814, 0.69999998807907, 0, 1)
clrs[clr.PlotHistogramHovered] = ImVec4(1, 0.60000002384186, 0, 1)
clrs[clr.TextSelectedBg] = ImVec4(0, 0, 1, 0.34999999403954)
clrs[clr.ModalWindowDarkening] = ImVec4(0.20000000298023, 0.20000000298023, 0.20000000298023, 0.34999999403954)
end

function kapcha()
	CaptchaWindow.v = not CaptchaWindow.v
	imgui.Process = CaptchaWindow.v
end



function imgui.ButtonHex(lable, rgb, size)
			local r = bit.band(bit.rshift(rgb, 16), 0xFF) / 255
			local g = bit.band(bit.rshift(rgb, 8), 0xFF) / 255
			local b = bit.band(rgb, 0xFF) / 255

			imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r, g, b, 0.6))
			imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r, g, b, 0.8))
			imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r, g, b, 1.0))
			local button = imgui.Button(lable, size)
			imgui.PopStyleColor(3) 
			return button
		end

function imgui.GetOpraStatus(count, tInfoJail)
		imgui.SameLine(imgui.GetWindowWidth() - 30); 
		if not tInfoJail[1] and tInfoJail[2] == nil and tInfoJail[3] == nil then
			imgui.TextColored(imgui.ImVec4(1.0, 0.3, 0.3, 1.0), fa.ICON_FA_TIMES_CIRCLE)
			imgui.Hint("status_ajail:"..count, u8("Опровержение не запрошено"))
		elseif tInfoJail[1] and tInfoJail[2] and tInfoJail[3] then
			imgui.TextColored(imgui.ImVec4(1.0, 1.0, 0.3, 1.0), fa.ICON_FA_CLOCK)
			imgui.Hint("status_ajail:"..count, u8("Опровержение запрошено\nЗапросил: "..tInfoJail[2].."\nВремя: "..os.date("%H:%M:%S", tInfoJail[3])))
		elseif not tInfoJail[1] and tInfoJail[2] and tInfoJail[3] then 
			imgui.TextColored(imgui.ImVec4(0.3, 1.0, 0.3, 1.0), fa.ICON_FA_CHECK_CIRCLE)
			imgui.Hint("status_ajail:"..count, u8("Опровержение проверено\nВыпустил: "..tInfoJail[2].."\nВремя: "..os.date("%H:%M:%S", tInfoJail[3])))
		else
			imgui.TextColored(imgui.ImVec4(1.0, 0.3, 0.3, 1.0), fa.ICON_FA_QUESTION_CIRCLE)
			imgui.Hint("status_ajail:"..count, u8"Неизвестная ошибка")
		end
	end

	function sampIsNickNameConnected(nick)
		local me = select(2, sampGetPlayerIdByCharHandle(playerPed))
		for i = 0, sampGetMaxPlayerId(false) do
			if sampIsPlayerConnected(i) or i == me then
				if sampGetPlayerNickname(i) == nick then return true, i end
			end
		end
		return false
	end

function amember(arg)
if #arg == 0 then
AmemberWindow.v = not AmemberWindow.v
imgui.Process = AmemberWindow.v
else
sampSendChat('/amember ' .. arg)
end
end

function tpcar(arg) 
	if arg:find('(.+) (.+)') then
		arg1, arg2 = arg:match('(.+) (.+)')
		lua_thread.create(function()
		sampSendChat('/getherecar '..arg2)
		sampSendChat("/pm "..arg1.." 0 Транспорт [ID"..arg2.."] телепортирован.")
		end)
	else
		sampAddChatMessage(tag.."Используйте: {E78284}/tpcar [ID player] [ID car]", -1)
	end
end 


function giveskin(arg)
	if arg:find('(.+) (.+)') then
		arg1, arg2 = arg:match('(.+) (.+)')
lua_thread.create(function()
sampSendChat("/setskin "..arg1.." "..arg2.." 1")
sampSendChat("/spplayer "..arg1)
sampSendChat("/pm "..arg1.." 0 Спасибо за участие в раздаче!")
end)
	else
		sampAddChatMessage(tag.."Используйте: {E78284}/ss [ID player] [ID skin]", -1)
	end
end


function tpm(arg)
if #arg == 0 then
TeleportWindow.v = not TeleportWindow.v
imgui.Process = TeleportWindow.v
else
sampSendChat('/tp ' .. arg)
end
end



function ahelper(arg)
MainWindow.v = not MainWindow.v
				imgui.Process = MainWindow.v
end


		
		
function isPos()
	if changePositionRecon then
		showCursor(true, false)
		local mouseX, mouseY = getCursorPos()
		cfg.main.posX, cfg.main.posY = mouseX, mouseY
		if isKeyJustPressed(VK_LBUTTON) then
			showCursor(false, false)
			sampAddChatMessage(tag..'Новое местоположение сохранено.', -1)
			changePositionRecon = false
			MainWindow.v = true
		end
		--if isKeyJustPressed(50) then
		--	showCursor(false, false)
		--	changePositionRecon = false
		--	sampAddChatMessage(tag..'Вы отменили изменение позиции.', -1)
		--	MainWindow.v = true
		--end
	end
end

function kotofeev()
	if imgui.ColorEdit3(u8'Основной цвет админ-чата', coloradmchat, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
		color_adminchat()
	end
	if imgui.ColorEdit3(u8'Дополнительный цвет админ-чата', twocoloradmchat, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
		twocolor_adminchat()
	end
	if imgui.ColorEdit3(u8'Основной цвет репорта', colorreport, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
		color_report()
	end
	if imgui.ColorEdit3(u8'Дополнительный цвет репорта', twocolorreport, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
		twocolor_report()
	end
	if imgui.ColorEdit3(u8'Основной цвет форм из админ-чата', colorforms, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
		color_forms()
	end
	if imgui.ColorEdit3(u8'Дополнительный цвет форм из админ-чата', twocolorforms, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
		twocolor_forms()
	end
end

function imgui.VoidText(bufvar, text)
local col = imgui.GetStyle().Colors[imgui.Col.Text]
	if #bufvar == 0 then
		imgui.SameLine(135)
		imgui.TextColored(imgui.ImVec4(col.x, col.y, col.z, 1.00), u8(text))
	end
end

function imgui.TextColoredRGB(text)
	local style = imgui.GetStyle()
	local colors = style.Colors
	local ImVec4 = imgui.ImVec4

	local explode_argb = function(argb)
		local a = bit.band(bit.rshift(argb, 24), 0xFF)
		local r = bit.band(bit.rshift(argb, 16), 0xFF)
		local g = bit.band(bit.rshift(argb, 8), 0xFF)
		local b = bit.band(argb, 0xFF)
		return a, r, g, b
	end

	local getcolor = function(color)
		if color:sub(1, 6):upper() == 'SSSSSS' then
			local r, g, b = colors[1].x, colors[1].y, colors[1].z
			local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
			return ImVec4(r, g, b, a / 255)
		end
		local color = type(color) == 'string' and tonumber(color, 16) or color
		if type(color) ~= 'number' then return end
		local r, g, b, a = explode_argb(color)
		return imgui.ImColor(r, g, b, a):GetVec4()
	end

	local render_text = function(text_)
		for w in text_:gmatch('[^\r\n]+') do
			local text, colors_, m = {}, {}, 1
			w = w:gsub('{(......)}', '{%1FF}')
			while w:find('{........}') do
				local n, k = w:find('{........}')
				local color = getcolor(w:sub(n + 1, k - 1))
				if color then
					text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
					colors_[#colors_ + 1] = color
					m = n
				end
				w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
			end
			if text[0] then
				for i = 0, #text do
					imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
					imgui.SameLine(nil, 0)
				end
				imgui.NewLine()
			else imgui.Text(u8(w)) end
		end
	end

	render_text(text)
end

function sampGetPlayerIdByNickname(nick)
  local _, myid = sampGetPlayerIdByCharHandle(playerPed)
  if tostring(nick) == sampGetPlayerNickname(myid) then return myid end
  for i = 0, 1000 do if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == tostring(nick) then return i end end
  return -1
end


function imgui.CenterTextColoredRGB(text)
		local width = imgui.GetWindowWidth()
		local style = imgui.GetStyle()
		local colors = style.Colors
		local ImVec4 = imgui.ImVec4

		local explode_argb = function(argb)
			local a = bit.band(bit.rshift(argb, 24), 0xFF)
			local r = bit.band(bit.rshift(argb, 16), 0xFF)
			local g = bit.band(bit.rshift(argb, 8), 0xFF)
			local b = bit.band(argb, 0xFF)
			return a, r, g, b
		end

		local getcolor = function(color)
			if color:sub(1, 6):upper() == 'SSSSSS' then
				local r, g, b = colors[1].x, colors[1].y, colors[1].z
				local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
				return ImVec4(r, g, b, a / 255)
			end
			local color = type(color) == 'string' and tonumber(color, 16) or color
			if type(color) ~= 'number' then return end
			local r, g, b, a = explode_argb(color)
			return imgui.ImColor(r, g, b, a):GetVec4()
		end

		local render_text = function(text_)
			for w in text_:gmatch('[^\r\n]+') do
				local textsize = w:gsub('{.-}', '')
				local text_width = imgui.CalcTextSize(u8(textsize))
				imgui.SetCursorPosX( width / 2 - text_width .x / 2 )
				local text, colors_, m = {}, {}, 1
				w = w:gsub('{(......)}', '{%1FF}')
				while w:find('{........}') do
					local n, k = w:find('{........}')
					local color = getcolor(w:sub(n + 1, k - 1))
					if color then
						text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
						colors_[#colors_ + 1] = color
						m = n
					end
					w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
				end
				if text[0] then
					for i = 0, #text do
						imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
						imgui.SameLine(nil, 0)
					end
					imgui.NewLine()
				else
					imgui.Text(u8(w))
				end
			end
		end
		render_text(text)
	end

	
function imgui.Hint(str_id, hint, delay, width)
		local hovered = imgui.IsItemHovered()
		local col = imgui.GetStyle().Colors[imgui.Col.Button]
		local animTime = 0.2
		local delay = delay or 0.00
		local show = true

		if not allHints then allHints = {} end
		if not allHints[str_id] then
			allHints[str_id] = {
				status = false,
				timer = 0
			}
		end

		if hovered then
			for k, v in pairs(allHints) do
				if k ~= str_id and os.clock() - v.timer <= animTime  then
					show = false
				end
			end
		end

		if show and allHints[str_id].status ~= hovered then
			allHints[str_id].status = hovered
			allHints[str_id].timer = os.clock() + (hovered == false and 0.00 or delay)
		end

		local showHint = function(text, alpha, max_width)
			imgui.PushStyleVar(imgui.StyleVar.Alpha, alpha)
			imgui.PushStyleVar(imgui.StyleVar.WindowRounding, 5)
			imgui.PushStyleVar(imgui.StyleVar.WindowPadding, imgui.ImVec2(10, 10))
			imgui.PushStyleColor(imgui.Col.PopupBg, imgui.ImVec4(0.15, 0.15, 0.15, 1.00))
			imgui.BeginTooltip()
			imgui.PushTextWrapPos(max_width or 450)
			imgui.TextColored(imgui.ImVec4(col.x, col.y, col.z, 1.00), fa.ICON_FA_INFO_CIRCLE..u8' Подсказка:')
			imgui.PushStyleVar(imgui.StyleVar.ItemSpacing, imgui.ImVec2(0, 0))
			imgui.TextColoredRGB(u8:decode(text))
			imgui.PopStyleVar()
			imgui.PopTextWrapPos()
			imgui.EndTooltip()
			imgui.PopStyleColor()
			imgui.PopStyleVar(3)
		end

		if show then
			local btw = os.clock() - allHints[str_id].timer
			if btw <= animTime then
				local s = function(f) 
					return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
				end
				local alpha = hovered and s(btw / animTime) or s(1.00 - btw / animTime)
				showHint(hint, alpha, width)
			elseif hovered then
				showHint(hint, 1.00, width)
			end
		end
end

function imgui.HintTwo(text, delay)
local col = imgui.GetStyle().Colors[imgui.Col.ButtonHovered]
	if imgui.IsItemHovered() then
		if go_hint == nil then go_hint = os.clock() + (delay and delay or 0.0) end
		local alpha = (os.clock() - go_hint) * 5 
		if os.clock() >= go_hint then 
			imgui.PushStyleVar(imgui.StyleVar.Alpha, alpha)
			imgui.PushStyleVar(imgui.StyleVar.WindowRounding, 5)
			imgui.PushStyleVar(imgui.StyleVar.WindowPadding, imgui.ImVec2(10, 10))
			imgui.PushStyleColor(imgui.Col.PopupBg, imgui.ImVec4(0.15, 0.15, 0.15, 1.00))
			imgui.BeginTooltip()
			imgui.PushTextWrapPos(max_width or 450)
			imgui.TextColored(imgui.ImVec4(col.x, col.y, col.z, 1.00), fa.ICON_FA_INFO_CIRCLE..u8' Подсказка:')
			imgui.PushStyleVar(imgui.StyleVar.ItemSpacing, imgui.ImVec2(0, 0))
			imgui.TextColoredRGB(u8:decode(text))
			imgui.PopStyleVar()
			imgui.PopTextWrapPos()
			imgui.EndTooltip()
			imgui.PopStyleColor()
			imgui.PopStyleVar(3)
		end
	end
end

function kotofeev3()
	local tLastKeys = {}
	imadd.HotKey('##12312312322222', ftradeKey, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Открыть панель администратора')
	imadd.HotKey('##123123123', facceptform, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Принять форму из админ-чата')
	imadd.HotKey('##1231231123523', fopentools, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Открыть меню настроек скрипта')
	imadd.HotKey('##openmenutp', fopenmenutp, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Открыть меню телепорта')
	imadd.HotKey('##openme45689nutp', fgm, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Активировать/деактивировать GodMode')
	imadd.HotKey('##openme45689nvbncvcutp', freoff, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Выйти из слежки')
	imadd.HotKey('##opbncvcutp', fvizualrep, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Вывести последний репорт в визуальный чат')
	imadd.HotKey('##opbncvcmnnutp', farep, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Вывести последний репорт в админ-чат')
	imadd.HotKey('##openreport', fopenreport, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Открыть репорт')
	imadd.HotKey('##lastreport', flastreport, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Вывести /pm на ID автора последнего репорта')
	imadd.HotKey('##lasddtreport', fnorules, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Написать автору репорта о том, что игрок не нарушает')
	imadd.HotKey('##lasddnbtreport', fspecrep, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Вступить в слежку за возможным нарушителем [репорт]')
	imadd.HotKey('##lasddnbtrephhhhort', fspecauthor, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Вступить в слежку за автором [репорт]')
	imadd.HotKey('##lasddnbtrephzzzzzzzzzzzzzzzhhhort', fperedam, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Передать администрации [репорт]')
	imadd.HotKey('##slapnut', fslap, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Слапнуть себя')
	imadd.HotKey('##vidatjp', fjetpack, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Выдать себе JetPack')
	imadd.HotKey('##famem', famember, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Открыть диалог для вступления во фракцию')
	imadd.HotKey('##speclastrep', fspeclast, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Следить за автором последнего репорта')
	imadd.HotKey('##spec12lastrep', fopenmap, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Открыть карту')
	imadd.HotKey('##flovlyareporta', flovlyareporta, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Активировать/деактивировать автоловлю репорта')
	imadd.HotKey('##adsads', fopenpunish, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Открыть меню выдачи наказаний')
	imadd.HotKey('##fairbrake', fairbrake, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Активировать/деактивировать AirBrake')
	imadd.HotKey('##upair', upair, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Повысить скорость AirBrake')
	imadd.HotKey('##fspeeddown', fspeeddown, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Понизить скорость AirBrake')
	imadd.HotKey('##fvzaim', fvzaim, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Взаимодействие с игроками в радиусе')
	imadd.HotKey('##ftpaz', ftpaz, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Телепортироваться в админ-зону')
	imadd.HotKey('##fjspeedup', fjspeedup, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Повысить скорость JetPack')
	imadd.HotKey('##fjspeeddown', fjspeeddown, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Понизить скорость JetPack')
	imadd.HotKey('##fopencbiz', fopencbiz, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Открыть отдел коммерции')
	imadd.HotKey('##fopenchome', fopenchome, {}, 100)
	imgui.SameLine()
	imgui.Text(u8'Открыть отдел недвижимости')
end



function isKeysDown(keylist)
	local tKeys = keylist
	local bool = false
	local isDownIndex = 0
	local key = #tKeys < 2 and tonumber(tKeys[1]) or tonumber(tKeys[#tKeys])
	if #tKeys < 2 then
		if not isKeyDown(VK_RMENU) and not isKeyDown(VK_LMENU) and not isKeyDown(VK_LSHIFT) then
			if wasKeyPressed(key) then
				bool = true
			end
		end
	else
		if isKeyDown(tKeys[1])  then
			if isKeyDown(tKeys[2]) then
				if tKeys[3] ~= nil then
					if isKeyDown(tKeys[3]) then
						if tKeys[4] ~= nil then
							if isKeyDown(tKeys[4]) then
								if tKeys[5] ~= nil then
									if isKeyDown(tKeys[5]) then
										if wasKeyPressed(key) then
											bool = true
										end
									end
								else
									if wasKeyPressed(key) then
										bool = true
									end
								end
							end
						else
							if wasKeyPressed(key) then
								bool = true
							end
						end
					end
				else
					if wasKeyPressed(key) then
						bool = true
					end
				end
			end
		end
	end
	if nextLockKey == keylist then
		bool = false
		nextLockKey = ""
	end
	return bool
end

function isKeysZazhat(keylist)
	local tKeys = keylist
	local bool = false
	local isDownIndex = 0
	local key = #tKeys < 2 and tonumber(tKeys[1]) or tonumber(tKeys[#tKeys])
	if #tKeys < 2 then
		if not isKeyDown(VK_RMENU) and not isKeyDown(VK_LMENU) and not isKeyDown(VK_LSHIFT) then
			if isKeyDown(key) then
				bool = true
			end
		end
	else
		if isKeyDown(tKeys[1])  then
			if isKeyDown(tKeys[2]) then
				if tKeys[3] ~= nil then
					if isKeyDown(tKeys[3]) then
						if tKeys[4] ~= nil then
							if isKeyDown(tKeys[4]) then
								if tKeys[5] ~= nil then
									if isKeyDown(tKeys[5]) then
										if isKeyDown(key) then
											bool = true
										end
									end
								else
									if isKeyDown(key) then
										bool = true
									end
								end
							end
						else
							if isKeyDown(key) then
								bool = true
							end
						end
					end
				else
					if isKeyDown(key) then
						bool = true
					end
				end
			end
		end
	end
	if nextLockKey == keylist then
		bool = false
		nextLockKey = ""
	end
	return bool
end
	
function peredam()
	if imgui.Button(fa.ICON_FA_COMMENTS..u8' Передать адм реп', imgui.ImVec2(145, 20)) then
		local template = u8:decode(reason_settings_report[9].v)
		local template = template:gsub('{nick_rep}', nick_rep) 
		local template = template:gsub('{my_id}', my_id) 
		local template = template:gsub('{id_rep}', id_rep) 
		local template = template:gsub('{my_name}', my_name) 
		sampSendDialogResponse(6370, 1, _, template)
		sampSendChat("/a >>> [РЕПОРТ] ".. report_name .."[".. report_id .."]: " .. report_text.. " ")
		text_buffer_rep.v = ''
		ReportWindow.v = false
	end
end



		
function imgui.CogButton()
	imgui.SameLine()
	imgui.TextDisabled(u8'<< Следить '..fa.ICON_FA_ROBOT)
	return imgui.IsItemClicked()
end

function imgui.SettingsButton()
	imgui.SameLine()
	imgui.PushFont(minimalfont)
	imgui.TextDisabled(fa.ICON_FA_COG)
	imgui.PopFont()
	imgui.HintTwo(u8'Настройки функции')
	return imgui.IsItemClicked()
end

function imgui.EyeButton()
	imgui.Text(fa.ICON_FA_EYE..u8'')
	return imgui.IsItemClicked()
end

function imgui.EyeSlashButton()
	imgui.Text(fa.ICON_FA_EYE_SLASH..u8'')
	return imgui.IsItemClicked()
end


function len(text)
	return #tostring(text):gsub('[\128-\191]', '')
end

function color_adminchat()
	local clr = join_argb(0, coloradmchat.v[1] * 255, coloradmchat.v[2] * 255, coloradmchat.v[3] * 255)
	cfg.coloradmchat = {r = coloradmchat.v[1] * 255, g = coloradmchat.v[2] * 255, b = coloradmchat.v[3] * 255, }
	cfg.main.coloradminchat = ('%06X'):format(clr)
end

function twocolor_adminchat()
	local clr = join_argb(0, twocoloradmchat.v[1] * 255, twocoloradmchat.v[2] * 255, twocoloradmchat.v[3] * 255)
	cfg.twocoloradmchat = {r = twocoloradmchat.v[1] * 255, g = twocoloradmchat.v[2] * 255, b = twocoloradmchat.v[3] * 255, }
	cfg.main.twocoloradminchat = ('%06X'):format(clr)
end

function stock_colorchecker()
	local clr = join_argb(0, stockcolorchecker.v[1] * 255, stockcolorchecker.v[2] * 255, stockcolorchecker.v[3] * 255)
	cfg.stockcolorchecker = {r = stockcolorchecker.v[1] * 255, g = stockcolorchecker.v[2] * 255, b = stockcolorchecker.v[3] * 255, }
	cfg.main.stockcolorchecker = ('%06X'):format(clr)
end

function adminsstock_colorchecker()
	local clr = join_argb(0, adminsstockcolorchecker.v[1] * 255, adminsstockcolorchecker.v[2] * 255, adminsstockcolorchecker.v[3] * 255)
	cfg.adminsstockcolorchecker = {r = adminsstockcolorchecker.v[1] * 255, g = adminsstockcolorchecker.v[2] * 255, b = adminsstockcolorchecker.v[3] * 255, }
	cfg.main.adminsstockcolorchecker = ('%06X'):format(clr)
end

function afk_colorchecker()
	local clr = join_argb(0, afkcolorchecker.v[1] * 255, afkcolorchecker.v[2] * 255, afkcolorchecker.v[3] * 255)
	cfg.afkcolorchecker = {r = afkcolorchecker.v[1] * 255, g = afkcolorchecker.v[2] * 255, b = afkcolorchecker.v[3] * 255, }
	cfg.main.afkcolorchecker = ('%06X'):format(clr)
end

function color_report()
	local clr = join_argb(0, colorreport.v[1] * 255, colorreport.v[2] * 255, colorreport.v[3] * 255)
	cfg.colorreport = {r = colorreport.v[1] * 255, g = colorreport.v[2] * 255, b = colorreport.v[3] * 255, }
	cfg.main.colorreport = ('%06X'):format(clr)
end

function twocolor_report()
	local clr = join_argb(0, twocolorreport.v[1] * 255, twocolorreport.v[2] * 255, twocolorreport.v[3] * 255)
	cfg.twocolorreport = {r = twocolorreport.v[1] * 255, g = twocolorreport.v[2] * 255, b = twocolorreport.v[3] * 255, }
	cfg.main.twocolorreport = ('%06X'):format(clr)
end


function color_forms()
	local clr = join_argb(0, colorforms.v[1] * 255, colorforms.v[2] * 255, colorforms.v[3] * 255)
	cfg.colorforms = {r = colorforms.v[1] * 255, g = colorforms.v[2] * 255, b = colorforms.v[3] * 255, }
	cfg.main.colorforms = ('%06X'):format(clr)
end

function twocolor_forms()
	local clr = join_argb(0, twocolorforms.v[1] * 255, twocolorforms.v[2] * 255, twocolorforms.v[3] * 255)
	cfg.twocolorforms = {r = twocolorforms.v[1] * 255, g = twocolorforms.v[2] * 255, b = twocolorforms.v[3] * 255, }
	cfg.main.twocolorforms = ('%06X'):format(clr)
end

function checkNameKlavisha(arg)
	if arg == '[65]' then
		name = "A" 

	elseif arg == '[66]' then
		name = "B" 

	elseif arg == '[67]' then
		name = "C" 

	elseif arg == '[68]' then
		name = "D" 

	elseif arg == '[69]' then
		name = "E"

	elseif arg == '[70]' then
		name = "F"

	elseif arg == '[71]' then
		name = "G"

	elseif arg == '[72]' then
		name = "H"

	elseif arg == '[73]' then
		name = "I"

	elseif arg == '[74]' then
		name = "J"

	elseif arg == '[75]' then
		name = "K"

	elseif arg == '[76]' then
		name = "L"

	elseif arg == '[77]' then
		name = "M"

	elseif arg == '[78]' then
		name = "N"

	elseif arg == '[79]' then
		name = "O"

	elseif arg == '[80]' then
		name = "P"

	elseif arg == '[81]' then
		name = "Q"
	
	elseif arg == '[82]' then
		name = "R"

	elseif arg == '[83]' then
		name = "S"

	elseif arg == '[84]' then
		name = "T"

	elseif arg == '[85]' then
		name = "U"

	elseif arg == '[86]' then
		name = "V"

	elseif arg == '[87]' then
		name = "W"

	elseif arg == '[88]' then
		name = "X"

	elseif arg == '[89]' then
		name = "Y"

	elseif arg == '[90]' then
		name = "Z"

	elseif arg == '[112]' then
		name = "F1"

	elseif arg == '[113]' then
		name = "F2"

	elseif arg == '[114]' then
		name = "F3"

	elseif arg == '[115]' then
		name = "F4"

	elseif arg == '[116]' then
		name = "F5"

	elseif arg == '[117]' then
		name = "F6"

	elseif arg == '[118]' then
		name = "F7"

	elseif arg == '[119]' then
		name = "F8"

	elseif arg == '[120]' then
		name = "F9"

	elseif arg == '[121]' then
		name = "F10"

	elseif arg == '[122]' then
		name = "F11"

	elseif arg == '[123]' then
		name = "F12"

	elseif arg == '[96]' then
		name = "Num 0"

	elseif arg == '[97]' then
		name = "Num 1"

	elseif arg == '[98]' then
		name = "Num 2"

	elseif arg == '[99]' then
		name = "Num 3"

	elseif arg == '[100]' then
		name = "Num 4"

	elseif arg == '[101]' then
		name = "Num 5"

	elseif arg == '[102]' then
		name = "Num 6"

	elseif arg == '[103]' then
		name = "Num 7"

	elseif arg == '[104]' then
		name = "Num 8"

	elseif arg == '[105]' then
		name = "Num 9"

	elseif arg == '[16]' then
		name = "L/R SHIFT"

	elseif arg == '[17]' then
		name = "L/R CTRL"

	elseif arg == '[20]' then
		name = "Caps Lock"

	elseif arg == '[192]' then
		name = "`"

	elseif arg == '[48]' then
		name = "0"

	elseif arg == '[49]' then
		name = "1"

	elseif arg == '[50]' then
		name = "2"

	elseif arg == '[51]' then
		name = "3"

	elseif arg == '[52]' then
		name = "4"

	elseif arg == '[53]' then
		name = "5"

	elseif arg == '[54]' then
		name = "6"

	elseif arg == '[55]' then
		name = "7"

	elseif arg == '[56]' then
		name = "8"

	elseif arg == '[57]' then
		name = "9"

	elseif arg == '[187]' then
		name = "+"

	elseif arg == '[189]' then
		name = "-"

	elseif arg == '[191]' then
		name = "/"

	elseif arg == '[220]' then
		name = '|'

	elseif arg == '[8]' then
		name = "Esc"

	elseif arg == '[13]' then
		name = "Enter / Num Enter"

	elseif arg == '[45]' then
		name = "Insert"

	elseif arg == '[36]' then
		name = "Home"

	elseif arg == '[33]' then
		name = "Page Up"

	elseif arg == '[46]' then
		name = "Delete / Num Del"

	elseif arg == '[35]' then
		name = "End"

	elseif arg == '[34]' then
		name = "Page Down"

	elseif arg == '[44]' then
		name = "Print Screen Sys Rq"

	elseif arg == '[145]' then
		name = "Scroll Lock"

	elseif arg == '[19]' then
		name = "Pause Break"

	elseif arg == '[144]' then
		name = "Num Lock"

	elseif arg == '[111]' then
		name = "Num  /"

	elseif arg == '[106]' then
		name = "Num *"

	elseif arg == '[109]' then
		name = "Num -"

	elseif arg == '[107]' then
		name = "Num +"

	elseif arg == '[9]' then
		name = "Tab"

	elseif arg == nil then
		name = "None"
	end
	return name
end

function getClosestCarId()
	local minDist = 9999
	local closestId = -1
	local x, y, z = getCharCoordinates(PLAYER_PED)
	for i, k in ipairs(getAllVehicles()) do
	   local xi, yi, zi = getCarCoordinates(k)
	   local dist = math.sqrt( (xi - x) ^ 2 + (yi - y) ^ 2 + (zi - z) ^ 2 )
	   if dist < minDist then
		  minDist = dist
		  closestId = getCarModel(k)
	   end
	end
	return closestId
end
function kotofeevformi()
	imgui.NewLine()
	imgui.Separator()
	imgui.TextColoredRGB('{E78284}*Р {84A6E7}- принимать вручную\n{E78284}*А{84A6E7} - принимать автоматически\n{E78284}*З{84A6E7} - звуковое оповещение')
	imgui.BeginChild("ChildWin1231233dow", imgui.ImVec2(140, 1400), true)
	imgui.CenterText(u8'Команда')
	imgui.Separator()
	imgui.Button(u8'/slap', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/jail', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/mute', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/kick', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/ban', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/unban', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/banip', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/setadmtag', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/plveh', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/warn', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/flip', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/freeze', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/pm', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/spplayer', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/sethp', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/unjail', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/weap', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/unmute', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/spcar', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/getip', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/pgetip', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/unwarn', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/givegun', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/removetune', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/delbname', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/delhname', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/warnoff', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/setgangzone', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/makeleader', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/sban', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/unbanip', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/jailoff', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/muteoff', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/skick', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/setskin', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/uval', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/ao', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/vv', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/deladmtag', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/banoff', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/agl', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/setname', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/banipoff', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/veh', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/agiveskin', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/giveitem', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/acceptadmin', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/awarn', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/unjailoff', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/asellbiz', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/asellhouse', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/setarmour', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/unmuteoff', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/rmute', imgui.ImVec2(-1, 20))
	imgui.Button(u8'/unrmute', imgui.ImVec2(-1, 20))
	imgui.EndChild()
	imgui.SameLine()
	imgui.BeginChild("ChildWin123123s3dow", imgui.ImVec2(40, 1400), true)
	imgui.CenterText(u8'P')
	imgui.Separator()
	
	if imgui.Checkbox('##sad', forma_slap) then
		cfg.formssettings.forma_slap = forma_slap.v
	end
	
	if imgui.Checkbox('##69', forma_jail) then
		cfg.formssettings.forma_jail = forma_jail.v
	end
	
	if imgui.Checkbox('##sad123123', forma_mute) then
		cfg.formssettings.forma_mute = forma_mute.v
	end
	
	if imgui.Checkbox('##sad123', forma_kick) then
		cfg.formssettings.forma_kick = forma_kick.v
	end

	if imgui.Checkbox('##ban', forma_ban) then
		cfg.formssettings.forma_ban = forma_ban.v
	end
	
	if imgui.Checkbox('##unban', forma_unban) then
		cfg.formssettings.forma_unban = forma_unban.v
	end
	
	if imgui.Checkbox('##banip', forma_banip) then
		cfg.formssettings.forma_banip = forma_banip.v
	end
	
	if imgui.Checkbox('##setadmtag', forma_setadmtag) then
		cfg.formssettings.forma_setadmtag = forma_setadmtag.v
	end
	
		if imgui.Checkbox('##plveh', forma_plveh) then
			cfg.formssettings.forma_plveh = forma_plveh.v
		end
	
		if imgui.Checkbox('##warn', forma_warn) then
			cfg.formssettings.forma_warn = forma_warn.v
		end
		
		if imgui.Checkbox('##flip', forma_flip) then
			cfg.formssettings.forma_flip = forma_flip.v
		end
		if imgui.Checkbox('##freeze', forma_freeze) then
			cfg.formssettings.forma_freeze = forma_freeze.v
		end
	
		if imgui.Checkbox('##pm', forma_pm) then
			cfg.formssettings.forma_pm = forma_pm.v
		end
		
		if imgui.Checkbox('##spplayer', forma_spplayer) then
			cfg.formssettings.forma_spplayer = forma_spplayer.v
		end
	
		if imgui.Checkbox('##sethp', forma_sethp) then
			cfg.formssettings.forma_sethp = forma_sethp.v
		end
	
		if imgui.Checkbox('##unjail', forma_unjail) then
			cfg.formssettings.forma_unjail = forma_unjail.v
		end
		
		if imgui.Checkbox('##weap', forma_weap) then
			cfg.formssettings.forma_weap = forma_weap.v
		end
	
		if imgui.Checkbox('##unmute', forma_unmute) then
			cfg.formssettings.forma_unmute = forma_unmute.v
		end
		
		if imgui.Checkbox('##spcar', forma_spcar) then
			cfg.formssettings.forma_spcar = forma_spcar.v
		end
		
		if imgui.Checkbox('##getip', forma_getip) then
			cfg.formssettings.forma_getip = forma_getip.v
		end
	
		if imgui.Checkbox('##pgetip', forma_pgetip) then
			cfg.formssettings.forma_pgetip = forma_pgetip.v
		end
		
		if imgui.Checkbox('##unwarn', forma_unwarn) then
			cfg.formssettings.forma_unwarn = forma_unwarn.v
		end
	
		if imgui.Checkbox('##givegun', forma_givegun) then
			cfg.formssettings.forma_givegun = forma_givegun.v
		end
	
		if imgui.Checkbox('##removetune', forma_removetune) then
			cfg.formssettings.forma_removetune = forma_removetune.v
		end
	

		if imgui.Checkbox('##delbname', forma_delbname) then
			cfg.formssettings.forma_delbname = forma_delbname.v
		end
		
	
		if imgui.Checkbox('##delhname', forma_delhname) then
			cfg.formssettings.forma_delhname = forma_delhname.v
		end
		
		if imgui.Checkbox('##warnoff', forma_warnoff) then
			cfg.formssettings.forma_warnoff = forma_warnoff.v
		end
		
		if imgui.Checkbox('##setgangzone', forma_setgangzone) then
			cfg.formssettings.forma_setgangzone	= forma_setgangzone.v
		end
		
		if imgui.Checkbox('##makeleader', forma_makeleader) then
			cfg.formssettings.forma_makeleader = forma_makeleader.v
		end
		
		if imgui.Checkbox('##sban', forma_sban) then
			cfg.formssettings.forma_sban = forma_sban.v
		end
		
		if imgui.Checkbox('##unbanip', forma_unbanip) then
			cfg.formssettings.forma_unbanip = forma_unbanip.v
		end
		
		if imgui.Checkbox('##jailoff', forma_jailoff) then
			cfg.formssettings.forma_jailoff = forma_jailoff.v
		end
	
	
		if imgui.Checkbox('##muteoff', forma_muteoff) then
			cfg.formssettings.forma_muteoff = forma_muteoff.v
		end
		
		if imgui.Checkbox('##skick', forma_skick) then
			cfg.formssettings.forma_skick = forma_skick.v
		end
	
		if imgui.Checkbox('##setskin', forma_setskin) then
			cfg.formssettings.forma_setskin = forma_setskin.v
		end
		
		if imgui.Checkbox('##uval', forma_uval) then
			cfg.formssettings.forma_uval = forma_uval.v
		end
		
		if imgui.Checkbox('##ao', forma_ao) then
			cfg.formssettings.forma_ao = forma_ao.v
		end
		
		if imgui.Checkbox('##vv', forma_vv) then
			cfg.formssettings.forma_vv = forma_vv.v
		end
		
		if imgui.Checkbox('##deladmtag', forma_deladmtag) then
			cfg.formssettings.forma_deladmtag = forma_deladmtag.v
		end
		
		if imgui.Checkbox('##banoff', forma_banoff) then
			cfg.formssettings.forma_banoff = forma_banoff.v
		end
	
		if imgui.Checkbox('##agl', forma_agl) then
			cfg.formssettings.forma_agl = forma_agl.v
		end
		
		if imgui.Checkbox('##setname', forma_setname) then
			cfg.formssettings.forma_setname = forma_setname.v
		end
		if imgui.Checkbox('##banipoff', forma_banipoff) then
			cfg.formssettings.forma_banipoff = forma_banipoff.v
		end
	
		if imgui.Checkbox('##veh', forma_veh) then
			cfg.formssettings.forma_veh = forma_veh.v
		end
	
		if imgui.Checkbox('##agiveskin', forma_agiveskin) then
			cfg.formssettings.forma_agiveskin = forma_agiveskin.v
		end
	
		if imgui.Checkbox('##giveitem', forma_giveitem) then
			cfg.formssettings.forma_giveitem = forma_giveitem.v
		end
			
		if imgui.Checkbox('##acceptadmin', forma_acceptadmin) then
			cfg.formssettings.forma_acceptadmin = forma_acceptadmin.v
		end
	
		if imgui.Checkbox('##awarn', forma_awarn) then
			cfg.formssettings.forma_awarn = forma_awarn.v
		end
	
		if imgui.Checkbox('##unjailoff', forma_unjailoff) then
			cfg.formssettings.forma_unjailoff = forma_unjailoff.v
		end
	
		if imgui.Checkbox('##asellbiz', forma_asellbiz) then
			cfg.formssettings.forma_asellbiz = forma_asellbiz.v
		end
	
	if imgui.Checkbox('##asellhouse', forma_asellhouse) then
		cfg.formssettings.forma_asellhouse = forma_asellhouse.v
	end
	
	if imgui.Checkbox('##setarmour', forma_setarmour) then
		cfg.formssettings.forma_setarmour = forma_setarmour.v
	end
	
	if imgui.Checkbox('##unmuteoff', forma_unmuteoff) then
		cfg.formssettings.forma_unmuteoff = forma_unmuteoff.v
	end
	
	if imgui.Checkbox('##rmute', forma_rmute) then
		cfg.formssettings.forma_rmute = forma_rmute.v
	end
	
	if imgui.Checkbox('##unrmute', forma_unrmute) then
		cfg.formssettings.forma_unrmute = forma_unrmute.v
	end
	imgui.EndChild()
	imgui.SameLine()
	imgui.BeginChild("ChildWin123123s3dow2", imgui.ImVec2(40, 1400), true)
	imgui.CenterText(u8'A')
	imgui.Separator()
	if imgui.Checkbox('##autoformaslap', autoforma_slap) then
		cfg.formssettings.autoforma_slap = autoforma_slap.v
	end
	if imgui.Checkbox('##autoformajail', autoforma_jail) then
		cfg.formssettings.autoforma_jail = autoforma_jail.v
	end
	
	if imgui.Checkbox('##sad1231123', autoforma_mute) then
		cfg.formssettings.autoforma_mute = autoforma_mute.v
	end
	
	if imgui.Checkbox('##sad113', autoforma_kick) then
		cfg.formssettings.autoforma_kick = autoforma_kick.v
	end

	if imgui.Checkbox('##ban1', autoforma_ban) then
		cfg.formssettings.autoforma_ban = autoforma_ban.v
	end
	
	if imgui.Checkbox('##unba1n', autoforma_unban) then
		cfg.formssettings.autoforma_unban = autoforma_unban.v
	end
	
	if imgui.Checkbox('##ba1nip', autoforma_banip) then
		cfg.formssettings.autoforma_banip = autoforma_banip.v
	end
	
	if imgui.Checkbox('##set1admtag', autoforma_setadmtag) then
		cfg.formssettings.autoforma_setadmtag = autoforma_setadmtag.v
	end
	
		if imgui.Checkbox('##p1lveh', autoforma_plveh) then
			cfg.formssettings.autoforma_plveh = autoforma_plveh.v
		end
	
		if imgui.Checkbox('##w1arn', autoforma_warn) then
			cfg.formssettings.autoforma_warn = autoforma_warn.v
		end
		
		if imgui.Checkbox('##f1lip', autoforma_flip) then
			cfg.formssettings.autoforma_flip = autoforma_flip.v
		end
		
		if imgui.Checkbox('##fr1eeze', autoforma_freeze) then
			cfg.formssettings.autoforma_freeze = autoforma_freeze.v
		end
		
		if imgui.Checkbox('##p1m', autoforma_pm) then
			cfg.formssettings.autoforma_pm = autoforma_pm.v
		end
		
		if imgui.Checkbox('##sppl1ayer', autoforma_spplayer) then
			cfg.formssettings.autoforma_spplayer = autoforma_spplayer.v
		end
	
		if imgui.Checkbox('##se1thp', autoforma_sethp) then
			cfg.formssettings.autoforma_sethp = autoforma_sethp.v
		end
	
		if imgui.Checkbox('##u1njail', autoforma_unjail) then
			cfg.formssettings.autoforma_unjail = autoforma_unjail.v
		end
		
		if imgui.Checkbox('##w1eap', autoforma_weap) then
			cfg.formssettings.autoforma_weap = autoforma_weap.v
		end
	
		if imgui.Checkbox('##un1ute', autoforma_unmute) then
			cfg.formssettings.autoforma_unmute = autoforma_unmute.v
		end
			
		if imgui.Checkbox('##sp1car', autoforma_spcar) then
			cfg.formssettings.autoforma_spcar = autoforma_spcar.v
		end
		
		if imgui.Checkbox('##ge1tip', autoforma_getip) then
			cfg.formssettings.autoforma_getip = autoforma_getip.v
		end
	
		if imgui.Checkbox('##pg1etip', autoforma_pgetip) then
			cfg.formssettings.autoforma_pgetip = autoforma_pgetip.v
		end
		
		if imgui.Checkbox('##u1nwarn', autoforma_unwarn) then
			cfg.formssettings.autoforma_unwarn = autoforma_unwarn.v
		end
	
		if imgui.Checkbox('##gi1vegun', autoforma_givegun) then
			cfg.formssettings.autoforma_givegun = autoforma_givegun.v
		end
		
		if imgui.Checkbox('##re1movetune', autoforma_removetune) then
			cfg.formssettings.autoforma_removetune = autoforma_removetune.v
		end
	

		if imgui.Checkbox('##del1bname', autoforma_delbname) then
			cfg.formssettings.autoforma_delbname = autoforma_delbname.v
		end
		
	
		if imgui.Checkbox('##del1hname', autoforma_delhname) then
			cfg.formssettings.autoforma_delhname = autoforma_delhname.v
		end
			
		if imgui.Checkbox('##w1arnoff', autoforma_warnoff) then
			cfg.formssettings.autoforma_warnoff = autoforma_warnoff.v
		end
		
		if imgui.Checkbox('##setgangzone22', autoforma_setgangzone) then
			cfg.formssettings.autoorma_setgangzone	= autoforma_setgangzone.v
		end
		
		if imgui.Checkbox('##makel1eader', autoforma_makeleader) then
			cfg.formssettings.autoforma_makeleader = autoforma_makeleader.v
		end
		
		if imgui.Checkbox('##sb1an', autoforma_sban) then
			cfg.formssettings.autoforma_sban = autoforma_sban.v
		end
		
		if imgui.Checkbox('##unb1anip', autoforma_unbanip) then
			cfg.formssettings.autoforma_unbanip = autoforma_unbanip.v
		end
		
		if imgui.Checkbox('##jailo1ff', autoforma_jailoff) then
			cfg.formssettings.autoforma_jailoff = autoforma_jailoff.v
		end
		
	
		if imgui.Checkbox('##muteo1ff', autoforma_muteoff) then
			cfg.formssettings.autoforma_muteoff = autoforma_muteoff.v
		end
		
	
		if imgui.Checkbox('##sk1ick', autoforma_skick) then
			cfg.formssettings.autoforma_skick = autoforma_skick.v
		end
	
	
		if imgui.Checkbox('##set1skin', autoforma_setskin) then
			cfg.formssettings.autoforma_setskin = autoforma_setskin.v
		end
		
	
		if imgui.Checkbox('##u1val', autoforma_uval) then
			cfg.formssettings.autoforma_uval = autoforma_uval.v
		end
			
		if imgui.Checkbox('##a1o', autoforma_ao) then
			cfg.formssettings.autoforma_ao = autoforma_ao.v
		end
		
		if imgui.Checkbox('##vv1', autoforma_vv) then
			cfg.formssettings.autoforma_vv = autoforma_vv.v
		end
		
	
		if imgui.Checkbox('##deladmtag1', autoforma_deladmtag) then
			cfg.formssettings.autoforma_deladmtag = autoforma_deladmtag.v
		end
		
	
		if imgui.Checkbox('##bano1ff', autoforma_banoff) then
			cfg.formssettings.autoforma_banoff = autoforma_banoff.v
		end
	
		if imgui.Checkbox('##ag1l', autoforma_agl) then
			cfg.formssettings.autoforma_agl = autoforma_agl.v
		end
		
	
		if imgui.Checkbox('##setn1ame', autoforma_setname) then
			cfg.formssettings.autoforma_setname = autoforma_setname.v
		end
		if imgui.Checkbox('##banipoffff', autoforma_banipoff) then
			cfg.formssettings.autoforma_banipoff = autoforma_banipoff.v
		end
		
		if imgui.Checkbox('##ve1h', autoforma_veh) then
			cfg.formssettings.autoforma_veh = autoforma_veh.v
		end
	
		if imgui.Checkbox('##agive1skin', autoforma_agiveskin) then
			cfg.formssettings.autoforma_agiveskin = autoforma_agiveskin.v
		end
	
		if imgui.Checkbox('##giveit1em', autoforma_giveitem) then
			cfg.formssettings.autoforma_giveitem = autoforma_giveitem.v
		end
	
		if imgui.Checkbox('##accept1admin', autoforma_acceptadmin) then
			cfg.formssettings.autoforma_acceptadmin = autoforma_acceptadmin.v
		end
	
		if imgui.Checkbox('##a1warn', autoforma_awarn) then
			cfg.formssettings.autoforma_awarn = autoforma_awarn.v
		end
	
		if imgui.Checkbox('##unj1ailoff', autoforma_unjailoff) then
			cfg.formssettings.autoforma_unjailoff = autoforma_unjailoff.v
		end
	
		if imgui.Checkbox('##ase1llbiz', autoforma_asellbiz) then
			cfg.formssettings.autoforma_asellbiz = autoforma_asellbiz.v
		end
	
	if imgui.Checkbox('##asel1lhouse', autoforma_asellhouse) then
		cfg.formssettings.autoforma_asellhouse = autoforma_asellhouse.v
	end
	
	if imgui.Checkbox('##seta1rmour', autoforma_setarmour) then
		cfg.formssettings.autoforma_setarmour = autoforma_setarmour.v
	end
	
	if imgui.Checkbox('##unmut1eoff', autoforma_unmuteoff) then
		cfg.formssettings.autoforma_unmuteoff = autoforma_unmuteoff.v
	end
		
	if imgui.Checkbox('##rmute1', autoforma_rmute) then
		cfg.formssettings.autoforma_rmute = autoforma_rmute.v
	end
	
	if imgui.Checkbox('##unrmute1', autoforma_unrmute) then
		cfg.formssettings.autoforma_unrmute = autoforma_unrmute.v
	end
	imgui.EndChild()
	imgui.SameLine()
	imgui.BeginChild("ChildWin123123s3dow3", imgui.ImVec2(40, 1400), true)
	imgui.CenterText(u8'З')
	imgui.Separator()
	if imgui.Checkbox('##идинахуй122123', notf_slap) then
		cfg.formssettings.notf_slap = notf_slap.v
	end
	if imgui.Checkbox('##autoformajawil', notf_jail) then
		cfg.formssettings.notf_jail = notf_jail.v
	end
	
	if imgui.Checkbox('##sad12311231', notf_mute) then
		cfg.formssettings.notf_mute = notf_mute.v
	end
	
	if imgui.Checkbox('##sad1131', notf_kick) then
		cfg.formssettings.notf_kick = notf_kick.v
	end

	if imgui.Checkbox('##ban21', notf_ban) then
		cfg.formssettings.notf_ban = notf_ban.v
	end
	
	if imgui.Checkbox('##unba1n', notf_unban) then
		cfg.formssettings.notf_unban = notf_unban.v
	end
	
	if imgui.Checkbox('##ba1nip', notf_banip) then
		cfg.formssettings.notf_banip = notf_banip.v
	end
	
	if imgui.Checkbox('##set1admtag', notf_setadmtag) then
		cfg.formssettings.notf_setadmtag = notf_setadmtag.v
	end
	
		if imgui.Checkbox('##p1lveh', notf_plveh) then
			cfg.formssettings.notf_plveh = notf_plveh.v
		end
	
		if imgui.Checkbox('##w1arn', notf_warn) then
			cfg.formssettings.notf_warn = notf_warn.v
		end
		
		if imgui.Checkbox('##f1lip', notf_flip) then
			cfg.formssettings.notf_flip = notf_flip.v
		end
		
		if imgui.Checkbox('##fr1eeze', notf_freeze) then
			cfg.formssettings.notf_freeze = notf_freeze.v
		end
		
		if imgui.Checkbox('##p1m', notf_pm) then
			cfg.formssettings.notf_pm = notf_pm.v
		end
		
		if imgui.Checkbox('##sppl1ayer', notf_spplayer) then
			cfg.formssettings.notf_spplayer = notf_spplayer.v
		end
	
		if imgui.Checkbox('##se1thp', notf_sethp) then
			cfg.formssettings.notf_sethp = notf_sethp.v
		end
	
		if imgui.Checkbox('##u1njail', notf_unjail) then
			cfg.formssettings.notf_unjail = notf_unjail.v
		end
		
		if imgui.Checkbox('##w1eap', notf_weap) then
			cfg.formssettings.notf_weap = notf_weap.v
		end
	
		if imgui.Checkbox('##un1ute', notf_unmute) then
			cfg.formssettings.notf_unmute = notf_unmute.v
		end
			
		if imgui.Checkbox('##sp1car', notf_spcar) then
			cfg.formssettings.notf_spcar = notf_spcar.v
		end
		
		if imgui.Checkbox('##ge1tip', notf_getip) then
			cfg.formssettings.notf_getip = notf_getip.v
		end
	
		if imgui.Checkbox('##pg1etip', notf_pgetip) then
			cfg.formssettings.notf_pgetip = notf_pgetip.v
		end
		
		if imgui.Checkbox('##u1nwarn', notf_unwarn) then
			cfg.formssettings.notf_unwarn = notf_unwarn.v
		end
	
		if imgui.Checkbox('##gi1vegun', notf_givegun) then
			cfg.formssettings.notf_givegun = notf_givegun.v
		end
		
		if imgui.Checkbox('##re1movetune', notf_removetune) then
			cfg.formssettings.notf_removetune = notf_removetune.v
		end
	

		if imgui.Checkbox('##del1bname', notf_delbname) then
			cfg.formssettings.notf_delbname = notf_delbname.v
		end
		
	
		if imgui.Checkbox('##del1hname', notf_delhname) then
			cfg.formssettings.notf_delhname = notf_delhname.v
		end
			
		if imgui.Checkbox('##w1arnoff', notf_warnoff) then
			cfg.formssettings.notf_warnoff = notf_warnoff.v
		end
		
		if imgui.Checkbox('##setgangzone1', notf_setgangzone) then
			cfg.formssettings.notf_setgangzone = notf_setgangzone.v
		end
		
		if imgui.Checkbox('##makel1eader', notf_makeleader) then
			cfg.formssettings.notf_makeleader = notf_makeleader.v
		end
		
		if imgui.Checkbox('##sb1an', notf_sban) then
			cfg.formssettings.notf_sban = notf_sban.v
		end
		
		if imgui.Checkbox('##unb1anip', notf_unbanip) then
			cfg.formssettings.notf_unbanip = notf_unbanip.v
		end
		
		if imgui.Checkbox('##jailo1ff', notf_jailoff) then
			cfg.formssettings.notf_jailoff = notf_jailoff.v
		end
		
	
		if imgui.Checkbox('##muteo1ff', notf_muteoff) then
			cfg.formssettings.notf_muteoff = notf_muteoff.v
		end
		
	
		if imgui.Checkbox('##sk1ick', notf_skick) then
			cfg.formssettings.notf_skick = notf_skick.v
		end
	
	
		if imgui.Checkbox('##set1skin', notf_setskin) then
			cfg.formssettings.notf_setskin = notf_setskin.v
		end
		
	
		if imgui.Checkbox('##u1val', notf_uval) then
			cfg.formssettings.notf_uval = notf_uval.v
		end
			
		if imgui.Checkbox('##a1o', notf_ao) then
			cfg.formssettings.notf_ao = notf_ao.v
		end
		
		if imgui.Checkbox('##vv2', notf_vv) then
			cfg.formssettings.notf_vv = notf_vv.v
		end
		
	
		if imgui.Checkbox('##deladmtag2', notf_deladmtag) then
			cfg.formssettings.notf_deladmtag = notf_deladmtag.v
		end
		
	
		if imgui.Checkbox('##bano1ff', notf_banoff) then
			cfg.formssettings.notf_banoff = notf_banoff.v
		end
	
		if imgui.Checkbox('##ag1l', notf_agl) then
			cfg.formssettings.notf_agl = notf_agl.v
		end
		
	
		if imgui.Checkbox('##setn1ame', notf_setname) then
			cfg.formssettings.notf_setname = notf_setname.v
		end
		if imgui.Checkbox('##sadjsadjerwjasdsadq', notf_banipoff) then
			cfg.formssettings.notf_banipoff = notf_banipoff.v
		end
			
		if imgui.Checkbox('##ve1h', notf_veh) then
			cfg.formssettings.notf_veh = notf_veh.v
		end
	
		if imgui.Checkbox('##agive1skin', notf_agiveskin) then
			cfg.formssettings.notf_agiveskin = notf_agiveskin.v
		end
	
		if imgui.Checkbox('##giveit1em', notf_giveitem) then
			cfg.formssettings.notf_giveitem = notf_giveitem.v
		end
	
		if imgui.Checkbox('##accept1admin', notf_acceptadmin) then
			cfg.formssettings.notf_acceptadmin = notf_acceptadmin.v
		end
	
		if imgui.Checkbox('##a1warn', notf_awarn) then
			cfg.formssettings.notf_awarn = notf_awarn.v
		end
	
		if imgui.Checkbox('##unj1ailoff', notf_unjailoff) then
			cfg.formssettings.notf_unjailoff = notf_unjailoff.v
		end
	
		if imgui.Checkbox('##ase1llbiz', notf_asellbiz) then
			cfg.formssettings.notf_asellbiz = notf_asellbiz.v
		end
	
	if imgui.Checkbox('##asel1lhouse', notf_asellhouse) then
		cfg.formssettings.notf_asellhouse = notf_asellhouse.v
	end
	
	if imgui.Checkbox('##seta1rmour', notf_setarmour) then
		cfg.formssettings.notf_setarmour = notf_setarmour.v
	end
	
	if imgui.Checkbox('##unmut1eoff', notf_unmuteoff) then
		cfg.formssettings.notf_unmuteoff = notf_unmuteoff.v
	end
	
	if imgui.Checkbox('##rmute2', notf_rmute) then
		cfg.formssettings.notf_rmute = notf_rmute.v
	end
	
	if imgui.Checkbox('##unrmute2', notf_unrmute) then
		cfg.formssettings.notf_unrmute = notf_unrmute.v
	end
	imgui.EndChild()
end

function kotofeevstatsadm()
	imgui.Text(u8'Местоположение окна статистики:')
	imgui.SameLine()
	if imgui.Button(fa.ICON_FA_ARROWS_ALT..u8'', imgui.ImVec2(-1, 25)) then
		if to.v then
		ChangePosWindow.v = true
		else
		sampAddChatMessage(tag..'Перемещение невозможно пока выключена панель информации', -1)
		end
	end
	if imgui.RadioButton(u8'Отображать онлайн (текущая сессия)', Radio['sesOnline']) then Radio['sesOnline'] = not Radio['sesOnline']; cfg.statTimers.sesOnline = Radio['sesOnline'] end
	if imgui.RadioButton(u8'Отображать онлайн за день', Radio['dayOnline']) then Radio['dayOnline'] = not Radio['dayOnline']; cfg.statTimers.dayOnline = Radio['dayOnline'] end
	if imgui.RadioButton(u8'Отображать онлайн в афк', Radio['dayAfk']) then Radio['dayAfk'] = not Radio['dayAfk']; cfg.statTimers.dayAfk = Radio['dayAfk'] end
	if imgui.RadioButton(u8'Отображать онлайн за неделю (без учета афк)', Radio['weekOnline']) then Radio['weekOnline'] = not Radio['weekOnline']; cfg.statTimers.weekOnline = Radio['weekOnline'] end
	if imgui.RadioButton(u8'Отображать онлайн афк за неделю', Radio['weekAfk']) then Radio['weekAfk'] = not Radio['weekAfk']; cfg.statTimers.weekAfk = Radio['weekAfk'] end
	if imgui.RadioButton(u8'Отображать общий онлайн за неделю (с учетом афк)', Radio['weekFull']) then Radio['weekFull'] = not Radio['weekFull']; cfg.statTimers.weekFull = Radio['weekFull'] end
	if imgui.RadioButton(u8'Отображать выданные наказания за день', Radio['nakazaniyaDay']) then Radio['nakazaniyaDay'] = not Radio['nakazaniyaDay']; cfg.statTimers.nakazaniyaDay = Radio['nakazaniyaDay'] end
	if imgui.RadioButton(u8'Отображать выданные наказания за все время', Radio['nakazaniyaVse']) then Radio['nakazaniyaVse'] = not Radio['nakazaniyaVse']; cfg.statTimers.nakazaniyaVse = Radio['nakazaniyaVse'] end
	if imgui.RadioButton(u8'Отображать выданные форм за день', Radio['formsDay']) then Radio['formsDay'] = not Radio['formsDay']; cfg.statTimers.formsDay = Radio['formsDay'] end
	if imgui.RadioButton(u8'Отображать выданные форм за все время', Radio['formsVse']) then Radio['formsVse'] = not Radio['formsVse']; cfg.statTimers.formsVse = Radio['formsVse'] end
	if imgui.RadioButton(u8'Отображать репортов отвечено за день', Radio['reportsDay']) then Radio['reportsDay'] = not Radio['reportsDay']; cfg.statTimers.reportsDay = Radio['reportsDay'] end
	if imgui.RadioButton(u8'Отображать репортов отвечено за все время', Radio['reportsVse']) then Radio['reportsVse'] = not Radio['reportsVse']; cfg.statTimers.reportsVse = Radio['reportsVse'] end
	if imgui.RadioButton(u8'Отображать кол-во репортов на данный момент', Radio['reportnow']) then Radio['reportnow'] = not Radio['reportnow']; cfg.statTimers.reportnow = Radio['reportnow'] end
	if imgui.RadioButton(u8'Отображать текущее время', Radio['nowTime']) then Radio['nowTime'] = not Radio['nowTime']; cfg.statTimers.nowTime = Radio['nowTime'] end
	imgui.Separator()
	imgui.PushFont(fontsize)
	imgui.CenterText(u8'Предосмотр')
	imgui.PopFont()
	if sampGetGamestate() ~= 3 then 
		imgui.TextColoredRGB("Подключение к серверу:\n"..get_clock(connectingTime))
	else
		if cfg.statTimers.sesOnline then imgui.TextColoredRGB("Текущая сессия: "..get_clock(sesOnline.v)) end
		if cfg.statTimers.dayOnline then imgui.TextColoredRGB("Онлайн за день: "..get_clock(cfg.onDay.online)) end
		if cfg.statTimers.dayAfk then imgui.TextColoredRGB("Онлайн в афк: "..get_clock(cfg.onDay.afk)) end
		if cfg.statTimers.reportsDay then imgui.TextColoredRGB("Репортов за день: "..cfg.main.reportzaday) end
		if cfg.statTimers.reportsVse then imgui.TextColoredRGB("Репортов за все время: "..cfg.main.reportzavse) end
		if cfg.statTimers.nakazaniyaDay then imgui.TextColoredRGB("Наказаний за день: "..cfg.main.nakazaniyaday) end
		if cfg.statTimers.nakazaniyaVse then imgui.TextColoredRGB("Наказаний за все время: "..cfg.main.nakazaniyavse) end
		if cfg.statTimers.formsDay then imgui.TextColoredRGB("Форм за день: "..cfg.main.formsday) end
		if cfg.statTimers.formsVse then imgui.TextColoredRGB("Форм за все время: "..cfg.main.formsvse) end
		if cfg.statTimers.nowTime then imgui.TextColoredRGB("Текущее время: "..nowTime123) end
		if cfg.statTimers.weekOnline then imgui.TextColoredRGB("За неделю (чистый): "..get_clock(cfg.onWeek.online)) end
		if cfg.statTimers.weekAfk then imgui.TextColoredRGB("АФК за неделю: "..get_clock(cfg.onWeek.afk)) end
		if cfg.statTimers.weekFull then imgui.TextColoredRGB("Онлайн за неделю: "..get_clock(cfg.onWeek.full)) end
		if cfg.statTimers.reportnow then imgui.TextColoredRGB("Репорта сейчас: "..reportnow) end
	end
end

function time()
	startTime = os.time()
	connectingTime = 0
	while true do
		wait(1000)
		nowTime123 = os.date("%H:%M:%S", os.time())
		if sampGetGamestate() == 3 then 								
			sesOnline.v = sesOnline.v + 1 								
			sesFull.v = os.time() - startTime 							
			sesAfk.v = sesFull.v - sesOnline.v							

			cfg.onDay.online = cfg.onDay.online + 1 					
			cfg.onDay.full = dayFull.v + sesFull.v 						
			cfg.onDay.afk = cfg.onDay.full - cfg.onDay.online			

			cfg.onWeek.online = cfg.onWeek.online + 1 					
			cfg.onWeek.full = weekFull.v + sesFull.v 					
			cfg.onWeek.afk = cfg.onWeek.full - cfg.onWeek.online		

			local today = tonumber(os.date('%w', os.time()))
			cfg.myWeekOnline[today] = cfg.onDay.full


			connectingTime = 0
		else
			connectingTime = connectingTime + 1                        
			startTime = startTime + 1									
		end
	end
end


function autoPiar()
	while true do 
		wait(tonumber(buffer54.v) * 1000)
		sendpiar()
	end
end


function number_week()
	local current_time = os.date'*t'
	local start_year = os.time{ year = current_time.year, day = 1, month = 1 }
	local week_day = ( os.date('%w', start_year) - 1 ) % 7
	return math.ceil((current_time.yday + week_day) / 7)
end

function getStrDate(unixTime)
	local tMonths = {'января', 'февраля', 'марта', 'апреля', 'мая', 'июня', 'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'}
	local day = tonumber(os.date('%d', unixTime))
	local month = tMonths[tonumber(os.date('%m', unixTime))]
	local weekday = tWeekdays[tonumber(os.date('%w', unixTime))]
	return string.format('%s, %s %s', weekday, day, month)
end

function get_clock(time)
	local timezone_offset = 86400 - os.date('%H', 0) * 3600
	if tonumber(time) >= 86400 then onDay = true else onDay = false end
	return os.date((onDay and math.floor(time / 86400)..'д ' or '')..'%H:%M:%S', time + timezone_offset)
end

function yuiop()

	imgui.SetNextWindowPos(imgui.ImVec2(posX123.v, posY123.v), imgui.Cond.Always)
	imgui.Begin(u8'##timer', _, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar)
	if sampGetGamestate() ~= 3 then 
		imgui.TextColoredRGB("Подключение: "..get_clock(connectingTime))
	else
		if cfg.statTimers.sesOnline then imgui.TextColoredRGB("Текущая сессия: "..get_clock(sesOnline.v)) end
		if cfg.statTimers.dayOnline then imgui.TextColoredRGB("Онлайн за день: "..get_clock(cfg.onDay.online)) end
		if cfg.statTimers.dayAfk then imgui.TextColoredRGB("Онлайн в афк: "..get_clock(cfg.onDay.afk)) end
		if cfg.statTimers.reportsDay then imgui.TextColoredRGB("Репортов за день: "..cfg.main.reportzaday) end
		if cfg.statTimers.reportsVse then imgui.TextColoredRGB("Репортов за все время: "..cfg.main.reportzavse) end
		if cfg.statTimers.nakazaniyaDay then imgui.TextColoredRGB("Наказаний за день: "..cfg.main.nakazaniyaday) end
		if cfg.statTimers.nakazaniyaVse then imgui.TextColoredRGB("Наказаний за все время: "..cfg.main.nakazaniyavse) end
		if cfg.statTimers.formsDay then imgui.TextColoredRGB("Форм за день: "..cfg.main.formsday) end
		if cfg.statTimers.formsVse then imgui.TextColoredRGB("Форм за все время: "..cfg.main.formsvse) end
		if cfg.statTimers.nowTime then imgui.TextColoredRGB("Текущее время: "..nowTime123) end
		if cfg.statTimers.weekOnline then imgui.TextColoredRGB("За неделю (чистый): "..get_clock(cfg.onWeek.online)) end
		if cfg.statTimers.weekAfk then imgui.TextColoredRGB("АФК за неделю: "..get_clock(cfg.onWeek.afk)) end
		if cfg.statTimers.weekFull then imgui.TextColoredRGB("Онлайн за неделю: "..get_clock(cfg.onWeek.full)) end
		if cfg.statTimers.reportnow then imgui.TextColoredRGB("Репорта сейчас: "..reportnow) end
	end
	imgui.End()
end


function lyalyalyalya2()
	posX123.v, posY123.v = getCursorPos()
	posX123.v = posX123.v + 1
	posY123.v = posY123.v + 1
	imgui.ShowCursor = true
	MainWindow.v = false
	changePositionStats = 1
	if changePositionStats then
		if isKeyDown(vkeys.VK_LBUTTON) then  
			cfg.pos.x = posX123.v
			cfg.pos.y = posY123.v
			sampAddChatMessage(tag..'Позиция статистики успешно сохранена!', -1)
			imgui.ShowCursor = false
			changePositionStats = 0
			MainWindow.v = true
			ChangePosWindow.v = false
		end
	end
end

function lyalyalyalya5()
	posX228.v, posY228.v = getCursorPos()
	posX228.v = posX228.v + 1
	posY228.v = posY228.v + 1
	imgui.ShowCursor = true
	MainWindow.v = false
	changePositionStatss = 1
	if changePositionStatss then
		if isKeyDown(vkeys.VK_LBUTTON) then  
			cfg.pos.x4 = posX228.v
			cfg.pos.y4 = posY228.v
			sampAddChatMessage(tag..'Позиция окна успешно сохранена!', -1)
			imgui.ShowCursor = false
			changePositionStatss = 0
			MainWindow.v = true
			ChangePosWindowFour.v = false
		end
	end
end

function lyalyalyalya6()
	posX333.v, posY333.v = getCursorPos()
	posX333.v = posX333.v + 1
	posY333.v = posY333.v + 1
	imgui.ShowCursor = true
	MainWindow.v = false
	changePositionStatsss = 1
	if changePositionStatsss then
		if isKeyDown(vkeys.VK_LBUTTON) then  
			cfg.pos.x5 = posX333.v
			cfg.pos.y5 = posY333.v
			sampAddChatMessage(tag..'Позиция окна информации успешно сохранена!', -1)
			imgui.ShowCursor = false
			changePositionStatsss = 0
			MainWindow.v = true
			ChangePosWindowFive.v = false
		end
	end
end


function lyalyalyalya4()
	posX999.v, posY999.v = getCursorPos()
	posX999.v = posX999.v + 1
	posY999.v = posY999.v + 1
	imgui.ShowCursor = true
	MainWindow.v = false
	changePositionStat1s = 1
	if changePositionStat1s then
		if isKeyDown(vkeys.VK_LBUTTON) then  
			cfg.checkerPosition.x = posX999.v
			cfg.checkerPosition.y = posY999.v
			sampAddChatMessage(tag..'Позиция чекера игроков успешно сохранена!', -1)
			imgui.ShowCursor = false
			changePositionStat1s = 0
			MainWindow.v = true
			ChangePosWindowThree.v = false
		end
	end
end

function lyalyalyalya7()
	posX789.v, posY789.v = getCursorPos()
	posX789.v = posX789.v + 1
	posY789.v = posY789.v + 1
	imgui.ShowCursor = true
	MainWindow.v = false
	changePositionStat1ss = 1
	if changePositionStat1ss then
		if isKeyDown(vkeys.VK_LBUTTON) then  
			cfg.adminscheckerPosition.x = posX789.v
			cfg.adminscheckerPosition.y = posY789.v
			sampAddChatMessage(tag..'Позиция чекера игроков успешно сохранена!', -1)
			imgui.ShowCursor = false
			changePositionStat1ss = 0
			MainWindow.v = true
			ChangePosWindowSeven.v = false
		end
	end
end
function lyalyalyalya8()
	posX10.v, posY10.v = getCursorPos()
	posX10.v = posX10.v + 1
	posY10.v = posY10.v + 100
	imgui.ShowCursor = true
	MainWindow.v = false
	changePositionStat1sss = 1
	if changePositionStat1sss then
		if isKeyDown(vkeys.VK_LBUTTON) then  
			cfg.punishcheckerPosition.x = posX10.v
			cfg.punishcheckerPosition.y = posY10.v
			sampAddChatMessage(tag..'Позиция чекера игроков успешно сохранена!', -1)
			imgui.ShowCursor = false
			changePositionStat1sss = 0
			MainWindow.v = true
			ChangePosWindowEight.v = false
		end
	end
end

function lyalyalyalya3()
	posX456.v, posY456.v = getCursorPos()
	posX456.v = posX456.v + 1
	posY456.v = posY456.v + 1
	imgui.ShowCursor = true
	MainWindow.v = false
	changePositionStatst = 1
	if changePositionStatst then
		if isKeyDown(vkeys.VK_LBUTTON) then  
			cfg.pos.x3 = posX456.v
			cfg.pos.y3 = posY456.v
			sampAddChatMessage(tag..'Позиция окна успешно сохранена!', -1)
			imgui.ShowCursor = false
			changePositionStatst = 0
			MainWindow.v = true
			ChangePosWindowTwo.v = false
		end
	end
end
function kotofeevautoopra()
if logBut["selected"] == 1 then 
	imgui.Text(u8'Время, на которое будет садиться игрок в деморган при запросе опровержения:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				imgui.InputInt(u8("##adsjaxsss211113123123123dsasdadsj"), buffer59)
				cfg.main.timeopra = string.format('%s', tostring(buffer59.v)) 
				imgui.PopItemWidth()
				if buffer59.v <= 0 then
					buffer59.v = 1
				elseif buffer59.v >= 2999 then
					buffer59.v = 2999
				end
	imgui.Text(u8'Команда для ручного запроса опровержения на последний словленный дом:')
	imgui.SameLine()
	imgui.PushItemWidth(100) 
	if imgui.InputText(u8"##13243555553355", cmdHouse) then
	sampUnregisterChatCommand(cfg.main.cmdHouse)
	cfg.main.cmdHouse = string.format('%s', tostring(cmdHouse.v)) 
	sampRegisterChatCommand(cfg.main.cmdHouse, ohome)
	end
	imgui.PopItemWidth()
	imgui.Text(u8'Команда для ручного запроса опровержения на последний словленный бизнес:')
	imgui.SameLine()
	imgui.PushItemWidth(100) 
	if imgui.InputText(u8"##1324354155553355", cmdBusiness) then
	sampUnregisterChatCommand(cfg.main.cmdBusiness)
	cfg.main.cmdBusiness = string.format('%s', tostring(cmdBusiness.v)) 
	sampRegisterChatCommand(cfg.main.cmdBusiness, obiz)
	end
	imgui.PopItemWidth()
	imgui.Separator()
	imgui.TextColoredRGB('{E78284}Укажите причину деморгана при запросе опровержения на дом, доступные тэги:')
	imgui.TextColoredRGB('{E78284}{idhouse} {84A6E7}- ID словленного дома')
	imgui.TextColoredRGB('{E78284}{time} {84A6E7}- время ввода капчи')
	imgui.TextColoredRGB('{E78284}{captcha} {84A6E7}- введённая капча')
	if imgui.InputText('##reasonhouse', reason_autoopra[1]) then 
		cfg.autoopra.myreasonhouse = tostring(u8:decode(reason_autoopra[1].v))
	end
	imgui.TextColoredRGB('{E78284}Укажите причину деморгана при запросе опровержения на бизнес, доступные тэги:')
	imgui.TextColoredRGB('{E78284}{idbiz} {84A6E7}- ID словленного бизнеса')
	imgui.TextColoredRGB('{E78284}{time} {84A6E7}- время ввода капчи')
	imgui.TextColoredRGB('{E78284}{captcha} {84A6E7}- введённая капча')
	if imgui.InputText('##reasonbiz', reason_autoopra[2]) then 
		cfg.autoopra.myreasonbiz = tostring(u8:decode(reason_autoopra[2].v))
	end
elseif logBut["selected"] == 5 then
	imgui.Text(u8'Активация авто-опровержения на дома и бизнесы: /autoopra, /aopra')
	imgui.Separator()
	if imgui.ToggleButton(u8'Запрашивать опровержение на ловлю бизнесов', checkautooprabiz) then 
		cfg.autoopra.settingbiz = not cfg.autoopra.settingbiz
	end 
	imgui.SameLine()
	imgui.Text(fa.ICON_FA_QUESTION_CIRCLE..u8'')
	imgui.Hint('bizopra', u8'При вводе команды /autoopra будет включена авто-опра на бизнесы (т.е. если человек поймал бизнес - его посадит в деморган)')
	if imgui.ToggleButton(u8'Запрашивать опровержение на ловлю домов', checkautooprahouse) then 
		cfg.autoopra.settinghouse = not cfg.autoopra.settinghouse
	end 
	imgui.SameLine()
	imgui.Text(fa.ICON_FA_QUESTION_CIRCLE..u8'')
	imgui.Hint('houseopra', u8'При вводе команды /autoopra будет включена авто-опра на дома (т.е. если человек поймал дом - его посадит в деморган)')
elseif logBut["selected"] == 3 then
if #log_full == 0 then
		for line in io.lines(pathOffLog) do
			table.insert(log_full, line)
		end
	end
	if #log_full == 0 then 
		imgui.SetCursorPosY((420 - 20) / 2)
		imgui.CenterTextColoredRGB("{ffff00}Лог покупки имущества пустой")
	else
		imgui.CenterTextColoredRGB(("{606060}") .. pathOffLog)
		hov_path_log = imgui.IsItemHovered()
		if imgui.IsItemClicked() then os.execute("explorer " .. pathOffLog) end
		imgui.Separator()
		local tCol = { ["Д"] = "{F3FF9A}", ["А"] = "{9AFFCA}", ["Б"] = "{FF9A9A}" }
		for i = #log_full, (#log_full >= 100 and #log_full - 100 or 1), -1 do
			local im = log_full[i]:match("| ([ДАБ])")
			local log = log_full[i]:gsub("^(.+)|(.+)", "%1|" .. (tCol[im] and tCol[im] or "{808080}") .. "%2")
			imgui.TextColoredRGB("{606060}" .. log)
		end
		if #log_full > 100 then 
			imgui.TextColoredRGB(yc.."+"..(#log_full - 100).." более старых. Кликните что-бы посмотреть")
			if imgui.IsItemClicked() then os.execute("explorer "..pathOffLog) end
		end
	end
elseif logBut["selected"] == 2 then 
if #tLog == 0 then 
		imgui.SetCursorPosY((420 - 20) / 2)
		imgui.CenterTextColoredRGB(lc.."Лог пустой")
	end

	for k, box in pairs(tLog) do
		if box[1] == 1 then
			imgui.Text(fa.ICON_FA_HOME)
			imgui.SameLine(30)
			imgui.Text(string.format(u8"| Игрок %s купил дом ID: %s по гос. цене за %s! Капча: %s", box[4][1], box[4][2], box[4][3], box[4][4]))
			imgui.Hint("plInt:"..k, u8(os.date("%H:%M:%S", box[2]).."\nПКМ - Взаимодействовать") )
			if imgui.IsItemClicked(1) then contK = k; imgui.OpenPopup("##toolContext") end
			imgui.GetOpraStatus(k, box[5])
		end
		if box[1] == 3 then
			imgui.Text(fa.ICON_FA_BUSINESS_TIME)
			imgui.SameLine(30)
			imgui.Text(string.format(u8"| Игрок %s купил бизнес ID: %s по гос. цене за %s! Капча: %s", box[4][1], box[4][2], box[4][3], box[4][4]))
			imgui.Hint("plInt:"..k,  u8(os.date("%H:%M:%S", box[2]).."\nПКМ - Взаимодействовать") )
			if imgui.IsItemClicked(1) then contK = k; imgui.OpenPopup("##toolContext") end
			imgui.GetOpraStatus(k, box[5])
		end
	end
	if contK ~= nil and imgui.BeginPopupContextItem("##toolContext") then
		local plOnline, _ = sampIsNickNameConnected(tLog[contK][4][1])
		imgui.CenterTextColoredRGB(lc..tLog[contK][4][1]..(plOnline and mc.." [Online]" or ec.." [Offline]").."\n"..lc.."Время покупки: "..os.date("%H:%M:%S",tLog[contK][2]))
		if not tLog[contK][5][1] then
			if imgui.Button(fa.ICON_FA_BED..u8(" Запросить опру"..(plOnline and "" or " в оффлайне")), imgui.ImVec2(220, 30)) then 
				local jtype = tLog[contK][1]
				sampSendChat(string.format("/jail%s %s %s опра [№%s | %s]", (plOnline and "" or "off"), tLog[contK][4][1], cfg.main.timeopra, tLog[contK][4][2], tLog[contK][4][3]))
				imgui.CloseCurrentPopup()
			end
		else
			if imgui.Button(fa.ICON_FA_CHECK..u8(" Одобрить"), imgui.ImVec2(107.5, 30)) then 
				sampSendChat(string.format("/unjail%s %s опра принята", (plOnline and "" or "off"), tLog[contK][4][1]))
				imgui.CloseCurrentPopup()
			end
			imgui.SameLine()
			if imgui.Button(fa.ICON_FA_TIMES..u8(" Отклонить"), imgui.ImVec2(107.5, 30)) then 
				sampSendChat(string.format("/unjail%s %s опра отказана", (plOnline and "" or "off"), tLog[contK][4][1]))
				imgui.CloseCurrentPopup(); MainWindow.v = false
			end
		end
		if imgui.Button(fa.ICON_FA_PRINT..u8" Строка покупки в чат", imgui.ImVec2(220, 30)) then 
			sampSetChatInputEnabled(true)
			sampSetChatInputText(tLog[contK][3])
			imgui.CloseCurrentPopup()
			MainWindow.v = false
		end
		if imgui.Button(fa.ICON_FA_ADDRESS_CARD..u8" История наказаний", imgui.ImVec2(220, 30)) then 
			sampSendChat("/checkpunish "..tLog[contK][4][1])
			imgui.CloseCurrentPopup()
			MainWindow.v = false
		end
		if imgui.ButtonHex(fa.ICON_FA_TRASH..u8" Удалить этот лог", 0xFFBB2020, imgui.ImVec2(220, 30)) then 
			table.remove(tLog, contK)
			imgui.CloseCurrentPopup()
		end
		imgui.EndPopup()
	end
elseif logBut["selected"] == 4 then 
if imgui.ToggleButton(u8'Уведомление в чат о покупке имущества игроком из белого списка', imgui.ImBool(cfg.main.notfinchat)) then 
	cfg.main.notfinchat = not cfg.main.notfinchat 
end 
imgui.SameLine()
imgui.PushFont(minimalfont)
imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
imgui.PopFont()
imgui.Hint('helplist', u8'Дополнительное оповещение в чат в случае если игрок, поймавший\nимущество, находился в белом списке')
if imgui.ToggleButton(u8'Удаление сообщения о покупке имущества', imgui.ImBool(cfg.main.delinchat)) then 
	cfg.main.delinchat = not cfg.main.delinchat 
end 
imgui.SameLine()
imgui.PushFont(minimalfont)
imgui.TextDisabled(fa.ICON_FA_QUESTION_CIRCLE..u8'')
imgui.PopFont()
imgui.Hint('helplis1t', u8'Скрипт будет удалять серверное сообщение о покупке имущества игроком из белого списка')
imgui.BeginChild("##IngonList", imgui.ImVec2(-1, 375), true)
		imgui.PushItemWidth(340)
		imgui.InputText("##AddIgnore", addIgnore)
		imgui.PopItemWidth()
		imgui.SameLine()
		if #addIgnore.v > 0 then 
			if imgui.Button(u8"Добавить", imgui.ImVec2(-1, 20)) then 
				table.insert(cfg.ignore, tostring(addIgnore.v))
				addIgnore.v = ""
			end
		else imgui.DisableButton(u8"Добавить", imgui.ImVec2(-1, 20)) end
		if #cfg.ignore == 0 then 
			imgui.SetCursorPosY((imgui.GetWindowHeight() - 10) / 2)
			imgui.CenterTextColoredRGB("{ffff00}Список игроков в белом списке пуст")
		end
		for k, v in pairs(cfg.ignore) do 
			imgui.TextColoredRGB(string.format("{868686}%s. {SSSSSS}%s", k, v))
			imgui.SameLine(imgui.GetWindowWidth() - 40)
			if imgui.Button(fa.ICON_FA_USER_SLASH.."##"..k, imgui.ImVec2(-1, 20)) then 
				table.remove(cfg.ignore, k)
			end
		end
	imgui.EndChild()
end
end
function MyName()
	_, myID = sampGetPlayerIdByCharHandle(PLAYER_PED)
	return sampGetPlayerNickname(myID)
end

function initializeRender()
  font = renderCreateFont("Tahoma", 10, FCR_BOLD + FCR_BORDER)
  font2 = renderCreateFont("Arial", 10, 5, FCR_ITALICS + FCR_BORDER)
end

function rotateCarAroundUpAxis(car, vec)
  local mat = Matrix3X3(getVehicleRotationMatrix(car))
  local rotAxis = Vector3D(mat.up:get())
  vec:normalize()
  rotAxis:normalize()
  local theta = math.acos(rotAxis:dotProduct(vec))
  if theta ~= 0 then
	rotAxis:crossProduct(vec)
	rotAxis:normalize()
	rotAxis:zeroNearZero()
	mat = mat:rotate(rotAxis, -theta)
  end
  setVehicleRotationMatrix(car, mat:get())
end

function readFloatArray(ptr, idx)
  return representIntAsFloat(readMemory(ptr + idx * 4, 4, false))
end

function writeFloatArray(ptr, idx, value)
  writeMemory(ptr + idx * 4, 4, representFloatAsInt(value), false)
end

function getVehicleRotationMatrix(car)
  local entityPtr = getCarPointer(car)
  if entityPtr ~= 0 then
	local mat = readMemory(entityPtr + 0x14, 4, false)
	if mat ~= 0 then
	  local rx, ry, rz, fx, fy, fz, ux, uy, uz
	  rx = readFloatArray(mat, 0)
	  ry = readFloatArray(mat, 1)
	  rz = readFloatArray(mat, 2)

	  fx = readFloatArray(mat, 4)
	  fy = readFloatArray(mat, 5)
	  fz = readFloatArray(mat, 6)

	  ux = readFloatArray(mat, 8)
	  uy = readFloatArray(mat, 9)
	  uz = readFloatArray(mat, 10)
	  return rx, ry, rz, fx, fy, fz, ux, uy, uz
	end
  end
end

function setVehicleRotationMatrix(car, rx, ry, rz, fx, fy, fz, ux, uy, uz)
  local entityPtr = getCarPointer(car)
  if entityPtr ~= 0 then
	local mat = readMemory(entityPtr + 0x14, 4, false)
	if mat ~= 0 then
	  writeFloatArray(mat, 0, rx)
	  writeFloatArray(mat, 1, ry)
	  writeFloatArray(mat, 2, rz)

	  writeFloatArray(mat, 4, fx)
	  writeFloatArray(mat, 5, fy)
	  writeFloatArray(mat, 6, fz)

	  writeFloatArray(mat, 8, ux)
	  writeFloatArray(mat, 9, uy)
	  writeFloatArray(mat, 10, uz)
	end
  end
end



function showCursor(toggle)
  if toggle then
	sampSetCursorMode(CMODE_LOCKCAM)
  else
	sampToggleCursor(false)
  end
  cursorEnabled = toggle
end


function check_input_available()
	if not isGamePaused() and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then 
		return true 
	end 
	return false 
end
function getNearCharToCenter(radius)
	local arr = {}
	local sx, sy = getScreenResolution()
	for _, player in ipairs(getAllChars()) do
		if select(1, sampGetPlayerIdByCharHandle(player)) and isCharOnScreen(player) and player ~= playerPed then
			local plX, plY, plZ = getCharCoordinates(player)
			local cX, cY = convert3DCoordsToScreen(plX, plY, plZ)
			local distBetween2d = getDistanceBetweenCoords2d(sx / 2, sy / 2, cX, cY)
			if distBetween2d <= tonumber(radius and radius or sx) then
				table.insert(arr, {distBetween2d, player})
			end
		end
	end
	if #arr > 0 then
		table.sort(arr, function(a, b) return (a[1] < b[1]) end)
		return arr[1][2]
	end
	return nil
end
function isKeyCheckAvailable()
  if not isSampfuncsLoaded() then
	return not isPauseMenuActive()
  end
  local result = not isSampfuncsConsoleActive() and not isPauseMenuActive()
  if isSampLoaded() and isSampAvailable() then
	result = result and not sampIsChatInputActive() and not sampIsDialogActive()
  end
  return result
end
function getPlayerColorWithoutAlpha(playerId)
	if sampIsPlayerConnected(playerId) then
		local color = sampGetPlayerColor(playerId)
		local a, r, g, b = explode_argb(color)
		local color = join_argb(255, r, g, b)
		return color
	end
	return -1
end
function isCarFree(car)
	if doesCharExist(getDriverOfCar(car)) then return false end
	local result, passengers = getNumberOfPassengers(car)
	if result and passengers > 0 then return false end
	return true
end
function renderFigure2D(x, y, points, radius, color)
	local step = math.pi * 2 / points
	local render_start, render_end = {}, {}
	for i = 0, math.pi * 2, step do
		render_start[1] = radius * math.cos(i) + x
		render_start[2] = radius * math.sin(i) + y
		render_end[1] = radius * math.cos(i + step) + x
		render_end[2] = radius * math.sin(i + step) + y
		renderDrawLine(render_start[1], render_start[2], render_end[1], render_end[2], 1, color)
	end
end
function renderFontDrawTextCenter(font, text, x, y, color)
	local length = renderGetFontDrawTextLength(font, text)
	if length and length ~= nil then 
		renderFontDrawText(font, text, x - length / 2, y, color)
	end 
end


function isNameTagVisible(id)
	local function getBodyPartCoordinates(id, handle)
		local ffi = require "ffi"
		local getBonePosition = ffi.cast("int (__thiscall*)(void*, float*, int, bool)", 0x5E4280)
		local pedptr = getCharPointer(handle)
		local vec = ffi.new("float[3]")
		getBonePosition(ffi.cast("void*", pedptr), vec, id, true)
		return vec[0], vec[1], vec[2]
	end

	local function GetMaskStats(id)
		local StructPtr = readMemory(sampGetPlayerStructPtr(id), 4, true)
		local Element = getStructElement(StructPtr, 179, 2, false)
		if Element == 0 then return false else return true end
	end

	local res = false
	local pStSet = sampGetServerSettingsPtr()
	local NTdist = representIntAsFloat(readMemory(pStSet + 39, 4, false))
	local bool, v = sampGetCharHandleBySampPlayerId(id)
	if bool and isCharOnScreen(v) then
		local x, y, z = getBodyPartCoordinates(8, v)
		local xi, yi, zi = getActiveCameraCoordinates()
		local result = isLineOfSightClear(x, y, z, xi, yi, zi, true, false, false, true, false)
		local dist = math.sqrt( (xi - x) ^ 2 + (yi - y) ^ 2 + (zi - z) ^ 2 )
		if result and dist <= NTdist and GetMaskStats(id) then
			res = true
		end
	end
	return res
end

function my1()
lua_thread.create(function ()
				for cikk22 in mybinder1.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer36.v))
				end
			end)
end

function my2()
lua_thread.create(function ()
				for cikk22 in mybinder2.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer37.v))
				end
			end)
end

function my3()
lua_thread.create(function ()
				for cikk22 in mybinder3.v:gmatch("[^\r\n]+") do
					sampSendChat(u8:decode(cikk22))
					wait(tonumber(buffer40.v))
				end
			end)
end

function my4()
lua_thread.create(function ()
for cikk22 in mybinder4.v:gmatch("[^\r\n]+") do
sampSendChat(u8:decode(cikk22))
wait(tonumber(buffer41.v))
end
end)
end


function spawnset()
local myCoordinates         = {getCharCoordinates(playerPed)}
cfg.spawncords.x = myCoordinates[1]
cfg.spawncords.y = myCoordinates[2]
cfg.spawncords.z = myCoordinates[3]
sampAddChatMessage('{E78284}[AdminTools] {84A6E7}Вы установили новую точку спавна {E78284}['..myCoordinates[1]..' | '..myCoordinates[2]..' | '..myCoordinates[3]..']', -1)
end

function crd()
local myCoordinates         = {getCharCoordinates(playerPed)}
sampAddChatMessage(''..myCoordinates[1]..'  |  '..myCoordinates[2]..'  |  '..myCoordinates[3]..'', -1)
setClipboardText(''..myCoordinates[1]..' '..myCoordinates[2]..' '..myCoordinates[3]..'')
end

function rek_off()
cfg.main.deletereklama = not cfg.main.deletereklama
sampAddChatMessage(tag..'Отображение сообщений о подозрении на рекламу '..(cfg.main.deletereklama and '{ff4040}выключено{84A6E7}.' or '{00ff00}включено{84A6E7}.'), -1)
end

function otstupcursor()
sampSetChatInputEnabled(true)
cursorotstup = 7
		if tonumber(spec_id) < 10 then
			cursorotstup = cursorotstup + 1
		elseif tonumber(spec_id) < 100 and tonumber(spec_id) >= 10 then
			cursorotstup = cursorotstup + 2
		elseif tonumber(spec_id) < 1000 and tonumber(spec_id) >= 100 then
			cursorotstup = cursorotstup + 3
		end
end

function otstupcursor1()
		sampSetChatInputEnabled(true)
		cursorotstup = 6
		if tonumber(spec_id) < 10 then
			cursorotstup = cursorotstup + 1
		elseif tonumber(spec_id) < 100 and tonumber(spec_id) >= 10 then
			cursorotstup = cursorotstup + 2
		elseif tonumber(spec_id) < 1000 and tonumber(spec_id) >= 100 then
			cursorotstup = cursorotstup + 3
		end
end

function playVolume()
	local notification = getGameDirectory().."\\moonloader\\resource\\"..cfg.main.nameaudioforform..""
	if not doesFileExist(notification) then
		sampAddChatMessage('[AdminTools] Звуковой файл отсутствует.', 14628149)
	else
		local audio = loadAudioStream(notification)
		setAudioStreamState(audio, 1)
		setAudioStreamVolume(audio, volume.v*0.01)
	end
end


function helpa()
HelpWindow.v = not HelpWindow.v
imgui.Process = HelpWindow.v 
end

function changes()
ChangeLogWindow.v = not ChangeLogWindow.v
imgui.Process = ChangeLogWindow.v 
end

function arep()
if isCharInAnyCar(PLAYER_PED) then
repcar = true
sampSendChat('/apanel')
sampAddChatMessage('[AdminTools] Транспорт починен.', 14628149)
else
sampAddChatMessage('[AdminTools] Вы не находитесь в транспорте.', 14628149)
end
end

function ammo()
addammo = true
sampSendChat('/apanel')
sampAddChatMessage('[AdminTools] Товар в аммунициях успешно пополнен.', 14628149)
end

function admall()
admall = true
sampSendChat('/apanel')
end

function ohome()
if nickp == nil or idp == nil or idhouse == nil or vremya == nil or captcha1 == nil or captcha2 == nil then
sampAddChatMessage(tag..'Никто не ловил домов в последнее время :(', -1)
else
if cfg.autoopra.myreasonhouse then
			local template = u8:decode(reason_autoopra[1].v)
			local template = template:gsub('{idhouse}', idhouse)
			local template = template:gsub('{time}', vremya)
			local template = template:gsub('{captcha}', captcha1)
			local result = sampIsPlayerConnected(idp)
			if not result then
				send_rpc_command('/jailoff '..nickp..' '..cfg.main.timeopra..' '..template)
			else
				send_rpc_command('/jail '..idp..' '..cfg.main.timeopra..' '..template)
			end
		else
			if not result then
				send_rpc_command('/jailoff '..nickp..' '..cfg.main.timeopra..' '..template)
			else
				send_rpc_command('/jail '..idp..' '..cfg.main.timeopra..' '..template)
			end
		end
end
end

function SettingsTraicer()
imgui.BeginChild("ChildWdsahdhindow1", imgui.ImVec2(-1, -1), true) 
			imgui.PushFont(fs16)
			imgui.CenterTextColoredRGB('{E3C47F}Настройки своих пуль')
			imgui.PopFont()
			imgui.Separator()
			if imgui.ToggleButton(u8"Отрисовка своих пуль", elements.checkbox.drawMyBullets) then
				cfg.config.drawMyBullets = elements.checkbox.drawMyBullets.v 
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end
			imgui.PushItemWidth(175)

			if imgui.SliderInt("##bulletsMyTime1", elements.int.timeRenderMyBullets, 5, 40) then
				cfg.config.timeRenderMyBullets = elements.int.timeRenderMyBullets.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Время задержки трейсера")

			if imgui.SliderInt("##renderWidthLinesTwo1", elements.int.sizeOffMyLine, 1, 10) then
				cfg.config.sizeOffMyLine = elements.int.sizeOffMyLine.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Толщина линий")

			if imgui.SliderInt('##maxMyBullets1', elements.int.maxLineMyLimit, 10, 300) then
				bulletSyncMy.maxLines = elements.int.maxLineMyLimit.v
				bulletSyncMy = {lastId = 0, maxLines = elements.int.maxLineMyLimit.v}
				for i = 1, bulletSyncMy.maxLines do
					bulletSyncMy[i] = { my = {time = 0, t = {x,y,z}, o = {x,y,z}, type = 0, color = 0}}
				end
				cfg.config.maxLineMyLimit = elements.int.maxLineMyLimit.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Максимальное количество линий")

			imgui.Separator()

			if imgui.ToggleButton(u8"Окончания у линий##1", elements.checkbox.cbEndMy) then
				cfg.config.cbEndMy = elements.checkbox.cbEndMy.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end

			if imgui.SliderInt('##endNumber1s', elements.int.rotationMyPolygonEnd, 2, 10) then
				cfg.config.rotationMyPolygonEnd = elements.int.rotationMyPolygonEnd.v 
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Количество углов на окончаниях")

			if imgui.SliderInt('##rotationOne1', elements.int.degreeMyPolygonEnd, 0, 360) then
				cfg.config.degreeMyPolygonEnd = elements.int.degreeMyPolygonEnd.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Градус поворота окончания")

			if imgui.SliderInt('##sizeTraicerEnd1', elements.int.sizeOffMyPolygonEnd, 1, 10) then
				cfg.config.sizeOffMyPolygonEnd = elements.int.sizeOffMyPolygonEnd.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end  imgui.SameLine() imgui.Text(u8"Размер окончания трейсера")

			imgui.Separator()

			imgui.PopItemWidth()
			imgui.Text(u8"Укажите цвет трейсера, если: ")
			imgui.PushItemWidth(325)
			if imgui.ColorEdit4("##dinamicObjectMy", dinamicObjectMy, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
				cfg.config.dinamicObjectMy = join_argb(dinamicObjectMy.v[1] * 255, dinamicObjectMy.v[2] * 255, dinamicObjectMy.v[3] * 255, dinamicObjectMy.v[4] * 255)
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Вы попали в динамический объект")
			if imgui.ColorEdit4("##staticObjectMy", staticObjectMy, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
				cfg.config.staticObjectMy = join_argb(staticObjectMy.v[1] * 255, staticObjectMy.v[2] * 255, staticObjectMy.v[3] * 255, staticObjectMy.v[4] * 255)
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Вы попали в статический объект")
			if imgui.ColorEdit4("##pedMy", pedPMy, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
				cfg.config.pedPMy = join_argb(pedPMy.v[1] * 255, pedPMy.v[2] * 255, pedPMy.v[3] * 255, pedPMy.v[4] * 255)
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Вы попали в игрока")
			if imgui.ColorEdit4("##carMy", carPMy, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
				cfg.config.carPMy = join_argb(carPMy.v[1] * 255, carPMy.v[2] * 255, carPMy.v[3] * 255, carPMy.v[4] * 255)
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Вы попали в машину")
			imgui.PopItemWidth()
			imgui.Separator()
			imgui.PushFont(fs16)
		imgui.CenterTextColoredRGB('{E3C47F}Настройки чужих пуль')
		imgui.PopFont()
			imgui.Separator()
			if imgui.ToggleButton(u8"Отрисовка чужих пуль", elements.checkbox.drawBullets) then
				cfg.config.drawBullets = elements.checkbox.drawBullets.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end
			imgui.PushItemWidth(175)

			if imgui.SliderInt("##bulletsTime2", elements.int.timeRenderBullets, 5, 40) then
				cfg.config.timeRenderBullets = elements.int.timeRenderBullets.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Время задержки трейсера")

			if imgui.SliderInt("##renderWidthLines2", elements.int.sizeOffLine, 1, 10) then
				cfg.config.sizeOffLine = elements.int.sizeOffLine.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Толщина линий")

			if imgui.SliderInt('##maxMyBullets2', elements.int.maxLineLimit, 10, 300) then
				bulletSync.maxLines = elements.int.maxLineLimit.v
				bulletSync = {lastId = 0, maxLines = elements.int.maxLineLimit.v}
				for i = 1, bulletSync.maxLines do
					bulletSync[i] = { other = {time = 0, t = {x,y,z}, o = {x,y,z}, type = 0, color = 0}}
				end
				cfg.config.maxLineLimit = elements.int.maxLineLimit.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Максимальное количество линий")

			imgui.Separator()

			if imgui.ToggleButton(u8"Окончания у линий##2", elements.checkbox.cbEnd) then
				cfg.config.cbEnd = elements.checkbox.cbEnd.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end

			if imgui.SliderInt('##endNumber2', elements.int.rotationPolygonEnd, 2, 10) then
				cfg.config.rotationPolygonEnd = elements.int.rotationPolygonEnd.v 
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Количество углов на окончаниях")

			if imgui.SliderInt('##rotationOne2', elements.int.degreePolygonEnd, 0, 360) then
				cfg.config.degreePolygonEnd = elements.int.degreePolygonEnd.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Градус поворота окончания")

			if imgui.SliderInt('##sizeTraicerEnd2', elements.int.sizeOffPolygonEnd, 1, 10) then
				cfg.config.sizeOffPolygonEnd = elements.int.sizeOffPolygonEnd.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end  imgui.SameLine() imgui.Text(u8"Размер окончания трейсера")

			imgui.PopItemWidth()

			imgui.Separator()

			if imgui.ToggleButton(u8"ИД и никнейм игрока при выстреле", elements.checkbox.showPlayerInfo) then
				cfg.config.showPlayerInfo = elements.checkbox.showPlayerInfo.v
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end

			if imgui.Button(u8"Настроить информацию о стрелке", imgui.ImVec2(325, 0)) then
				imgui.OpenPopup(u8"Настройка информации о стрелке")
			end

			if imgui.BeginPopup(u8"Настройка информации о стрелке") then
				if imgui.ToggleButton(u8"Показывать ИД", elements.checkbox.onlyId) then
					cfg.config.onlyId = elements.checkbox.onlyId.v
					 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
				end
				if imgui.ToggleButton(u8"Показывать никнейм", elements.checkbox.onlyNick) then
					cfg.config.onlyNick = elements.checkbox.onlyNick.v
					 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
				end
				imgui.EndPopup()
			end

			imgui.PushItemWidth(325)

			if imgui.ColorEdit4("##infoNickId", colorPlayerI, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
				cfg.config.colorPlayerI = join_argb(colorPlayerI.v[1] * 255, colorPlayerI.v[2] * 255, colorPlayerI.v[3] * 255, colorPlayerI.v[4] * 255)
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Укажите цвет никнейма стрелка")

			imgui.PopItemWidth()

			imgui.Separator()
			imgui.Text(u8"Укажите цвет трейсера, если: ")
			imgui.PushItemWidth(325)
			if imgui.ColorEdit4("##dinamicObject", dinamicObject, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
				cfg.config.dinamicObject = join_argb(dinamicObject.v[1] * 255, dinamicObject.v[2] * 255, dinamicObject.v[3] * 255, dinamicObject.v[4] * 255)
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Игрок попал в динамический объект")
			if imgui.ColorEdit4("##staticObject", staticObject, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
				cfg.config.staticObject = join_argb(staticObject.v[1] * 255, staticObject.v[2] * 255, staticObject.v[3] * 255, staticObject.v[4] * 255)
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Игрок попал в статический объект")
			if imgui.ColorEdit4("##ped", pedP, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
				cfg.config.pedP = join_argb(pedP.v[1] * 255, pedP.v[2] * 255, pedP.v[3] * 255, pedP.v[4] * 255)
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Игрок попал в игрока")
			if imgui.ColorEdit4("##car", carP, imgui.ColorEditFlags.NoInputs + imgui.ColorEditFlags.AlphaBar) then
				cfg.config.carP = join_argb(carP.v[1] * 255, carP.v[2] * 255, carP.v[3] * 255, carP.v[4] * 255)
				 inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
			end imgui.SameLine() imgui.Text(u8"Игрок попал в машину")
			imgui.PopItemWidth()
			imgui.Separator()
			imgui.EndChild()
end

function obiz()
if nickp == nil or idp == nil or idbiz == nil or vremya == nil or captcha1 == nil or captcha2 == nil then
sampAddChatMessage(tag..'Никто не ловил бизнесов в последнее время :(', -1)
else
if cfg.autoopra.myreasonbiz then
			local template = u8:decode(reason_autoopra[2].v)
			local template = template:gsub('{idbiz}', idbiz)
			local template = template:gsub('{time}', vremya)
			local template = template:gsub('{captcha}', captcha1)
			local result = sampIsPlayerConnected(idp)
			if not result then
				send_rpc_command('/jailoff '..nickp..' '..cfg.main.timeopra..' '..template)
			else
				send_rpc_command('/jail '..idp..' '..cfg.main.timeopra..' '..template)
			end
		else
		local result = sampIsPlayerConnected(idp)
			if not result then
				send_rpc_command('/jailoff '..nickp..' '..cfg.main.timeopra..' опра бизнес №'..idbiz)
			else
				send_rpc_command('/jail '..idp..' '..cfg.main.timeopra..' опра бизнес №'..idbiz)
			end
		end
end
end

function clr(arg)
if tonumber(arg) and tonumber(arg) >= 5 and tonumber(arg) <= 100 then
for i = 1, arg do
sampAddChatMessage('', -1)
end
else
sampAddChatMessage(tag.."Укажите верное количество строк [5-100]", -1)
end
end

function color()
		ColorsWindow.v = not ColorsWindow.v
		imgui.Process = ColorsWindow.v 
end

function calc(params)
	if params == '' then
		sampAddChatMessage(tag.."Используйте: /cal [пример]", -1)
	else
		local func = load('return ' .. params)
		if func == nil then
			sampAddChatMessage(tag.."Ошибка.", -1)
		else
			local bool, res = pcall(func)
			if bool == false or type(res) ~= 'number' then
				sampAddChatMessage(tag.."Ошибка.", -1)
			
			else
				sampAddChatMessage(tag.."Результат: " .. res, -1)
			end
		end
	end
end

function send_rpc_command(text)
	local bs = raknetNewBitStream()
	local rn = require 'samp.raknet'
	raknetBitStreamWriteInt32(bs, #text)
	raknetBitStreamWriteString(bs, text)
	raknetSendRpc(rn.RPC.SERVERCOMMAND, bs)
	raknetDeleteBitStream(bs)
end


function ajailThread()
	while true do wait(0)
		if isGamePaused() and cfg.autoopra.status then
			while isGamePaused() do wait(0) end
			cfg.autoopra.status = false
			sampShowDialog(5454, tag..'Предупреждение', '{488cff}Автоматический режим был выключен из-за сворачивания игры', 'Понял', _, 0)
		end
	end
end


function tpmetka(arg)
if not tonumber(arg) then
sampAddChatMessage(tag..'Вы телепортированы на метку на карте.', -1)
_, x, y, z = getTargetBlipCoordinatesFixed()
	if not _ then 
	sampAddChatMessage(tag.."Метка для телепорта {E78284}не найдена{84A6E7}.", -1)  else setCharCoordinates(PLAYER_PED, x, y, z) end
elseif tonumber(arg) == 1 then
sampAddChatMessage(tag..'Вы телепортированы на серверную метку.', -1)
tpcssss()
end 
end

function distance_cord(lat1, lon1, lat2, lon2)
	if lat1 == nil or lon1 == nil or lat2 == nil or lon2 == nil or lat1 == "" or lon1 == "" or lat2 == "" or lon2 == "" then
		return 0
	end
	local dlat = math.rad(lat2 - lat1)
	local dlon = math.rad(lon2 - lon1)
	local sin_dlat = math.sin(dlat / 2)
	local sin_dlon = math.sin(dlon / 2)
	local a =
		sin_dlat * sin_dlat + math.cos(math.rad(lat1)) * math.cos(
			math.rad(lat2)
		) * sin_dlon * sin_dlon
	local c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
	local d = 6378 * c
	return d
end

function renderCarNames()
	while true do
	if cfg.Settings.renderText and not isGamePaused() then
			for i = 0, 2000 do
		local result_get_handle, vehHandle = sampGetCarHandleBySampVehicleId(i)
				if result_get_handle and isCarOnScreen(vehHandle) then
					proccessInfo(vehHandle)
		end
	  end
		end
		wait(0)
	end
end


function proccessInfo(vehHandle)
  local pedX, pedY, pedZ = getCharCoordinates(PLAYER_PED)
  local carX, carY, carZ = getCarCoordinates(vehHandle)

  if getDistanceBetweenCoords3d(pedX, pedY, pedZ, carX, carY, carZ) < tonumber(cfg.Settings.distance) then
	local carRenderText = nil
	local model = getCarModel(vehHandle)

	if cfg.Settings.mode == 1 then
	  carRenderText = withID[1][model]
	elseif cfg.Settings.mode == 2 then
	  local carTechName = withID[2][getCarModel(vehHandle)]
	  carRenderText = carTechName..'.dff\n'..carTechName..'.txd'
	end
	if not carRenderText then
		carRenderText = 'Неизвестная модель '..model
	end
	for k,v in ipairs(getAllVehicles()) do
				local hp = getCarHealth(vehHandle)
				 _, VehicleID = sampGetVehicleIdByCarHandle(vehHandle)
				local wposX, wposY = convert3DCoordsToScreen(carX, carY, carZ); 
						   renderFontDrawText(fontForRender, carRenderText..' ['..VehicleID..'] \nHP: '..hp, wposX - 30.0 , wposY + 5.0, 0xFFFFFFFF)
			end
  end
end



function displayVehicleName(x, y, gxt)
  x, y = convertWindowScreenCoordsToGameScreenCoords(x, y)
  useRenderCommands(true)
  setTextWrapx(640.0)
  setTextProportional(true)
  setTextJustify(false)
  setTextScale(0.33, 0.8)
  setTextDropshadow(0, 0, 0, 0, 0)
  setTextColour(255, 255, 255, 230)
  setTextEdge(1, 0, 0, 0, 100)
  setTextFont(1)
  displayText(x, y, gxt)
end


function getCarFreeSeat(car)
  if doesCharExist(getDriverOfCar(car)) then
	local maxPassengers = getMaximumNumberOfPassengers(car)
	for i = 0, maxPassengers do
	  if isCarPassengerSeatFree(car, i) then
		return i + 1
	  end
	end
	return nil 
  else
	return 0
  end
end

function jumpIntoCar(car)
  local seat = getCarFreeSeat(car)
  if not seat then return false end                       
  if seat == 0 then warpCharIntoCar(playerPed, car)        
  else warpCharIntoCarAsPassenger(playerPed, car, seat - 1) 
  end
  restoreCameraJumpcut()
  return true
end

function setCharCoordinatesDontResetAnim(char, x, y, z)
  if doesCharExist(char) then
	local ptr = getCharPointer(char)
	setEntityCoordinates(ptr, x, y, z)
  end
end

function setEntityCoordinates(entityPtr, x, y, z)
  if entityPtr ~= 0 then
	local matrixPtr = readMemory(entityPtr + 0x14, 4, false)
	if matrixPtr ~= 0 then
	  local posPtr = matrixPtr + 0x30
	  writeMemory(posPtr + 0, 4, representFloatAsInt(x), false)
	  writeMemory(posPtr + 4, 4, representFloatAsInt(y), false) 
	  writeMemory(posPtr + 8, 4, representFloatAsInt(z), false)
	end
  end
end

if cfg.main.theme == 'pink' then pinkTheme() result = imgui.ImInt(0)
elseif cfg.main.theme == 'darkgreen' then DarkGreen() result = imgui.ImInt(1)
elseif cfg.main.theme == 'red' then Red() result = imgui.ImInt(2)
elseif cfg.main.theme == 'purple' then Purple() result = imgui.ImInt(3)
elseif cfg.main.theme == 'dark' then Dark() result = imgui.ImInt(4)
elseif cfg.main.theme == 'White' then White() result = imgui.ImInt(5)
else cfg.main.theme = 'pink' pinkTheme() result = imgui.ImInt(0) end

if cfg.main.numberbind == 0 then result1 = imgui.ImInt(0)
elseif cfg.main.numberbind == 1 then result1 = imgui.ImInt(1)
elseif cfg.main.numberbind == 2 then result1 = imgui.ImInt(2)
elseif cfg.main.numberbind == 3 then result1 = imgui.ImInt(3)
elseif cfg.main.numberbind == 4 then result1 = imgui.ImInt(4)
elseif cfg.main.numberbind == 5 then result1 = imgui.ImInt(5)
elseif cfg.main.numberbind == 6 then result1 = imgui.ImInt(6)
elseif cfg.main.numberbind == 7 then result1 = imgui.ImInt(7)
elseif cfg.main.numberbind == 8 then result1 = imgui.ImInt(8)
else cfg.main.numberbind = 0 result1 = imgui.ImInt(0) end

function teleportPlayer(x, y, z)
  if isCharInAnyCar(playerPed) then
	setCharCoordinates(playerPed, x, y, z)
  end
  setCharCoordinatesDontResetAnim(playerPed, x, y, z)
end

function imgui.ToggleButton(str_id, bool)
	local rBool = false

	if LastActiveTime == nil then
		LastActiveTime = {}
	end
	if LastActive == nil then
		LastActive = {}
	end

	local function ImSaturate(f)
		return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
	end
	
	local p = imgui.GetCursorScreenPos()
	local draw_list = imgui.GetWindowDrawList()

	local height = imgui.GetTextLineHeightWithSpacing()
	local width = height * 1.70
	local radius = height * 0.50
	local ANIM_SPEED = 0.15
	local butPos = imgui.GetCursorPos()

	if imgui.InvisibleButton(str_id, imgui.ImVec2(width, height)) then
		bool.v = not bool.v
		rBool = true
		LastActiveTime[tostring(str_id)] = os.clock()
		LastActive[tostring(str_id)] = true
	end

	imgui.SetCursorPos(imgui.ImVec2(butPos.x + width + 8, butPos.y + 2.5))
	imgui.Text( str_id:gsub('##.+', '') )

	local t = bool.v and 1.0 or 0.0

	if LastActive[tostring(str_id)] then
		local time = os.clock() - LastActiveTime[tostring(str_id)]
		if time <= ANIM_SPEED then
			local t_anim = ImSaturate(time / ANIM_SPEED)
			t = bool.v and t_anim or 1.0 - t_anim
		else
			LastActive[tostring(str_id)] = false
		end
	end
	
	local col_static = 0xFF202020
	local col = bool.v and imgui.ColorConvertFloat4ToU32(imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.Button])) or 0xFF606060

	draw_list:AddRectFilled(imgui.ImVec2(p.x, p.y + (height / 6)), imgui.ImVec2(p.x + width - 1.0, p.y + (height - (height / 6))), col, 5.0)
	draw_list:AddCircleFilled(imgui.ImVec2(p.x + radius + t * (width - radius * 2.0), p.y + radius), radius - 0.75, col_static)
	draw_list:AddCircle(imgui.ImVec2(p.x + radius + t * (width - radius * 2.0), p.y + radius), radius - 0.75, col, 32, 2)

	return rBool
end

function regcommands()
	sampRegisterChatCommand('rvanka', rvanka)
	sampRegisterChatCommand('tpr', tponroad)
	sampRegisterChatCommand('rekb', rekb)
	sampRegisterChatCommand("amember", amember)
	sampRegisterChatCommand('checkip', chip)
	sampRegisterChatCommand("cbiz", clicks)
	sampRegisterChatCommand("chome", clickss)
	sampRegisterChatCommand("op", opraplus)
	sampRegisterChatCommand("om", opraminus)
	sampRegisterChatCommand("nick", nicknames)
	sampRegisterChatCommand("rlvl", rlvl)
	sampRegisterChatCommand(cmdHouse.v, ohome)
	sampRegisterChatCommand(cmdBusiness.v, obiz)
	sampRegisterChatCommand('online', function()
		myOnline.v = not myOnline.v
	end)
	sampRegisterChatCommand("updatelog", changes)
	sampRegisterChatCommand("tpm", tpmetka)
	sampRegisterChatCommand('tpc', function(num) 
		sampSendChat('/tpcor '..num) 
	end)
	sampRegisterChatCommand('ah', function(num) 
		sampSendChat('/asellhouse '..num) 
	end)
	sampRegisterChatCommand('ab', function(num) 
		sampSendChat('/asellbiz '..num) 
	end)
	sampRegisterChatCommand('gh', function(num) 
		sampSendChat('/gotohouse '..num) 
	end)
	sampRegisterChatCommand('gb', function(num) 
		sampSendChat('/gotobiz '..num) 
	end)
	sampRegisterChatCommand("clr", clr)
	sampRegisterChatCommand("cal", calc)
	sampRegisterChatCommand("color", color)
	sampRegisterChatCommand("arep", arep)
	sampRegisterChatCommand("ammo", ammo)
	sampRegisterChatCommand("admall", admall)
	sampRegisterChatCommand("helpa", helpa)
	sampRegisterChatCommand('spawnset', spawnset)
	sampRegisterChatCommand('crd', crd)
	sampRegisterChatCommand('rek_off', rek_off)
	sampRegisterChatCommand("ss", giveskin)
	sampRegisterChatCommand("tp", tpm)
	sampRegisterChatCommand('spcarall', spcarall)
	sampRegisterChatCommand('flood', flood)
	sampRegisterChatCommand('rules', rules)
	sampRegisterChatCommand('dm', dm)
	sampRegisterChatCommand('db', db)
	sampRegisterChatCommand('oskrod', oskrod)
	sampRegisterChatCommand('sbiv', sbiv)
	sampRegisterChatCommand('upomrod', upomrod)
	sampRegisterChatCommand('dbk', dbk)
	sampRegisterChatCommand('ncop', ncop)
	sampRegisterChatCommand('cheat', cheat)
	sampRegisterChatCommand('ntune', ntune)
	sampRegisterChatCommand('nead', nead)
	sampRegisterChatCommand('desc', desc)
	sampRegisterChatCommand('protection', zawita)
	sampRegisterChatCommand('oskadm', oskadm)
	sampRegisterChatCommand('pc', pc)
	sampRegisterChatCommand('xdonate', dx4)
	sampRegisterChatCommand('mdm', mdm)
	sampRegisterChatCommand('sk', sk)
	sampRegisterChatCommand('tk', tk)
	sampRegisterChatCommand('vk', vk)
	sampRegisterChatCommand('arenahh', kapcha)
	sampRegisterChatCommand('discord', discord)
	sampRegisterChatCommand('my1', my1)
	sampRegisterChatCommand('my2', my2)
	sampRegisterChatCommand('my3', my3)
	sampRegisterChatCommand('my4', my4)
	sampRegisterChatCommand('tpcar', tpcar)
	sampRegisterChatCommand('amenu', function() MainWindow.v = not MainWindow.v end)
	sampRegisterChatCommand('autoopra', function()
		cfg.autoopra.status = not cfg.autoopra.status
		if cfg.autoopra.settinghouse then cfg.autoopra.house = not cfg.autoopra.house end
		if cfg.autoopra.settingbiz then cfg.autoopra.business = not cfg.autoopra.business end
		sampAddChatMessage(tag..'Автоопровержение '..(cfg.autoopra.status and '{E78284}включено' or '{E78284}выключено'), -1)
	end)
	sampRegisterChatCommand('aopra', function()
		cfg.autoopra.status = not cfg.autoopra.status
		if cfg.autoopra.settinghouse then cfg.autoopra.house = not cfg.autoopra.house end
		if cfg.autoopra.settingbiz then cfg.autoopra.business = not cfg.autoopra.business end
		sampAddChatMessage(tag..'Автоопровержение '..(cfg.autoopra.status and '{E78284}включено' or '{E78284}выключено'), -1)
	end)
	sampRegisterChatCommand("toolsoff", function ()
		sampAddChatMessage(tag..'Скрипт успешно выгружен, для запуска используйте {E78284}CTRL + R.', -1)
		thisScript():unload()
	end)
	sampRegisterChatCommand("toolsreload", function ()
		sampAddChatMessage(tag..'Скрипт успешно перезагружен.', -1)
		thisScript():reload()
	end)
end

function ev.onSendPlayerSync(data) 
	if cfg.main.invisible then 
		local sync = samp_create_sync_data('spectator')
		sync.position = data.position
		sync.send()
		return false 
	end
end

function samp_create_sync_data(sync_type, copy_from_player)
	local ffi = require 'ffi'
	local sampfuncs = require 'sampfuncs'
	local raknet = require 'samp.raknet'


	copy_from_player = copy_from_player or true
	local sync_traits = {
		player = {'PlayerSyncData', raknet.PACKET.PLAYER_SYNC, sampStorePlayerOnfootData},
		vehicle = {'VehicleSyncData', raknet.PACKET.VEHICLE_SYNC, sampStorePlayerIncarData},
		passenger = {'PassengerSyncData', raknet.PACKET.PASSENGER_SYNC, sampStorePlayerPassengerData},
		aim = {'AimSyncData', raknet.PACKET.AIM_SYNC, sampStorePlayerAimData},
		trailer = {'TrailerSyncData', raknet.PACKET.TRAILER_SYNC, sampStorePlayerTrailerData},
		unoccupied = {'UnoccupiedSyncData', raknet.PACKET.UNOCCUPIED_SYNC, nil},
		bullet = {'BulletSyncData', raknet.PACKET.BULLET_SYNC, nil},
		spectator = {'SpectatorSyncData', raknet.PACKET.SPECTATOR_SYNC, nil}
	}
	local sync_info = sync_traits[sync_type]
	local data_type = 'struct ' .. sync_info[1]
	local data = ffi.new(data_type, {})
	local raw_data_ptr = tonumber(ffi.cast('uintptr_t', ffi.new(data_type .. '*', data)))
	if copy_from_player then
		local copy_func = sync_info[3]
		if copy_func then
			local _, player_id
			if copy_from_player == true then
				_, player_id = sampGetPlayerIdByCharHandle(PLAYER_PED)
			else
				player_id = tonumber(copy_from_player)
			end
			copy_func(player_id, raw_data_ptr)
		end
	end
	local func_send = function()
		local bs = raknetNewBitStream()
		raknetBitStreamWriteInt8(bs, sync_info[2])
		raknetBitStreamWriteBuffer(bs, raw_data_ptr, ffi.sizeof(data))
		raknetSendBitStreamEx(bs, sampfuncs.HIGH_PRIORITY, sampfuncs.UNRELIABLE_SEQUENCED, 1)
		raknetDeleteBitStream(bs)
	end
	local mt = {
		__index = function(t, index)
			return data[index]
		end,
		__newindex = function(t, index, value)
			data[index] = value
		end
	}
	return setmetatable({send = func_send}, mt)
end



function cccc()
	if cfg.main.playersChecker then 
		local x, y = cfg.checkerPosition.x, cfg.checkerPosition.y
		renderFontDrawTextAlign(fonts.playersChecker, "Игроки онлайн: ", cfg.checkerPosition.x, cfg.checkerPosition.y, -1, cfg.main.align)
		for k,v in ipairs(J_.PLAYERS_CHECKER[1]) do 
			local id = sampGetPlayerIdByNickname(v)
			if id and id ~= -1 then
				if sampIsPlayerConnected(id) then 
					y = y + cfg.main.otschecker
					local color = sampGetPlayerColor(id)
					local color = {explode_argb(color)}
					local color = join_argb(255, color[2], color[3], color[4])
					local fColor = bit.tohex(color)
					if fColor and color then 
						if cfg.main.afkinchecker then
							if sampIsPlayerPaused(id) then
								if fColor == 'fffdfcfc' then
								renderFontDrawTextAlign(fonts.playersChecker, "{"..cfg.main.stockcolorchecker.."}"..v.." ["..id.."] - {"..cfg.main.afkcolorchecker.."}AFK", x, y, color, cfg.main.align)
								else
								renderFontDrawTextAlign(fonts.playersChecker, "{"..fColor.."}"..v.." ["..id.."] - {"..cfg.main.afkcolorchecker.."}AFK", x, y, color, cfg.main.align)
								end
							else 
								if fColor == 'fffdfcfc' then
								renderFontDrawTextAlign(fonts.playersChecker, "{"..cfg.main.stockcolorchecker.."}"..v.." ["..id.."]", x, y, color, cfg.main.align)
								else
								renderFontDrawTextAlign(fonts.playersChecker, "{"..fColor.."}"..v.." ["..id.."]", x, y, color, cfg.main.align)
								end
							end
						else
							if fColor == 'fffdfcfc' then
								renderFontDrawTextAlign(fonts.playersChecker, "{"..cfg.main.stockcolorchecker.."}"..v.." ["..id.."]", x, y, color, cfg.main.align)
							else
								renderFontDrawTextAlign(fonts.playersChecker, "{"..fColor.."}"..v.." ["..id.."]", x, y, color, cfg.main.align)
							end
						end
					end 
				end
			end
		end 
	end
	if cfg.main.adminsChecker then 
		local x, y = cfg.adminscheckerPosition.x, cfg.adminscheckerPosition.y
		renderFontDrawTextAlign(fonts456.adminsChecker, "Администрация онлайн: ", cfg.adminscheckerPosition.x, cfg.adminscheckerPosition.y, -1, cfg.main.adminsAlign)
		for i = 1,#adminsTable do
			local id = adminsTable[i]["id"]
			if id and id ~= -1 then
				if sampIsPlayerConnected(id) then 
					y = y + cfg.main.adminsotschecker
					local color = sampGetPlayerColor(id)
					local color = {explode_argb(color)}
					local color = join_argb(255, color[2], color[3], color[4])
					local fColor = bit.tohex(color)
					if fColor and color then 
						if cfg.main.adminsafkinchecker then
							if sampIsPlayerPaused(id) then
								if fColor == 'fffdfcfc' then
								renderFontDrawTextAlign(fonts456.adminsChecker, "{"..cfg.main.adminsstockcolorchecker.."}"..adminsTable[i]["nick"].." ["..id.."] "..adminsTable[i]["job"].." - ["..adminsTable[i]["warns"].."/3] - "..adminsTable[i]["rep"].." - {"..cfg.main.afkcolorchecker.."}AFK", x, y, color, cfg.main.adminsAlign)
								else
								renderFontDrawTextAlign(fonts456.adminsChecker, "{"..fColor.."}"..adminsTable[i]["nick"].." ["..id.."] "..adminsTable[i]["job"].." - ["..adminsTable[i]["warns"].."/3] - "..adminsTable[i]["rep"].." - {"..cfg.main.afkcolorchecker.."}AFK", x, y, color, cfg.main.adminsAlign)
								end
							else 
								if fColor == 'fffdfcfc' then
								renderFontDrawTextAlign(fonts456.adminsChecker, "{"..cfg.main.adminsstockcolorchecker.."}"..adminsTable[i]["nick"].." ["..id.."] "..adminsTable[i]["job"].." - ["..adminsTable[i]["warns"].."/3] - "..adminsTable[i]["rep"], x, y, color, cfg.main.adminsAlign)
								else
								renderFontDrawTextAlign(fonts456.adminsChecker, "{"..fColor.."}"..adminsTable[i]["nick"].." ["..id.."] "..adminsTable[i]["job"].." - ["..adminsTable[i]["warns"].."/3] - "..adminsTable[i]["rep"], x, y, color, cfg.main.adminsAlign)
								end
							end
						else
							if fColor == 'fffdfcfc' then
								renderFontDrawTextAlign(fonts456.adminsChecker, "{"..cfg.main.adminsstockcolorchecker.."}"..adminsTable[i]["nick"].." ["..id.."] "..adminsTable[i]["job"].." - ["..adminsTable[i]["warns"].."/3] - "..adminsTable[i]["rep"], x, y, color, cfg.main.adminsAlign)
							else
								renderFontDrawTextAlign(fonts456.adminsChecker, "{"..fColor.."}"..adminsTable[i]["nick"].." ["..id.."] "..adminsTable[i]["job"].." - ["..adminsTable[i]["warns"].."/3] - "..adminsTable[i]["rep"], x, y, color, cfg.main.adminsAlign)
							end
						end
					end 
				end
			end
		end 
	end
	if style_killlist.v == 2 or style_killlist.v == 3 then
		setStructElement(sampGetKillInfoPtr(), 0, 4, 0)
	else
		setStructElement(sampGetKillInfoPtr(), 0, 4, 1)
	end
end

function imgui.BoolButton(bool, ...)
	if type(bool) ~= 'boolean' then return end
	if bool then
		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]))
		imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]))
		imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]))
		local result = imgui.Button(...)
		imgui.PopStyleColor(3)
		return result
	else
		imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.Button]))
		imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]))
		imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.ButtonActive]))
		local result = imgui.Button(...)
		imgui.PopStyleColor(3)
		return result
	end
end

function renderFontDrawTextAlign(font, text, x, y, color, align)
	if not align or align == 1 then
		renderFontDrawText(font, text, x, y, color)
	end
	if align == 2 then 
		renderFontDrawText(font, text, x - renderGetFontDrawTextLength(font, text) / 2, y, color)
	end
	if align == 3 then 
		renderFontDrawText(font, text, x - renderGetFontDrawTextLength(font, text), y, color)
	end
end

function loadbinders()
if not doesDirectoryExist(getGameDirectory()..'//moonloader//AdminToolsKing') then 
	createDirectory(getGameDirectory()..'//moonloader//AdminToolsKing') 
	sampAddChatMessage(tag..'Директория для нужных файлов скрипта успешно создана', -1)
end
if not doesDirectoryExist(getGameDirectory()..'//moonloader//AdminToolsKing//Логи//') then 
	createDirectory(getGameDirectory()..'//moonloader//AdminToolsKing//Логи//') 
	sampAddChatMessage(tag..'Директория для логов успешно создана', -1)
end
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//binder1.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//binder1.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для биндера "Собственный №1" успешно создан', -1)
	end
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//binder2.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//binder2.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для биндера "Собственный №2" успешно создан', -1)
	end
	
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//binder3.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//binder3.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для биндера "Собственный №3" успешно создан', -1)
	end
	
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//binder4.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//binder4.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для биндера "Собственный №4" успешно создан', -1)
	end
	
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//AcceptForms.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//AcceptForms.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для записи принятых форм успешно создан', -1)
	end
	
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//GiveWarnsTK.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//GiveWarnsTK.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для записи выданных варнов за ТК успешно создан', -1)
	end
	
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//zawitabinder.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//zawitabinder.txt", 'w')
		f:write(u8'/ao Уважаемые игроки, берегите свои аккаунты. Устанавливайте привязку по VK (vk-guard)!\n/ao Не давайте пароль от своего аккаунта никому, не скачивайте модификации с неизвестных сайтов.\n/ao Напомню, администрация не несет ответственности за ваши аккаунты. Все в ваших руках!')
		f:close()
		sampAddChatMessage(tag..'Файл для биндера "Защита аккаунтов" успешно создан', -1)
	end
	
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//donatebinder.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//donatebinder.txt", 'w')
		f:write(u8'/ao Уважаемые игроки, на данный момент на сервере действует акция X2 донат!\n/ao Вся пополненная сумма увеличивается в 2 раза, не упустите возможность приобрести привилегии по низкой цене!\n/aoПополнение счета на нашем сайте - *** ссылка ***')
		f:close()
		sampAddChatMessage(tag..'Файл для биндера "Множитель доната" успешно создан', -1)
	end
	
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//rulesbinder.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//rulesbinder.txt", 'w')
		f:write(u8'/ao Уважаемые игроки, советую ознакомиться с правилами сервера на нашем форуме - *** ссылка ***\n/ao За нарушение правил сервера Вы будете строго наказаны, приятной игры!')
		f:close()
		sampAddChatMessage(tag..'Файл для биндера "Правила сервера" успешно создан', -1)
	end
	
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//discordbinder.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//discordbinder.txt", 'w')
		f:write(u8'/ao Не хватает общения? Хочешь продать имущество? После сложного учебного дня хочется отдохнуть?\n/ao Тогда присоединяйся к Дискорду нашего сервера! Адекватные игроки и модерация.\n/ao Ссылка на наш Дискорд-канал: discord.gg/QusdeJnGeM')
		f:close()
		sampAddChatMessage(tag..'Файл для биндера "Дискорд" успешно создан', -1)
	end
	
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//groupbinder.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//groupbinder.txt", 'w')
		f:write(u8'/ao Уважаемые игроки, хотите узнавать актуальную информацию самым первым?\n/ao Для такого случая у нас есть паблик ВК - vk.com/arizona_kingrp, узнавайте новости самым первым!')
		f:close()
		sampAddChatMessage(tag..'Файл для биндера "Паблик VK" успешно создан', -1)
	end
	
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//Логи//AdminVipChatLogs.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//AdminVipChatLogs.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для записи сообщений от администраторов в VIP чате создан.', -1)
	end
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//Логи//UnjailsLogs.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//UnjailsLogs.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для записи выпусков из деморгана создан.', -1)
	end
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//Логи//UnmutesLogs.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//UnmutesLogs.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для записи снятий мутов создан.', -1)
	end
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//Логи//UnbanLogs.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//UnbanLogs.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для записи разблокировок создан.', -1)
	end
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//Логи//UnbanipLogs.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//UnbanipLogs.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для записи разблокировок IP создан.', -1)
	end
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//Логи//BanoffLogs.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//BanoffLogs.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для записи блокировок в оффлайне создан.', -1)
	end
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//Логи//JailoffLogs.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//JailoffLogs.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для записи выдачи деморганов в оффлайне создан.', -1)
	end
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//Логи//MuteoffLogs.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//MuteoffLogs.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для записи выдачи мутов в оффлайне создан.', -1)
	end
	if not doesFileExist(getGameDirectory().."//moonloader//AdminToolsKing//Логи//BanipoffLogs.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//BanipoffLogs.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для записи выдачи блокировок IP в оффлайне создан.', -1)
	end
	
	if not doesFileExist(getWorkingDirectory().."\\AdminToolsKing\\Логи\\AutoOpraLogs.txt") then
		local f = io.open(getGameDirectory().."//moonloader//AdminToolsKing//Логи//AutoOpraLogs.txt", 'w')
		f:close()
		sampAddChatMessage(tag..'Файл для записи покупок имущества создан.', -1)
	end
	
	mybind1 = io.open(getGameDirectory().."//moonloader//AdminToolsKing//binder1.txt", "r")
	mybinder1.v = mybind1:read('*a')
	mybind1:close()
	
	mybind2 = io.open(getGameDirectory().."//moonloader//AdminToolsKing//binder2.txt", "r")
	mybinder2.v = mybind2:read('*a')
	mybind2:close()
	
	mybind3 = io.open(getGameDirectory().."//moonloader//AdminToolsKing//binder3.txt", "r")
	mybinder3.v = mybind3:read('*a')
	mybind3:close()
	
	mybind4 = io.open(getGameDirectory().."//moonloader//AdminToolsKing//binder4.txt", "r")
	mybinder4.v = mybind4:read('*a')
	mybind4:close()
	
	zawitabind = io.open(getGameDirectory().."//moonloader//AdminToolsKing//zawitabinder.txt", "r")
	zawitabinder.v = zawitabind:read('*a')
	zawitabind:close()
	
	donatebind = io.open(getGameDirectory().."//moonloader//AdminToolsKing//donatebinder.txt", "r")
	donatebinder.v = donatebind:read('*a')
	donatebind:close()
	
	rulesbind = io.open(getGameDirectory().."//moonloader//AdminToolsKing//rulesbinder.txt", "r")
	rulesbinder.v = rulesbind:read('*a')
	rulesbind:close()
	
	discordbind = io.open(getGameDirectory().."//moonloader//AdminToolsKing//discordbinder.txt", "r")
	discordbinder.v = discordbind:read('*a')
	discordbind:close()
	
	groupbind = io.open(getGameDirectory().."//moonloader//AdminToolsKing//groupbinder.txt", "r")
	groupbinder.v = groupbind:read('*a')
	groupbind:close()
end

function ev.onSendBulletSync(data)
	if elements.checkbox.drawMyBullets.v then
		if data.center.x ~= 0 then
			if data.center.y ~= 0 then
				if data.center.z ~= 0 then
					bulletSyncMy.lastId = bulletSyncMy.lastId + 1
					if bulletSyncMy.lastId < 1 or bulletSyncMy.lastId > bulletSyncMy.maxLines then
						bulletSyncMy.lastId = 1
					end
					bulletSyncMy[bulletSyncMy.lastId].my.time = os.time() + elements.int.timeRenderMyBullets.v
					bulletSyncMy[bulletSyncMy.lastId].my.o.x, bulletSyncMy[bulletSyncMy.lastId].my.o.y, bulletSyncMy[bulletSyncMy.lastId].my.o.z = data.origin.x, data.origin.y, data.origin.z
					bulletSyncMy[bulletSyncMy.lastId].my.t.x, bulletSyncMy[bulletSyncMy.lastId].my.t.y, bulletSyncMy[bulletSyncMy.lastId].my.t.z = data.target.x, data.target.y, data.target.z
					if data.targetType == 0 then
						bulletSyncMy[bulletSyncMy.lastId].my.color = join_argb(255, staticObjectMy.v[1]*255, staticObjectMy.v[2]*255, staticObjectMy.v[3]*255)
					elseif data.targetType == 1 then
						bulletSyncMy[bulletSyncMy.lastId].my.color = join_argb(255, pedPMy.v[1]*255, pedPMy.v[2]*255, pedPMy.v[3]*255)
					elseif data.targetType == 2 then
						bulletSyncMy[bulletSyncMy.lastId].my.color = join_argb(255, carPMy.v[1]*255, carPMy.v[2]*255, carPMy.v[3]*255)
					elseif data.targetType == 3 then
						bulletSyncMy[bulletSyncMy.lastId].my.color = join_argb(255, dinamicObjectMy.v[1]*255, dinamicObjectMy.v[2]*255, dinamicObjectMy.v[3]*255)
					end
				end
			end
		end
	end
end 


function ev.onBulletSync(playerid, data)
	if elements.checkbox.drawBullets.v then
		if data.center.x ~= 0 then
			if data.center.y ~= 0 then
				if data.center.z ~= 0 then
					bulletSync.lastId = bulletSync.lastId + 1
					if bulletSync.lastId < 1 or bulletSync.lastId > bulletSync.maxLines then
						bulletSync.lastId = 1
					end
					if elements.checkbox.showPlayerInfo.v then
						bulletSync[bulletSync.lastId].other.id = playerid
						bulletSync[bulletSync.lastId].other.colorText = join_argb(255, colorPlayerI.v[1]*255, colorPlayerI.v[2]*255, colorPlayerI.v[3]*255)
					end
					bulletSync[bulletSync.lastId].other.time = os.time() + elements.int.timeRenderBullets.v
					bulletSync[bulletSync.lastId].other.o.x, bulletSync[bulletSync.lastId].other.o.y, bulletSync[bulletSync.lastId].other.o.z = data.origin.x, data.origin.y, data.origin.z
					bulletSync[bulletSync.lastId].other.t.x, bulletSync[bulletSync.lastId].other.t.y, bulletSync[bulletSync.lastId].other.t.z = data.target.x, data.target.y, data.target.z
					bulletSync[bulletSync.lastId].other.type = data.targetType
					if data.targetType == 0 then
						bulletSync[bulletSync.lastId].other.color = join_argb(255, staticObject.v[1]*255, staticObject.v[2]*255, staticObject.v[3]*255)
					elseif data.targetType == 1 then
						bulletSync[bulletSync.lastId].other.color = join_argb(255, pedP.v[1]*255, pedP.v[2]*255, pedP.v[3]*255)
					elseif data.targetType == 2 then
						bulletSync[bulletSync.lastId].other.color = join_argb(255, carP.v[1]*255, carP.v[2]*255, carP.v[3]*255)
					elseif data.targetType == 3 then
						bulletSync[bulletSync.lastId].other.color = join_argb(255, dinamicObject.v[1]*255, dinamicObject.v[2]*255, dinamicObject.v[3]*255)
					end
				end
			end
		end
	end
end

function sendpiar()
if cfg.main.autopiar then
		if result1.v == 0 then 
			lua_thread.create(function ()
			for cikk22 in zawitabinder.v:gmatch("[^\r\n]+") do
			sampSendChat(u8:decode(cikk22))
			end
			end)
			elseif result1.v == 1 then 
				lua_thread.create(function ()
for cikk22 in donatebinder.v:gmatch("[^\r\n]+") do
sampSendChat(u8:decode(cikk22))
end
end)
			elseif result1.v == 2 then 
				lua_thread.create(function ()
for cikk22 in rulesbinder.v:gmatch("[^\r\n]+") do
sampSendChat(u8:decode(cikk22))
end
end)
			elseif result1.v == 3 then 
				lua_thread.create(function ()
for cikk22 in discordbinder.v:gmatch("[^\r\n]+") do
sampSendChat(u8:decode(cikk22))
end
end)
			elseif result1.v == 4 then 
				lua_thread.create(function ()
for cikk22 in groupbinder.v:gmatch("[^\r\n]+") do
sampSendChat(u8:decode(cikk22))
end
end)
			elseif result1.v == 5 then 
				lua_thread.create(function ()
for cikk22 in mybinder1.v:gmatch("[^\r\n]+") do
sampSendChat(u8:decode(cikk22))
end
end)
			elseif result1.v == 6 then 
				lua_thread.create(function ()
for cikk22 in mybinder2.v:gmatch("[^\r\n]+") do
sampSendChat(u8:decode(cikk22))
end
end)
			elseif result1.v == 7 then 
				lua_thread.create(function ()
for cikk22 in mybinder3.v:gmatch("[^\r\n]+") do
sampSendChat(u8:decode(cikk22))
end
end)
			elseif result1.v == 8 then 
				lua_thread.create(function ()
for cikk22 in mybinder4.v:gmatch("[^\r\n]+") do
sampSendChat(u8:decode(cikk22))
end
end)
			end
	end
end

function rlvl(arg)
if tonumber(arg) and tonumber(arg) >= 3 and tonumber(arg) <= 100 then
	local peds = getAllChars()
	for _, v in pairs(peds) do
		local result, myid = sampGetPlayerIdByCharHandle(playerPed)
		local mx, my, mz = getCharCoordinates(playerPed)
		local x, y, z = getCharCoordinates(v)
		local distance = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
		local result, id = sampGetPlayerIdByCharHandle(v)
		if result and id ~= sampGetPlayerIdByCharHandle(PLAYER_PED) and distance < tonumber(arg) then
			if id ~= myid then
				local nick = sampGetPlayerNickname(id)
				local lvl = sampGetPlayerScore(id)
				if lvl < 15 then
					sampAddChatMessage(tag..'Никнейм: {fe4e4e}'..nick..' ['..id..'] {84A6E7}| Уровень: {fe4e4e}'..lvl..' [ПУСТЫШКА]', -1)
				else
					sampAddChatMessage(tag..'Никнейм: {E78284}'..nick..' ['..id..'] {84A6E7}| Уровень: {E78284}'..lvl, -1)
				end
			end
		end
	end
else
sampAddChatMessage(tag..'Укажите радиус проверки уровней [3-100]', -1)
end
end


function settingswallhackoncar()
if imgui.BeginPopupModal(u8'Настройки | WallHack на транспорт', MainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
			imgui.CenterText(u8'Тип названия авто:')
				if imgui.RadioButton(u8"Название транспорта", style_wallhackoncar, 1) then
			cfg.Settings.mode = 1
			end
			if imgui.RadioButton(u8'Название текстуры файла', style_wallhackoncar, 2) then
				cfg.Settings.mode = 2
			end
			imgui.Text(u8'Дальность прорисовки:')
			imgui.SameLine()
				imgui.PushItemWidth(100)
				imgui.InputInt(u8("##whdist"), buffer70)
				cfg.Settings.distance = string.format('%s', tostring(buffer70.v)) 
				imgui.PopItemWidth()
				if buffer70.v <= 1 then
					buffer70.v = 1
				elseif buffer70.v >= 50 then
					buffer70.v = 50
				end
				imgui.Text(u8'Шрифт:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputText('##fontwh', fontwh) then 
					cfg.Settings.font = string.format('%s', tostring(fontwh.v)) 
					fontForRender = renderCreateFont(cfg.Settings.font, cfg.Settings.size, cfg.Settings.style, FCR_BOLD + FCR_BORDER)	
				end 
				imgui.PopItemWidth()
				imgui.Text(u8'Размер шрифта:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##ssas"), buffer71) then
					cfg.Settings.size = string.format('%s', tostring(buffer71.v))
					fontForRender = renderCreateFont(cfg.Settings.font, cfg.Settings.size, cfg.Settings.style, FCR_BOLD + FCR_BORDER)				
				end
				imgui.PopItemWidth()
				if buffer71.v <= 6 then
					buffer71.v = 6
				elseif buffer71.v >= 35 then
					buffer71.v = 35
				end
				imgui.Text(u8'Стиль шрифта:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##sssas"), buffer72) then
					cfg.Settings.style = string.format('%s', tostring(buffer72.v))
					fontForRender = renderCreateFont(cfg.Settings.font, cfg.Settings.size, cfg.Settings.style, FCR_BOLD + FCR_BORDER)				
				end
				imgui.PopItemWidth()
				if buffer72.v < 1 then
					buffer72.v = 1
				end
				if imgui.Button(u8'Сохранить и закрыть', imgui.ImVec2(-1, 25)) then
					inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
					imgui.CloseCurrentPopup()
				end
				imgui.EndPopup()
			end
end

function connectwithplayer()
if check_input_available() and isKeysZazhat(fvzaim.v) then 
				local cx, cy = windowCoordinates[1] / 2, windowCoordinates[2] / 2
				local wheel = getMousewheelDelta()
				local maxRad = (windowCoordinates[2] / 2) - 60
				local ACTIVE_COLOR = (cfg.main.targetState == "player" and 0xFF84A6E7 or 0xFFFF8C00)
				cfg.main.circleRadius = cfg.main.circleRadius + (wheel * 2)
				if cfg.main.circleRadius < 30 then cfg.main.circleRadius = 30 end 
				if cfg.main.circleRadius > maxRad then cfg.main.circleRadius = maxRad end
				local mltСorner = math.floor(cfg.main.circleRadius / 100) == 0 and 1 or math.floor(cfg.main.circleRadius / 100)
				for i = 1, 2 do renderFigure2D(cx, cy, 25 * mltСorner, cfg.main.circleRadius + i, (cfg.main.targetState == "player" and PLAYER_COLOR or ACTIVE_COLOR)) end
				renderFontDrawTextCenter(fonts1.circle, "Режим: "..(cfg.main.targetState == "player" and "Игроки" or "Транспорт"), cx, windowCoordinates[2] - 40, 0xFF84A6E7)
				renderFontDrawTextCenter(fonts1.circle, "Размер: "..(cfg.main.circleRadius < maxRad and cfg.main.circleRadius > 30 and cfg.main.circleRadius or (cfg.main.circleRadius <= 30 and "Минимум" or (cfg.main.circleRadius >= maxRad and "Максимум"))), windowCoordinates[1] / 2, windowCoordinates[2] - 29, 0xFF84A6E7)
				renderFontDrawTextCenter(fonts1.circle, "Изменение радиуса: колёсико мыши", cx, windowCoordinates[2] - 18, 0xFF84A6E7)
				if cfg.main.targetState == "player" then 
					local nearPed = getNearCharToCenter(cfg.main.circleRadius)
					if doesCharExist(nearPed) then
						local id                    = select(2, sampGetPlayerIdByCharHandle(nearPed))
						local plColor               = getPlayerColorWithoutAlpha(id)
						local plPause               = sampIsPlayerPaused(id)
						local plName                = sampGetPlayerNickname(id)..'['..id..']'
						local plCoordinates         = {getCharCoordinates(nearPed)}
						local fPlCoordinates        = {convert3DCoordsToScreen(plCoordinates[1], plCoordinates[2], plCoordinates[3])}
						local myCoordinates         = {getCharCoordinates(playerPed)}
						PLAYER_COLOR                = plColor
						if isCharOnScreen(nearPed) then
							renderDrawLine(cx, cy, fPlCoordinates[1], fPlCoordinates[2], 2, plColor)
							renderDrawPolygon(fPlCoordinates[1], fPlCoordinates[2], 8, 8, 8, 0, plColor)
							if not isNameTagVisible(id) then
								if plPause then renderFontDrawTextCenter(fonts1.circle, 'AFK', fPlCoordinates[1], fPlCoordinates[2] - 35, 0xFFAA3333) end
								renderFontDrawTextCenter(fonts1.circle, plName, fPlCoordinates[1], fPlCoordinates[2] - 20, plColor)
							end
							local dist = math.floor(getDistanceBetweenCoords3d(plCoordinates[1], plCoordinates[2], plCoordinates[3], myCoordinates[1], myCoordinates[2], myCoordinates[3]))..' метров'
							renderFontDrawTextCenter(fonts1.circle, dist, cx, cy + cfg.main.circleRadius + 10, ACTIVE_COLOR)
							renderFontDrawText(fonts1.circle, '1 - Телепортироваться',              cx + cfg.main.circleRadius + 10, cy - 30,    ACTIVE_COLOR)
							renderFontDrawText(fonts1.circle, '2 - Телепортировать к себе',         cx + cfg.main.circleRadius + 10, cy - 15,    ACTIVE_COLOR)
							renderFontDrawText(fonts1.circle, '3 - Уйти в рекон за игроком',        cx + cfg.main.circleRadius + 10, cy,         ACTIVE_COLOR)
							renderFontDrawText(fonts1.circle, '4 - Выдать 100 HP',                  cx + cfg.main.circleRadius + 10, cy + 15,    ACTIVE_COLOR)
							renderFontDrawText(fonts1.circle, '5 - Заспавнить игрока',              cx + cfg.main.circleRadius + 10, cy + 30,    ACTIVE_COLOR)
							renderFontDrawText(fonts1.circle, '6 - Открыть меню взаимодействия с игроком',        cx + cfg.main.circleRadius + 10, cy + 45,    ACTIVE_COLOR)
							if isKeyJustPressed(VK_1) then 
								sampSendChat("/goto "..id)
							end
							if isKeyJustPressed(VK_2) then 
								if cfg.main.mylvladmin >= 2 then 
									sampSendChat("/gethere "..id)
								else 
									sampAddChatMessage(tag..'Ваш админ-уровень слишком низок для выполнения данного действия.', -1)
								end
							end
							if isKeyJustPressed(VK_3) then 
								sampSendChat("/re "..id)
							end
							if isKeyJustPressed(VK_4) then 
								sampSendChat("/sethp "..id.." 100")
							end
							if isKeyJustPressed(VK_5) then 
								sampSendChat("/spplayer "..id)
							end
							if isKeyJustPressed(VK_6) then 
								InteractionWindow.v = true
								muteid = id
							end
						end
					else 
						PLAYER_COLOR = -1
					end
			end
			end
end

function loadbinds()
cfg.main.ftradeKey = encodeJson(ftradeKey.v)
		cfg.main.ffloodkey = encodeJson(ffloodkey.v)
		cfg.main.fopentools = encodeJson(fopentools.v)
		cfg.main.fopenpunish = encodeJson(fopenpunish.v)
		cfg.main.fairbrake = encodeJson(fairbrake.v)
		cfg.main.fspeedup = encodeJson(fspeedup.v)
		cfg.main.fjspeedup = encodeJson(fjspeedup.v)
		cfg.main.fspeeddown = encodeJson(fspeeddown.v)
		cfg.main.upair = encodeJson(upair.v)
		cfg.main.fjspeeddown = encodeJson(fjspeeddown.v)
		cfg.main.fvzaim = encodeJson(fvzaim.v)
		cfg.main.fopencbiz = encodeJson(fopencbiz.v)
		cfg.main.fopenchome = encodeJson(fopenchome.v)
		cfg.main.ftpaz = encodeJson(ftpaz.v)
		cfg.main.fchecker = encodeJson(fchecker.v)
		cfg.main.facceptform = encodeJson(facceptform.v)
		cfg.main.fopenmenutp = encodeJson(fopenmenutp.v)
		cfg.main.fgm = encodeJson(fgm.v)
		cfg.main.freoff = encodeJson(freoff.v)
		cfg.main.fvizualrep = encodeJson(fvizualrep.v)
		cfg.main.farep = encodeJson(farep.v)
		cfg.main.fopenreport = encodeJson(fopenreport.v)
		cfg.main.flastreport = encodeJson(flastreport.v)
		cfg.main.fnorules = encodeJson(fnorules.v)
		cfg.main.fspecrep = encodeJson(fspecrep.v)
		cfg.main.fperedam = encodeJson(fperedam.v)
		cfg.main.fslap = encodeJson(fslap.v)
		cfg.main.famember = encodeJson(famember.v)
		cfg.main.fspeclast = encodeJson(fspeclast.v)
		cfg.main.fopenmap = encodeJson(fopenmap.v)
		cfg.main.flovlyareporta = encodeJson(flovlyareporta.v)
		cfg.main.fjetpack = encodeJson(fjetpack.v)
		cfg.main.fspecauthor = encodeJson(fspecauthor.v)
end

function nicknames(arg)
if tonumber(arg) then
	local result = sampIsPlayerConnected(arg)
	if not result then
		sampAddChatMessage(tag..'Указанный вами игрок находится не в сети!', -1)
	else
		send_rpc_command('/pm '..arg..' 0 Уважаемый игрок, ваш никнейм составлен не по требуемому формату.')
		send_rpc_command('/pm '..arg..' 0 Сделайте свой никнейм по форме: Nick_Name | Пример: Requiem_Devil')
		send_rpc_command('/kick '..arg..' NickName [Имя_Фамилия]')
	end
else
	sampAddChatMessage(tag..'Укажите верный ID игрока!', -1)
end
end

function rvanka(arg)
if tonumber(arg) then
	local result = sampIsPlayerConnected(arg)
	if not result then
		sampAddChatMessage(tag..'Указанный вами игрок находится не в сети!', -1)
	else
		send_rpc_command('/banip '..arg..' ИЗП [Рванка]')
	end
else
	sampAddChatMessage(tag..'Укажите верный ID игрока!', -1)
end
end

function rekb(arg)
if tonumber(arg) then
	local result = sampIsPlayerConnected(arg)
	if not result then
		sampAddChatMessage(tag..'Указанный вами игрок находится не в сети!', -1)
	else
		send_rpc_command('/banip '..arg..' Реклама постор. ресурсов')
	end
else
	sampAddChatMessage(tag..'Укажите верный ID игрока!', -1)
end
end


function opraplus(arg)
if arg== nil or arg == " " or arg == "" then
sampAddChatMessage(tag..'Укажите верный NickName игрока!', -1)
else
	local id = sampGetPlayerIdByNickname(arg)
	local result = sampIsPlayerConnected(id)
	if not result then
		send_rpc_command('/unjailoff '..arg..' опровержение принято')
	else
		send_rpc_command('/unjail '..id..' опровержение принято')
	end
end
end

function opraminus(arg)
if arg== nil or arg == " " or arg == "" then
sampAddChatMessage(tag..'Укажите верный NickName игрока!', -1)
else
	local id = sampGetPlayerIdByNickname(arg)
	local result = sampIsPlayerConnected(id)
	if not result then
		send_rpc_command('/unjailoff '..arg..' опровержение отклонено')
	else
		send_rpc_command('/unjail '..id..' опровержение отклонено')
	end
end
end


function clicks()
sampSendClickTextdraw(525)
sampSendDialogResponse(966, 1, 8, "")
end

function clickss()
sampSendClickTextdraw(525)
sampSendDialogResponse(966, 1, 9, "")
end


function chip(cl)
	ips = {}
	for word in string.gmatch(cl, "(%d+%p%d+%p%d+%p%d+)") do
		table.insert(ips, { querццy = word })
	end
	if #ips > 0 then
		data_json = cjson.encode(ips)
		asyncHttpRequest(
			"POST",
			"http://ip-api.com/batch?fields=25305&lang=ru",
			{ data = data_json },
			function(response)
				local rdata = cjson.decode(u8:decode(response.text))
				local text = ""
				for i = 1, #rdata do
					if rdata[i]["status"] == "success" then
						local distances =
							distance_cord(
								rdata[1]["lat"],
								rdata[1]["lon"],
								rdata[i]["lat"],
								rdata[i]["lon"]
							)
						if cfg.main.removeip then
							sampAddChatMessage(tag..'Проверяю IP: {E78284}скрыто {84A6E7}| {E78284}№'..i, -1)
						else
							sampAddChatMessage(tag..'Проверяю IP: {E78284}'..rdata[i]["query"]..' {84A6E7}| {E78284}№'..i, -1)
						end
							sampAddChatMessage(tag..'['..i..' IP] Страна: '..rdata[i]["country"]..' | Город: '..rdata[i]["city"]..' | Провайдер: '..rdata[i]["isp"], -1)
							sampAddChatMessage(tag..'['..i..' IP] Расстояние от регистрационного: '..distances..'км', -1)
			   end
				end
				if text == "" then
					text = " \n\t{FFF500}Ничего не найдено"
				end
			end,
			function(err)
				sampAddChatMessage(tag.."Произошла ошибка " .. err, -1)
			end
		)
	else
		sampAddChatMessage(tag..'Используйте /checkip [IP адрес(-ы)]', -1)
	end
end

function CodeList()

ev.onPlayerDeathNotification = function(killerId, killedId, reason)
			if reason < 0 or reason > 46 or killerId > 1000 or killedId > 1000 then 
				return false 
			end
			lua_thread.create(function()
				local line = {
					killer = (not cfg.main.showIDKiller) and sampGetPlayerNickname(killerId) or string.format('%s[%d]', sampGetPlayerNickname(killerId), killerId), 
					killerColor = sampGetPlayerColor(killerId), 
					killed = (not cfg.main.showIDKilled) and sampGetPlayerNickname(killedId) or string.format('%s[%d]', sampGetPlayerNickname(killedId), killedId), 
					killedColor = sampGetPlayerColor(killedId), 
					timeKill = os.date("%H:%M:%S"),
					killer_id = killerId,
					killed_id = killedId,
					reason = reason
				}
				if (#killInfo >= tonumber(cfg.main.maxLinesInKillList)) then
					killInfo[#killInfo + 1] = line
					for i = 1, #killInfo - 1 do 
						killInfo[i] = killInfo[i + 1]
					end
					table.remove(killInfo)
				else
					table.insert(killInfo, line)
				end
				
			end)
			if cfg.main.warningtk then
		if sampGetPlayerColor(killerId) == sampGetPlayerColor(killedId) then
		if sampGetPlayerColor(killedId) < 368966908 or sampGetPlayerColor(killedId) > 368966908 then
		color1 = string.format('%06X', bit.band(sampGetPlayerColor(killedId), 0xFFFFFF))
		if not isGamePaused() then
		sampAddChatMessage('{E78284}<WARNING TK> {'..color1..'}'..sampGetPlayerNickname(killerId) .. ' [' .. killerId .. '] {84A6E7}убил своего напарника по организации {'..color1..'}'..sampGetPlayerNickname(killedId) .. ' [' .. killedId .. ']', -1)
		end
		end
		end
		end
		end
end

function CodeList2()
if cfg.main.killlist then
if cfg.main.stylekilllist == 2 then 
	for i = 1, #killInfo do
		local y = cfg.killListPosition.y + math.pow(-1, 0) * (i - 1) * (cfg.main.indentKillListY + renderGetFontDrawHeight(fonts123.killList));
		if drawClickableText(fonts123.killList,string.format('{a0a0a0}[%s]{ffffff} {%06X}%s', killInfo[i].timeKill, argb_to_rgb_bare(killInfo[i].killerColor), killInfo[i].killer),cfg.killListPosition.x,y, 0xFFFFFFFF, 0xFFFFFFFF) then if cfg.main.spectatekill and not editPositionKillList then sampSendChat('/re '..killInfo[i].killer_id) end end
		renderDrawTexture(LOAD_IMAGES.KILL_LIST[tonumber(killInfo[i].reason)],cfg.killListPosition.x + renderGetFontDrawTextLength(fonts123.killList, '['..killInfo[i].timeKill..'] ') + renderGetFontDrawTextLength(fonts123.killList, killInfo[i].killer) + cfg.main.indentKillListX,y - (cfg.main.iconSizeKillListX - renderGetFontDrawHeight(fonts123.killList)) / 2.0,cfg.main.iconSizeKillListX,cfg.main.iconSizeKillListY,0,0xFFFFFFFF)
		if drawClickableText(fonts123.killList,string.format('{%06X}%s', argb_to_rgb_bare(killInfo[i].killedColor), killInfo[i].killed),cfg.killListPosition.x + renderGetFontDrawTextLength(fonts123.killList, '['..killInfo[i].timeKill..'] ') + renderGetFontDrawTextLength(fonts123.killList, killInfo[i].killer) + 2 * cfg.main.indentKillListX + cfg.main.iconSizeKillListX,y,0xFFFFFFFF, 0xFFFFFFFF) then if cfg.main.spectatekill then sampSendChat('/re '..killInfo[i].killed_id) end end
	end
elseif cfg.main.stylekilllist == 3 then
	for i = 1, #killInfo do
		local y = cfg.killListPosition.y + math.pow(-1, 0) * (i - 1) * (cfg.main.indentKillListY + renderGetFontDrawHeight(fonts123.killList));
		if drawClickableText(fonts123.killList,string.format('{a0a0a0}[%s]{ffffff} {%06X}%s', killInfo[i].timeKill, argb_to_rgb_bare(killInfo[i].killerColor), killInfo[i].killer),cfg.killListPosition.x,y,0xFFFFFFFF, 0x257E1CFF) then if cfg.main.spectatekill and not editPositionKillList then sampSendChat('/re '..killInfo[i].killer_id) end end
		renderFontDrawText(fonts123.killList,string.format(' {a0a0a0}=> '..weapons.get_name(tonumber(killInfo[i].reason))..' => '),cfg.killListPosition.x + renderGetFontDrawTextLength(fonts123.killList, '['..killInfo[i].timeKill..'] ') + renderGetFontDrawTextLength(fonts123.killList, killInfo[i].killer) + 2 * cfg.main.indentKillListX,y,0xFFFFFFFF)
		if drawClickableText(fonts123.killList,string.format('{%06X}%s', argb_to_rgb_bare(killInfo[i].killedColor), killInfo[i].killed),cfg.killListPosition.x + renderGetFontDrawTextLength(fonts123.killList, '['..killInfo[i].timeKill..'] ') + renderGetFontDrawTextLength(fonts123.killList, killInfo[i].killer) + 4 * cfg.main.indentKillListX + renderGetFontDrawTextLength(fonts123.killList, ' {a0a0a0}=> '..weapons.get_name(tonumber(killInfo[i].reason))..' => ') ,y,0xFFFFFFFF, 0xFFFFFFFF) then if cfg.main.spectatekill then sampSendChat('/re '..killInfo[i].killed_id) end end
	end
end
end
end

function argb_to_rgb_bare(argb)
	return bit.band(argb, 16777215);
end

IMAGES = {
	KILL_LIST = {
	[0] = "moonloader/AdminToolsKing/KillList/weap_0.png",
	[1] = "moonloader/AdminToolsKing/KillList/weap_1.png",
	[2] = "moonloader/AdminToolsKing/KillList/weap_2.png",
	[3] = "moonloader/AdminToolsKing/KillList/weap_3.png",
	[4] = "moonloader/AdminToolsKing/KillList/weap_4.png",
	[5] = "moonloader/AdminToolsKing/KillList/weap_5.png",
	[6] = "moonloader/AdminToolsKing/KillList/weap_6.png",
	[7] = "moonloader/AdminToolsKing/KillList/weap_7.png",
	[8] = "moonloader/AdminToolsKing/KillList/weap_8.png",
	[9] = "moonloader/AdminToolsKing/KillList/weap_9.png",
	[10] = "moonloader/AdminToolsKing/KillList/weap_10.png",
	[11] = "moonloader/AdminToolsKing/KillList/weap_11.png",
	[12] = "moonloader/AdminToolsKing/KillList/weap_12.png",
	[13] = "moonloader/AdminToolsKing/KillList/weap_13.png",
	[14] = "moonloader/AdminToolsKing/KillList/weap_14.png",
	[15] = "moonloader/AdminToolsKing/KillList/weap_15.png",
	[16] = "moonloader/AdminToolsKing/KillList/weap_16.png",
	[17] = "moonloader/AdminToolsKing/KillList/weap_17.png",
	[18] = "moonloader/AdminToolsKing/KillList/weap_18.png",
	[19] = "moonloader/AdminToolsKing/KillList/weap_19.png",
	[20] = "moonloader/AdminToolsKing/KillList/weap_20.png",
	[21] = "moonloader/AdminToolsKing/KillList/weap_21.png",
	[22] = "moonloader/AdminToolsKing/KillList/weap_22.png",
	[23] = "moonloader/AdminToolsKing/KillList/weap_23.png",
	[24] = "moonloader/AdminToolsKing/KillList/weap_24.png",
	[25] = "moonloader/AdminToolsKing/KillList/weap_25.png",
	[26] = "moonloader/AdminToolsKing/KillList/weap_26.png",
	[27] = "moonloader/AdminToolsKing/KillList/weap_27.png",
	[28] = "moonloader/AdminToolsKing/KillList/weap_28.png",
	[29] = "moonloader/AdminToolsKing/KillList/weap_29.png",
	[30] = "moonloader/AdminToolsKing/KillList/weap_30.png",
	[31] = "moonloader/AdminToolsKing/KillList/weap_31.png",
	[32] = "moonloader/AdminToolsKing/KillList/weap_32.png",
	[33] = "moonloader/AdminToolsKing/KillList/weap_33.png",
	[34] = "moonloader/AdminToolsKing/KillList/weap_34.png",
	[35] = "moonloader/AdminToolsKing/KillList/weap_35.png",
	[36] = "moonloader/AdminToolsKing/KillList/weap_36.png",
	[37] = "moonloader/AdminToolsKing/KillList/weap_37.png",
	[38] = "moonloader/AdminToolsKing/KillList/weap_38.png",
	[39] = "moonloader/AdminToolsKing/KillList/weap_39.png",
	[40] = "moonloader/AdminToolsKing/KillList/weap_40.png",
	[41] = "moonloader/AdminToolsKing/KillList/weap_41.png",
	[42] = "moonloader/AdminToolsKing/KillList/weap_42.png",
	[43] = "moonloader/AdminToolsKing/KillList/weap_43.png",
	[44] = "moonloader/AdminToolsKing/KillList/weap_44.png",
	[45] = "moonloader/AdminToolsKing/KillList/weap_45.png",
	[46] = "moonloader/AdminToolsKing/KillList/weap_46.png",
	[49] = "moonloader/AdminToolsKing/KillList/weap_49.png",
	[50] = "moonloader/AdminToolsKing/KillList/weap_50.png",
	[51] = "moonloader/AdminToolsKing/KillList/weap_51.png",
	[53] = "moonloader/AdminToolsKing/KillList/weap_53.png",
	[54] = "moonloader/AdminToolsKing/KillList/weap_54.png",
	[255] = "moonloader/AdminToolsKing/KillList/weap_255.png"
	
		},
}


function SettingsKill()
imgui.CenterText(u8'Выберите тип килл листа')
			if imgui.RadioButton(u8"Стандартный", style_killlist, 1) then
				cfg.main.stylekilllist = 1
				kill_selected.v = 1
			end
			imgui.SameLine(250)
			if imgui.RadioButton(u8'Эксклюзивный №1', style_killlist, 2) then
				cfg.main.stylekilllist = 2
				kill_selected.v = 2 
			end
			imgui.SameLine(500)
			if imgui.RadioButton(u8'Эксклюзивный №2', style_killlist, 3) then
				cfg.main.stylekilllist = 3
				kill_selected.v = 3
			end
			imgui.Separator()
			if cfg.main.stylekilllist == 1 then
			elseif cfg.main.stylekilllist == 2 then
				if imgui.ToggleButton(u8'Отображать ID убийцы', imgui.ImBool(cfg.main.showIDKiller)) then 
					cfg.main.showIDKiller = not cfg.main.showIDKiller 
				end 
				if imgui.ToggleButton(u8'Отображать ID убитого', imgui.ImBool(cfg.main.showIDKilled)) then 
					cfg.main.showIDKilled = not cfg.main.showIDKilled 
				end
				imgui.Text(u8'Местоположение:')
				imgui.SameLine()
				if imgui.Button(fa.ICON_FA_ARROWS_ALT..u8'') then 
				if not editPositionKillList then 
					sampAddChatMessage(tag..'Используйте {E78284}ЛКМ {84A6E7}для сохранения позиции списка убийств.', -1)
					local lastX, lastY = cfg.killListPosition.x, cfg.killListPosition.y
					local open = cfg.main.regChecker
					editPositionKillList = true 
					MainWindow.v = false
					lua_thread.create(function()
						while editPositionKillList do wait(0)
						sampSetCursorMode(CMODE_LOCKCAM)
							local x, y = getCursorPos()
							cfg.killListPosition.x, cfg.killListPosition.y = x, y
							if isKeyDown(VK_LBUTTON) then 
								sampAddChatMessage(tag..'Позиция списка убийств успешно сохранена.', -1)
								inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
								editPositionKillList = false 
								sampToggleCursor(false)
								break 
							end
						end
					end)
				else 
					sampAddChatMessage("Для начала завершите прошедшее редактирование.", -1)
				end 
				end			
				imgui.Separator()
				imgui.Text(u8'Горизонтальный отступ между строками:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##killindentx"), KillBufferIndentX) then
					cfg.main.indentKillListX = string.format('%s', tostring(KillBufferIndentX.v))	
				end
				imgui.PopItemWidth()
				if KillBufferIndentX.v <= 0 then
					KillBufferIndentX.v = 0
				elseif KillBufferIndentX.v >= 50 then
					KillBufferIndentX.v = 50
				end
				imgui.PushItemWidth(100)
				imgui.Text(u8'Вертикальный отступ между строками:')
				imgui.SameLine()
				if imgui.InputInt(u8("##fsdijerguifrgd"), KillBufferIndentY) then
					cfg.main.indentKillListY = string.format('%s', tostring(KillBufferIndentY.v))	
				end
				imgui.PopItemWidth()
				if KillBufferIndentY.v <= 0 then
					KillBufferIndentY.v = 0
				elseif KillBufferIndentY.v >= 50 then
					KillBufferIndentY.v = 50
				end
				
				imgui.Text(u8'Размер иконки оружия по ширине:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##dfjnfgj"), KillBufferIconSizeX) then
					cfg.main.iconSizeKillListX = string.format('%s', tostring(KillBufferIconSizeX.v))	
				end
				imgui.PopItemWidth()
				if KillBufferIconSizeX.v <= 0 then
					KillBufferIconSizeX.v = 0
				elseif KillBufferIconSizeX.v >= 50 then
					KillBufferIconSizeX.v = 50
				end
				imgui.PushItemWidth(100)
				imgui.Text(u8'Размер иконки оружия по высоте:')
				imgui.SameLine()
				if imgui.InputInt(u8("##fedjgf24"), KillBufferIconSizeY) then
					cfg.main.iconSizeKillListY = string.format('%s', tostring(KillBufferIconSizeY.v))	
				end
				imgui.PopItemWidth()
				if KillBufferIconSizeY.v <= 0 then
					KillBufferIconSizeY.v = 0
				elseif KillBufferIconSizeY.v >= 50 then
					KillBufferIconSizeY.v = 50
				end
				imgui.Separator()
				imgui.Text(u8'Шрифт килл листа:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputText('##qqqqqqqqqqqqqqqq', FontKill) then 
					cfg.main.FontKill = string.format('%s', tostring(FontKill.v)) 
					fonts123 = { 
						killList         = renderCreateFont(cfg.main.FontKill, cfg.fonts.killListSize, cfg.fonts.killListStyle),
					}		
				end 
				imgui.PopItemWidth()
				imgui.Text(u8'Стиль шрифта:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##aye228"), KillBufferFontStyle) then
					cfg.fonts.killListStyle = string.format('%s', tostring(KillBufferFontStyle.v))	
					fonts123 = { 
						killList         = renderCreateFont(cfg.main.FontKill, cfg.fonts.killListSize, cfg.fonts.killListStyle),
					}
				end
				imgui.PopItemWidth()
				if KillBufferFontStyle.v <= 1 then
					KillBufferFontStyle.v = 1
				end
				imgui.Text(u8'Размер шрифта:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##aye2128"), KillBufferSize) then
					cfg.fonts.killListSize = string.format('%s', tostring(KillBufferSize.v))	
					fonts123 = { 
						killList         = renderCreateFont(cfg.main.FontKill, cfg.fonts.killListSize, cfg.fonts.killListStyle),
					}
				end
				imgui.PopItemWidth()
				if KillBufferSize.v <= 1 then
					KillBufferSize.v = 1
				end
				imgui.Separator()
			elseif cfg.main.stylekilllist == 3 then
				if imgui.ToggleButton(u8'Отображать ID убийцы', imgui.ImBool(cfg.main.showIDKiller)) then 
					cfg.main.showIDKiller = not cfg.main.showIDKiller 
				end 
				if imgui.ToggleButton(u8'Отображать ID убитого', imgui.ImBool(cfg.main.showIDKilled)) then 
					cfg.main.showIDKilled = not cfg.main.showIDKilled 
				end
				imgui.Text(u8'Местоположение:')
				imgui.SameLine()
				if imgui.Button(fa.ICON_FA_ARROWS_ALT..u8'') then 
				if not editPositionKillList then 
					sampAddChatMessage(tag..'Используйте {E78284}ЛКМ {84A6E7}для сохранения позиции списка убийств.', -1)
					local lastX, lastY = cfg.killListPosition.x, cfg.killListPosition.y
					local open = cfg.main.regChecker
					editPositionKillList = true 
					MainWindow.v = false
					lua_thread.create(function()
						while editPositionKillList do wait(0)
						sampSetCursorMode(CMODE_LOCKCAM)
							local x, y = getCursorPos()
							cfg.killListPosition.x, cfg.killListPosition.y = x, y
							if isKeyDown(VK_LBUTTON) then 
								sampAddChatMessage(tag..'Позиция списка убийств успешно сохранена.', -1)
								inicfg.save(cfg, "AdminToolsKing\\AdminTools.ini")
								editPositionKillList = false 
								sampToggleCursor(false)
								break 
							end
						end
					end)
				else 
					sampAddChatMessage("Для начала завершите прошедшее редактирование.", -1)
				end
				end			
				imgui.Separator()
				imgui.Text(u8'Горизонтальный отступ между строками:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##killindentx"), KillBufferIndentX) then
					cfg.main.indentKillListX = string.format('%s', tostring(KillBufferIndentX.v))	
				end
				imgui.PopItemWidth()
				if KillBufferIndentX.v <= 0 then
					KillBufferIndentX.v = 0
				elseif KillBufferIndentX.v >= 50 then
					KillBufferIndentX.v = 50
				end
				imgui.PushItemWidth(100)
				imgui.Text(u8'Вертикальный отступ между строками:')
				imgui.SameLine()
				if imgui.InputInt(u8("##fsdijerguifrgd"), KillBufferIndentY) then
					cfg.main.indentKillListY = string.format('%s', tostring(KillBufferIndentY.v))	
				end
				imgui.PopItemWidth()
				if KillBufferIndentY.v <= 0 then
					KillBufferIndentY.v = 0
				elseif KillBufferIndentY.v >= 50 then
					KillBufferIndentY.v = 50
				end
				imgui.Separator()
				imgui.Text(u8'Шрифт килл листа:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputText('##qqqqqqqqqqqqqqqq', FontKill) then 
					cfg.main.FontKill = string.format('%s', tostring(FontKill.v)) 
					fonts123 = { 
						killList         = renderCreateFont(cfg.main.FontKill, cfg.fonts.killListSize, cfg.fonts.killListStyle),
					}		
				end 
				imgui.PopItemWidth()
				imgui.Text(u8'Стиль шрифта:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##aye228"), KillBufferFontStyle) then
					cfg.fonts.killListStyle = string.format('%s', tostring(KillBufferFontStyle.v))	
					fonts123 = { 
						killList         = renderCreateFont(cfg.main.FontKill, cfg.fonts.killListSize, cfg.fonts.killListStyle),
					}
				end
				imgui.PopItemWidth()
				if KillBufferFontStyle.v <= 1 then
					KillBufferFontStyle.v = 1
				end
				imgui.Text(u8'Размер шрифта:')
				imgui.SameLine()
				imgui.PushItemWidth(100)
				if imgui.InputInt(u8("##aye2128"), KillBufferSize) then
					cfg.fonts.killListSize = string.format('%s', tostring(KillBufferSize.v))	
					fonts123 = { 
						killList         = renderCreateFont(cfg.main.FontKill, cfg.fonts.killListSize, cfg.fonts.killListStyle),
					}
				end
				imgui.PopItemWidth()
				if KillBufferSize.v <= 1 then
					KillBufferSize.v = 1
				end
				imgui.Separator()
			end
end

function imgui.CustomMenu(labels, selected, size, speed, centering)
	local bool = false
	speed = speed and speed or 0.2
	local radius = size.y * 0.50
	local draw_list = imgui.GetWindowDrawList()
	if LastActiveTime == nil then LastActiveTime = {} end
	if LastActive == nil then LastActive = {} end
	local function ImSaturate(f)
		return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
	end
	for i, v in ipairs(labels) do
		local c = imgui.GetCursorPos()
		local p = imgui.GetCursorScreenPos()
		if imgui.InvisibleButton(v..'##'..i, size) then
			selected.v = i
			LastActiveTime[v] = os.clock()
			LastActive[v] = true
			bool = true
		end
		imgui.SetCursorPos(c)
		local t = selected.v == i and 1.0 or 0.0
		if LastActive[v] then
			local time = os.clock() - LastActiveTime[v]
			if time <= 0.3 then
				local t_anim = ImSaturate(time / speed)
				t = selected.v == i and t_anim or 1.0 - t_anim
			else
				LastActive[v] = false
			end
		end
		local col_button = imgui.GetColorU32(selected.v == i and imgui.GetStyle().Colors[imgui.Col.ButtonActive] or imgui.ImVec4(0,0,0,0))
		local col_box = imgui.GetColorU32(selected.v == i and imgui.GetStyle().Colors[imgui.Col.ButtonHovered] or imgui.ImVec4(0,0,0,0))
		local col_hovered = imgui.GetStyle().Colors[imgui.Col.ButtonActive]
		local col_hovered = imgui.GetColorU32(imgui.ImVec4(col_hovered.x, col_hovered.y, col_hovered.z, (imgui.IsItemHovered() and 0.2 or 0)))
		draw_list:AddRectFilled(imgui.ImVec2(p.x-size.x/6, p.y), imgui.ImVec2(p.x + (radius * 0.65) + t * size.x, p.y + size.y), col_button, 0.0)
		draw_list:AddRectFilled(imgui.ImVec2(p.x-size.x/6, p.y), imgui.ImVec2(p.x + (radius * 0.65) + size.x, p.y + size.y), col_hovered, 0.0)
		imgui.SetCursorPos(imgui.ImVec2(c.x+(centering and (size.x-imgui.CalcTextSize(v).x)/2 or 15), c.y+(size.y-imgui.CalcTextSize(v).y)/2))
		imgui.Text(v)
		imgui.SetCursorPos(imgui.ImVec2(c.x, c.y+size.y))
		draw_list:AddRectFilled(imgui.ImVec2(p.x+170, p.y), imgui.ImVec2(p.x+180, p.y + size.y), col_box)
	end
	return bool
end


function drawClickableText(font, text, posX, posY, color, colorA)
   renderFontDrawText(font, text, posX, posY, color)
   local textLenght = renderGetFontDrawTextLength(font, text)
   local textHeight = renderGetFontDrawHeight(font)
   local curX, curY = getCursorPos()
   if curX >= posX and curX <= posX + textLenght and curY >= posY and curY <= posY + textHeight then
	 renderFontDrawText(font, text, posX, posY, colorA)
	 if wasKeyPressed(1) then
	   return true
	 end
   end
end


function checkstate()
while true do
	wait(0)
	if ReconWindow.v and not isGamePaused() then
	showcheck = true
	showid = true
	sampSendChat('/check '..spec_id)
	wait(800)
	sampSendChat('/id '..spec_id)
	wait(1500)
	end
end
end

function infostate()
	shotre = 0
	local _, char = sampGetCharHandleBySampPlayerId(spec_id)
	if _ and char and org and euro and btc and bankbtc and warns and vipstatus then
			local afkplayer = sampIsPlayerPaused(spec_id)
			imgui.BeginChild('##34545345445456454', imgui.ImVec2(0, 0), false)
			imgui.Columns(4)
			--imgui.SetColumnWidth(-1, 87); imgui.Text(u8'Уровень'); imgui.NextColumn()
			--imgui.SetColumnWidth(-1, 87); imgui.Text(tostring(sampGetPlayerScore(spec_id))); imgui.NextColumn()
			--imgui.SetColumnWidth(-1, 87); imgui.Text(u8'Опыт'); imgui.NextColumn()
			--imgui.SetColumnWidth(-1, 87); imgui.Text(tostring(respect)); imgui.NextColumn()
			--imgui.Separator()

			imgui.Text(u8'Пинг')
			imgui.NextColumn()
			if tonumber(sampGetPlayerPing(spec_id)) > 60 then 
				if not pl then
					imgui.TextColoredRGB('{ff6347}'..sampGetPlayerPing(spec_id)..'(0.00)') 
				else 
					imgui.TextColoredRGB('{ff6347}'..sampGetPlayerPing(spec_id)..'('..pl..')') 
				end
			else 
				if not pl then
					imgui.Text(tostring(sampGetPlayerPing(spec_id))..'(0.00)') 
				else 
					imgui.Text(tostring(sampGetPlayerPing(spec_id))..'('..pl..')') 
				end
			end
			imgui.NextColumn()
			imgui.Text(u8'АФК')
			imgui.NextColumn()
			if afkplayer then imgui.Text(u8'Отошел') else imgui.Text('0') end
			imgui.Separator()

			imgui.NextColumn()
			imgui.Text(u8'Здоровье')
			imgui.NextColumn()
			imgui.Text(tostring(sampGetPlayerHealth(spec_id)))
			imgui.NextColumn()
			imgui.Text(u8'Бронь')
			imgui.NextColumn()
			imgui.Text(tostring(sampGetPlayerArmor(spec_id)))
			imgui.Separator()

			imgui.NextColumn()
			imgui.Text(u8'Оружие/ПТ')
			imgui.NextColumn()
			if _ then
			imgui.Text(''..tonumber(getCurrentCharWeapon(char))..':'..getAmmoInCharWeapon(char, tonumber(getCurrentCharWeapon(char)))..'')
			else
			imgui.Text('0')
			end
			--imgui.NextColumn()
			--imgui.Text(u8'Shot общее')
			--imgui.NextColumn()
			--imgui.Text('0/0')
			--imgui.Separator()

			imgui.NextColumn()
			imgui.Text(u8'VIP статус')
			imgui.NextColumn()
			imgui.Text(u8(tostring(vipstatus)))
			imgui.Separator()

			imgui.NextColumn()
			imgui.Text(u8'WARNS')
			imgui.NextColumn()
			imgui.Text(tostring(warns))
			imgui.NextColumn()
			imgui.Text(u8'Shot в /re')
			imgui.NextColumn()
			if _ then
			if isCharShooting(char) then
			shotre = shotre + 1
			end
			end
			imgui.Text(''..shotre..'/'..shotre)
			imgui.Separator()

			imgui.NextColumn()
			imgui.Text(u8'Фракция')
			imgui.NextColumn()
			if org ~= "Не имеется" then 
				imgui.Text(u8(org)) 
			else 
				imgui.Text(u8'Гражданин') 
			end
			imgui.NextColumn()
			imgui.Text(u8'Ранг')
			imgui.NextColumn()
			imgui.Text(tostring(rank))
			imgui.Separator()

			imgui.NextColumn()
			imgui.Text(u8'Скорость')
			imgui.NextColumn()
			if _ then 
			imgui.Text(''..math.ceil(getCharSpeed(char))) 
			else
			imgui.Text("0")
			end
			imgui.NextColumn()
			imgui.Text(u8'Скин')
			imgui.NextColumn()
			if _ then 
			imgui.Text(tostring(getCharModel(char)))
			else
			imgui.Text('0')
			end
			imgui.Separator()


			imgui.NextColumn()
			imgui.Text(u8'Игра')
			imgui.NextColumn()
			if statespec then
				imgui.TextColoredRGB(tostring(statespec))
			else
				imgui.Text(u8("Загрузка"))
			end
			imgui.NextColumn()
			imgui.Text(u8'Защита')
			imgui.NextColumn()
			imgui.Text(tostring(protect))
			imgui.Separator()

			imgui.NextColumn()
			imgui.Text(u8'Урон')
			imgui.NextColumn()
			imgui.Text(tostring(damag))
			imgui.NextColumn()
			imgui.Text(u8'Реген')
			imgui.NextColumn()
			imgui.Text(tostring(regen))
			imgui.Separator()

			imgui.NextColumn()
			imgui.Text(u8'Euro')
			imgui.NextColumn()
			imgui.Text(tostring(euro))
			imgui.NextColumn()
			imgui.Text(u8'BTC')
			imgui.NextColumn()
			if btc and bankbtc then
				imgui.Text(tostring(btc+bankbtc))
			end
			imgui.Separator()

			--imgui.NextColumn()
			--imgui.Text(u8'VIP статус')
			--imgui.NextColumn()
			--imgui.Text(u8(tostring(vipstatus)))
			--imgui.Separator()

			imgui.Columns(1)

				imgui.EndChild()
		end
--			local afkplayer = sampIsPlayerPaused(spec_id)
--			imgui.BeginChild('##34545345445456452344', imgui.ImVec2(0, 0), false)
--			imgui.Columns(4)
--			imgui.SetColumnWidth(-1, 87); imgui.Text(u8'Уровень'); imgui.NextColumn()
--			imgui.SetColumnWidth(-1, 87); imgui.Text(tostring(sampGetPlayerScore(spec_id))); imgui.NextColumn()
--			imgui.SetColumnWidth(-1, 87); imgui.Text(u8'Опыт'); imgui.NextColumn()
--			imgui.SetColumnWidth(-1, 87); --[[imgui.Text(respect);]] imgui.NextColumn()
--			imgui.Separator()
--
--			imgui.Text(u8'Пинг')
--			imgui.NextColumn()
--			if tonumber(sampGetPlayerPing(spec_id)) > 60 then 
--				if not pl then
--					imgui.TextColoredRGB('{ff6347}'..sampGetPlayerPing(spec_id)..'(0.00)') 
--				else 
--					imgui.TextColoredRGB('{ff6347}'..sampGetPlayerPing(spec_id)..'('..pl..')') 
--				end
--			else 
--				if not pl then
--					imgui.Text(''..sampGetPlayerPing(spec_id)..'(0.00)') 
--				else 
--					imgui.Text(''..sampGetPlayerPing(spec_id)..'('..pl..')') 
--				end
--			end
--			imgui.NextColumn()
--			imgui.Text(u8'АФК')
--			imgui.NextColumn()
--			if afkplayer then imgui.Text(u8'Отошел') else imgui.Text('0') end
--			imgui.Separator()
--
--			imgui.NextColumn()
--			imgui.Text(u8'Здоровье')
--			imgui.NextColumn()
--			imgui.Text(tostring(sampGetPlayerHealth(spec_id)))
--			imgui.NextColumn()
--			imgui.Text(u8'Бронь')
--			imgui.NextColumn()
--			imgui.Text(tostring(sampGetPlayerArmor(spec_id)))
--			imgui.Separator()
--
--			imgui.NextColumn()
--			imgui.Text(u8'Оружие/ПТ')
--			imgui.NextColumn()
--			if _ then
--			imgui.Text(''..tonumber(getCurrentCharWeapon(char))..':'..getAmmoInCharWeapon(char, tonumber(getCurrentCharWeapon(char)))..'')
--			else
--			imgui.Text('0')
--			end
--			imgui.NextColumn()
--			imgui.Text(u8'Shot общее')
--			imgui.NextColumn()
--			imgui.Text('0/0')
--			imgui.Separator()
--
--			imgui.NextColumn()
--			imgui.Text(u8'WARNS')
--			imgui.NextColumn()
--			imgui.Text(tostring(warns))
--			imgui.NextColumn()
--			imgui.Text(u8'Shot в /re')
--			imgui.NextColumn()
--			if _ then
--			if isCharShooting(char) then
--			shotre = shotre + 1
--			end
--			end
--			imgui.Text(''..shotre..'/'..shotre)
--			imgui.Separator()
--
--			imgui.NextColumn()
--			imgui.Text(u8'Фракция')
--			imgui.NextColumn()
--			if org ~= "Не имеется" then imgui.Text(tostring(org)) else imgui.Text(u8'Гражданин') end
--			imgui.NextColumn()
--			imgui.Text(u8'Ранг')
--			imgui.NextColumn()
--			imgui.Text(tostring(rank))
--			imgui.Separator()
--
--			imgui.NextColumn()
--			imgui.Text(u8'Скорость')
--			imgui.NextColumn()
--			if _ then 
--			imgui.Text(''..math.ceil(getCharSpeed(char))..' / 257.0') 
--			else
--			imgui.Text('0 / 257.0')
--			end
--			imgui.NextColumn()
--			imgui.Text(u8'Скин')
--			imgui.NextColumn()
--			if _ then 
--			imgui.Text(tostring(getCharModel(char)))
--			else
--			imgui.Text('0')
--			end
--			imgui.Separator()
--
--
--			imgui.NextColumn()
--			imgui.Text(u8'Игра')
--			imgui.NextColumn()
--			imgui.TextColoredRGB((tostring(statespec)))
--			imgui.NextColumn()
--			imgui.Text(u8'Защита')
--			imgui.NextColumn()
--			imgui.Text('-0%')
--			imgui.Separator()
--
--			imgui.NextColumn()
--			imgui.Text(u8'Урон')
--			imgui.NextColumn()
--			imgui.Text('+0')
--			imgui.NextColumn()
--			imgui.Text(u8'Реген')
--			imgui.NextColumn()
--			imgui.Text('0')
--			imgui.Separator()
--
--			imgui.NextColumn()
--			imgui.Text(u8'Euro')
--			imgui.NextColumn()
--			imgui.Text(tostring(euro))
--			imgui.NextColumn()
--			imgui.Text(u8'BTC')
--			imgui.NextColumn()
--			imgui.Text(tostring(btc))
--			imgui.Separator()
--
--			imgui.NextColumn()
--			imgui.Text(u8'VIP статус')
--			imgui.NextColumn()
--			imgui.Text((tostring(vipstatus)))
--			imgui.Separator()
--
--			imgui.EndChild()
end

function reconusers()

	imgui.SetNextWindowSize(imgui.ImVec2(1, 1), imgui.Cond.FirstUseEver)
	imgui.SetNextWindowPos(imgui.ImVec2(posX228.v, posY228.v), imgui.Cond.Always)

  imgui.Begin(fa.ICON_FA_EYE .. u8' Слежка',reconusers_state,imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar)
  imgui.ShowCursor = true
  imgui.CenterTextColoredRGB('{fe4e4e}Очередь слежки')
  for idjb in report_text:gmatch("(%d+)") do
	
	if idjb then 

	  if sampIsPlayerConnected(idjb) then
		nickrecon = sampGetPlayerNickname(idjb)
	   if imgui.Button(u8''.. nickrecon .. "[".. idjb .."]", imgui.ImVec2(200,25)) then sampSendChat('/re '..idjb ) end
	  end
	end
	
	
  end
  imgui.End()

end

function kbinds()
		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(fopentools.v) then
				MainWindow.v = not MainWindow.v
				imgui.Process = MainWindow.v
			end
		end
		
		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(ftpaz.v) then
				sampSendChat('/az')
			end
		end
		
		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(fopencbiz.v) then
				clicks()
			end
		end
		
		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(fopenchome.v) then
				clickss()
			end
		end
		
		if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and isPlayerPlaying(playerHandle) then
			if isKeysDown(fopenpunish.v) then
				MainWindow.v = not MainWindow.v
				menusel.v = 5
			end
		end
end


function imgui.VerticalSeparator()
	local p = imgui.GetCursorScreenPos()
	imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x, p.y + imgui.GetContentRegionMax().y), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.Separator]))
end

		function imgui.DisableButton(text, size)
			imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.50, 0.50, 0.50, 1.00))
			imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.50, 0.50, 0.50, 1.00))
			imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.50, 0.50, 0.50, 1.00))
			local button = imgui.Button(text, size)
			imgui.PopStyleColor(3)
			return button
		end
		
			function imgui.CustomBarLogs()
		local pos = imgui.GetCursorScreenPos()
		local drawList = imgui.GetWindowDrawList()

		local count = #logBut["buttons"]
		local height = 20
		local animTime = 0.2
		local sel = logBut["selected"]


		local renderButton = function(n, color)
			if n == 1 then
				drawList:AddRectFilled(imgui.ImVec2(pos.x + (135 * n) - 135, pos.y), imgui.ImVec2(pos.x + (135 * n), pos.y + 35), color, 5, 9)
			elseif n == count then
				drawList:AddRectFilled(imgui.ImVec2(pos.x + (135 * n) - 135, pos.y), imgui.ImVec2(pos.x + (135 * n), pos.y + 35), color, 5, 6)
			else
				drawList:AddRectFilled(imgui.ImVec2(pos.x + (135 * n) - 135, pos.y), imgui.ImVec2(pos.x + (135 * n), pos.y + 35), color)
			end
		end
		local smooth = function(color)
			local s = function(f)
				return f < 0 and 0 or (f > 255 and 255 or f)
			end
			local _, r, g, b = explode_U32(color)
			local a = s((os.clock() - logBut["clicked"]["time"]) * (128 / animTime))
			return join_argb(a, r, g, b)
		end
			renderButton(sel, mcx)
		imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 0)
		imgui.PushStyleVar(imgui.StyleVar.ItemSpacing, imgui.ImVec2(0, 4))

		for i, button in ipairs(logBut["buttons"]) do
			if imgui.Button(u8(button .. "##" .. i), imgui.ImVec2(135, 35)) then
				if logBut["selected"] ~= i then
					logBut["clicked"]["last"] = logBut["selected"]
					logBut["clicked"]["time"] = os.clock()
					logBut["selected"] = i
				end
			end
			if i ~= count then
				imgui.SameLine()
			end
		end

		imgui.PopStyleVar(2)
	end
	
	function explode_U32(u32)
	local a = bit.band(bit.rshift(u32, 24), 0xFF)
	local r = bit.band(bit.rshift(u32, 16), 0xFF)
	local g = bit.band(bit.rshift(u32, 8), 0xFF)
	local b = bit.band(u32, 0xFF)
	return a, r, g, b
end



function teleportInterior(ped, posX, posY, posZ, int)
	setCharInterior(ped, int)
	setInteriorVisible(int)
	setCharCoordinates(ped, posX, posY, posZ)
end

function fps_correction()
	return representIntAsFloat(readMemory(0xB7CB5C, 4, false))
end


function getNearestRoadCoordinates(radius)
	local A = { getCharCoordinates(PLAYER_PED) }
	local B = { getClosestStraightRoad(A[1], A[2], A[3], 0, radius or 600) }
	if B[1] ~= 0 and B[2] ~= 0 and B[3] ~= 0 then
		return true, B[1], B[2], B[3]
	end
	return false
end


function tponroad()
local result, x, y, z = getNearestRoadCoordinates()
		if result then
			local dist = getDistanceBetweenCoords3d(x, y, z, getCharCoordinates(PLAYER_PED))
			if not ReconWindow.v then
				setCharCoordinates(PLAYER_PED, x, y, z + 1)
				sampAddChatMessage(("[AdminTools] Вы телепортированы на ближайшую от Вас дорогу (%dm.)"):format(dist), 0xAAFFAA)
			else
			lua_thread.create(function()
			sampSendChat('/reoff')  
			wait(500)
			setCharCoordinates(PLAYER_PED, x, y, z + 1)
			sampAddChatMessage(("[AdminTools] Вы телепортировали игрока из слежки на ближайшую от Вас дорогу (%dm.)"):format(dist), 0xAAFFAA)
			wait(500)
			sampSendChat('/gethere '..spec_id)
			end)
			end
		else
			sampAddChatMessage("[AdminTools] Не нашлось ни одной дороги поблизости", 0xFFAAAA)
		end
end

function checkKey()
sampAddChatMessage(tag..'/'..klavisha..' {FF69B4}- Открыть меню настроек скрипта', -1)
sampAddChatMessage(tag..'/helpa {FF69B4}- Список команд скрипта', -1)
sampAddChatMessage(tag..'Разработчик: {FF69B4}Саша Гожельников *gozhelniikov', -1)
sampAddChatMessage(tag..'Для получения дополнительной информации по скрипту, посетите сайт: {FF69B4}t.me/raksamplua', -1)
sampAddChatMessage(tag..'Этот скрипт работает только на: {FF69B4}ARIZONA ARENA', -1)
end

