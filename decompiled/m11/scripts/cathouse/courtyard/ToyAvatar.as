package cathouse.courtyard
{
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import utils.LogicUtils;
   import yishi.datas.templates.CatHouseTemplateInfo;
   import yishi.manager.PathManager;
   
   public class ToyAvatar extends BaseCatLoadObject
   {
      
      private static var _defaultPoint:Point = new Point();
      
      private var _isDamaged:Boolean;
      
      private var _isShelf:Boolean;
      
      private var _posMCList:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private var _centerPos:Point = new Point();
      
      private var _hitTestRect:Rectangle;
      
      private var _curCatPosList:Vector.<Point> = new Vector.<Point>();
      
      public function ToyAvatar()
      {
         super();
         _hitTestRect = new Rectangle(0,0,50,50);
         graphics.beginFill(16711680,0);
         graphics.drawRect(0,0,50,50);
         graphics.endFill();
      }
      
      public function get posMCList() : Vector.<MovieClip>
      {
         return _posMCList;
      }
      
      public function get centerPos() : Point
      {
         return _centerPos;
      }
      
      public function get curCatPosList() : Vector.<Point>
      {
         return _curCatPosList;
      }
      
      public function set isDamaged(param1:Boolean) : void
      {
         _isDamaged = param1;
      }
      
      public function get isDamaged() : Boolean
      {
         return _isDamaged;
      }
      
      public function get isShelf() : Boolean
      {
         return _isShelf;
      }
      
      public function get hitTestRect() : Rectangle
      {
         return _hitTestRect;
      }
      
      override public function set templateInfo(param1:CatHouseTemplateInfo) : void
      {
         _isShelf = false;
         if(_templateInfo != param1)
         {
            _templateInfo = param1;
            if(_templateInfo != null)
            {
               _isShelf = _templateInfo.Types == 101;
               toLoadAvatar(PathManager.resourcePath + "images" + _templateInfo.Avatar + ".swf");
            }
         }
      }
      
      override protected function onLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var centerPosMcName:String;
         var centerPosMc:MovieClip;
         var catPosMcName:String;
         var curCatPosMc:MovieClip;
         var i:uint;
         var info:LoaderInfo = param1;
         var content:Object = param2;
         _isLoading = false;
         clearAvatar();
         _curLoadedDisplayObject = content as DisplayObject;
         _centerPos.x = _centerPos.y = 0;
         _posMCList.length = 0;
         if(_curLoadedDisplayObject != null)
         {
            _curLoadedDisplayObject.x = _curLoadedDisplayObject.y = 0;
            if(_curLoadedDisplayObject is MovieClip)
            {
               if(_templateInfo != null)
               {
                  centerPosMcName = "offsetPos_mc_1";
                  if(_curLoadedDisplayObject.hasOwnProperty(centerPosMcName))
                  {
                     centerPosMc = _curLoadedDisplayObject[centerPosMcName] as MovieClip;
                     if(centerPosMc != null)
                     {
                        _centerPos.x = centerPosMc.x;
                        _centerPos.y = centerPosMc.y;
                     }
                  }
                  _curCatPosList.length = 0;
                  i = 0;
                  while(i < 5)
                  {
                     catPosMcName = "pos_0" + (i + 1);
                     if(_curLoadedDisplayObject.hasOwnProperty(catPosMcName))
                     {
                        curCatPosMc = _curLoadedDisplayObject[catPosMcName] as MovieClip;
                        _posMCList.push(curCatPosMc);
                        _curCatPosList.push(new Point(curCatPosMc.x,curCatPosMc.y));
                     }
                     i = i + 1;
                  }
               }
            }
            addChild(_curLoadedDisplayObject);
            ObjectUtils.disposeObject(_loading);
            _loading = null;
         }
         faultPosHandler();
         _curCatPosList.sort(function(param1:Point, param2:Point):int
         {
            return Math.random() ? 1 : -1;
         });
         if(_loadedCallbackFun != null)
         {
            _loadedCallbackFun(this);
         }
         _loadedCallbackFun = null;
      }
      
      private function faultPosHandler() : void
      {
         var _loc3_:* = 0;
         var _loc1_:* = 0;
         var _loc2_:uint = uint(_templateInfo == null ? 5 : _templateInfo.CatCount);
         if(_curCatPosList.length < _loc2_)
         {
            _loc3_ = uint(_loc2_ - _curCatPosList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc3_)
            {
               _curCatPosList.push(_defaultPoint);
               _loc1_++;
            }
         }
      }
      
      override public function dispose() : void
      {
         LogicUtils.disposeDisplayCollection(_posMCList);
         _curCatPosList = null;
         super.dispose();
      }
   }
}

