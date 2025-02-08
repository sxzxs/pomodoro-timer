#Requires AutoHotkey v2.0 
#include <Direct2DRender>
#include <fmod>
#include <NTLCalc>
CoordMode "Mouse", "Screen"

g_font_size := 30
g_opacity := 0xBB

monitor_info := get_all_monitor_info()
g_all_clock := []
loop(1)
    g_all_clock.Push(Clock(monitor_info[A_Index]))

; music
system := FMOD_system()
system.FMOD_System_Init(32, FMOD_INIT_NORMAL := 0x00000000, extradriverdata := 0)
sound_map := Map()
;遍历文件 加载初始
Loop Files, A_ScriptDir '\music\*'
{
    sound_map[A_LoopFileName] := SoundObj(A_LoopFileName)
}

OnExit(exit)
;暂停
~^Del::
{
    for k,v in sound_map
    {
        if(v.is_load)
            v.channel.FMOD_Channel_SetPaused(true)
    }
}

play_sound(music_name, is_stop := false)
{
    if(!sound_map.Has(music_name))
    {
        MsgBox('没有这首音乐 :' A_ScriptDir '\music' music_name)
        return
    }
    if(!sound_map[music_name].is_load)
    {
        sound := FMOD_sound()
        channel := FMOD_channel()
        system.FMOD_System_CreateSound(A_ScriptDir '/music/' music_name, FMOD_DEFAULT := 0x0, 0, &sound)
        sound_map[music_name].channel := channel
        sound_map[music_name].sound := sound
        system.FMOD_System_PlaySound(sound_map[music_name].sound, 0, true, &channel)
        sound_map[music_name].is_load := true
    }
    sound_map[music_name].channel.FMOD_Channel_SetPosition(0)
    if(is_stop)
        sound_map[music_name].channel.FMOD_Channel_SetPaused(true)
    else
        sound_map[music_name].channel.FMOD_Channel_SetPaused(false)
}

exit(*)
{
    for k,v in sound_map
    {
        if(v.sound != '' && v.is_load)
            v.sound.FMOD_Sound_Release()
    }
    system.FMOD_System_Close()
    system.FMOD_System_Release()
}

class SoundObj
{
    __New(file_name) 
    {
        this.is_load := false
        this.music_file := file_name
        this.sound := ''
        this.channel := ''
    }
}

#HotIf is_hover()

^LButton::
{
    Clock.overlay.GetMousePos(&mx, &my)
    while(GetKeyState("LButton", "P"))
    {
        MouseGetPos(&sx, &sy)
        sx := sx - mx
        sy := sy - my
        g_all_clock[1].x := sx
        g_all_clock[1].y := sy
        g_all_clock[1].draw()
        Sleep(40)
    }
}

^RButton::
{
    A_TrayMenu.Show()
}
wheeldown::
{
    global g_opacity
    g_opacity := (g_opacity-10 < 1 ? 1 : g_opacity-10)
    return
}

wheelup::
{
    global g_opacity
    g_opacity := (g_opacity+10 > 255 ? 255 : g_opacity+10)
    return
}

^wheeldown::
{
    global g_font_size
    g_font_size := (g_font_size-1 < 1 ? 1 : g_font_size-1)
}

^wheelup::
{
    global g_font_size
    g_font_size := (g_font_size+1 > 100 ? 100 : g_font_size+1)
}
#HotIf

class Clock
{
    __New(monitor_info) 
    {
        this.overlay := Direct2DRender(0, 0, 50, 50)
        Clock.overlay := this.overlay
        this.monitor_info := monitor_info
        this.x := monitor_info.Left
        this.y := monitor_info.Top
        this.w := monitor_info.Right - monitor_info.Left
        this.h := monitor_info.Bottom - monitor_info.Top
        this.start_time := A_TickCount
        this.start_flag := false
        this.all_time := 900 ; 15min
        this.object_text := ""
        ;设置定时器
        SetTimer(ObjBindMethod(this, 'draw'), 40)

        ;创建托盘菜单
		this.tray_menue := A_TrayMenu
		this.tray_menue.Delete()
        this.tray_menue.Add("设置时间`t(&S)", (*) => (this.get_set_time(), this.start_flag := false, this.stop_play_music()))
        this.tray_menue.Add("设置目标`t(&A)", (*) => (this.get_object_text()))
        this.tray_menue.Add("开始计时`t(&T)", (*) => (this.start_flag := true, this.start_time := A_TickCount, this.stop_play_music()))
        this.tray_menue.Add("重置计时`t(&L)", (*) => (this.start_flag := false,  this.stop_play_music()))
        this.tray_menue.Add("停止播放`t(&P)", (*) => (this.stop_play_music()))
        this.tray_menue.Add()
        this.tray_menue.Add("重启`t(&R)", (*) => Reload())
        this.tray_menue.Add("退出`t(&X)", (*) => ExitApp())
        this.tray_menue.Default := "1&"
    }

    stop_play_music()
    {
        play_sound("菜鸟图库-央视新闻联播.mp3", true)
    }

    is_hover() => this.overlay.GetMousePos(&mx, &my)

    get_set_time()
    {
        IB := InputBox("请输入时间(秒):", "time", "w640 h200")
        if IB.Result != "Cancel"
            this.all_time := NTLCalc(IB.Value)
    }

    get_object_text()
    {
        IB := InputBox("请输入时间(秒):", "time", "w640 h200")
        if IB.Result != "Cancel"
            this.object_text := IB.Value
    }

    draw()
    {
        Critical
        ;剩余时间
        if(!this.start_flag)
            last_time := this.all_time
        else
            last_time := this.all_time - Ceil((A_TickCount - this.start_time) / 1000)

        if(last_time < 0)
        {
            if(this.start_flag)
                play_sound("菜鸟图库-央视新闻联播.mp3")
            this.start_flag := false
        }

        uijm := FormatSeconds(last_time)
        uijm .= ' ' this.object_text
        wh := this.overlay.GetTextWidthHeight(uijm, g_font_size, 'Courier')
        w := wh.width, h := wh.height
        this.overlay.SetPosition(this.x, this.y, w, h)
        if (this.overlay.BeginDraw()) 
        {
            this.overlay.FillRoundedRectangle(0, 0, w, h, 5, 5, g_opacity << 24)
            this.overlay.DrawText(uijm, 0, 0, g_font_size, 0xccFF0000, "Courier")
            this.overlay.EndDraw()
        }
    }
}

;MsgBox FormatSeconds(7384)  ; 7384 = 2 小时 + 3 分钟 + 4 秒. 它的结果: 2:03:04
FormatSeconds(NumberOfSeconds)  ; 把指定的秒数转换成 hh:mm:ss 格式.
{
    time := 19990101  ; 任意日期的 *午夜*.
    time := DateAdd(time, NumberOfSeconds, "Seconds")
    return NumberOfSeconds//3600 ":" FormatTime(time, "mm:ss")
    /*
    ; 和上面方法不同的是, 这里不支持超过 24 小时的秒数:
    return FormatTime(time, "h:mm:ss")
    */
}

is_hover()
{
    for k,v in g_all_clock
    {
        if(v.is_hover())
            return true
    }
    return false
}

get_all_monitor_info()
{
    screen_number := GetMonitorCount()
    arr_screen := []
    loop(screen_number)
    {
        info := GetMonitorInfo(A_Index)
        arr_screen.Push(info)
    }
    return arr_screen
}

GetMonitorCount()
{
	Monitors := MDMF_Enum()
	return Monitors['TotalCount']
}

GetMonitorInfo(MonitorNum)
{
	Monitors := MDMF_Enum()
	for k,v in Monitors 
	{
		if(IsObject(v) && v.HasOwnProp('num'))
		{
			if (v.Num = MonitorNum) 
			{
				return v
			}
		}
	}
}

GetPrimaryMonitor()
{
	Monitors := MDMF_Enum()
	for k,v in Monitors {
		if (v.Primary) {
			return v.Num
		}
	}
}
MDMF_Enum(HMON := "") {
	static EnumProc := CallbackCreate(MDMF_EnumProc)
	static Monitors := Map()

	if (HMON = "") { 	; new enumeration
		Monitors := Map("TotalCount", 0)
		if !DllCall("User32.dll\EnumDisplayMonitors", "Ptr", 0, "Ptr", 0, "Ptr", EnumProc, "Ptr", ObjPtr(Monitors), "Int")
			return False
	}

	return (HMON = "") ? Monitors : Monitors.HasKey(HMON) ? Monitors[HMON] : False
}
MDMF_EnumProc(HMON, HDC, PRECT, ObjectAddr) {
	Monitors := ObjFromPtrAddRef(ObjectAddr)

	Monitors[HMON] := MDMF_GetInfo(HMON)
	Monitors["TotalCount"]++
	if (Monitors[HMON].Primary) {
		Monitors["Primary"] := HMON
	}

	return true
}

MDMF_GetInfo(HMON) {
	MIEX := Buffer(40 + (32 << !!1))
	NumPut("UInt", MIEX.Size, MIEX, 0)
	if DllCall("User32.dll\GetMonitorInfo", "Ptr", HMON, "Ptr", MIEX.Ptr, "Int") {
		return {Name:      (Name := StrGet(MIEX.Ptr + 40, 32))  ; CCHDEVICENAME = 32
		      , Num:       RegExReplace(Name, ".*(\d+)$", "$1")
		      , Left:      NumGet(MIEX, 4, "Int")    ; display rectangle
		      , Top:       NumGet(MIEX, 8, "Int")    ; "
		      , Right:     NumGet(MIEX, 12, "Int")   ; "
		      , Bottom:    NumGet(MIEX, 16, "Int")   ; "
		      , WALeft:    NumGet(MIEX, 20, "Int")   ; work area
		      , WATop:     NumGet(MIEX, 24, "Int")   ; "
		      , WARight:   NumGet(MIEX, 28, "Int")   ; "
		      , WABottom:  NumGet(MIEX, 32, "Int")   ; "
		      , Primary:   NumGet(MIEX, 36, "UInt")} ; contains a non-zero value for the primary monitor.
	}
	return False
}