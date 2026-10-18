package secretadventure.item
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import yishi.datas.templates.SecretEventTemplate;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   
   public class SecretNode extends Sprite
   {
      
      private var _eventTemp:SecretEventTemplate;
      
      private var _state:int;
      
      private var _mapType:int;
      
      private var _box:Bitmap;
      
      private var _loadContent:DisplayObject;
      
      private var _clickFlg:Bitmap;
      
      private var _lightFlg:Bitmap;
      
      private const GRID_W:int = 117;
      
      private const GRID_H:int = 109;
      
      private var _gray:Array;
      
      private var _dispearMc:MovieClip;
      
      public function SecretNode(param1:int)
      {
         super();
         _mapType = param1;
         this.x = -58.5;
         this.y = -54.5;
         _gray = [UIFilter.getGrayFilter()];
         emptyBox();
      }
      
      private function emptyBox() : void
      {
         var _loc1_:BitmapData = null;
         if(_mapType == 2)
         {
            _loc1_ = SecretComBitData.Instance.grassEmpty;
            _box = new Bitmap(_loc1_);
            addChild(_box);
         }
         else
         {
            _loc1_ = SecretComBitData.Instance.empty;
            _box = new Bitmap(_loc1_);
            addChild(_box);
         }
         _lightFlg = new Bitmap();
         addChild(_lightFlg);
      }
      
      public function set eventTemp(param1:SecretEventTemplate) : void
      {
         var _loc3_:* = null;
         if(_eventTemp != null)
         {
            return;
         }
         _eventTemp = param1;
         var _loc2_:int = int(_eventTemp.FunType);
         if(_loc2_ == 0)
         {
            return;
         }
         if(_loc2_ != 1)
         {
            normalBox();
            doLoadRes();
         }
         updateStateView();
      }
      
      private function normalBox() : void
      {
         var _loc1_:BitmapData = null;
         if(_mapType == 2)
         {
            _loc1_ = SecretComBitData.Instance.grassEvent;
         }
         else
         {
            _loc1_ = SecretComBitData.Instance.event;
         }
         _box.bitmapData = _loc1_;
         _box.x = 0;
         _box.y = 0;
      }
      
      private function doLoadRes() : void
      {
         if(_eventTemp.Icon == null || _eventTemp.Icon == "")
         {
            return;
         }
         var _loc2_:int = int(_eventTemp.FunType);
         var _loc3_:Array = [8,9,13,14];
         if(_state == 1 && _loc3_.indexOf(_loc2_) == -1)
         {
            return;
         }
         var _loc4_:int = int(_eventTemp.Resource == 1 ? _mapType : 0);
         var _loc1_:String = PathManager.getSecretSource(_loc4_,_eventTemp.Icon);
         LoaderManagerII.instance.load(_loc1_,2,0,onLoadCompleteHandler);
      }
      
      private function onLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:int = 0;
         if(param2 is MovieClip)
         {
            _loadContent = param2 as MovieClip;
            if(_loadContent)
            {
               _loadContent.x = 117 / 2;
               _loadContent.y = 109 / 2;
            }
            _loc3_ = int(_eventTemp.FunType);
            if(_loc3_ == 8 || _loc3_ == 9)
            {
               refreshMc();
            }
            else if(_loc3_ == 13 || _loc3_ == 14)
            {
               if(_loadContent)
               {
                  if(_state == 0)
                  {
                     _loadContent.filters = null;
                  }
                  else
                  {
                     _loadContent.filters = _gray;
                  }
               }
            }
         }
         else if(param2 is Bitmap)
         {
            _loadContent = param2 as Bitmap;
         }
         if(_loadContent)
         {
            addChild(_loadContent);
         }
      }
      
      public function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         updateStateView();
      }
      
      private function updateStateView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BitmapData = null;
         if(_eventTemp)
         {
            _loc2_ = int(_eventTemp.FunType);
            if(_loc2_ == 8 || _loc2_ == 9)
            {
               refreshMc(true);
            }
            else if(_loc2_ == 13 || _loc2_ == 14)
            {
               if(_loadContent)
               {
                  if(_state == 0)
                  {
                     _loadContent.filters = null;
                  }
                  else
                  {
                     _loadContent.filters = _gray;
                  }
               }
            }
            else if(_state == 1)
            {
               if(_loc2_ == 6 && _loadContent)
               {
                  if(_dispearMc == null)
                  {
                     _dispearMc = ComponentFactory.Instance.creatCustomObject("asset.secretad.dispearMc");
                     addChild(_dispearMc);
                     _dispearMc.addEventListener("secret.dispear",dispearHandler);
                     _dispearMc.gotoAndPlay(1);
                     _dispearMc.x = 117 / 2;
                     _dispearMc.y = 109 / 2;
                  }
               }
               else
               {
                  releaseContent();
               }
               normalBox();
            }
            else if(_state == -1)
            {
               _loc1_ = SecretComBitData.Instance.redBit;
               _box.bitmapData = _loc1_;
               _box.x = 6;
               _box.y = 7;
            }
            else if(_state == 0)
            {
               normalBox();
            }
         }
      }
      
      private function dispearHandler(param1:Event) : void
      {
         releaseContent();
      }
      
      public function showWalkClick() : void
      {
         var _loc1_:BitmapData = null;
         if(!_clickFlg)
         {
            _loc1_ = SecretComBitData.Instance.walk;
            _clickFlg = new Bitmap(_loc1_);
            _clickFlg.x = 0;
            _clickFlg.y = -41;
         }
         addChild(_clickFlg);
      }
      
      public function dispearWalkClick() : void
      {
         if(_clickFlg && _clickFlg.parent)
         {
            removeChild(_clickFlg);
         }
      }
      
      private function refreshMc(param1:Boolean = false) : void
      {
         var _loc3_:int = int(_eventTemp.FunType);
         var _loc2_:MovieClip = _loadContent as MovieClip;
         if(_loc3_ == 8)
         {
            if(_loc2_)
            {
               if(_state == 0)
               {
                  if(param1)
                  {
                     _loc2_.mc.gotoAndPlay("sun");
                  }
                  else
                  {
                     _loc2_.mc.gotoAndStop("sunStop");
                  }
               }
               else if(_state == 1)
               {
                  if(param1)
                  {
                     _loc2_.mc.gotoAndPlay("moon");
                  }
                  else
                  {
                     _loc2_.mc.gotoAndStop("moonStop");
                  }
               }
            }
         }
         else if(_loc3_ == 9)
         {
            if(_loc2_)
            {
               if(_state == 0)
               {
                  if(param1)
                  {
                     _loc2_.mc.gotoAndPlay("down");
                  }
                  else
                  {
                     _loc2_.mc.gotoAndStop("downStop");
                  }
               }
               else if(_state == 1)
               {
                  if(param1)
                  {
                     _loc2_.mc.gotoAndPlay("up");
                  }
                  else
                  {
                     _loc2_.mc.gotoAndStop("upStop");
                  }
               }
            }
         }
      }
      
      public function get canPass() : Boolean
      {
         if(!_eventTemp)
         {
            return false;
         }
         var _loc1_:int = int(_eventTemp.FunType);
         if(_loc1_ == 0)
         {
            return false;
         }
         if(_loc1_ == 1 || _loc1_ == 12 || _loc1_ == 13 || _loc1_ == 14)
         {
            return true;
         }
         if(_loc1_ == 8)
         {
            return false;
         }
         if(_loc1_ == 9)
         {
            return _state == 0;
         }
         return _state == 1;
      }
      
      public function doRollOut() : void
      {
         _lightFlg.bitmapData = null;
      }
      
      public function doRollOver() : void
      {
         var _loc1_:BitmapData = SecretComBitData.Instance.grassEmpty;
         _lightFlg.bitmapData = _loc1_;
      }
      
      public function clearToGray() : void
      {
         releaseContent();
      }
      
      private function releaseContent() : void
      {
         if(_loadContent is MovieClip)
         {
            ObjectUtils.disposeViolentMc(_loadContent as MovieClip);
            _loadContent = null;
         }
         else
         {
            ObjectUtils.disposeObject(_loadContent);
            _loadContent = null;
         }
      }
      
      public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onLoadCompleteHandler);
         ObjectUtils.disposeObject(_box);
         _box = null;
         releaseContent();
         if(_dispearMc)
         {
            _dispearMc.removeEventListener("secret.dispear",dispearHandler);
         }
         ObjectUtils.disposeViolentMc(_dispearMc);
         _dispearMc = null;
         ObjectUtils.disposeObject(_clickFlg);
         _clickFlg = null;
         ObjectUtils.disposeObject(_lightFlg);
         _lightFlg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _eventTemp = null;
         _gray = null;
      }
   }
}

