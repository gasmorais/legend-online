package skytreasure.view
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.active.PlayerCrashInfoMsg;
   import events.SkyTreasureEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.skytreasure.SkyTreasureModel;
   import skytreasure.SkyTreasureBoxManager;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.SkyTreasureManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class SkyTreasureCenterView extends Sprite implements Disposeable, IEnterFrame
   {
      
      private var _bg:Bitmap;
      
      private var _charged:IconButton;
      
      private var _seniorCharged:IconButton;
      
      private var _startBtn:IconButton;
      
      private var _speedupBtn:IconButton;
      
      private var _ballMove:MovieClip;
      
      private var _skyMove:MovieClip;
      
      private var _numberText:FilterFrameText;
      
      private var _actionValueText:FilterFrameText;
      
      private var _centerBottomBg:Bitmap;
      
      private var _mask:Sprite;
      
      public function SkyTreasureCenterView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.skytreasure.centerLargeBg");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("skytreasure.center.start");
         _startBtn.visible = true;
         _speedupBtn = ComponentFactory.Instance.creatComponentByStylename("skytreasure.center.stop");
         _speedupBtn.tipData = LanguageMgr.GetTranslation("activity.skytreasure.center.speedupTip");
         _speedupBtn.visible = false;
         _charged = ComponentFactory.Instance.creatComponentByStylename("skytreasure.center.charge");
         _charged.tipData = LanguageMgr.GetTranslation("activity.skytreasure.center.chargeTip");
         _seniorCharged = ComponentFactory.Instance.creatComponentByStylename("skytreasure.center.seniorCharge");
         _seniorCharged.tipData = LanguageMgr.GetTranslation("activity.skytreasure.center.seniorchargeTip");
         _ballMove = ComponentFactory.Instance.creatCustomObject("skytreasure.SkyTreasureCenterViewEf");
         _ballMove.stop();
         _skyMove = ComponentFactory.Instance.creatCustomObject("skytreasure.SkyTreasureCenterViewSkyMoveEf");
         _skyMove.stop();
         _numberText = ComponentFactory.Instance.creatComponentByStylename("skytreasure.centerView.numberText");
         _numberText.text = LanguageMgr.GetTranslation("activity.skytreasure.center.stoneNumber",GoodsManager.instance.getBagCountByTempId(1,208049));
         _actionValueText = ComponentFactory.Instance.creatComponentByStylename("skytreasure.centerView.actionValueText");
         _centerBottomBg = ComponentFactory.Instance.creatBitmap("asset.skytreasure.center.bottombg");
         initMask();
         addChild(_bg);
         addChild(_skyMove);
         addChild(_centerBottomBg);
         addChild(_ballMove);
         addChild(_charged);
         addChild(_seniorCharged);
         addChild(_startBtn);
         addChild(_speedupBtn);
         addChild(_numberText);
         addChild(_actionValueText);
         SkyTreasureManager.Instance.state = 2;
      }
      
      private function initEvent() : void
      {
         _charged.addEventListener("click",__chargedHandler);
         _seniorCharged.addEventListener("click",__seniorChargedHandler);
         _startBtn.addEventListener("click",__startHandler);
         _speedupBtn.addEventListener("click",__speedupBtnHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__uPlayerInfoHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__uPlayerInfoHandler);
         SkyTreasureManager.Instance.addEventListener("SKYTREASURE_RANK_UPDATE",__rankUpdate);
         SkyTreasureManager.Instance.addEventListener("SKYTREASURE_SPEEDUP",__speedupHandler);
         SkyTreasureBoxManager.Instance.addEventListener("SKYTREASURE_CREATE_BOX",__createBox);
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function initMask() : void
      {
         _mask = new Sprite();
         _mask.graphics.beginFill(13625548);
         _mask.graphics.drawRect(300,10,476,430);
         _mask.graphics.endFill();
         addChild(_mask);
         this.mask = _mask;
      }
      
      protected function __startHandler(param1:MouseEvent) : void
      {
         if(model.joinInfoVO.actionEnergy <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.skytreasure.center.actionValueAlert"));
            return;
         }
         _ballMove.play();
         SkyTreasureManager.Instance.state = 1;
         if(SkyTreasureBoxManager.Instance.isInitState())
         {
            SkyTreasureBoxManager.Instance.resumeMoveAllBox();
            SkyTreasureBoxManager.Instance.initTimer();
         }
         else
         {
            SkyTreasureBoxManager.Instance.initTimer();
         }
         _skyMove.play();
         _startBtn.visible = false;
         _speedupBtn.visible = true;
         SkyTreasureManager.Instance.sendStart();
      }
      
      private function __createBox(param1:SkyTreasureEvent) : void
      {
         var _loc2_:SkyTreasureBox = param1.data as SkyTreasureBox;
         _loc2_.initTweenMax();
         if(_loc2_)
         {
            addChild(_loc2_);
         }
      }
      
      protected function __speedupBtnHandler(param1:MouseEvent) : void
      {
         SkyTreasureBoxManager.Instance.speedAllBox();
         _ballMove.stop();
         SkyTreasureManager.Instance.state = 2;
         _skyMove.stop();
         _startBtn.visible = true;
         _speedupBtn.visible = false;
         SkyTreasureManager.Instance.sendSpeedup();
      }
      
      private function stop() : void
      {
         SkyTreasureBoxManager.Instance.pauseAllBox();
         _ballMove.stop();
         SkyTreasureManager.Instance.state = 2;
         _skyMove.stop();
         _startBtn.visible = true;
         _speedupBtn.visible = false;
      }
      
      public function enterFrame() : void
      {
         var _loc6_:Rectangle = null;
         var _loc2_:Point = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         if(!SkyTreasureManager.Instance.isStart())
         {
            return;
         }
         if(model.joinInfoVO.actionEnergy <= 0)
         {
            return;
         }
         var _loc1_:Array = SkyTreasureBoxManager.Instance.boxList;
         var _loc8_:Rectangle = _ballMove.getRect(this);
         var _loc10_:Point = this.localToGlobal(new Point(_loc8_.x,_loc8_.y));
         for each(var _loc5_:SkyTreasureBox in _loc1_)
         {
            if(_loc5_.isMoveing())
            {
               _loc6_ = _loc5_.getRect(this);
               _loc2_ = this.localToGlobal(new Point(_loc6_.x,_loc6_.y));
               if(_loc2_.x >= _loc10_.x)
               {
                  _loc3_ = _loc10_.x - _loc2_.x;
                  _loc4_ = _loc10_.y - _loc2_.y;
                  _loc7_ = Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
                  _loc9_ = _loc8_.width / 2 + _loc5_.width / 2;
                  if(_loc7_ < _loc9_)
                  {
                     useActionEnergy();
                     _loc5_.hitDispose();
                  }
               }
            }
         }
      }
      
      private function useActionEnergy() : void
      {
         model.joinInfoVO.useActionEnergy();
         __rankUpdate();
         SkyTreasureManager.Instance.sendHitBox();
         if(model.joinInfoVO.actionEnergy <= 0)
         {
            stop();
            SkyTreasureManager.Instance.sendFinish();
         }
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         if(_charged)
         {
            _charged.removeEventListener("click",__chargedHandler);
         }
         if(_seniorCharged)
         {
            _seniorCharged.removeEventListener("click",__seniorChargedHandler);
         }
         if(_startBtn)
         {
            _startBtn.removeEventListener("click",__startHandler);
         }
         if(_speedupBtn)
         {
            _speedupBtn.removeEventListener("click",__speedupBtnHandler);
         }
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__uPlayerInfoHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__uPlayerInfoHandler);
         SkyTreasureManager.Instance.removeEventListener("SKYTREASURE_RANK_UPDATE",__rankUpdate);
         SkyTreasureManager.Instance.removeEventListener("SKYTREASURE_CREATE_BOX",__createBox);
         SkyTreasureManager.Instance.removeEventListener("SKYTREASURE_SPEEDUP",__speedupHandler);
      }
      
      public function get model() : SkyTreasureModel
      {
         return SkyTreasureManager.Instance.model;
      }
      
      private function __rankUpdate(param1:SkyTreasureEvent = null) : void
      {
         _actionValueText.text = LanguageMgr.GetTranslation("activity.skytreasure.center.actionValueNumber",model.joinInfoVO.actionEnergy);
      }
      
      private function __speedupHandler(param1:SkyTreasureEvent) : void
      {
         var _loc3_:PlayerCrashInfoMsg = param1.data as PlayerCrashInfoMsg;
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("activity.skytreasure.center.speedupComplete",model.joinInfoVO.actionEnergy,_loc3_.crashScore);
         var _loc4_:TodayNotAlertFrame = ComponentFactory.Instance.creatComponentByStylename("skytreasure.center.speedTip");
         _loc4_.show(_loc2_,"");
         _loc4_._describeTxt.text = _loc2_;
         model.joinInfoVO.actionEnergy = 0;
      }
      
      private function __uPlayerInfoHandler(param1:BagEvent) : void
      {
         _numberText.text = LanguageMgr.GetTranslation("activity.skytreasure.center.stoneNumber",GoodsManager.instance.getBagCountByTempId(1,208049));
      }
      
      private function __chargedHandler(param1:MouseEvent) : void
      {
         if(SkyTreasureManager.Instance.isStart())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.skytreasure.center.tips"));
            return;
         }
         var _loc2_:int = int(GoodsManager.instance.getBagCountByTempId(1,208049));
         if(_loc2_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.skyTreasure.center.senoirCharge"));
            return;
         }
         SkyTreasureManager.Instance.commonCharge();
      }
      
      private function __confirmCharge(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(param1)
         {
            _loc3_ = int(GoodsManager.instance.getBagCountByTempId(1,208049));
            if(_loc3_ < 50)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.skyTreasure.center.senoirCharge"));
               return;
            }
            SkyTreasureManager.Instance.senoirCharge();
         }
      }
      
      private function __seniorChargedHandler(param1:MouseEvent) : void
      {
         if(SkyTreasureManager.Instance.isStart())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.skytreasure.center.tips"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208049);
         var _loc6_:String = LanguageMgr.GetTranslation("activity.skytreasure.senoircharge.content",_loc5_.TemplateName);
         SimpleAlertHelper.instance.data = [__confirmCharge];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc6_,_loc2_,_loc3_);
      }
      
      public function dispose() : void
      {
         removeEvent();
         SkyTreasureBoxManager.Instance.dispose();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_centerBottomBg);
         _centerBottomBg = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_speedupBtn);
         _speedupBtn = null;
         ObjectUtils.disposeObject(_charged);
         _charged = null;
         ObjectUtils.disposeObject(_seniorCharged);
         _seniorCharged = null;
         ObjectUtils.disposeObject(_ballMove);
         _ballMove = null;
         ObjectUtils.disposeObject(_skyMove);
         _skyMove = null;
         ObjectUtils.disposeObject(_numberText);
         _numberText = null;
         ObjectUtils.disposeObject(_actionValueText);
         _actionValueText = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function test() : void
      {
      }
   }
}

