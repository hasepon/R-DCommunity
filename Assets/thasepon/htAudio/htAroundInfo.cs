using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class htAroundInfo : MonoBehaviour {

    struct AroundInfo{
        Vector3 Hitpoint;
        Material HitObjMat;
        float Dist;
    };

    // レイの設定用変数
    enum RayDir
    {
        Forward = 0,
        Back,
        Right,
        Left,
        Up,
        Down,
        Navi,
        MAX_RAYDIR
    };
    Ray[] Rays;
    float RayDist = 1000.0f;
    RaycastHit hits;
    public LayerMask mask;
    
    // Use this for initialization
    void Start () {
        Rays = new Ray[(int)RayDir.MAX_RAYDIR];
    }
	
	// Update is called once per frame
	void Update () {

    }

    /// <summary>
    /// レイの更新用関数
    /// </summary>
    void RayUpdate()
    {
        // レイの向きの更新
        Rays[(int)RayDir.Forward].direction = transform.forward;
        Rays[(int)RayDir.Back].direction = -transform.forward;
        Rays[(int)RayDir.Right].direction = transform.right;
        Rays[(int)RayDir.Left].direction = -transform.right;
        Rays[(int)RayDir.Up].direction = transform.up;
        Rays[(int)RayDir.Down].direction = -transform.up;
        Rays[(int)RayDir.Navi].direction = transform.forward + (-transform.up);

        // レイのポジションの更新
        for (int i = 0; i < (int)RayDir.MAX_RAYDIR; i++)
        {
            Rays[i].origin = transform.position;
        }

        // ヒットしているレイの数値の保存
        for (int i = 0; i < (int)RayDir.MAX_RAYDIR; i++)
        {
            if (Physics.Raycast(Rays[i], out hits, RayDist, mask))
            {
                // レイの数値の保存
                Debug.Log(hits.transform.name);
                Debug.DrawRay(Rays[i].origin, Rays[i].direction, Color.green);
            }
        }

    }

}
