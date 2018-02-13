Shader "Holistic/03 - Illuminating Surfaces/ViewNormals" 
{
	SubShader {
		CGPROGRAM
      #pragma surface surf Lambert

      struct Input{half t;};

      void surf (Input IN, inout SurfaceOutput o) {
				o.Albedo = o.Normal.rgb;
      }
      ENDCG
	}
	FallBack "Diffuse"
}
