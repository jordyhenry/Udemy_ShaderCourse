Shader "Holistic/04 - The Dot Product/DotProduct" 
{
	Properties
	{
		_mySlider("Question", Range(1,5))=1
	}
	SubShader {
		CGPROGRAM
      #pragma surface surf Lambert

      half _mySlider;

      struct Input
      {
      	float3 viewDir;
      };

      void surf (Input IN, inout SurfaceOutput o) {
      	int question = round(_mySlider);

      	if(question==1){
	      	//Question 1
					half dotp = dot(IN.viewDir, o.Normal);
					o.Albedo = float3(1, dotp, 1);
				}else if(question==2){
					//Question 2
					half dotp = 1 - dot(IN.viewDir, o.Normal);
					o.Albedo = float3(0, dotp, 1);
				}else if(question==3){
					//Question 3
					half dotp = dot(IN.viewDir, o.Normal);
					o.Albedo = float3(dotp, 1, 1-dotp);
				}else if(question==4){
					//Question 4
					half dotp = dot(IN.viewDir, o.Normal);
					o.Albedo.r = 1-dotp;
				}else if(question==5){
					//Question 5
					half dotp = dot(IN.viewDir, o.Normal);
					o.Albedo.gb = float2(1-dotp, 0);
				}
      }
      ENDCG
	}
	FallBack "Diffuse"
}
