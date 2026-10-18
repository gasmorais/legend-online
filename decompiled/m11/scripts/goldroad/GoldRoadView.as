package goldroad
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import events.GoldRoadEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import managers.GoldRoadManager;
   import mvc.module.goldroad.GoldRoadModel;
   
   public class GoldRoadView extends Sprite implements Disposeable
   {
      
      private var mountMc:MovieClip;
      
      private var diceMc:MovieClip;
      
      private var diceImage:MutipleImage;
      
      private var currentXY:Array;
      
      private var targetXY:Array;
      
      private var _lastStep:int;
      
      private var _sprite:Component;
      
      private var _cellArray:Array;
      
      private var antiArr:Array = [2,3,0,1];
      
      public function GoldRoadView()
      {
         super();
         currentXY = [];
         targetXY = [];
         _cellArray = [];
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _sprite = new Component();
         diceImage = ComponentFactory.Instance.creatComponentByStylename("goldroad.DiceMutiImage");
         diceImage.visible = true;
         diceImage.showImg(Math.abs(model.randomNum) - 1);
         diceMc = ComponentFactory.Instance.creatCustomObject("goldroad.bigDiceMc");
         diceMc.gotoAndStop(1);
         diceMc.visible = false;
         addChild(_sprite);
         addChild(diceMc);
         addChild(diceImage);
      }
      
      private function addEvent() : void
      {
         GoldRoadManager.instance.addEventListener("GOLDROADRE_FRESH",setGoldRoadView);
      }
      
      private function setGoldRoadView(param1:GoldRoadEvent) : void
      {
         var _loc2_:int = 0;
         var _loc5_:GoldRoadCell = null;
         var _loc3_:int = 0;
         var _loc4_:GoldRoadCell = null;
         _lastStep = model.stepKey;
         if(mountMc)
         {
            mountMc.parent.removeChild(mountMc);
         }
         mountMc = ComponentFactory.Instance.creatCustomObject("goldroad.goldroadmount.Run" + int(model.stepKey / 9));
         addChild(mountMc);
         currentXY = model.getXYbyStepKey(model.stepKey);
         mountMc.x = currentXY[0];
         mountMc.y = currentXY[1] - 10;
         mountMc.scaleX = mountMc.scaleY = model.getScale(currentXY[1]);
         mountMc.gotoAndStop(model.getFrameByFace(model.stepKey));
         mountMc.rotation = model.getRotationByFace(model.stepKey);
         _loc2_ = 0;
         while(_loc2_ < model.GoldRoadGoodList.length - 8)
         {
            _loc5_ = _cellArray[_loc2_] as GoldRoadCell;
            if(!_loc5_)
            {
               _loc5_ = new GoldRoadCell();
               _sprite.addChild(_loc5_);
            }
            _loc5_.data = model.GoldRoadGoodList[_loc2_];
            _cellArray[_loc2_] = _loc5_;
            _loc2_++;
         }
         _loc3_ = model.GoldRoadGoodList.length - 1;
         while(_loc3_ > 27)
         {
            _loc4_ = _cellArray[_loc3_] as GoldRoadCell;
            if(!_loc4_)
            {
               _loc4_ = new GoldRoadCell();
               _sprite.addChild(_loc4_);
            }
            _loc4_.data = model.GoldRoadGoodList[_loc3_];
            _cellArray[_loc3_] = _loc4_;
            _loc3_--;
         }
      }
      
      public function refreshView() : void
      {
         targetXY = model.getXYbyStepKey(model.stepKey);
         playBigDiceMovie();
      }
      
      private function playBigDiceMovie() : void
      {
         diceImage.visible = false;
         diceMc.visible = true;
         diceMc.gotoAndPlay(1);
         if(diceMc)
         {
            TweenMax.to(diceMc,1,{
               "frame":diceMc.totalFrames - 1,
               "onComplete":diceMcPlayerOver
            });
         }
      }
      
      private function diceMcPlayerOver() : void
      {
         if(diceMc)
         {
            diceMc.gotoAndStop(0);
            diceMc.visible = false;
         }
         diceImage.visible = true;
         diceImage.showImg(Math.abs(model.randomNum) - 1);
         if(mountMc)
         {
            playMountRunMovie();
         }
      }
      
      private function playMountRunMovie() : void
      {
         var _loc1_:Number = Math.abs(model.randomNum) / 2;
         if(model.randomNum > 0)
         {
            showClockWise(_loc1_);
         }
         else
         {
            showAntiClockWise(_loc1_);
         }
      }
      
      private function showClockWise(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc5_:Array = null;
         var _loc4_:Array = null;
         if(int(_lastStep / 9) == int(model.stepKey / 9))
         {
            mountMc.gotoAndPlay(1);
            TweenMax.to(mountMc,param1,{
               "x":targetXY[0],
               "y":targetXY[1] - 10,
               "onComplete":__onMountOverComplete,
               "onUpdate":onScaleUpdate,
               "onUpdateParams":[mountMc],
               "ease":Linear.easeNone
            });
         }
         else
         {
            _loc2_ = (int(_lastStep / 9 + 1)) * 9;
            _loc3_ = param1 * (_loc2_ - _lastStep) / (model.stepKey - _lastStep);
            if(_loc2_ >= 36)
            {
               _loc3_ = param1 * (_loc2_ - _lastStep) / (model.stepKey + 36 - _lastStep);
               _loc2_ = 0;
            }
            _loc5_ = model.getXYbyStepKey(_loc2_);
            _loc4_ = [_loc2_,_loc5_,param1];
            mountMc.gotoAndPlay(1);
            mountMc.rotation = model.getRotationByFace(_lastStep);
            TweenMax.to(mountMc,_loc3_,{
               "x":_loc5_[0],
               "y":_loc5_[1] - 10,
               "onComplete":__onVertexOverComplete,
               "onCompleteParams":[_loc4_],
               "onUpdate":onScaleUpdate,
               "onUpdateParams":[mountMc],
               "ease":Linear.easeNone
            });
         }
      }
      
      private function __onVertexOverComplete(param1:Array) : void
      {
         var _loc2_:Number = NaN;
         if(mountMc)
         {
            mountMc.gotoAndStop(model.getFrameByFace(param1[0]));
            ObjectUtils.disposeObject(mountMc);
         }
         mountMc = ComponentFactory.Instance.creatCustomObject("goldroad.goldroadmount.Run" + int(model.stepKey / 9));
         addChild(mountMc);
         mountMc.x = param1[1][0];
         mountMc.y = param1[1][1] - 10;
         mountMc.scaleX = mountMc.scaleY = model.getScale(param1[1][1]);
         if(mountMc)
         {
            if(param1[0] == model.stepKey)
            {
               __onMountOverComplete();
            }
            else
            {
               mountMc.gotoAndPlay(1);
               mountMc.rotation = model.getRotationByFace(param1[0]);
               _loc2_ = param1[2] * (model.stepKey - param1[0]) / (model.stepKey - _lastStep);
               if(param1[0] == 0)
               {
                  _loc2_ = param1[2] * (model.stepKey - param1[0]) / (model.stepKey + 36 - _lastStep);
               }
               TweenMax.to(mountMc,_loc2_,{
                  "x":targetXY[0],
                  "y":targetXY[1] - 10,
                  "onComplete":__onMountOverComplete,
                  "onUpdate":onScaleUpdate,
                  "onUpdateParams":[mountMc],
                  "ease":Linear.easeNone
               });
            }
         }
      }
      
      private function onScaleUpdate(param1:MovieClip) : void
      {
         mountMc.scaleX = mountMc.scaleY = model.getScale(param1.y);
      }
      
      private function __onMountOverComplete() : void
      {
         _lastStep = model.stepKey;
         if(mountMc)
         {
            mountMc.gotoAndStop(model.getFrameByFace(model.stepKey));
         }
         model.dispatchEvent(new GoldRoadEvent("GOLDROADRE_ARRIVE",null));
      }
      
      private function showAntiClockWise(param1:Number) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc2_:Array = null;
         var _loc5_:Array = null;
         getPreMount();
         if(int(_lastStep / 9) == int(model.stepKey / 9))
         {
            mountMc.gotoAndPlay(1);
            TweenMax.to(mountMc,param1,{
               "x":targetXY[0],
               "y":targetXY[1] - 10,
               "onComplete":__onMountAntiOverComplete,
               "onUpdate":onScaleUpdate,
               "onUpdateParams":[mountMc],
               "ease":Linear.easeNone
            });
         }
         else
         {
            _loc3_ = int(_lastStep / 9) * 9;
            _loc4_ = param1 * (_lastStep - _loc3_) / (_lastStep - model.stepKey);
            if(_loc3_ <= 0)
            {
               _loc4_ = param1 * (_lastStep - _loc3_) / (_lastStep + 36 - model.stepKey);
            }
            _loc2_ = model.getXYbyStepKey(_loc3_);
            _loc5_ = [_loc3_,_loc2_,param1];
            mountMc.gotoAndPlay(1);
            TweenMax.to(mountMc,_loc4_,{
               "x":_loc2_[0],
               "y":_loc2_[1] - 10,
               "onComplete":__onVertexAntiOverComplete,
               "onCompleteParams":[_loc5_],
               "onUpdate":onScaleUpdate,
               "onUpdateParams":[mountMc],
               "ease":Linear.easeNone
            });
         }
      }
      
      private function __onVertexAntiOverComplete(param1:Array) : void
      {
         var _loc2_:Number = NaN;
         if(mountMc)
         {
            ObjectUtils.disposeViolentMc(mountMc);
         }
         var _loc3_:int = int(antiArr[int(model.stepKey / 9)]);
         mountMc = ComponentFactory.Instance.creatCustomObject("goldroad.goldroadmount.Run" + _loc3_);
         addChild(mountMc);
         mountMc.x = param1[1][0];
         mountMc.y = param1[1][1] - 10;
         mountMc.scaleX = mountMc.scaleY = model.getScale(param1[1][1]);
         if(mountMc)
         {
            if(param1[0] == model.stepKey)
            {
               __onMountAntiOverComplete();
            }
            else
            {
               mountMc.gotoAndPlay(1);
               _loc2_ = param1[2] * (param1[0] - model.stepKey) / (_lastStep - model.stepKey);
               if(param1[0] == 0)
               {
                  _loc2_ = param1[2] * (param1[0] + 36 - model.stepKey) / (_lastStep + 36 - model.stepKey);
               }
               TweenMax.to(mountMc,_loc2_,{
                  "x":targetXY[0],
                  "y":targetXY[1] - 10,
                  "onComplete":__onMountAntiOverComplete,
                  "onUpdate":onScaleUpdate,
                  "onUpdateParams":[mountMc],
                  "ease":Linear.easeNone
               });
            }
         }
      }
      
      private function getPreMount() : void
      {
         if(mountMc)
         {
            ObjectUtils.disposeViolentMc(mountMc);
         }
         var _loc1_:int = int(antiArr[int(_lastStep / 9)]);
         mountMc = ComponentFactory.Instance.creatCustomObject("goldroad.goldroadmount.Run" + _loc1_);
         addChild(mountMc);
         var _loc2_:Array = model.getXYbyStepKey(_lastStep);
         mountMc.x = _loc2_[0];
         mountMc.y = _loc2_[1] - 10;
         mountMc.scaleX = mountMc.scaleY = model.getScale(_loc2_[1]);
      }
      
      private function __onMountAntiOverComplete() : void
      {
         _lastStep = model.stepKey;
         if(mountMc)
         {
            ObjectUtils.disposeObject(mountMc);
         }
         mountMc = ComponentFactory.Instance.creatCustomObject("goldroad.goldroadmount.Run" + int(model.stepKey / 9));
         addChild(mountMc);
         mountMc.x = targetXY[0];
         mountMc.y = targetXY[1] - 10;
         mountMc.scaleX = mountMc.scaleY = model.getScale(targetXY[1]);
         mountMc.gotoAndStop(model.getFrameByFace(model.stepKey));
         mountMc.rotation = model.getRotationByFace(model.stepKey);
         model.dispatchEvent(new GoldRoadEvent("GOLDROADRE_ARRIVE",null));
      }
      
      private function get model() : GoldRoadModel
      {
         return GoldRoadManager.instance.model;
      }
      
      private function removeEvent() : void
      {
         GoldRoadManager.instance.removeEventListener("GOLDROADRE_FRESH",setGoldRoadView);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_sprite)
         {
            while(_sprite.numChildren > 0)
            {
               ObjectUtils.disposeObject(_sprite.getChildAt(0));
            }
            ObjectUtils.disposeObject(_sprite);
            _sprite = null;
         }
         _cellArray = null;
         currentXY = null;
         targetXY = null;
         if(diceImage)
         {
            ObjectUtils.disposeObject(diceImage);
         }
         diceImage = null;
         if(diceMc)
         {
            ObjectUtils.disposeObject(diceMc);
         }
         diceMc = null;
         if(mountMc)
         {
            ObjectUtils.disposeObject(mountMc);
         }
         mountMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

