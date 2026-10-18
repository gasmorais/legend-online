package yishi.datas.battle
{
   import battle.BattleManager;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import utils.LogicUtils;
   
   public class BattleOtherResByteLoader
   {
      
      private var _resLoader:Loader;
      
      private var _pathArr:Array;
      
      private var _complete:Function;
      
      private var _totalCount:int;
      
      private var _curCount:int;
      
      private var _isCompleted:Boolean;
      
      public function BattleOtherResByteLoader(param1:Array, param2:Function)
      {
         super();
         _pathArr = param1;
         _totalCount = _pathArr.length;
         _complete = param2;
      }
      
      public function startLoad() : void
      {
         if(!resourceModel)
         {
            loadComplete();
            return;
         }
         _curCount = -1;
         loadNext();
      }
      
      private function loadNext() : void
      {
         _curCount = _curCount + 1;
         if(_curCount < _totalCount)
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
      
      private function loadOne() : void
      {
         var _loc1_:String = _pathArr[_curCount];
         resourceModel.addMultiClassResourcePath(_loc1_.toLowerCase());
         LoaderManagerII.instance.load(_loc1_,1,10,btyeLoadComplete);
      }
      
      private function btyeLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:ApplicationDomain = resourceModel.getDomainByPaty(param1.url);
         var _loc4_:LoaderContext = new LoaderContext(false,_loc3_);
         if(DisplayLoader.isDebug)
         {
            _loc4_.allowCodeImport = true;
         }
         _resLoader = new Loader();
         _resLoader.contentLoaderInfo.addEventListener("complete",__loadOtherResComplete);
         _resLoader.loadBytes(param2 as ByteArray,_loc4_);
      }
      
      private function __loadOtherResComplete(param1:Event) : void
      {
         _resLoader.contentLoaderInfo.removeEventListener("complete",__loadOtherResComplete);
         _resLoader.unloadAndStop(false);
         _resLoader = null;
         loadNext();
      }
      
      public function get completed() : Boolean
      {
         return _isCompleted;
      }
      
      private function get resourceModel() : ResourceModel
      {
         return BattleManager.getInstance().resourceModel;
      }
      
      public function dispose() : void
      {
         _resLoader = null;
         LogicUtils.disposeDisplayCollection(_pathArr);
         _pathArr = null;
         _complete = null;
      }
   }
}

