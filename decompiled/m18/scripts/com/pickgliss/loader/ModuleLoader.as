package com.pickgliss.loader
{
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.loaderii.LoaderEventII;
   import com.pickgliss.ui.ComponentSetting;
   import flash.utils.ByteArray;
   
   public class ModuleLoader extends DisplayLoader
   {
      
      private var bytes1:ByteArray;
      
      private var bytes2:ByteArray;
      
      public function ModuleLoader()
      {
         super();
      }
      
      public static function decry(param1:ByteArray) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeByte(67);
         _loc2_.writeByte(87);
         _loc2_.writeByte(83);
         param1.position = 21;
         param1.readBytes(_loc2_,124,param1.bytesAvailable - 121);
         param1.readBytes(_loc2_,3);
         return _loc2_;
      }
      
      public static function getDefinition(param1:String) : *
      {
         return DisplayLoader.Context.applicationDomain.getDefinition(param1);
      }
      
      public static function hasDefinition(param1:String) : Boolean
      {
         return DisplayLoader.Context.applicationDomain.hasDefinition(param1);
      }
      
      override public function loadFromBytes(param1:ByteArray, param2:LoaderInfo) : void
      {
         _info = param2;
         analyMd5(param1);
      }
      
      public function analyMd5(param1:ByteArray) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:String = ComponentSetting.getUrlMd5(info.url);
         if(ComponentSetting.checkNeedAnalyzeMd5(_loc5_))
         {
            _loc2_ = true;
            if(UiConfigAnalyzer.data)
            {
               _loc3_ = ComponentSetting.getMD5FileNameByFilePath(info.url);
               _loc4_ = int(UiConfigAnalyzer.data[_loc3_]);
               if(_loc4_ != 0)
               {
                  _loc2_ = Math.abs(_loc4_ - param1.bytesAvailable) < 3000;
               }
            }
            if(ComponentSetting.compareMD5(param1,_loc5_) && _loc2_)
            {
               bytes1 = new ByteArray();
               param1.position = 37;
               param1.readBytes(bytes1);
               handleModule(bytes1,_loc5_);
            }
            else
            {
               dispatchEvent(new LoaderEventII("complete",info,null));
            }
         }
         else
         {
            handleModule(param1,_loc5_);
         }
      }
      
      private function handleModule(param1:ByteArray, param2:String = "") : void
      {
         param1.position = 0;
         if(param1[0] != 67 || param1[1] != 87 || param1[2] != 83)
         {
            param1 = decry(param1);
            bytes2 = param1;
         }
         if(param1)
         {
            param1.position = 0;
         }
         _displayLoader.loadBytes(param1,Context);
      }
      
      override public function dispose() : void
      {
         if(bytes1)
         {
            bytes1.clear();
            bytes1 = null;
         }
         if(bytes2)
         {
            bytes2.clear();
            bytes2 = null;
         }
         super.dispose();
      }
   }
}

