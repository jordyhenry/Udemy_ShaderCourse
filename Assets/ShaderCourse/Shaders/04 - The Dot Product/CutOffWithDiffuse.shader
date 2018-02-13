Shader "Holistic/04 - The Dot Product/CutOffWithDiffuse" {
	Properties
	{
		_myDiffuse("Diffuse Texture", 2D) = "white" {}
		_StripeColor1("Stripe 1 Color", Color) = (0,0,0,0)
		_StripeColor2("Stripe 2 Color", Color) = (0,0,0,0)
		_StripeSize("Stripe Size", Range(0,20)) = 1
	}

	SubShader 
	{
		CGPROGRAM
      #pragma surface surf Lambert

      sampler2D _myDiffuse;
      float4 _StripeColor1;
      float4 _StripeColor2;
      half _StripeSize;

      struct Input{
      	float2 uv_myDiffuse;
      	float3 viewDir;
      	float3 worldPos;
      };

      void surf (Input IN, inout SurfaceOutput o) {
      	o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
				half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
				o.Emission = frac(IN.worldPos.y*(_StripeSize) * 0.5) > 0.4 ? _StripeColor1*rim: _StripeColor2*rim;
      }
      ENDCG
	}
	FallBack "Diffuse"
}
