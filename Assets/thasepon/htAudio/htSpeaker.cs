using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;
using System;

public class htSpeaker : MonoBehaviour{

    // DLL宣言一覧
    [DllImport("OpenAL_Engine", CharSet = CharSet.Unicode)]
    public static extern IntPtr htaSpeakerCreateName([MarshalAs(UnmanagedType.LPWStr)]string filepath, [MarshalAs(UnmanagedType.LPWStr)]string soundname);
    [DllImport("OpenAL_Engine")]
    public static extern void htaSpeakerDelete(IntPtr instance);

    [DllImport("OpenAL_Engine")]
    public static extern bool Play(IntPtr instance);
    [DllImport("OpenAL_Engine")]
    public static extern bool Stop(IntPtr instance);
    [DllImport("OpenAL_Engine")]
    public static extern bool Pause(IntPtr instance);

    [DllImport("OpenAL_Engine")]
    public static extern void htaSpeakerPosition(IntPtr instance, float x, float y, float z);
    [DllImport("OpenAL_Engine")]
    public static extern void htaSpeakerVelocity(IntPtr instance, float x, float y, float z);
    [DllImport("OpenAL_Engine")]
    public static extern void htaSpeakerDirection(IntPtr instance,float x, float y, float z);

    [DllImport("OpenAL_Engine")]
    public static extern void htaSpeakerSetConeOuterGain(IntPtr instance,float val);
    [DllImport("OpenAL_Engine")]
    public static extern void htaSpeakerSetConeInnerAngle(IntPtr instance, float val);
    [DllImport("OpenAL_Engine")]
    public static extern void htaSpeakerSetConeOuterAngle(IntPtr instance, float val);

    [DllImport("OpenAL_Engine")]
    public static extern float htaSpeakerGetConeOuterGain(IntPtr instance);
    [DllImport("OpenAL_Engine")]
    public static extern float htaSpeakerGetConeInnerAngle(IntPtr instance);
    [DllImport("OpenAL_Engine")]
    public static extern float htaSpeakerGetConeOuterAngle(IntPtr instance);

    // DLL宣言終了

    // dll[speaker] pointer
    IntPtr SpeakerPtr = IntPtr.Zero;
    // xml,soundfile root path
    string DataPath = "J:\\UnityProj\\PluginTest\\Data";
    // use sound name
    string SoundName;

    float OuterGain = 0;
    float innerAngle = 0;
    float outerAngle = 0;

    public float InnerAngle { get { return innerAngle; } }
    public float OuterAngle { get { return outerAngle; } }


    /// <summary>
    /// コンストラクタ
    /// 使用するサウンドの音声を送ってね
    /// </summary>
    /// <param name="SN">use registname</param>
    public htSpeaker(string SN)
    {
        if (SpeakerPtr == IntPtr.Zero)
        {
            SoundName = SN;
            SpeakerPtr = htaSpeakerCreateName(DataPath, SoundName);
        }
    }

    /// <summary>
    /// position update
    /// </summary>
    /// <param name="vector">now position</param>
	public void PositionUpdate (Vector3 vector)
    {
        if (SpeakerPtr != IntPtr.Zero)
        {
            htaSpeakerPosition(SpeakerPtr, vector.x, vector.y, vector.z);
        }
    }

    /// <summary>
    /// End Use Speaker
    /// Don't Reuse
    /// Please Call to OnApplicationQuit()
    /// </summary>
    public void DeleteSpeaker()
    {
        if (SpeakerPtr != IntPtr.Zero)
        {
            htaSpeakerDelete(SpeakerPtr);
            SpeakerPtr = IntPtr.Zero;
        }
    }

    /// <summary>
    /// PlaySound
    /// </summary>
    public void PlaySound()
    {
        if (SpeakerPtr != IntPtr.Zero)
        {
            Play(SpeakerPtr);
        }
    }

    /// <summary>
    /// PlaySound
    /// </summary>
    public void PlaySound( string soundName )
    {
        if (SpeakerPtr != IntPtr.Zero)
        {
            Play(SpeakerPtr);
        }
    }

    /// <summary>
    /// Stop to sound
    /// with a call to Play() for restart
    /// but rebooting is from the headbuffer
    /// </summary>
    public void StopSound()
    {
        if (SpeakerPtr != IntPtr.Zero)
        {
            Stop(SpeakerPtr);
        }
    }

    /// <summary>
    /// Pause to Sound
    /// Rebooting is from where it left off
    /// </summary>
    public void PauseSound()
    {
        if (SpeakerPtr != IntPtr.Zero)
        {
            Pause(SpeakerPtr);
        }
    }


}
