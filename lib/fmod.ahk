#Requires autohotkey v2+

Common_Init()
{
    DllCall('CoInitializeEx', 'ptr', 0, 'uint', COINIT_APARTMENTTHREADED := 0x2)
}

FMOD_str_buf(str, encoding)
{
    buf := buffer(strput(str, encoding))
    strput(str, buf, encoding)
    return buf
}
class FMOD_FUNC
{
    static __New() 
    {
        SplitPath(A_LineFile,,&dir)
        path := ""
        lib_path := dir
        if(A_IsCompiled)
        {
            path := (A_PtrSize == 4) ? A_ScriptDir . "\lib\dll_32\" : A_ScriptDir . "\lib\dll_64\"
            lib_path := A_ScriptDir . "\lib"
        }
        else
        {
            path := (A_PtrSize == 4) ? dir . "\dll_32\" : dir . "\dll_64\"
        }
        dllcall("SetDllDirectory", "Str", path)
		this.lib := DllCall("LoadLibrary", "Str", 'fmod64.dll',"ptr")
        ;===============================================================================================================
        this.FMOD_Memory_Initialize := this.GPA("FMOD_Memory_Initialize")
        this.FMOD_Memory_GetStats := this.GPA("FMOD_Memory_GetStats")
        this.FMOD_Debug_Initialize := this.GPA("FMOD_Debug_Initialize")
        this.FMOD_File_SetDiskBusy := this.GPA("FMOD_File_SetDiskBusy")
        this.FMOD_File_GetDiskBusy := this.GPA("FMOD_File_GetDiskBusy")
        this.FMOD_Thread_SetAttributes := this.GPA("FMOD_Thread_SetAttributes")
        this.FMOD_System_Create := this.GPA("FMOD_System_Create")
        this.FMOD_System_Release := this.GPA("FMOD_System_Release")
        this.FMOD_System_SetOutput := this.GPA("FMOD_System_SetOutput")
        this.FMOD_System_GetOutput := this.GPA("FMOD_System_GetOutput")
        this.FMOD_System_GetNumDrivers := this.GPA("FMOD_System_GetNumDrivers")
        this.FMOD_System_GetDriverInfo := this.GPA("FMOD_System_GetDriverInfo")
        this.FMOD_System_SetDriver := this.GPA("FMOD_System_SetDriver")
        this.FMOD_System_GetDriver := this.GPA("FMOD_System_GetDriver")
        this.FMOD_System_SetSoftwareChannels := this.GPA("FMOD_System_SetSoftwareChannels")
        this.FMOD_System_GetSoftwareChannels := this.GPA("FMOD_System_GetSoftwareChannels")
        this.FMOD_System_SetSoftwareFormat := this.GPA("FMOD_System_SetSoftwareFormat")
        this.FMOD_System_GetSoftwareFormat := this.GPA("FMOD_System_GetSoftwareFormat")
        this.FMOD_System_SetDSPBufferSize := this.GPA("FMOD_System_SetDSPBufferSize")
        this.FMOD_System_GetDSPBufferSize := this.GPA("FMOD_System_GetDSPBufferSize")
        this.FMOD_System_SetFileSystem := this.GPA("FMOD_System_SetFileSystem")
        this.FMOD_System_AttachFileSystem := this.GPA("FMOD_System_AttachFileSystem")
        this.FMOD_System_SetAdvancedSettings := this.GPA("FMOD_System_SetAdvancedSettings")
        this.FMOD_System_GetAdvancedSettings := this.GPA("FMOD_System_GetAdvancedSettings")
        this.FMOD_System_SetCallback := this.GPA("FMOD_System_SetCallback")
        this.FMOD_System_SetPluginPath := this.GPA("FMOD_System_SetPluginPath")
        this.FMOD_System_LoadPlugin := this.GPA("FMOD_System_LoadPlugin")
        this.FMOD_System_UnloadPlugin := this.GPA("FMOD_System_UnloadPlugin")
        this.FMOD_System_GetNumNestedPlugins := this.GPA("FMOD_System_GetNumNestedPlugins")
        this.FMOD_System_GetNestedPlugin := this.GPA("FMOD_System_GetNestedPlugin")
        this.FMOD_System_GetNumPlugins := this.GPA("FMOD_System_GetNumPlugins")
        this.FMOD_System_GetPluginHandle := this.GPA("FMOD_System_GetPluginHandle")
        this.FMOD_System_GetPluginInfo := this.GPA("FMOD_System_GetPluginInfo")
        this.FMOD_System_SetOutputByPlugin := this.GPA("FMOD_System_SetOutputByPlugin")
        this.FMOD_System_GetOutputByPlugin := this.GPA("FMOD_System_GetOutputByPlugin")
        this.FMOD_System_CreateDSPByPlugin := this.GPA("FMOD_System_CreateDSPByPlugin")
        this.FMOD_System_GetDSPInfoByPlugin := this.GPA("FMOD_System_GetDSPInfoByPlugin")
        this.FMOD_System_RegisterCodec := this.GPA("FMOD_System_RegisterCodec")
        this.FMOD_System_RegisterDSP := this.GPA("FMOD_System_RegisterDSP")
        this.FMOD_System_RegisterOutput := this.GPA("FMOD_System_RegisterOutput")
        this.FMOD_System_Init := this.GPA("FMOD_System_Init")
        this.FMOD_System_Close := this.GPA("FMOD_System_Close")
        this.FMOD_System_Update := this.GPA("FMOD_System_Update")
        this.FMOD_System_SetSpeakerPosition := this.GPA("FMOD_System_SetSpeakerPosition")
        this.FMOD_System_GetSpeakerPosition := this.GPA("FMOD_System_GetSpeakerPosition")
        this.FMOD_System_SetStreamBufferSize := this.GPA("FMOD_System_SetStreamBufferSize")
        this.FMOD_System_GetStreamBufferSize := this.GPA("FMOD_System_GetStreamBufferSize")
        this.FMOD_System_Set3DSettings := this.GPA("FMOD_System_Set3DSettings")
        this.FMOD_System_Get3DSettings := this.GPA("FMOD_System_Get3DSettings")
        this.FMOD_System_Set3DNumListeners := this.GPA("FMOD_System_Set3DNumListeners")
        this.FMOD_System_Get3DNumListeners := this.GPA("FMOD_System_Get3DNumListeners")
        this.FMOD_System_Set3DListenerAttributes := this.GPA("FMOD_System_Set3DListenerAttributes")
        this.FMOD_System_Get3DListenerAttributes := this.GPA("FMOD_System_Get3DListenerAttributes")
        this.FMOD_System_Set3DRolloffCallback := this.GPA("FMOD_System_Set3DRolloffCallback")
        this.FMOD_System_MixerSuspend := this.GPA("FMOD_System_MixerSuspend")
        this.FMOD_System_MixerResume := this.GPA("FMOD_System_MixerResume")
        this.FMOD_System_GetDefaultMixMatrix := this.GPA("FMOD_System_GetDefaultMixMatrix")
        this.FMOD_System_GetSpeakerModeChannels := this.GPA("FMOD_System_GetSpeakerModeChannels")
        this.FMOD_System_GetVersion := this.GPA("FMOD_System_GetVersion")
        this.FMOD_System_GetOutputHandle := this.GPA("FMOD_System_GetOutputHandle")
        this.FMOD_System_GetChannelsPlaying := this.GPA("FMOD_System_GetChannelsPlaying")
        this.FMOD_System_GetCPUUsage := this.GPA("FMOD_System_GetCPUUsage")
        this.FMOD_System_GetFileUsage := this.GPA("FMOD_System_GetFileUsage")
        this.FMOD_System_CreateSound := this.GPA("FMOD_System_CreateSound")
        this.FMOD_System_CreateStream := this.GPA("FMOD_System_CreateStream")
        this.FMOD_System_CreateDSP := this.GPA("FMOD_System_CreateDSP")
        this.FMOD_System_CreateDSPByType := this.GPA("FMOD_System_CreateDSPByType")
        this.FMOD_System_CreateChannelGroup := this.GPA("FMOD_System_CreateChannelGroup")
        this.FMOD_System_CreateSoundGroup := this.GPA("FMOD_System_CreateSoundGroup")
        this.FMOD_System_CreateReverb3D := this.GPA("FMOD_System_CreateReverb3D")
        this.FMOD_System_PlaySound := this.GPA("FMOD_System_PlaySound")
        this.FMOD_System_PlayDSP := this.GPA("FMOD_System_PlayDSP")
        this.FMOD_System_GetChannel := this.GPA("FMOD_System_GetChannel")
        this.FMOD_System_GetDSPInfoByType := this.GPA("FMOD_System_GetDSPInfoByType")
        this.FMOD_System_GetMasterChannelGroup := this.GPA("FMOD_System_GetMasterChannelGroup")
        this.FMOD_System_GetMasterSoundGroup := this.GPA("FMOD_System_GetMasterSoundGroup")
        this.FMOD_System_AttachChannelGroupToPort := this.GPA("FMOD_System_AttachChannelGroupToPort")
        this.FMOD_System_DetachChannelGroupFromPort := this.GPA("FMOD_System_DetachChannelGroupFromPort")
        this.FMOD_System_SetReverbProperties := this.GPA("FMOD_System_SetReverbProperties")
        this.FMOD_System_GetReverbProperties := this.GPA("FMOD_System_GetReverbProperties")
        this.FMOD_System_LockDSP := this.GPA("FMOD_System_LockDSP")
        this.FMOD_System_UnlockDSP := this.GPA("FMOD_System_UnlockDSP")
        this.FMOD_System_GetRecordNumDrivers := this.GPA("FMOD_System_GetRecordNumDrivers")
        this.FMOD_System_GetRecordDriverInfo := this.GPA("FMOD_System_GetRecordDriverInfo")
        this.FMOD_System_GetRecordPosition := this.GPA("FMOD_System_GetRecordPosition")
        this.FMOD_System_RecordStart := this.GPA("FMOD_System_RecordStart")
        this.FMOD_System_RecordStop := this.GPA("FMOD_System_RecordStop")
        this.FMOD_System_IsRecording := this.GPA("FMOD_System_IsRecording")
        this.FMOD_System_CreateGeometry := this.GPA("FMOD_System_CreateGeometry")
        this.FMOD_System_SetGeometrySettings := this.GPA("FMOD_System_SetGeometrySettings")
        this.FMOD_System_GetGeometrySettings := this.GPA("FMOD_System_GetGeometrySettings")
        this.FMOD_System_LoadGeometry := this.GPA("FMOD_System_LoadGeometry")
        this.FMOD_System_GetGeometryOcclusion := this.GPA("FMOD_System_GetGeometryOcclusion")
        this.FMOD_System_SetNetworkProxy := this.GPA("FMOD_System_SetNetworkProxy")
        this.FMOD_System_GetNetworkProxy := this.GPA("FMOD_System_GetNetworkProxy")
        this.FMOD_System_SetNetworkTimeout := this.GPA("FMOD_System_SetNetworkTimeout")
        this.FMOD_System_GetNetworkTimeout := this.GPA("FMOD_System_GetNetworkTimeout")
        this.FMOD_System_SetUserData := this.GPA("FMOD_System_SetUserData")
        this.FMOD_System_GetUserData := this.GPA("FMOD_System_GetUserData")
        this.FMOD_Sound_Release := this.GPA("FMOD_Sound_Release")
        this.FMOD_Sound_GetSystemObject := this.GPA("FMOD_Sound_GetSystemObject")
        this.FMOD_Sound_Lock := this.GPA("FMOD_Sound_Lock")
        this.FMOD_Sound_Unlock := this.GPA("FMOD_Sound_Unlock")
        this.FMOD_Sound_SetDefaults := this.GPA("FMOD_Sound_SetDefaults")
        this.FMOD_Sound_GetDefaults := this.GPA("FMOD_Sound_GetDefaults")
        this.FMOD_Sound_Set3DMinMaxDistance := this.GPA("FMOD_Sound_Set3DMinMaxDistance")
        this.FMOD_Sound_Get3DMinMaxDistance := this.GPA("FMOD_Sound_Get3DMinMaxDistance")
        this.FMOD_Sound_Set3DConeSettings := this.GPA("FMOD_Sound_Set3DConeSettings")
        this.FMOD_Sound_Get3DConeSettings := this.GPA("FMOD_Sound_Get3DConeSettings")
        this.FMOD_Sound_Set3DCustomRolloff := this.GPA("FMOD_Sound_Set3DCustomRolloff")
        this.FMOD_Sound_Get3DCustomRolloff := this.GPA("FMOD_Sound_Get3DCustomRolloff")
        this.FMOD_Sound_GetSubSound := this.GPA("FMOD_Sound_GetSubSound")
        this.FMOD_Sound_GetSubSoundParent := this.GPA("FMOD_Sound_GetSubSoundParent")
        this.FMOD_Sound_GetName := this.GPA("FMOD_Sound_GetName")
        this.FMOD_Sound_GetLength := this.GPA("FMOD_Sound_GetLength")
        this.FMOD_Sound_GetFormat := this.GPA("FMOD_Sound_GetFormat")
        this.FMOD_Sound_GetNumSubSounds := this.GPA("FMOD_Sound_GetNumSubSounds")
        this.FMOD_Sound_GetNumTags := this.GPA("FMOD_Sound_GetNumTags")
        this.FMOD_Sound_GetTag := this.GPA("FMOD_Sound_GetTag")
        this.FMOD_Sound_GetOpenState := this.GPA("FMOD_Sound_GetOpenState")
        this.FMOD_Sound_ReadData := this.GPA("FMOD_Sound_ReadData")
        this.FMOD_Sound_SeekData := this.GPA("FMOD_Sound_SeekData")
        this.FMOD_Sound_SetSoundGroup := this.GPA("FMOD_Sound_SetSoundGroup")
        this.FMOD_Sound_GetSoundGroup := this.GPA("FMOD_Sound_GetSoundGroup")
        this.FMOD_Sound_GetNumSyncPoints := this.GPA("FMOD_Sound_GetNumSyncPoints")
        this.FMOD_Sound_GetSyncPoint := this.GPA("FMOD_Sound_GetSyncPoint")
        this.FMOD_Sound_GetSyncPointInfo := this.GPA("FMOD_Sound_GetSyncPointInfo")
        this.FMOD_Sound_AddSyncPoint := this.GPA("FMOD_Sound_AddSyncPoint")
        this.FMOD_Sound_DeleteSyncPoint := this.GPA("FMOD_Sound_DeleteSyncPoint")
        this.FMOD_Sound_SetMode := this.GPA("FMOD_Sound_SetMode")
        this.FMOD_Sound_GetMode := this.GPA("FMOD_Sound_GetMode")
        this.FMOD_Sound_SetLoopCount := this.GPA("FMOD_Sound_SetLoopCount")
        this.FMOD_Sound_GetLoopCount := this.GPA("FMOD_Sound_GetLoopCount")
        this.FMOD_Sound_SetLoopPoints := this.GPA("FMOD_Sound_SetLoopPoints")
        this.FMOD_Sound_GetLoopPoints := this.GPA("FMOD_Sound_GetLoopPoints")
        this.FMOD_Sound_GetMusicNumChannels := this.GPA("FMOD_Sound_GetMusicNumChannels")
        this.FMOD_Sound_SetMusicChannelVolume := this.GPA("FMOD_Sound_SetMusicChannelVolume")
        this.FMOD_Sound_GetMusicChannelVolume := this.GPA("FMOD_Sound_GetMusicChannelVolume")
        this.FMOD_Sound_SetMusicSpeed := this.GPA("FMOD_Sound_SetMusicSpeed")
        this.FMOD_Sound_GetMusicSpeed := this.GPA("FMOD_Sound_GetMusicSpeed")
        this.FMOD_Sound_SetUserData := this.GPA("FMOD_Sound_SetUserData")
        this.FMOD_Sound_GetUserData := this.GPA("FMOD_Sound_GetUserData")
        this.FMOD_Channel_GetSystemObject := this.GPA("FMOD_Channel_GetSystemObject")
        this.FMOD_Channel_Stop := this.GPA("FMOD_Channel_Stop")
        this.FMOD_Channel_SetPaused := this.GPA("FMOD_Channel_SetPaused")
        this.FMOD_Channel_GetPaused := this.GPA("FMOD_Channel_GetPaused")
        this.FMOD_Channel_SetVolume := this.GPA("FMOD_Channel_SetVolume")
        this.FMOD_Channel_GetVolume := this.GPA("FMOD_Channel_GetVolume")
        this.FMOD_Channel_SetVolumeRamp := this.GPA("FMOD_Channel_SetVolumeRamp")
        this.FMOD_Channel_GetVolumeRamp := this.GPA("FMOD_Channel_GetVolumeRamp")
        this.FMOD_Channel_GetAudibility := this.GPA("FMOD_Channel_GetAudibility")
        this.FMOD_Channel_SetPitch := this.GPA("FMOD_Channel_SetPitch")
        this.FMOD_Channel_GetPitch := this.GPA("FMOD_Channel_GetPitch")
        this.FMOD_Channel_SetMute := this.GPA("FMOD_Channel_SetMute")
        this.FMOD_Channel_GetMute := this.GPA("FMOD_Channel_GetMute")
        this.FMOD_Channel_SetReverbProperties := this.GPA("FMOD_Channel_SetReverbProperties")
        this.FMOD_Channel_GetReverbProperties := this.GPA("FMOD_Channel_GetReverbProperties")
        this.FMOD_Channel_SetLowPassGain := this.GPA("FMOD_Channel_SetLowPassGain")
        this.FMOD_Channel_GetLowPassGain := this.GPA("FMOD_Channel_GetLowPassGain")
        this.FMOD_Channel_SetMode := this.GPA("FMOD_Channel_SetMode")
        this.FMOD_Channel_GetMode := this.GPA("FMOD_Channel_GetMode")
        this.FMOD_Channel_SetCallback := this.GPA("FMOD_Channel_SetCallback")
        this.FMOD_Channel_IsPlaying := this.GPA("FMOD_Channel_IsPlaying")
        this.FMOD_Channel_SetPan := this.GPA("FMOD_Channel_SetPan")
        this.FMOD_Channel_SetMixLevelsOutput := this.GPA("FMOD_Channel_SetMixLevelsOutput")
        this.FMOD_Channel_SetMixLevelsInput := this.GPA("FMOD_Channel_SetMixLevelsInput")
        this.FMOD_Channel_SetMixMatrix := this.GPA("FMOD_Channel_SetMixMatrix")
        this.FMOD_Channel_GetMixMatrix := this.GPA("FMOD_Channel_GetMixMatrix")
        this.FMOD_Channel_GetDSPClock := this.GPA("FMOD_Channel_GetDSPClock")
        this.FMOD_Channel_SetDelay := this.GPA("FMOD_Channel_SetDelay")
        this.FMOD_Channel_GetDelay := this.GPA("FMOD_Channel_GetDelay")
        this.FMOD_Channel_AddFadePoint := this.GPA("FMOD_Channel_AddFadePoint")
        this.FMOD_Channel_SetFadePointRamp := this.GPA("FMOD_Channel_SetFadePointRamp")
        this.FMOD_Channel_RemoveFadePoints := this.GPA("FMOD_Channel_RemoveFadePoints")
        this.FMOD_Channel_GetFadePoints := this.GPA("FMOD_Channel_GetFadePoints")
        this.FMOD_Channel_GetDSP := this.GPA("FMOD_Channel_GetDSP")
        this.FMOD_Channel_AddDSP := this.GPA("FMOD_Channel_AddDSP")
        this.FMOD_Channel_RemoveDSP := this.GPA("FMOD_Channel_RemoveDSP")
        this.FMOD_Channel_GetNumDSPs := this.GPA("FMOD_Channel_GetNumDSPs")
        this.FMOD_Channel_SetDSPIndex := this.GPA("FMOD_Channel_SetDSPIndex")
        this.FMOD_Channel_GetDSPIndex := this.GPA("FMOD_Channel_GetDSPIndex")
        this.FMOD_Channel_Set3DAttributes := this.GPA("FMOD_Channel_Set3DAttributes")
        this.FMOD_Channel_Get3DAttributes := this.GPA("FMOD_Channel_Get3DAttributes")
        this.FMOD_Channel_Set3DMinMaxDistance := this.GPA("FMOD_Channel_Set3DMinMaxDistance")
        this.FMOD_Channel_Get3DMinMaxDistance := this.GPA("FMOD_Channel_Get3DMinMaxDistance")
        this.FMOD_Channel_Set3DConeSettings := this.GPA("FMOD_Channel_Set3DConeSettings")
        this.FMOD_Channel_Get3DConeSettings := this.GPA("FMOD_Channel_Get3DConeSettings")
        this.FMOD_Channel_Set3DConeOrientation := this.GPA("FMOD_Channel_Set3DConeOrientation")
        this.FMOD_Channel_Get3DConeOrientation := this.GPA("FMOD_Channel_Get3DConeOrientation")
        this.FMOD_Channel_Set3DCustomRolloff := this.GPA("FMOD_Channel_Set3DCustomRolloff")
        this.FMOD_Channel_Get3DCustomRolloff := this.GPA("FMOD_Channel_Get3DCustomRolloff")
        this.FMOD_Channel_Set3DOcclusion := this.GPA("FMOD_Channel_Set3DOcclusion")
        this.FMOD_Channel_Get3DOcclusion := this.GPA("FMOD_Channel_Get3DOcclusion")
        this.FMOD_Channel_Set3DSpread := this.GPA("FMOD_Channel_Set3DSpread")
        this.FMOD_Channel_Get3DSpread := this.GPA("FMOD_Channel_Get3DSpread")
        this.FMOD_Channel_Set3DLevel := this.GPA("FMOD_Channel_Set3DLevel")
        this.FMOD_Channel_Get3DLevel := this.GPA("FMOD_Channel_Get3DLevel")
        this.FMOD_Channel_Set3DDopplerLevel := this.GPA("FMOD_Channel_Set3DDopplerLevel")
        this.FMOD_Channel_Get3DDopplerLevel := this.GPA("FMOD_Channel_Get3DDopplerLevel")
        this.FMOD_Channel_Set3DDistanceFilter := this.GPA("FMOD_Channel_Set3DDistanceFilter")
        this.FMOD_Channel_Get3DDistanceFilter := this.GPA("FMOD_Channel_Get3DDistanceFilter")
        this.FMOD_Channel_SetUserData := this.GPA("FMOD_Channel_SetUserData")
        this.FMOD_Channel_GetUserData := this.GPA("FMOD_Channel_GetUserData")
        this.FMOD_Channel_SetFrequency := this.GPA("FMOD_Channel_SetFrequency")
        this.FMOD_Channel_GetFrequency := this.GPA("FMOD_Channel_GetFrequency")
        this.FMOD_Channel_SetPriority := this.GPA("FMOD_Channel_SetPriority")
        this.FMOD_Channel_GetPriority := this.GPA("FMOD_Channel_GetPriority")
        this.FMOD_Channel_SetPosition := this.GPA("FMOD_Channel_SetPosition")
        this.FMOD_Channel_GetPosition := this.GPA("FMOD_Channel_GetPosition")
        this.FMOD_Channel_SetChannelGroup := this.GPA("FMOD_Channel_SetChannelGroup")
        this.FMOD_Channel_GetChannelGroup := this.GPA("FMOD_Channel_GetChannelGroup")
        this.FMOD_Channel_SetLoopCount := this.GPA("FMOD_Channel_SetLoopCount")
        this.FMOD_Channel_GetLoopCount := this.GPA("FMOD_Channel_GetLoopCount")
        this.FMOD_Channel_SetLoopPoints := this.GPA("FMOD_Channel_SetLoopPoints")
        this.FMOD_Channel_GetLoopPoints := this.GPA("FMOD_Channel_GetLoopPoints")
        this.FMOD_Channel_IsVirtual := this.GPA("FMOD_Channel_IsVirtual")
        this.FMOD_Channel_GetCurrentSound := this.GPA("FMOD_Channel_GetCurrentSound")
        this.FMOD_Channel_GetIndex := this.GPA("FMOD_Channel_GetIndex")
        this.FMOD_ChannelGroup_GetSystemObject := this.GPA("FMOD_ChannelGroup_GetSystemObject")
        this.FMOD_ChannelGroup_Stop := this.GPA("FMOD_ChannelGroup_Stop")
        this.FMOD_ChannelGroup_SetPaused := this.GPA("FMOD_ChannelGroup_SetPaused")
        this.FMOD_ChannelGroup_GetPaused := this.GPA("FMOD_ChannelGroup_GetPaused")
        this.FMOD_ChannelGroup_SetVolume := this.GPA("FMOD_ChannelGroup_SetVolume")
        this.FMOD_ChannelGroup_GetVolume := this.GPA("FMOD_ChannelGroup_GetVolume")
        this.FMOD_ChannelGroup_SetVolumeRamp := this.GPA("FMOD_ChannelGroup_SetVolumeRamp")
        this.FMOD_ChannelGroup_GetVolumeRamp := this.GPA("FMOD_ChannelGroup_GetVolumeRamp")
        this.FMOD_ChannelGroup_GetAudibility := this.GPA("FMOD_ChannelGroup_GetAudibility")
        this.FMOD_ChannelGroup_SetPitch := this.GPA("FMOD_ChannelGroup_SetPitch")
        this.FMOD_ChannelGroup_GetPitch := this.GPA("FMOD_ChannelGroup_GetPitch")
        this.FMOD_ChannelGroup_SetMute := this.GPA("FMOD_ChannelGroup_SetMute")
        this.FMOD_ChannelGroup_GetMute := this.GPA("FMOD_ChannelGroup_GetMute")
        this.FMOD_ChannelGroup_SetReverbProperties := this.GPA("FMOD_ChannelGroup_SetReverbProperties")
        this.FMOD_ChannelGroup_GetReverbProperties := this.GPA("FMOD_ChannelGroup_GetReverbProperties")
        this.FMOD_ChannelGroup_SetLowPassGain := this.GPA("FMOD_ChannelGroup_SetLowPassGain")
        this.FMOD_ChannelGroup_GetLowPassGain := this.GPA("FMOD_ChannelGroup_GetLowPassGain")
        this.FMOD_ChannelGroup_SetMode := this.GPA("FMOD_ChannelGroup_SetMode")
        this.FMOD_ChannelGroup_GetMode := this.GPA("FMOD_ChannelGroup_GetMode")
        this.FMOD_ChannelGroup_SetCallback := this.GPA("FMOD_ChannelGroup_SetCallback")
        this.FMOD_ChannelGroup_IsPlaying := this.GPA("FMOD_ChannelGroup_IsPlaying")
        this.FMOD_ChannelGroup_SetPan := this.GPA("FMOD_ChannelGroup_SetPan")
        this.FMOD_ChannelGroup_SetMixLevelsOutput := this.GPA("FMOD_ChannelGroup_SetMixLevelsOutput")
        this.FMOD_ChannelGroup_SetMixLevelsInput := this.GPA("FMOD_ChannelGroup_SetMixLevelsInput")
        this.FMOD_ChannelGroup_SetMixMatrix := this.GPA("FMOD_ChannelGroup_SetMixMatrix")
        this.FMOD_ChannelGroup_GetMixMatrix := this.GPA("FMOD_ChannelGroup_GetMixMatrix")
        this.FMOD_ChannelGroup_GetDSPClock := this.GPA("FMOD_ChannelGroup_GetDSPClock")
        this.FMOD_ChannelGroup_SetDelay := this.GPA("FMOD_ChannelGroup_SetDelay")
        this.FMOD_ChannelGroup_GetDelay := this.GPA("FMOD_ChannelGroup_GetDelay")
        this.FMOD_ChannelGroup_AddFadePoint := this.GPA("FMOD_ChannelGroup_AddFadePoint")
        this.FMOD_ChannelGroup_SetFadePointRamp := this.GPA("FMOD_ChannelGroup_SetFadePointRamp")
        this.FMOD_ChannelGroup_RemoveFadePoints := this.GPA("FMOD_ChannelGroup_RemoveFadePoints")
        this.FMOD_ChannelGroup_GetFadePoints := this.GPA("FMOD_ChannelGroup_GetFadePoints")
        this.FMOD_ChannelGroup_GetDSP := this.GPA("FMOD_ChannelGroup_GetDSP")
        this.FMOD_ChannelGroup_AddDSP := this.GPA("FMOD_ChannelGroup_AddDSP")
        this.FMOD_ChannelGroup_RemoveDSP := this.GPA("FMOD_ChannelGroup_RemoveDSP")
        this.FMOD_ChannelGroup_GetNumDSPs := this.GPA("FMOD_ChannelGroup_GetNumDSPs")
        this.FMOD_ChannelGroup_SetDSPIndex := this.GPA("FMOD_ChannelGroup_SetDSPIndex")
        this.FMOD_ChannelGroup_GetDSPIndex := this.GPA("FMOD_ChannelGroup_GetDSPIndex")
        this.FMOD_ChannelGroup_Set3DAttributes := this.GPA("FMOD_ChannelGroup_Set3DAttributes")
        this.FMOD_ChannelGroup_Get3DAttributes := this.GPA("FMOD_ChannelGroup_Get3DAttributes")
        this.FMOD_ChannelGroup_Set3DMinMaxDistance := this.GPA("FMOD_ChannelGroup_Set3DMinMaxDistance")
        this.FMOD_ChannelGroup_Get3DMinMaxDistance := this.GPA("FMOD_ChannelGroup_Get3DMinMaxDistance")
        this.FMOD_ChannelGroup_Set3DConeSettings := this.GPA("FMOD_ChannelGroup_Set3DConeSettings")
        this.FMOD_ChannelGroup_Get3DConeSettings := this.GPA("FMOD_ChannelGroup_Get3DConeSettings")
        this.FMOD_ChannelGroup_Set3DConeOrientation := this.GPA("FMOD_ChannelGroup_Set3DConeOrientation")
        this.FMOD_ChannelGroup_Get3DConeOrientation := this.GPA("FMOD_ChannelGroup_Get3DConeOrientation")
        this.FMOD_ChannelGroup_Set3DCustomRolloff := this.GPA("FMOD_ChannelGroup_Set3DCustomRolloff")
        this.FMOD_ChannelGroup_Get3DCustomRolloff := this.GPA("FMOD_ChannelGroup_Get3DCustomRolloff")
        this.FMOD_ChannelGroup_Set3DOcclusion := this.GPA("FMOD_ChannelGroup_Set3DOcclusion")
        this.FMOD_ChannelGroup_Get3DOcclusion := this.GPA("FMOD_ChannelGroup_Get3DOcclusion")
        this.FMOD_ChannelGroup_Set3DSpread := this.GPA("FMOD_ChannelGroup_Set3DSpread")
        this.FMOD_ChannelGroup_Get3DSpread := this.GPA("FMOD_ChannelGroup_Get3DSpread")
        this.FMOD_ChannelGroup_Set3DLevel := this.GPA("FMOD_ChannelGroup_Set3DLevel")
        this.FMOD_ChannelGroup_Get3DLevel := this.GPA("FMOD_ChannelGroup_Get3DLevel")
        this.FMOD_ChannelGroup_Set3DDopplerLevel := this.GPA("FMOD_ChannelGroup_Set3DDopplerLevel")
        this.FMOD_ChannelGroup_Get3DDopplerLevel := this.GPA("FMOD_ChannelGroup_Get3DDopplerLevel")
        this.FMOD_ChannelGroup_Set3DDistanceFilter := this.GPA("FMOD_ChannelGroup_Set3DDistanceFilter")
        this.FMOD_ChannelGroup_Get3DDistanceFilter := this.GPA("FMOD_ChannelGroup_Get3DDistanceFilter")
        this.FMOD_ChannelGroup_SetUserData := this.GPA("FMOD_ChannelGroup_SetUserData")
        this.FMOD_ChannelGroup_GetUserData := this.GPA("FMOD_ChannelGroup_GetUserData")
        this.FMOD_ChannelGroup_Release := this.GPA("FMOD_ChannelGroup_Release")
        this.FMOD_ChannelGroup_AddGroup := this.GPA("FMOD_ChannelGroup_AddGroup")
        this.FMOD_ChannelGroup_GetNumGroups := this.GPA("FMOD_ChannelGroup_GetNumGroups")
        this.FMOD_ChannelGroup_GetGroup := this.GPA("FMOD_ChannelGroup_GetGroup")
        this.FMOD_ChannelGroup_GetParentGroup := this.GPA("FMOD_ChannelGroup_GetParentGroup")
        this.FMOD_ChannelGroup_GetName := this.GPA("FMOD_ChannelGroup_GetName")
        this.FMOD_ChannelGroup_GetNumChannels := this.GPA("FMOD_ChannelGroup_GetNumChannels")
        this.FMOD_ChannelGroup_GetChannel := this.GPA("FMOD_ChannelGroup_GetChannel")
        this.FMOD_SoundGroup_Release := this.GPA("FMOD_SoundGroup_Release")
        this.FMOD_SoundGroup_GetSystemObject := this.GPA("FMOD_SoundGroup_GetSystemObject")
        this.FMOD_SoundGroup_SetMaxAudible := this.GPA("FMOD_SoundGroup_SetMaxAudible")
        this.FMOD_SoundGroup_GetMaxAudible := this.GPA("FMOD_SoundGroup_GetMaxAudible")
        this.FMOD_SoundGroup_SetMaxAudibleBehavior := this.GPA("FMOD_SoundGroup_SetMaxAudibleBehavior")
        this.FMOD_SoundGroup_GetMaxAudibleBehavior := this.GPA("FMOD_SoundGroup_GetMaxAudibleBehavior")
        this.FMOD_SoundGroup_SetMuteFadeSpeed := this.GPA("FMOD_SoundGroup_SetMuteFadeSpeed")
        this.FMOD_SoundGroup_GetMuteFadeSpeed := this.GPA("FMOD_SoundGroup_GetMuteFadeSpeed")
        this.FMOD_SoundGroup_SetVolume := this.GPA("FMOD_SoundGroup_SetVolume")
        this.FMOD_SoundGroup_GetVolume := this.GPA("FMOD_SoundGroup_GetVolume")
        this.FMOD_SoundGroup_Stop := this.GPA("FMOD_SoundGroup_Stop")
        this.FMOD_SoundGroup_GetName := this.GPA("FMOD_SoundGroup_GetName")
        this.FMOD_SoundGroup_GetNumSounds := this.GPA("FMOD_SoundGroup_GetNumSounds")
        this.FMOD_SoundGroup_GetSound := this.GPA("FMOD_SoundGroup_GetSound")
        this.FMOD_SoundGroup_GetNumPlaying := this.GPA("FMOD_SoundGroup_GetNumPlaying")
        this.FMOD_SoundGroup_SetUserData := this.GPA("FMOD_SoundGroup_SetUserData")
        this.FMOD_SoundGroup_GetUserData := this.GPA("FMOD_SoundGroup_GetUserData")
        this.FMOD_DSP_Release := this.GPA("FMOD_DSP_Release")
        this.FMOD_DSP_GetSystemObject := this.GPA("FMOD_DSP_GetSystemObject")
        this.FMOD_DSP_AddInput := this.GPA("FMOD_DSP_AddInput")
        this.FMOD_DSP_DisconnectFrom := this.GPA("FMOD_DSP_DisconnectFrom")
        this.FMOD_DSP_DisconnectAll := this.GPA("FMOD_DSP_DisconnectAll")
        this.FMOD_DSP_GetNumInputs := this.GPA("FMOD_DSP_GetNumInputs")
        this.FMOD_DSP_GetNumOutputs := this.GPA("FMOD_DSP_GetNumOutputs")
        this.FMOD_DSP_GetInput := this.GPA("FMOD_DSP_GetInput")
        this.FMOD_DSP_GetOutput := this.GPA("FMOD_DSP_GetOutput")
        this.FMOD_DSP_SetActive := this.GPA("FMOD_DSP_SetActive")
        this.FMOD_DSP_GetActive := this.GPA("FMOD_DSP_GetActive")
        this.FMOD_DSP_SetBypass := this.GPA("FMOD_DSP_SetBypass")
        this.FMOD_DSP_GetBypass := this.GPA("FMOD_DSP_GetBypass")
        this.FMOD_DSP_SetWetDryMix := this.GPA("FMOD_DSP_SetWetDryMix")
        this.FMOD_DSP_GetWetDryMix := this.GPA("FMOD_DSP_GetWetDryMix")
        this.FMOD_DSP_SetChannelFormat := this.GPA("FMOD_DSP_SetChannelFormat")
        this.FMOD_DSP_GetChannelFormat := this.GPA("FMOD_DSP_GetChannelFormat")
        this.FMOD_DSP_GetOutputChannelFormat := this.GPA("FMOD_DSP_GetOutputChannelFormat")
        this.FMOD_DSP_Reset := this.GPA("FMOD_DSP_Reset")
        this.FMOD_DSP_SetCallback := this.GPA("FMOD_DSP_SetCallback")
        this.FMOD_DSP_SetParameterFloat := this.GPA("FMOD_DSP_SetParameterFloat")
        this.FMOD_DSP_SetParameterInt := this.GPA("FMOD_DSP_SetParameterInt")
        this.FMOD_DSP_SetParameterBool := this.GPA("FMOD_DSP_SetParameterBool")
        this.FMOD_DSP_SetParameterData := this.GPA("FMOD_DSP_SetParameterData")
        this.FMOD_DSP_GetParameterFloat := this.GPA("FMOD_DSP_GetParameterFloat")
        this.FMOD_DSP_GetParameterInt := this.GPA("FMOD_DSP_GetParameterInt")
        this.FMOD_DSP_GetParameterBool := this.GPA("FMOD_DSP_GetParameterBool")
        this.FMOD_DSP_GetParameterData := this.GPA("FMOD_DSP_GetParameterData")
        this.FMOD_DSP_GetNumParameters := this.GPA("FMOD_DSP_GetNumParameters")
        this.FMOD_DSP_GetParameterInfo := this.GPA("FMOD_DSP_GetParameterInfo")
        this.FMOD_DSP_GetDataParameterIndex := this.GPA("FMOD_DSP_GetDataParameterIndex")
        this.FMOD_DSP_ShowConfigDialog := this.GPA("FMOD_DSP_ShowConfigDialog")
        this.FMOD_DSP_GetInfo := this.GPA("FMOD_DSP_GetInfo")
        this.FMOD_DSP_GetType := this.GPA("FMOD_DSP_GetType")
        this.FMOD_DSP_GetIdle := this.GPA("FMOD_DSP_GetIdle")
        this.FMOD_DSP_SetUserData := this.GPA("FMOD_DSP_SetUserData")
        this.FMOD_DSP_GetUserData := this.GPA("FMOD_DSP_GetUserData")
        this.FMOD_DSP_SetMeteringEnabled := this.GPA("FMOD_DSP_SetMeteringEnabled")
        this.FMOD_DSP_GetMeteringEnabled := this.GPA("FMOD_DSP_GetMeteringEnabled")
        this.FMOD_DSP_GetMeteringInfo := this.GPA("FMOD_DSP_GetMeteringInfo")
        this.FMOD_DSP_GetCPUUsage := this.GPA("FMOD_DSP_GetCPUUsage")
        this.FMOD_DSPConnection_GetInput := this.GPA("FMOD_DSPConnection_GetInput")
        this.FMOD_DSPConnection_GetOutput := this.GPA("FMOD_DSPConnection_GetOutput")
        this.FMOD_DSPConnection_SetMix := this.GPA("FMOD_DSPConnection_SetMix")
        this.FMOD_DSPConnection_GetMix := this.GPA("FMOD_DSPConnection_GetMix")
        this.FMOD_DSPConnection_SetMixMatrix := this.GPA("FMOD_DSPConnection_SetMixMatrix")
        this.FMOD_DSPConnection_GetMixMatrix := this.GPA("FMOD_DSPConnection_GetMixMatrix")
        this.FMOD_DSPConnection_GetType := this.GPA("FMOD_DSPConnection_GetType")
        this.FMOD_DSPConnection_SetUserData := this.GPA("FMOD_DSPConnection_SetUserData")
        this.FMOD_DSPConnection_GetUserData := this.GPA("FMOD_DSPConnection_GetUserData")
        this.FMOD_Geometry_Release := this.GPA("FMOD_Geometry_Release")
        this.FMOD_Geometry_AddPolygon := this.GPA("FMOD_Geometry_AddPolygon")
        this.FMOD_Geometry_GetNumPolygons := this.GPA("FMOD_Geometry_GetNumPolygons")
        this.FMOD_Geometry_GetMaxPolygons := this.GPA("FMOD_Geometry_GetMaxPolygons")
        this.FMOD_Geometry_GetPolygonNumVertices := this.GPA("FMOD_Geometry_GetPolygonNumVertices")
        this.FMOD_Geometry_SetPolygonVertex := this.GPA("FMOD_Geometry_SetPolygonVertex")
        this.FMOD_Geometry_GetPolygonVertex := this.GPA("FMOD_Geometry_GetPolygonVertex")
        this.FMOD_Geometry_SetPolygonAttributes := this.GPA("FMOD_Geometry_SetPolygonAttributes")
        this.FMOD_Geometry_GetPolygonAttributes := this.GPA("FMOD_Geometry_GetPolygonAttributes")
        this.FMOD_Geometry_SetActive := this.GPA("FMOD_Geometry_SetActive")
        this.FMOD_Geometry_GetActive := this.GPA("FMOD_Geometry_GetActive")
        this.FMOD_Geometry_SetRotation := this.GPA("FMOD_Geometry_SetRotation")
        this.FMOD_Geometry_GetRotation := this.GPA("FMOD_Geometry_GetRotation")
        this.FMOD_Geometry_SetPosition := this.GPA("FMOD_Geometry_SetPosition")
        this.FMOD_Geometry_GetPosition := this.GPA("FMOD_Geometry_GetPosition")
        this.FMOD_Geometry_SetScale := this.GPA("FMOD_Geometry_SetScale")
        this.FMOD_Geometry_GetScale := this.GPA("FMOD_Geometry_GetScale")
        this.FMOD_Geometry_Save := this.GPA("FMOD_Geometry_Save")
        this.FMOD_Geometry_SetUserData := this.GPA("FMOD_Geometry_SetUserData")
        this.FMOD_Geometry_GetUserData := this.GPA("FMOD_Geometry_GetUserData")
        this.FMOD_Reverb3D_Release := this.GPA("FMOD_Reverb3D_Release")
        this.FMOD_Reverb3D_Set3DAttributes := this.GPA("FMOD_Reverb3D_Set3DAttributes")
        this.FMOD_Reverb3D_Get3DAttributes := this.GPA("FMOD_Reverb3D_Get3DAttributes")
        this.FMOD_Reverb3D_SetProperties := this.GPA("FMOD_Reverb3D_SetProperties")
        this.FMOD_Reverb3D_GetProperties := this.GPA("FMOD_Reverb3D_GetProperties")
        this.FMOD_Reverb3D_SetActive := this.GPA("FMOD_Reverb3D_SetActive")
        this.FMOD_Reverb3D_GetActive := this.GPA("FMOD_Reverb3D_GetActive")
        this.FMOD_Reverb3D_SetUserData := this.GPA("FMOD_Reverb3D_SetUserData")
        this.FMOD_Reverb3D_GetUserData := this.GPA("FMOD_Reverb3D_GetUserData")
    }
	static GPA(function) 
    {
		return DllCall("GetProcAddress", 'Ptr', this.lib, 'AStr', function, 'Ptr')
	}
}

class FMOD_sound
{
    __New()
    {
        this.ptr := 0
    }
    FMOD_Sound_GetNumSubSounds(&numsubsounds)
    {
        rtn := DllCall(FMOD_FUNC.FMOD_Sound_GetNumSubSounds, 'ptr', this, 'int*', &numsubsounds, 'int')
        return rtn
    }
    FMOD_Sound_GetSubSound(index, &subsound)
    {
        rtn := DllCall(FMOD_FUNC.FMOD_Sound_GetSubSound, 'ptr', this, 'int', index, 'ptr*', &tp := 0, 'int')
        subsound.ptr := tp
        return rtn
    }
    FMOD_Sound_Release()
    {
        rtn := DllCall(FMOD_FUNC.FMOD_Sound_Release, 'ptr', this, 'int')
        return rtn
    }
    FMOD_Sound_SetMode(mode)
    {
        rtn := DllCall(FMOD_FUNC.FMOD_Sound_SetMode, 'ptr', this, mode)
    }
}
class FMOD_channel
{
    __New() 
    {
        this.ptr := 0
    }
    FMOD_Channel_GetPaused(&paused := 0)
    {
        rtn := DllCall(FMOD_FUNC.FMOD_Channel_GetPaused, 'ptr', this, 'int*', &paused, 'int')
        return rtn
    }
    FMOD_Channel_SetPaused(paused)
    {
        rtn := DllCall(FMOD_FUNC.FMOD_Channel_SetPaused, 'ptr', this, 'int', paused, 'int')
        return rtn
    }
    FMOD_Channel_SetPosition(position)
    {
        FMOD_TIMEUNIT_MS := 0x00000001
        rtn := DllCall(FMOD_FUNC.FMOD_Channel_SetPosition, 'ptr', this, 'uint', position, 'uint', FMOD_TIMEUNIT_MS)
        return rtn
    }
    FMOD_Channel_GetPosition(&position)
    {
        FMOD_TIMEUNIT_MS := 0x00000001
        rtn := DllCall(FMOD_FUNC.FMOD_Channel_GetPosition, 'ptr', this, 'uint*', &position, 'uint', FMOD_TIMEUNIT_MS)
        return rtn
    }
}

class FMOD_system
{
    __New(headerversion := 0x00020217) ;FMOD_VERSION    0x00020217
    {
        this.ptr := 0
        this.FMOD_System_Create(headerversion)
    }
    FMOD_System_Init(maxchannels, flags, extradriverdata)
    {
        rtn := DllCall(FMOD_FUNC.FMOD_System_Init, 'ptr', this, 'int', maxchannels, 'uint', extradriverdata, 'ptr', extradriverdata, 'int')
        return rtn
    }
    FMOD_System_SetStreamBufferSize(filebuffersize, filebuffersizetype)
    {
        rtn := DllCall(FMOD_FUNC.FMOD_System_SetStreamBufferSize, 'ptr', this, 'int', filebuffersize, 'uint', filebuffersizetype, 'int')
        return rtn
    }
    FMOD_System_Release()
    {
        rtn := DllCall(FMOD_FUNC.FMOD_System_Release, 'ptr', this, 'int')
        return rtn
    }
    FMOD_System_Create(headerversion)
    {
        rtn := DllCall(FMOD_FUNC.FMOD_System_Create, 'ptr*', &ptr := 0, 'uint', headerversion, 'int')
        this.ptr := ptr
        return rtn
    }
    FMOD_System_Close()
    {
        rtn := DllCall(FMOD_FUNC.FMOD_System_Close, 'ptr', this, 'int')
        return rtn
    }
    FMOD_System_CreateSound(name_or_data, mode, exinfo, &sound)
    {
        if(type(name_or_data) = 'String')
            name_or_data := FMOD_str_buf(name_or_data, 'UTf-8')
        rtn := DllCall(FMOD_FUNC.FMOD_System_CreateSound, 'ptr', this, 'ptr', name_or_data, 'int', mode, 'ptr', exinfo, 'ptr*', &ptr := 0, 'int')
        sound.ptr := ptr
        return rtn
    }
    FMOD_System_CreateStream(name_or_data, mode, exinfo, &sound)
    {
        if(type(name_or_data) = 'String')
            name_or_data := FMOD_str_buf(name_or_data, 'UTf-8')
        rtn := DllCall(FMOD_FUNC.FMOD_System_CreateStream, 'ptr', this, 'ptr', name_or_data, 'int', mode, 'ptr', exinfo, 'ptr*', &ptr := 0, 'int')
        sound.ptr := ptr
        return rtn
    }
    FMOD_System_PlaySound(sound, channelgroup, paused, &channel)
    {
        rtn := DllCall(FMOD_FUNC.FMOD_System_PlaySound, 'ptr', this, 'ptr', sound, 'ptr', channelgroup, 'int', paused, 'ptr*', &ptr := 0, 'int')
        channel.ptr := ptr
        return rtn
    }
}
/*
1>class FMOD_CREATESOUNDEXINFO	size(224):
1>	+---
1> 0	| cbsize
1> 4	| length
1> 8	| fileoffset
1>12	| numchannels
1>16	| defaultfrequency
1>20	| FMOD_SOUND_FORMAT format
1>24	| decodebuffersize
1>28	| initialsubsound
1>32	| numsubsounds
1>  	| <alignment member> (size=4)
1>40	| inclusionlist
1>48	| inclusionlistnum
1>  	| <alignment member> (size=4)
1>56	| pcmreadcallback
1>64	| pcmsetposcallback
1>72	| nonblockcallback
1>80	| dlsname
1>88	| encryptionkey
1>96	| maxpolyphony
1>  	| <alignment member> (size=4)
1>104	| userdata
1>112	| FMOD_SOUND_TYPE suggestedsoundtype
1>  	| <alignment member> (size=4)
1>120	| fileuseropen
1>128	| fileuserclose
1>136	| fileuserread
1>144	| fileuserseek
1>152	| fileuserasyncread
1>160	| fileuserasynccancel
1>168	| fileuserdata
1>176	| filebuffersize
1>180	| FMOD_CHANNELORDER channelorder
1>184	| initialsoundgroup
1>192	| initialseekposition
1>196	| initialseekpostype
1>200	| ignoresetfilesystem
1>204	| audioqueuepolicy
1>208	| minmidigranularity
1>212	| nonblockthreadid
1>216	| fsbguid
1>	+---
typedef struct FMOD_CREATESOUNDEXINFO
{
    int                            cbsize;
    unsigned int                   length;
    unsigned int                   fileoffset;
    int                            numchannels;
    int                            defaultfrequency;
    FMOD_SOUND_FORMAT              format;
    unsigned int                   decodebuffersize;
    int                            initialsubsound;
    int                            numsubsounds;
    int                           *inclusionlist;
    int                            inclusionlistnum;
    FMOD_SOUND_PCMREAD_CALLBACK    pcmreadcallback;
    FMOD_SOUND_PCMSETPOS_CALLBACK  pcmsetposcallback;
    FMOD_SOUND_NONBLOCK_CALLBACK   nonblockcallback;
    const char                    *dlsname;
    const char                    *encryptionkey;
    int                            maxpolyphony;
    void                          *userdata;
    FMOD_SOUND_TYPE                suggestedsoundtype;
    FMOD_FILE_OPEN_CALLBACK        fileuseropen;
    FMOD_FILE_CLOSE_CALLBACK       fileuserclose;
    FMOD_FILE_READ_CALLBACK        fileuserread;
    FMOD_FILE_SEEK_CALLBACK        fileuserseek;
    FMOD_FILE_ASYNCREAD_CALLBACK   fileuserasyncread;
    FMOD_FILE_ASYNCCANCEL_CALLBACK fileuserasynccancel;
    void                          *fileuserdata;
    int                            filebuffersize;
    FMOD_CHANNELORDER              channelorder;
    FMOD_SOUNDGROUP               *initialsoundgroup;
    unsigned int                   initialseekposition;
    FMOD_TIMEUNIT                  initialseekpostype;
    int                            ignoresetfilesystem;
    unsigned int                   audioqueuepolicy;
    unsigned int                   minmidigranularity;
    int                            nonblockthreadid;
    FMOD_GUID                     *fsbguid;
} FMOD_CREATESOUNDEXINFO;

*/