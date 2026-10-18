package com.pickgliss.utils
{
   import avmplus.getQualifiedClassName;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.setInterval;
   
   public class ObjectPool
   {
      
      private static var pools:Dictionary = new Dictionary();
      
      public function ObjectPool()
      {
         super();
         setInterval(checkGC,300000);
      }
      
      private static function getPool(param1:Class) : Array
      {
         if(param1 in pools)
         {
            return pools[param1];
         }
         pools[param1] = [];
         return pools[param1];
      }
      
      public static function getObject(param1:Class, param2:String = "", ... rest) : Object
      {
         var _loc5_:Object = null;
         var _loc4_:Array = getPool(param1);
         if(_loc4_.length > 0)
         {
            return _loc4_.pop();
         }
         if(param2)
         {
            _loc5_ = ComponentFactory.Instance.creat(param2,rest);
         }
         else
         {
            _loc5_ = construct(param1,rest);
         }
         return _loc5_;
      }
      
      public static function disposeObject(param1:Object, param2:Class = null) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 is Disposeable)
         {
            param1["dispose"]();
         }
         var _loc4_:String = null;
         if(!param2)
         {
            _loc4_ = getQualifiedClassName(param1);
            param2 = getDefinitionByName(_loc4_) as Class;
         }
         var _loc3_:Array = getPool(param2);
         _loc3_.push(param1);
      }
      
      public static function construct(param1:Class, param2:Array) : Object
      {
         switch(int(param2.length))
         {
            case 0:
               return new param1();
            case 1:
               return new param1(param2[0]);
            case 2:
               return new param1(param2[0],param2[1]);
            case 3:
               return new param1(param2[0],param2[1],param2[2]);
            case 4:
               return new param1(param2[0],param2[1],param2[2],param2[3]);
            case 5:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4]);
            case 6:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5]);
            case 7:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6]);
            case 8:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7]);
            case 9:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8]);
            case 10:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9]);
            default:
               return null;
         }
      }
      
      private function checkGC() : void
      {
      }
   }
}

