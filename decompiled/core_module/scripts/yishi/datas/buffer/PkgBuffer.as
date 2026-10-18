package yishi.datas.buffer
{
   import yishi.comm.PackageIn;
   
   public class PkgBuffer
   {
      
      public var pkg:PackageIn;
      
      public var time:int;
      
      public var callBack:Function;
      
      public var leftTime:int;
      
      public function PkgBuffer(param1:PackageIn, param2:int, param3:Function, param4:int)
      {
         super();
         pkg = param1;
         time = param2;
         callBack = param3;
         leftTime = param4;
      }
   }
}

