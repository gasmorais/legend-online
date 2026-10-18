package yishi.view.newGuildHelp
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.manager.PathManager;
   
   public class NewGuildView extends Sprite implements Disposeable
   {
      
      private var _isShow:Boolean;
      
      private var _minGrade:int;
      
      private var _bgUrl:String;
      
      private var _index:int;
      
      private var _path:String;
      
      private var _viewBg:Bitmap;
      
      private var _curViewData:XML;
      
      private var _curItemList:XMLList;
      
      private var _back:Function;
      
      private var _frameName:String;
      
      public function NewGuildView(param1:String)
      {
         super();
         _frameName = param1;
      }
      
      public static function getUrl(param1:String) : String
      {
         return PathManager.resourcePath + "help/" + param1 + ".png";
      }
      
      public function set data(param1:XML) : void
      {
         if(_curViewData == param1)
         {
            return;
         }
         clean();
         _curViewData = param1;
         _curItemList = param1.item.(@isShow == true);
         _isShow = _curViewData.@isShow;
         _bgUrl = _curViewData.@viewBgUrl;
         _index = _curViewData.@index;
         _minGrade = _curViewData.@minGrade;
         updateBgBitmap(_bgUrl);
      }
      
      private function createGuildItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:NewGuildItem = null;
         _loc2_ = 0;
         while(_loc2_ < _curItemList.length())
         {
            _loc1_ = new NewGuildItem(_frameName);
            addChild(_loc1_);
            _loc1_.data = _curItemList[_loc2_];
            _loc2_++;
         }
      }
      
      private function updateBgBitmap(param1:String) : void
      {
         var _loc2_:String = _frameName.split(".")[0];
         _path = _loc2_ + "/" + param1;
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onComplete);
         var _loc3_:String = getUrl(_path);
         LoaderManagerII.instance.load(_loc3_,2,8,__onComplete);
      }
      
      private function __onComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(param2)
         {
            _viewBg = param2 as Bitmap;
            addChild(_viewBg);
            createGuildItem();
         }
      }
      
      private function clean() : void
      {
         if(_viewBg)
         {
            ObjectUtils.disposeObject(_viewBg);
         }
         _viewBg = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

