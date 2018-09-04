using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveChar : MonoBehaviour {

    htSpeaker Speaker;

    // Use this for initialization
    void Start () {
        Speaker = new htSpeaker("TestBgm");

        Speaker.PlaySound();
    }
	
	// Update is called once per frame
	void Update () {
        Speaker.PositionUpdate(transform.position);
    }

    void OnApplicationQuit()
    {
        Speaker.DeleteSpeaker();
    }

    void OnDisable()
    {
        Speaker.DeleteSpeaker();
    }

}
