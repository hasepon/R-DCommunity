Shader "Custom/Noise/Block"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_NoiseCount("Noise Count", int) = 3
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }

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

			sampler2D _MainTex;
			float4 _MainTex_ST;

			int _NoiseCount;

			float randomNoise(fixed2 p)
			{
				return frac(sin(dot(p, fixed2(12.9898, 78.233))) * 43758.5453);
			}

			float noise(fixed2 n)
			{
				fixed2 p = floor(n);
				return randomNoise(p);
			}
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = noise(i.uv * _NoiseCount);
				return col;
			}
			ENDCG
		}
	}
}
