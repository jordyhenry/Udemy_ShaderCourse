Shader "Holistic/05 - Lighting/ToonRamp" 
{
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_RampTex("Ramp Texture", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue"="Geometry" }
		
		CGPROGRAM
		#pragma surface surf ToonRamp

		fixed4 _Color;
		sampler2D _RampTex;

		half4 LightingToonRamp (SurfaceOutput s, half3 lightDir, half atten)
		{
			//-1 to 1
			float diff = dot(s.Normal, lightDir);
			//0 to 1
			float h = diff * 0.5 + 0.5;
			float2 rh = h;
			float3 ramp = tex2D(_RampTex, rh).rgb;

			float4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
			c.a = s.Alpha;
			return c;
		}
		
		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = _Color.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
