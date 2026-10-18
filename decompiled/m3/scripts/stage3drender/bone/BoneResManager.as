package stage3drender.bone
{
   import flash.events.Event;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import stage3drender.Global;
   
   public class BoneResManager
   {
      
      private static var _instance:BoneResManager;
      
      private var _callbackDic:Dictionary = new Dictionary();
      
      private var _contentDic:Dictionary = new Dictionary();
      
      private var _contentList:Array = [];
      
      private var _isDoing:Boolean = false;
      
      private var _contentPath:String;
      
      public function BoneResManager()
      {
         super();
      }
      
      public static function get instance() : BoneResManager
      {
         if(_instance == null)
         {
            _instance = new BoneResManager();
         }
         return _instance;
      }
      
      public function createBoneMovie(param1:String, param2:ByteArray, param3:Object, param4:Function = null) : void
      {
         if(Global.starlingFactory.getTextureAtlas(param1))
         {
            param4.call(param3,param1);
         }
         else
         {
            if(_callbackDic[param1] == null)
            {
               _callbackDic[param1] = [];
            }
            _callbackDic[param1].push({
               "context":param3,
               "fun":param4
            });
            if(!_contentDic[param1])
            {
               _contentDic[param1] = byteArrayClone(param2);
               _contentList.push(param1);
            }
            checkIsDoing();
         }
      }
      
      private function byteArrayClone(param1:ByteArray) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeBytes(param1,0,param1.length);
         _loc2_.position = 0;
         return _loc2_;
      }
      
      private function doRecall(param1:String) : void
      {
         var _loc2_:Array = _callbackDic[param1];
         for each(var _loc3_:Object in _loc2_)
         {
            (_loc3_.fun as Function).call(_loc3_.context,param1);
         }
      }
      
      private function loadNext() : void
      {
         _isDoing = true;
         _contentPath = _contentList.shift();
         Global.starlingFactory.addEventListener("complete",paraseComplete);
         Global.starlingFactory.parseData(_contentDic[_contentPath],_contentPath);
      }
      
      protected function paraseComplete(param1:Event) : void
      {
         Global.starlingFactory.removeEventListener("complete",paraseComplete);
         doRecall(_contentPath);
         ByteArray(_contentDic[_contentPath]).clear();
         _contentDic[_contentPath] = null;
         delete _contentDic[_contentPath];
         _isDoing = false;
         checkIsDoing();
      }
      
      private function checkIsDoing() : void
      {
         if(_isDoing == false)
         {
            if(_contentList.length > 0)
            {
               loadNext();
            }
         }
      }
   }
}

