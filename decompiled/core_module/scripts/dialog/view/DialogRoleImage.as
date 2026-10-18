package dialog.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.utils.ObjectUtils;
   import dialog.data.DialogMessageInfo;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import yishi.manager.PathManager;
   
   public class DialogRoleImage extends Sprite
   {
      
      private static const BACK_SCALE:Number = 0.8;
      
      private static const BACK_TINT_AMOUNT:Number = 1;
      
      private static const ROLE_DISTANCE:Number = 90;
      
      private static const BACK_POS:Point = new Point(0,55);
      
      private var _headSps:Array;
      
      private var _urlDic:Dictionary;
      
      private var _containerDic:Dictionary;
      
      private var _bitmapArr:Array;
      
      public function DialogRoleImage()
      {
         super();
         _headSps = [];
         initContainer();
         _urlDic = new Dictionary(true);
         _containerDic = new Dictionary(true);
         _bitmapArr = [];
      }
      
      private function initContainer() : void
      {
         var _loc1_:Sprite = new Sprite();
         addChild(_loc1_);
         TweenMax.to(_loc1_,0,{
            "y":BACK_POS.y,
            "scaleX":0.8,
            "scaleY":0.8,
            "alpha":0
         });
         _headSps.unshift(_loc1_);
         _loc1_ = new Sprite();
         _loc1_.x = 90;
         addChild(_loc1_);
         _headSps.unshift(_loc1_);
      }
      
      public function loadImages(param1:Dictionary) : void
      {
         var _loc2_:String = null;
         for each(var _loc3_:DialogMessageInfo in param1)
         {
            if(_loc3_.roleId <= 0)
            {
               _loc3_.roleId = 1;
            }
            _loc2_ = PathManager.solveHeadPath(_loc3_.roleId);
            _containerDic[_loc3_.roleId] = _headSps.pop();
            _urlDic[_loc2_] = _loc3_.roleId;
            LoaderManagerII.instance.load(_loc2_,2,8,onLoadComplete);
         }
      }
      
      public function loadImagesByRoleId(param1:Array) : void
      {
         var _loc3_:String = null;
         if(_containerDic[_loc2_])
         {
            return;
         }
         for each(var _loc2_:int in param1)
         {
            _loc3_ = PathManager.solveHeadPath(_loc2_);
            _containerDic[_loc2_] = _headSps.pop();
            _urlDic[_loc3_] = _loc2_;
            LoaderManagerII.instance.load(_loc3_,2,5,onLoadComplete);
         }
      }
      
      private function onLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(!param2 || !parent)
         {
            return;
         }
         var _loc3_:int = int(_urlDic[param1.url]);
         var _loc4_:Sprite = _containerDic[_loc3_] as Sprite;
         if(!_loc4_ || _loc4_.numChildren > 0)
         {
            return;
         }
         _loc4_.addChild(param2 as DisplayObject);
         _bitmapArr.push(param2);
      }
      
      public function swapToRoleById(param1:int) : void
      {
         var id:int = param1;
         var tempIco:Sprite = _containerDic[id];
         if(!tempIco)
         {
            return;
         }
         if(this.getChildAt(1) != tempIco && this.numChildren > 1)
         {
            if(tempIco.width != 0)
            {
               TweenMax.to(this.getChildAt(0),0.3,{"x":-90});
            }
            TweenMax.to(this.getChildAt(1),0.01,{
               "x":90 + 10,
               "onComplete":function():void
               {
                  addChild(tempIco);
               }
            });
            TweenMax.to(this.getChildAt(0),0.3,{
               "x":90,
               "y":0,
               "scaleX":1,
               "scaleY":1,
               "alpha":1
            });
            TweenMax.to(this.getChildAt(1),0,{
               "x":BACK_POS.x,
               "y":BACK_POS.y,
               "scaleX":0.8,
               "scaleY":0.8,
               "alpha":0
            });
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Sprite = null;
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onLoadComplete);
         for each(var _loc3_:Sprite in _containerDic)
         {
            ObjectUtils.disposeViolentMc(_loc3_);
         }
         if(_bitmapArr)
         {
            _loc1_ = 0;
            while(_loc1_ < _bitmapArr.length)
            {
               _loc2_ = _bitmapArr[_loc1_];
               ObjectUtils.disposeViolentMc(_loc2_);
               if(_loc2_.loaderInfo && _loc2_.loaderInfo.loader)
               {
                  _loc2_.loaderInfo.loader.unload();
                  _loc2_.loaderInfo.loader.unloadAndStop(true);
               }
               _loc1_++;
            }
            _bitmapArr = null;
         }
         _urlDic = null;
         _headSps = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

