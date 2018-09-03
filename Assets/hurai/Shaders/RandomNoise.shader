﻿Shader "Custom/Noise/Random"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			float randomNoise(fixed2 p)
			{
				return frac(sin(dot(p, fixed2(12.9898, 78.233))) * 43758.5453);
			}

			sampler2D _MainTex;
			uniform float4 _MainTex_ST;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = randomNoise(i.uv);
				return col;
			}
			ENDCG
		}
	}
}
