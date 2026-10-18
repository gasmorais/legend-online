package battle.view.skillname
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   
   public class SkillNameLoader
   {
      
      private static const PATH:String = "skillName/";
      
      private var _ids:Array;
      
      private var _complete:Function;
      
      private var _cache:Dictionary;
      
      private var _count:int;
      
      private var _isCompleted:Boolean;
      
      public function SkillNameLoader(param1:Array, param2:Function)
      {
         super();
         _ids = filterIds(param1);
         _complete = param2;
         _cache = new Dictionary();
      }
      
      public static function getSkillNameIds(param1:Array) : Array
      {
         var _loc3_:SkillTempInfo = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(param1[_loc4_]);
            if(_loc3_)
            {
               if(_loc3_.SonType != 0 && _loc3_.SonType != 1 && _loc3_.UseWay == 1 && _loc2_.indexOf(_loc3_.SonType) == -1)
               {
                  _loc2_.push(_loc3_.SonType);
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function filterIds(param1:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = int(param1[_loc3_]);
            if(_loc2_.indexOf(_loc4_) == -1)
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function load() : void
      {
         _count = -1;
         loadNext();
      }
      
      private function loadOne() : void
      {
         var _loc1_:String = PathManager.resourcePath + "skillName/";
         _loc1_ += _ids[_count] + ".png";
         LoaderManagerII.instance.load(_loc1_,2,7,onComplete,null);
      }
      
      private function onComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(!_cache)
         {
            return;
         }
         if(param2)
         {
            _cache[_ids[_count]] = param2;
         }
         loadNext();
      }
      
      private function loadNext() : void
      {
         _count = _count + 1;
         if(_count < _ids.length)
         {
            loadOne();
         }
         else
         {
            loadComplete();
         }
      }
      
      private function loadComplete() : void
      {
         _isCompleted = true;
         if(_complete != null)
         {
            _complete();
            _complete = null;
         }
      }
      
      public function get completed() : Boolean
      {
         return _isCompleted;
      }
      
      public function getRes(param1:int) : DisplayObject
      {
         return _cache[param1] as DisplayObject;
      }
      
      public function dispose() : void
      {
         var _loc1_:DisplayObject = null;
         for(var _loc2_:String in _cache)
         {
            _loc1_ = _cache[_loc2_] as DisplayObject;
            ObjectUtils.disposeObject(_loc1_);
            delete _cache[_loc2_];
            _loc1_ = null;
         }
         _cache = null;
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onComplete);
      }
   }
}

