using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class htAroundInfo : MonoBehaviour {

    // 固定Ray
    Ray ForwardRay;
    Ray BackRay;
    Ray RightRay;
    Ray LeftRay;
    Ray UpRay;
    Ray DownRay;

    // Use this for initialization
    void Start () {
        ForwardRay = new Ray(transform.position, transform.position);
        BackRay = new Ray(transform.position, -transform.forward);
        RightRay = new Ray(transform.position, transform.right);
        LeftRay = new Ray(transform.position, -transform.right);
        UpRay = new Ray(transform.position, transform.up);
        DownRay = new Ray(transform.position, -transform.up);
    }
	
	// Update is called once per frame
	void Update () {
		
	}
}
