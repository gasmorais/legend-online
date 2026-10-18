package bottle
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import events.BottleEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.BottleManager;
   import mvc.module.bottle.BottleModel;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class BottleBottomView extends Sprite implements Disposeable
   {
      
      public static const TOTALWIDTH:int = 390;
      
      public static const TOTALFRAME:int = 65;
      
      public static const BGWIDTH:int = 426;
      
      private static const HEIGHT_ARRAY:Array = [102,85,85,85,33];
      
      private var _boxArr:Vector.<BottleBottomIntergalBoxView>;
      
      private var _percentbg:Image;
      
      private var _progressMC:MovieClip;
      
      private var _bg2:Image;
      
      public var maskTopPos:int;
      
      public function BottleBottomView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _percentbg = ComponentFactory.Instance.creatComponentByStylename("bottle.percentbg");
         _boxArr = new Vector.<BottleBottomIntergalBoxView>();
         addChild(_percentbg);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _boxArr[_loc1_] = ComponentFactory.Instance.creatCustomObject("bottle.BottleBottomIntergalBoxView");
            _boxArr[_loc1_].boxIndex = _loc1_;
            if(_loc1_ == 3)
            {
               _boxArr[_loc1_].x = 291;
            }
            else if(_loc1_ == 4)
            {
               _boxArr[_loc1_].x = 375;
            }
            else
            {
               _boxArr[_loc1_].x = 35 + 82 * _loc1_;
            }
            _boxArr[_loc1_].buttonMode = false;
            addChild(_boxArr[_loc1_]);
            _loc1_++;
         }
         initEvent();
         updateView(false);
         if(_percentbg && model)
         {
            _percentbg.tipData = LanguageMgr.GetTranslation("bottle.bottleBottom.costNumber",model.openCount);
         }
      }
      
      private function initEvent() : void
      {
         BottleManager.instance.addEventListener("CT__UPDATE_BOX_STATUS",onUpdate);
      }
      
      private function removeEvent() : void
      {
         BottleManager.instance.removeEventListener("CT__UPDATE_BOX_STATUS",onUpdate);
      }
      
      private function onUpdate(param1:BottleEvent) : void
      {
         var _loc2_:int = int(param1.data.addCount);
         setTimeout(showAddIntergal,200,_loc2_);
         updateView();
      }
      
      private function showAddIntergal(param1:int) : void
      {
         if(param1 < 1)
         {
            return;
         }
         var _loc2_:TextField = ComponentFactory.Instance.creatComponentByStylename("bottle.OpenDescribeTxt1");
         _loc2_.htmlText = LanguageMgr.GetTranslation("bottle.BottleBoxView.OpenDescribeTxt2",param1);
         _loc2_.x = 90;
         _loc2_.y = 51;
         addChild(_loc2_);
         TweenMax.to(_loc2_,1,{
            "x":281,
            "onComplete":onShowAddIntergalComplete,
            "onCompleteParams":[_loc2_]
         });
      }
      
      private function onShowAddIntergalComplete(param1:TextField) : void
      {
         TweenMax.to(param1,1,{
            "x":400,
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
         var _loc4_:int = 0;
         var _loc3_:int = int(model.openCount);
         var _loc2_:Array = model.getCountArray();
         if(!_loc2_)
         {
            return;
         }
         if(_loc3_ == 0)
         {
            _loc4_ = 0;
         }
         else if(0 < _loc3_ && _loc3_ <= _loc2_[0])
         {
            _loc4_ = 65 * (-(426 - _loc3_ * HEIGHT_ARRAY[4] / _loc2_[0] - 5) + 426) / 390;
         }
         else if(_loc2_[0] < _loc3_ && _loc3_ <= _loc2_[1])
         {
            _loc4_ = 65 * (-(426 - (_loc3_ - _loc2_[0]) * HEIGHT_ARRAY[3] / (_loc2_[1] - _loc2_[0]) - 33) + 426) / 390;
         }
         else if(_loc2_[1] < _loc3_ && _loc3_ <= _loc2_[2])
         {
            _loc4_ = 65 * (-(426 - (_loc3_ - _loc2_[1]) * HEIGHT_ARRAY[2] / (_loc2_[2] - _loc2_[1]) - 118) + 426) / 390;
         }
         else if(_loc2_[2] < _loc3_ && _loc3_ <= _loc2_[3])
         {
            _loc4_ = 65 * (-(426 - (_loc3_ - _loc2_[2]) * HEIGHT_ARRAY[1] / (_loc2_[3] - _loc2_[2]) - 203) + 426) / 390;
         }
         else if(_loc2_[3] < _loc3_ && _loc3_ < _loc2_[4])
         {
            _loc4_ = 65 * (-(426 - (_loc3_ - _loc2_[3]) * HEIGHT_ARRAY[0] / (_loc2_[4] - _loc2_[3]) - 288) + 426) / 390;
         }
         else if(_loc3_ >= _loc2_[4])
         {
            _loc4_ = 65;
         }
         if(_loc4_ > 0)
         {
            if(!_progressMC)
            {
               _progressMC = ComponentFactory.Instance.creat("asset.bottle.pointmc");
            }
            addChildAt(_progressMC,1);
            _progressMC.x = -59;
            _progressMC.y = 56;
            _progressMC.gotoAndStop(_loc4_);
            if(!_bg2)
            {
               _bg2 = ComponentFactory.Instance.creatComponentByStylename("bottle.percentbg2");
            }
            addChildAt(_bg2,2);
            _bg2.alpha = 0;
         }
         if(_bg2 && model)
         {
            _bg2.tipData = LanguageMgr.GetTranslation("bottle.bottleBottom.costNumber",model.openCount);
         }
         if(_percentbg && model)
         {
            _percentbg.tipData = LanguageMgr.GetTranslation("bottle.bottleBottom.costNumber",model.openCount);
         }
      }
      
      private function get model() : BottleModel
      {
         return BottleManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_percentbg);
         _percentbg = null;
         ObjectUtils.disposeObject(_progressMC);
         _progressMC = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
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

