package com.speedEngine.speedBones.utils
{
   import com.adobe.utils.AGALMiniAssembler;
   import flash.display3D.Context3D;
   import flash.display3D.Program3D;
   
   public class AGALPrograms
   {
      
      private static const POINT_XYAGAL:String = "mul vt1.xyzw vt0.xyxy, vc1.wxzy\nadd vt0.xy vt1.xz, vt1.yw      \nmul vt0.xy vc0.xy vt0.xy       \nadd vt0.xy vc0.zw vt0.xy       \n";
      
      private static const ALPHA_AGAL:String = "mul oc, ft0.xyzw, fc20.xxxx    \n";
      
      private static const RGBA_AGAL:String = "tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n";
      
      private static const DXT1_AGAL:String = "tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n";
      
      private static const DXT5_AGAL:String = "tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n";
      
      private var _context3d:Context3D;
      
      private var _programDxt5:Program3D;
      
      private var _programDxt1:Program3D;
      
      private var _programRGBA:Program3D;
      
      private var _vagal:AGALMiniAssembler;
      
      private var _fagal:AGALMiniAssembler;
      
      private var _fagalStr:String;
      
      private var _vagalStr:String;
      
      public function AGALPrograms(param1:Context3D, param2:Array, param3:Array, param4:Array, param5:Array, param6:Array)
      {
         var _loc7_:Array = null;
         super();
         _context3d = param1;
         _vagalStr = "mov vt0, va0  \nmul vt1.xyzw vt0.xyxy, vc1.wxzy\nadd vt0.xy vt1.xz, vt1.yw      \nmul vt0.xy vc0.xy vt0.xy       \nadd vt0.xy vc0.zw vt0.xy       \nmov op vt0 \nmov v0, va1";
         _fagalStr = "mul ft0 ft0 fc16 \nadd ft0 ft0 fc17 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assemble(_vagalStr,"tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param2.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param2.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param2.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nm44 ft0 ft0 fc10 \nadd ft0 ft0 fc14 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param2.push([_programDxt5,_programDxt1,_programRGBA]);
         _vagalStr = "mov vt0, va0 \nmul vt1.xyzw vt0.xyxy, vc1.wxzy\nadd vt0.xy vt1.xz, vt1.yw      \nmul vt0.xy vc0.xy vt0.xy       \nadd vt0.xy vc0.zw vt0.xy       \nmov op vt0 \nmov v0, va1";
         _fagalStr = "mul ft0 ft0 fc16 \nadd ft0 ft0 fc17 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assemble(_vagalStr,"tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param2.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param2.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param2.push([_programDxt5,_programDxt1],_programRGBA);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nm44 ft0 ft0 fc10 \nadd ft0 ft0 fc14 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param2.push([_programDxt5,_programDxt1,_programRGBA]);
         _vagalStr = "mov vt0, va0  \nmul vt1.xyzw vt0.xyxy, vc1.wxzy\nadd vt0.xy vt1.xz, vt1.yw      \nmul vt0.xy vc0.xy vt0.xy       \nadd vt0.xy vc0.zw vt0.xy       \nmov op vt0 \nmov v0, va1";
         _fagalStr = "mul ft0 ft0 fc16 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assemble(_vagalStr,"tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param3.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param3.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param3.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nm44 ft0 ft0 fc10 \nadd ft0 ft0 fc14 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param3.push([_programDxt5,_programDxt1,_programRGBA]);
         _vagalStr = "mov vt0, va0 \nmul vt1.xyzw vt0.xyxy, vc1.wxzy\nadd vt0.xy vt1.xz, vt1.yw      \nmul vt0.xy vc0.xy vt0.xy       \nadd vt0.xy vc0.zw vt0.xy       \nmov op vt0 \nmov v0, va1";
         _fagalStr = "mul ft0 ft0 fc16 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assemble(_vagalStr,"tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param3.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param3.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param3.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nm44 ft0 ft0 fc10 \nadd ft0 ft0 fc14 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param3.push([_programDxt5,_programDxt1,_programRGBA]);
         _vagalStr = "mov vt0, va0  \nmul vt1.xyzw vt0.xyxy, vc1.wxzy\nadd vt0.xy vt1.xz, vt1.yw      \nmul vt0.xy vc0.xy vt0.xy       \nadd vt0.xy vc0.zw vt0.xy       \nmov op vt0 \nmov v0, va1";
         _fagalStr = "add ft0 ft0 fc16 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assemble(_vagalStr,"tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param4.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param4.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param4.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nm44 ft0 ft0 fc10 \nadd ft0 ft0 fc14 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param4.push([_programDxt5,_programDxt1,_programRGBA]);
         _vagalStr = "mov vt0, va0 \nmul vt1.xyzw vt0.xyxy, vc1.wxzy\nadd vt0.xy vt1.xz, vt1.yw      \nmul vt0.xy vc0.xy vt0.xy       \nadd vt0.xy vc0.zw vt0.xy       \nmov op vt0 \nmov v0, va1";
         _fagalStr = "add ft0 ft0 fc16 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assemble(_vagalStr,"tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param4.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param4.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param4.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nm44 ft0 ft0 fc10 \nadd ft0 ft0 fc14 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param4.push([_programDxt5,_programDxt1,_programRGBA]);
         _vagalStr = "mov vt0, va0  \nmul vt1.xyzw vt0.xyxy, vc1.wxzy\nadd vt0.xy vt1.xz, vt1.yw      \nmul vt0.xy vc0.xy vt0.xy       \nadd vt0.xy vc0.zw vt0.xy       \nmov op vt0 \nmov v0, va1";
         _fagalStr = "mul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assemble(_vagalStr,"tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param5.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param5.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param5.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nm44 ft0 ft0 fc10 \nadd ft0 ft0 fc14 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param5.push([_programDxt5,_programDxt1,_programRGBA]);
         _vagalStr = "mov vt0, va0 \nmul vt1.xyzw vt0.xyxy, vc1.wxzy\nadd vt0.xy vt1.xz, vt1.yw      \nmul vt0.xy vc0.xy vt0.xy       \nadd vt0.xy vc0.zw vt0.xy       \nmov op vt0 \nmov v0, va1";
         _fagalStr = "mul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assemble(_vagalStr,"tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param5.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param5.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param5.push([_programDxt5,_programDxt1,_programRGBA]);
         _fagalStr = "m44 ft0 ft0 fc0 \nadd ft0 ft0 fc4 \nm44 ft0 ft0 fc5 \nadd ft0 ft0 fc9 \nm44 ft0 ft0 fc10 \nadd ft0 ft0 fc14 \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         _programDxt5 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt5,linear,nomip> \n" + _fagalStr);
         _programDxt1 = assembleFagal("tex ft0, v0, fs0 <2d,repeat,dxt1,linear,nomip> \n" + _fagalStr);
         _programRGBA = assembleFagal("tex ft0, v0, fs0 <2d,repeat,linear,nomip> \n" + _fagalStr);
         param5.push([_programDxt5,_programDxt1,_programRGBA]);
         _loc7_ = createQuadProgram();
         _programDxt5 = assemble(_loc7_[0],_loc7_[1]);
         param5.push(_programDxt5);
         _loc7_ = createProgram("dxt5,",false);
         _programDxt5 = assemble(_loc7_[0],_loc7_[1]);
         _loc7_ = createProgram("dxt1,",false);
         _programDxt1 = assemble(_loc7_[0],_loc7_[1]);
         _loc7_ = createProgram("",false);
         _programRGBA = assemble(_loc7_[0],_loc7_[1]);
         param6.push([_programDxt5,_programDxt1,_programRGBA]);
         _loc7_ = createProgram("dxt5,",true);
         _programDxt5 = assemble(_loc7_[0],_loc7_[1]);
         _loc7_ = createProgram("dxt1,",true);
         _programDxt1 = assemble(_loc7_[0],_loc7_[1]);
         _loc7_ = createProgram("",true);
         _programRGBA = assemble(_loc7_[0],_loc7_[1]);
         param6.push([_programDxt5,_programDxt1,_programRGBA]);
         _loc7_ = createRenderProgramBGRA(false);
         _programDxt5 = assemble(_loc7_[0],_loc7_[1]);
         param6.push(_programDxt5);
         _loc7_ = createRenderProgramBGRA(true);
         _programDxt5 = assemble(_loc7_[0],_loc7_[1]);
         param6.push(_programDxt5);
      }
      
      private function assemble(param1:String, param2:String) : Program3D
      {
         _vagal = new AGALMiniAssembler();
         _vagal.assemble("vertex",param1);
         _fagal = new AGALMiniAssembler();
         _fagal.assemble("fragment",param2);
         var _loc3_:Program3D = this._context3d.createProgram();
         _loc3_.upload(_vagal.agalcode,_fagal.agalcode);
         return _loc3_;
      }
      
      private function assembleFagal(param1:String) : Program3D
      {
         _fagal = new AGALMiniAssembler();
         _fagal.assemble("fragment",param1);
         var _loc2_:Program3D = this._context3d.createProgram();
         _loc2_.upload(_vagal.agalcode,_fagal.agalcode);
         return _loc2_;
      }
      
      private function createQuadProgram() : Array
      {
         var _loc1_:String = "mov vt0, va0               \nmov v0, va1                \nmul vt1.xyzw vt0.xyxy, vc1.wxzy\nadd vt0.xy vt1.xz, vt1.yw      \nmul vt0.xy vc0.xy vt0.xy       \nadd vt0.xy vc0.zw vt0.xy       \nmov op vt0                 \n";
         var _loc2_:String = "mov ft0, fc0               \nmul ft0.xyzw, ft0.xyzw, fc20.xxxx \nmul oc, ft0.xyzw, fc20.xxxx    \n";
         return [_loc1_,_loc2_];
      }
      
      private function createRenderProgramBGRA(param1:Boolean) : Array
      {
         var _loc2_:String = "mov vt0, va0\nmov v0, va1 \nsub v1, va1, vc4.zwxx  \nsub v2, va1, vc4.xyxx  \nadd v3, va1, vc4.xyxx  \nadd v4, va1, vc4.zwxx  \nmov op vt0 \n";
         var _loc3_:String = "tex ft0,  v0, fs0 <2d,repeat,linear,nomip> \nmul ft5, ft0, fc0.xxxx                         \ntex ft1,  v1, fs0 <2d,repeat,linear,nomip> \nmul ft1, ft1, fc0.zzzz                         \nadd ft5, ft5, ft1                              \ntex ft2,  v2, fs0 <2d,repeat,linear,nomip> \nmul ft2, ft2, fc0.yyyy                         \nadd ft5, ft5, ft2                              \ntex ft3,  v3, fs0 <2d,repeat,linear,nomip> \nmul ft3, ft3, fc0.yyyy                         \nadd ft5, ft5, ft3                              \ntex ft4,  v4, fs0 <2d,repeat,linear,nomip> \nmul ft4, ft4, fc0.zzzz                         \nadd ft5, ft5, ft4                              \n";
         if(param1)
         {
            _loc3_ += "mul ft5.xyz, fc1.xyz, ft5.www                  \nmul oc, ft5, fc1.wwww                          \n";
         }
         else
         {
            _loc3_ += "mov  oc, ft5                              \n";
         }
         return [_loc2_,_loc3_];
      }
      
      private function createProgram(param1:String, param2:Boolean) : Array
      {
         var _loc3_:String = "mov vt0, va0  \nmul vt1.xyzw vt0.xyxy, vc1.wxzy\nadd vt0.xy vt1.xz, vt1.yw      \nmul vt0.xy vc0.xy vt0.xy       \nadd vt0.xy vc0.zw vt0.xy       \nmov v0, va1 \nsub v1, va1, vc4.zwxx  \nsub v2, va1, vc4.xyxx  \nadd v3, va1, vc4.xyxx  \nadd v4, va1, vc4.zwxx  \nmov op vt0 \n";
         var _loc4_:String = "tex ft0,  v0, fs0 <2d,repeat," + param1 + "linear,nomip> \n" + "mul ft5, ft0, fc0.xxxx                         \n" + "tex ft1,  v1, fs0 <2d,repeat," + param1 + "linear,nomip> \n" + "mul ft1, ft1, fc0.zzzz                         \n" + "add ft5, ft5, ft1                              \n" + "tex ft2,  v2, fs0 <2d,repeat," + param1 + "linear,nomip> \n" + "mul ft2, ft2, fc0.yyyy                         \n" + "add ft5, ft5, ft2                              \n" + "tex ft3,  v3, fs0 <2d,repeat," + param1 + "linear,nomip> \n" + "mul ft3, ft3, fc0.yyyy                         \n" + "add ft5, ft5, ft3                              \n";
         if(param1 != "dxt1,")
         {
            _loc4_ += "tex ft4,  v4, fs0 <2d,repeat," + param1 + "linear,nomip> \n" + "mul ft4, ft4, fc0.zzzz                         \n" + "add ft5, ft5, ft4                              \n";
         }
         if(param2)
         {
            _loc4_ += "mul ft5.xyz, fc1.xyz, ft5.www                  \nmul oc, ft5, fc1.wwww                          \n";
         }
         else
         {
            _loc4_ += "mov  oc, ft5                              \n";
         }
         return [_loc3_,_loc4_];
      }
   }
}

