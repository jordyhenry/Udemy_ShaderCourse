//Using the same logic that creates ToonRamp lighting, 
//apply the ramp image to the surface albedo in 
//the surface shader function using the normal and viewDir 
//to determine the uvs. The solution is attached.

Shader "Holistic/05 - Lighting/ToonRampChallenge" 
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
			float3 viewDir;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			float diff = dot(o.Normal, IN.viewDir);
			float h = diff * 0.5 + 0.5;
			float2 rh = h;
			float3 ramp = tex2D(_RampTex, rh).rgb;
			o.Albedo = _Color.rgb * ramp;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
