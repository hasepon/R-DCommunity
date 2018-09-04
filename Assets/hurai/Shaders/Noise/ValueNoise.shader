Shader "Custom/Noise/Value"
{
	Properties
	{
		[HideInInspector]_MainTex ("Texture", 2D) = "white" {}
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
			#include "NoiseUtil.cginc"

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

			float valueNoise(fixed2 st)
			{
				fixed2 p = floor(st);
				fixed2 f = frac(st);

				float v00 = random(p + fixed2(0, 0));
				float v10 = random(p + fixed2(1, 0));
				float v01 = random(p + fixed2(0, 1));
				float v11 = random(p + fixed2(1, 1));

				fixed2 u = f * f * (3.0 - 2.0 * f);

				float v0010 = lerp(v00, v10, u.x);
				float v0111 = lerp(v01, v11, u.x);
				return lerp(v0010, v0111, u.y);
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
				float c = valueNoise(i.uv * _NoiseCount);

				return fixed4(c,c,c,1);
			}
			ENDCG
		}
	}
}
