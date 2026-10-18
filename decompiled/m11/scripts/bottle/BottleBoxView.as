package bottle
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.BottleEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.BottleManager;
   import mvc.module.bottle.BottleModel;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   
   public class BottleBoxView extends Sprite implements Disposeable
   {
      
      public static const MAXCURRENT:int = 100;
      
      private static const HEIGHT_ARRAY:Array = [25,90,90,90,90];
      
      private static const LOCATIONY_ARRAY:Array = [415,325,235,145,55];
      
      private var currentArray:Array = [0,0,0,0,0];
      
      private var _currentNumber:int;
      
      private var _boxArr:Vector.<BottleIntergalBoxView> = new Vector.<BottleIntergalBoxView>(5);
      
      private var _boxViewbg:Bitmap;
      
      private var _numBmp:BitmapData;
      
      private var _currentCountBmp:BitmapData;
      
      private var _numImg0:Sprite;
      
      private var _numImg1:Sprite;
      
      private var _numImg2:Sprite;
      
      private var _numImg3:Sprite;
      
      private var _numImg4:Sprite;
      
      private var _numImgBmp0:Bitmap;
      
      private var _numImgBmp1:Bitmap;
      
      private var _numImgBmp2:Bitmap;
      
      private var _numImgBmp3:Bitmap;
      
      private var _numImgBmp4:Bitmap;
      
      private var _currentCountSprite:Sprite;
      
      private var _percentbg:Bitmap;
      
      private var _currentCount:Bitmap;
      
      private var _currentCount2:Bitmap;
      
      private var _countTxt:FilterFrameText;
      
      private var _progressMC:MovieClip;
      
      private var _currentheight:int;
      
      public var _totalHeight:int;
      
      public function BottleBoxView()
      {
         super();
         initView();
         _totalHeight = HEIGHT_ARRAY[0] + HEIGHT_ARRAY[1] + HEIGHT_ARRAY[2] + HEIGHT_ARRAY[3] + HEIGHT_ARRAY[4];
         initData();
         updateView(false);
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _boxViewbg = ComponentFactory.Instance.creatBitmap("asset.bottle.countbg");
         _numImgBmp0 = ComponentFactory.Instance.creatBitmap("asset.bottle.NumImage");
         _numImgBmp1 = ComponentFactory.Instance.creatBitmap("asset.bottle.NumImage");
         _numImgBmp2 = ComponentFactory.Instance.creatBitmap("asset.bottle.NumImage");
         _numImgBmp3 = ComponentFactory.Instance.creatBitmap("asset.bottle.NumImage");
         _numImgBmp4 = ComponentFactory.Instance.creatBitmap("asset.bottle.NumImage");
         _numBmp = ComponentFactory.Instance.creatBitmapData("asset.bottle.NumBmpData");
         _currentCountBmp = ComponentFactory.Instance.creatBitmapData("asset.bottle.NumBmpData2");
         _percentbg = ComponentFactory.Instance.creatBitmap("asset.bottle.percentbg");
         _currentCount = ComponentFactory.Instance.creatBitmap("asset.bottle.CurrentCount");
         _currentCount2 = ComponentFactory.Instance.creatBitmap("asset.bottle.CurrentCount2");
         _progressMC = ComponentFactory.Instance.creat("asset.bottle.progressMC");
         _progressMC.x = 147;
         _progressMC.y = 244;
         _numImg0 = new Sprite();
         _numImg1 = new Sprite();
         _numImg2 = new Sprite();
         _numImg3 = new Sprite();
         _numImg4 = new Sprite();
         _currentCountSprite = new Sprite();
         addChild(_boxViewbg);
         addChild(_numImg0);
         _numImg0.x = 64;
         _numImg0.y = LOCATIONY_ARRAY[0];
         addChild(_numImg1);
         _numImg1.x = 64;
         _numImg1.y = LOCATIONY_ARRAY[1];
         addChild(_numImg2);
         _numImg2.x = 64;
         _numImg2.y = LOCATIONY_ARRAY[2];
         addChild(_numImg3);
         _numImg3.x = 64;
         _numImg3.y = LOCATIONY_ARRAY[3];
         addChild(_numImg4);
         _numImg4.x = 64;
         _numImg4.y = LOCATIONY_ARRAY[4];
         addChild(_numImgBmp0);
         _numImgBmp0.x = _numImg0.x;
         _numImgBmp0.y = LOCATIONY_ARRAY[0] + 20;
         addChild(_numImgBmp1);
         _numImgBmp1.x = _numImg1.x;
         _numImgBmp1.y = LOCATIONY_ARRAY[1] + 20;
         addChild(_numImgBmp2);
         _numImgBmp2.x = _numImg2.x;
         _numImgBmp2.y = LOCATIONY_ARRAY[2] + 20;
         addChild(_numImgBmp3);
         _numImgBmp3.x = _numImg3.x;
         _numImgBmp3.y = LOCATIONY_ARRAY[3] + 20;
         addChild(_numImgBmp4);
         _numImgBmp4.x = _numImg4.x;
         _numImgBmp4.y = LOCATIONY_ARRAY[4] + 20;
         addChild(_currentCountSprite);
         _currentCountSprite.x = _currentCount.x + _currentCount.width;
         _currentCountSprite.y = 6;
         addChild(_percentbg);
         addChild(_currentCount);
         addChild(_currentCount2);
         _currentCount2.y = _currentCount.y;
         _currentCount2.x = _currentCountSprite.x + _currentCountSprite.width;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _boxArr[_loc1_] = ComponentFactory.Instance.creatCustomObject("bottle.BottleIntergalBoxView");
            _boxArr[_loc1_].boxIndex = _loc1_;
            _boxArr[_loc1_].y = 42 + 90 * (4 - _loc1_);
            _boxArr[_loc1_].buttonMode = true;
            addChild(_boxArr[_loc1_]);
            _loc1_++;
         }
         initEvent();
         addChild(_progressMC);
         if(_progressMC)
         {
            _progressMC.gotoAndStop(1);
         }
      }
      
      private function initData() : void
      {
         _currentNumber = model.nowLayer;
         currentArray = model.getHeightArray();
         NumberViewUtils.refreshValue(currentArray[0],_numImg0,_numBmp,11,17,8,11,"0123456789");
         NumberViewUtils.refreshValue(currentArray[1],_numImg1,_numBmp,11,17,8,11,"0123456789");
         NumberViewUtils.refreshValue(currentArray[2],_numImg2,_numBmp,11,17,11,11,"0123456789");
         NumberViewUtils.refreshValue(currentArray[3],_numImg3,_numBmp,11,17,11,11,"0123456789");
         NumberViewUtils.refreshValue(currentArray[4],_numImg4,_numBmp,11,17,11,11,"0123456789");
         NumberViewUtils.refreshValue(_currentNumber,_currentCountSprite,_currentCountBmp,11,17,11,11,"0123456789");
         _currentCount2.x = _currentCountSprite.x + _currentCountSprite.width;
      }
      
      private function initEvent() : void
      {
         BottleManager.instance.addEventListener("UPDATE_REWARD_USERINFO",onUpdateInfomation);
      }
      
      private function removeEvent() : void
      {
         BottleManager.instance.removeEventListener("UPDATE_REWARD_USERINFO",onUpdateInfomation);
      }
      
      private function onUpdate(param1:BottleEvent) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = int(param1.data);
         }
         setTimeout(showAddIntergal,200,_loc2_);
         updateView();
      }
      
      private function onUpdateInfomation(param1:BottleEvent) : void
      {
         var _loc2_:int = 0;
         _currentNumber = model.nowLayer;
         currentArray = model.getHeightArray();
         NumberViewUtils.refreshValue(_currentNumber,_currentCountSprite,_currentCountBmp,11,17,11,11,"0123456789");
         NumberViewUtils.refreshValue(currentArray[0],_numImg0,_numBmp,11,17,8,11,"0123456789");
         NumberViewUtils.refreshValue(currentArray[1],_numImg1,_numBmp,11,17,8,11,"0123456789");
         NumberViewUtils.refreshValue(currentArray[2],_numImg2,_numBmp,11,17,11,11,"0123456789");
         NumberViewUtils.refreshValue(currentArray[3],_numImg3,_numBmp,11,17,11,11,"0123456789");
         NumberViewUtils.refreshValue(currentArray[4],_numImg4,_numBmp,11,17,11,11,"0123456789");
         _currentCount2.x = _currentCountSprite.x + _currentCountSprite.width;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            (_boxArr[_loc2_] as BottleIntergalBoxView).boxIndex = _loc2_;
            _loc2_++;
         }
         onUpdate(null);
      }
      
      private function showAddIntergal(param1:int) : void
      {
         if(param1 < 1)
         {
            return;
         }
         var _loc3_:String = "#FFFF00";
         if(param1 > 1)
         {
            _loc3_ = "#CEA031";
         }
         var _loc2_:TextField = ComponentFactory.Instance.creatComponentByStylename("bottle.OpenDescribeTxt");
         _loc2_.htmlText = LanguageMgr.GetTranslation("bottle.BottleBoxView.OpenDescribeTxt",_loc3_,param1);
         _loc2_.x = 90;
         _loc2_.y = 395;
         addChild(_loc2_);
         TweenMax.to(_loc2_,1,{
            "y":250,
            "onComplete":onShowAddIntergalComplete,
            "onCompleteParams":[_loc2_]
         });
      }
      
      private function onShowAddIntergalComplete(param1:TextField) : void
      {
         TweenMax.to(param1,1,{
            "y":100,
            "alpha":0,
            "onComplete":onMoveAddIntergalComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function onMoveAddIntergalComplete(param1:TextField) : void
      {
         try
         {
            removeChild(param1);
         }
         catch(e:Error)
         {
         }
      }
      
      private function disapearComplete(param1:BaseIconView) : void
      {
         ObjectUtils.disposeObject(param1);
      }
      
      public function updateView(param1:Boolean = true) : void
      {
         updateEffMc(param1);
         updateBox();
         updateLocation();
      }
      
      private function updateLocation() : void
      {
         NumberViewUtils.refreshValue(_currentNumber,_currentCountSprite,_currentCountBmp,11,17,11,11,"0123456789");
         _numImgBmp0.x = _numImg0.x;
         _numImgBmp0.y = LOCATIONY_ARRAY[0] + 20;
         _numImgBmp1.x = _numImg1.x;
         _numImgBmp1.y = LOCATIONY_ARRAY[1] + 20;
         _numImgBmp2.x = _numImg2.x;
         _numImgBmp2.y = LOCATIONY_ARRAY[2] + 20;
         _numImgBmp3.x = _numImg3.x;
         _numImgBmp3.y = LOCATIONY_ARRAY[3] + 20;
         _numImgBmp4.x = _numImg4.x;
         _numImgBmp4.y = LOCATIONY_ARRAY[4] + 20;
      }
      
      private function updateBox(param1:BottleEvent = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 != null)
         {
            _loc2_ = int(param1.data);
            setTimeout(createIconAnime,200,_loc2_);
         }
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _boxArr[_loc3_].refreshStatus();
            _loc3_++;
         }
      }
      
      private function createIconAnime(param1:int) : void
      {
         if(this.stage == null)
         {
            return;
         }
         var _loc2_:BaseIconView = ComponentFactory.Instance.creatCustomObject("core.BaseIcon",[iconComplete]);
         _loc2_.icon = IconFactory.getGoodsIconByTID(param1);
      }
      
      private function iconComplete(param1:BaseIconView = null) : void
      {
         var bagPoint:Point;
         var icon:BaseIconView = param1;
         var point:Point = new Point(_boxArr[model.clickBoxIndex].x,_boxArr[model.clickBoxIndex].y);
         icon.x = this.localToGlobal(point).x;
         icon.y = this.localToGlobal(point).y;
         icon.mouseChildren = icon.mouseEnabled = false;
         bagPoint = this.localToGlobal(new Point(495,316));
         if(icon)
         {
            TweenMax.to(icon,1,{
               "delay":0.4,
               "bezierThrough":[{
                  "x":icon.x,
                  "y":icon.y
               },{
                  "x":bagPoint.x + 40,
                  "y":bagPoint.y + 30
               }],
               "scaleX":0.3,
               "scaleY":0.3,
               "orientToBezier":false,
               "ease":Quart.easeIn,
               "onUpdate":function():void
               {
                  if(!icon.parent)
                  {
                     StageReferance.stage.addChild(icon);
                  }
               },
               "onComplete":_moveComplete,
               "onCompleteParams":[icon]
            });
         }
      }
      
      private function _moveComplete(param1:BaseIconView) : void
      {
         BottleManager.instance.sendOpenInfo(3,0);
         TweenMax.to(param1,0.5,{
            "alpha":0,
            "onComplete":disapearComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function updateEffMc(param1:Boolean = true) : void
      {
         var _loc2_:int = int(model.nowLayer);
         if(currentArray[0] == 0 && currentArray[1] == 0 && currentArray[2] == 0 && currentArray[3] == 0 && currentArray[4] == 0)
         {
            return;
         }
         if(_loc2_ == 0)
         {
            _currentheight = 0;
         }
         else if(0 < _loc2_ && _loc2_ <= currentArray[0])
         {
            _currentheight = 100 * (_loc2_ * HEIGHT_ARRAY[0] / currentArray[0] + 3) / _totalHeight;
         }
         else if(currentArray[0] < _loc2_ && _loc2_ <= currentArray[1])
         {
            _currentheight = 100 * ((_loc2_ - currentArray[0]) * HEIGHT_ARRAY[1] / (currentArray[1] - currentArray[0]) + HEIGHT_ARRAY[0]) / _totalHeight;
         }
         else if(currentArray[1] < _loc2_ && _loc2_ <= currentArray[2])
         {
            _currentheight = 100 * ((_loc2_ - currentArray[1]) * HEIGHT_ARRAY[2] / (currentArray[2] - currentArray[1]) + HEIGHT_ARRAY[0] + HEIGHT_ARRAY[1]) / _totalHeight;
         }
         else if(currentArray[2] < _loc2_ && _loc2_ <= currentArray[3])
         {
            _currentheight = 100 * ((_loc2_ - currentArray[2]) * HEIGHT_ARRAY[3] / (currentArray[3] - currentArray[2]) + HEIGHT_ARRAY[0] + HEIGHT_ARRAY[1] + HEIGHT_ARRAY[2]) / _totalHeight;
         }
         else if(currentArray[3] < _loc2_ && _loc2_ < currentArray[4])
         {
            _currentheight = 100 * ((_loc2_ - currentArray[3]) * HEIGHT_ARRAY[4] / (currentArray[4] - currentArray[3]) + HEIGHT_ARRAY[0] + HEIGHT_ARRAY[1] + HEIGHT_ARRAY[2] + HEIGHT_ARRAY[3]) / _totalHeight;
         }
         else if(_loc2_ >= currentArray[4])
         {
            _currentheight = 100;
         }
         if(_currentheight > 0)
         {
            if(_progressMC)
            {
               _progressMC.gotoAndStop(_currentheight);
            }
         }
         else if(_currentheight == 0)
         {
            if(_progressMC)
            {
               _progressMC.gotoAndStop(1);
            }
         }
      }
      
      private function get model() : BottleModel
      {
         return BottleManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_boxViewbg);
         _boxViewbg = null;
         ObjectUtils.disposeObject(_numBmp);
         _numBmp = null;
         ObjectUtils.disposeObject(_currentCountSprite);
         _currentCountSprite = null;
         ObjectUtils.disposeObject(_numImg0);
         _numImg0 = null;
         ObjectUtils.disposeObject(_numImg1);
         _numImg1 = null;
         ObjectUtils.disposeObject(_numImg2);
         _numImg2 = null;
         ObjectUtils.disposeObject(_numImg3);
         _numImg3 = null;
         ObjectUtils.disposeObject(_numImg4);
         _numImg4 = null;
         ObjectUtils.disposeObject(_percentbg);
         _percentbg = null;
         ObjectUtils.disposeObject(_currentCount);
         _currentCount = null;
         ObjectUtils.disposeObject(_currentCount2);
         _currentCount2 = null;
         ObjectUtils.disposeObject(_numImgBmp0);
         _numImgBmp0 = null;
         ObjectUtils.disposeObject(_numImgBmp1);
         _numImgBmp1 = null;
         ObjectUtils.disposeObject(_numImgBmp2);
         _numImgBmp2 = null;
         ObjectUtils.disposeObject(_numImgBmp3);
         _numImgBmp3 = null;
         ObjectUtils.disposeObject(_numImgBmp4);
         _numImgBmp4 = null;
         ObjectUtils.disposeObject(_progressMC);
         _progressMC = null;
         if(_boxArr)
         {
            while(_boxArr.length)
            {
               _boxArr.pop().dispose();
            }
            _boxArr = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

