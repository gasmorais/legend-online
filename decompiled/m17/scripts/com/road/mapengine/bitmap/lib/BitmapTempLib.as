package com.road.mapengine.bitmap.lib
{
   import com.pickgliss.loader.DomainResourceLoad;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class BitmapTempLib
   {
      
      private static var _instance:BitmapTempLib;
      
      private var _lib:Dictionary;
      
      private var _ids:Dictionary;
      
      private var _count:Dictionary;
      
      public function BitmapTempLib()
      {
         super();
         _lib = new Dictionary(true);
         _ids = new Dictionary(true);
         _count = new Dictionary(true);
      }
      
      public static function get instance() : BitmapTempLib
      {
         if(!_instance)
         {
            _instance = new BitmapTempLib();
         }
         return _instance;
      }
      
      public function addBitmapdata(param1:BitmapData, param2:String) : void
      {
         if(_lib[param2])
         {
            var _loc3_:String = param2;
            var _loc4_:Number = _count[_loc3_] + 1;
            _count[_loc3_] = _loc4_;
         }
         else
         {
            _ids[param1] = param2;
            _lib[param2] = param1;
            _count[param2] = 1;
         }
      }
      
      public function createBitmapdata(param1:String) : BitmapData
      {
         var _loc3_:* = undefined;
         var _loc2_:BitmapData = null;
         if(hasBitmap(param1))
         {
            var _loc4_:String = param1;
            var _loc5_:Number = _count[_loc4_] + 1;
            _count[_loc4_] = _loc5_;
            return _lib[param1] as BitmapData;
         }
         if(DomainResourceLoad.loaderContext.applicationDomain.hasDefinition(param1))
         {
            _loc3_ = DomainResourceLoad.loaderContext.applicationDomain.getDefinition(param1);
            _loc2_ = new _loc3_() as BitmapData;
            addBitmapdata(_loc2_,param1);
            return _loc2_;
         }
         return null;
      }
      
      public function removeBitmapdataByCName(param1:String) : void
      {
         if(_count[param1] > 0)
         {
            var _loc2_:String = param1;
            var _loc3_:Number = _count[_loc2_] - 1;
            _count[_loc2_] = _loc3_;
         }
         else
         {
            disposeByKey(param1);
         }
      }
      
      public function removeBitmapdata(param1:BitmapData) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:String = _ids[param1];
         if(_loc2_)
         {
            removeBitmapdataByCName(_loc2_);
            return;
         }
         throw new Error("removeBitmapdata");
      }
      
      private function disposeByKey(param1:String) : void
      {
         var _loc2_:BitmapData = _lib[param1] as BitmapData;
         if(_loc2_)
         {
            _loc2_.dispose();
         }
         _loc2_ = null;
         delete _lib[param1];
      }
      
      public function hasBitmap(param1:String) : Boolean
      {
         return _lib[param1] != null;
      }
      
      public function dispose() : void
      {
         for(var _loc1_:String in _count)
         {
            disposeByKey(_loc1_);
            delete _count[_loc1_];
         }
      }
   }
}

