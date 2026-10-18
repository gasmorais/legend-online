package continuePayRebate
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import continuePayRebate.view.ContinuePayRebateChestView;
   import continuePayRebate.view.ContinuePayRebateRewardView;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import funny.FunnyEvent;
   import funny.datas.FunnyData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import mvc.module.funny.FunnyModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class ContinuePayRebateFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _back:Bitmap;
      
      private var _chestView:ContinuePayRebateChestView;
      
      private var _rewardView:ContinuePayRebateRewardView;
      
      private var _payBtn:IconButton;
      
      private var _payText:FilterFrameText;
      
      private var _countDown:FilterFrameText;
      
      private var _timer:Timer;
      
      private var _helpBtn:BaseButton;
      
      private var _hasPayNum:int = 0;
      
      public function ContinuePayRebateFrame()
      {
         FunnyManager.instance.sendGetBag(1);
         super();
         initView();
         intitData();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,693,506);
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("ContinuePayRebateFrame.border");
         _back = ComponentFactory.Instance.creatBitmap("asset.continuePayRebate.topBack");
         _chestView = ComponentFactory.Instance.creatCustomObject("continuePayRebate.view.ContinuePayRebateChestView");
         _rewardView = ComponentFactory.Instance.creatCustomObject("continuePayRebate.view.ContinuePayRebateRewardView");
         _payBtn = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.payBtn");
         _payText = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.payText");
         _countDown = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.countDown");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.helpBtn");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_border)
         {
            addToContent(_border);
         }
         if(_back)
         {
            addToContent(_back);
         }
         if(_chestView)
         {
            addToContent(_chestView);
         }
         if(_rewardView)
         {
            addToContent(_rewardView);
         }
         if(_payBtn)
         {
            addToContent(_payBtn);
         }
         if(_payText)
         {
            addToContent(_payText);
         }
         if(_countDown)
         {
            addToContent(_countDown);
         }
         if(_helpBtn)
         {
            addToContent(_helpBtn);
         }
      }
      
      private function intitData() : void
      {
         if(model.continuePayRebateChestData.length < 1 || !model.continuePayRebateData || model.continuePayRebateData.bagList.length < 1)
         {
            return;
         }
         _chestView.data = model.continuePayRebateChestData;
         _rewardView.data = model.continuePayRebateData;
         if(model.continuePayRebateChestData[0].finishNum > 0)
         {
            _hasPayNum = model.continuePayRebateChestData[0].finishNum;
         }
         _payText.text = LanguageMgr.GetTranslation("continuePayRebate.mainframe.hasPayCount",_hasPayNum);
         __timerHandler(null);
      }
      
      private function addTimeEvent() : void
      {
         if(!_timer)
         {
            return;
         }
         _timer.stop();
         _timer.removeEventListener("timer",__timerHandler);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function removeTimeEvent() : void
      {
         if(!_timer)
         {
            return;
         }
         _timer.stop();
         _timer.removeEventListener("timer",__timerHandler);
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         if(model.continuePayRebateChestData.length < 1)
         {
            return;
         }
         var _loc2_:FunnyData = model.continuePayRebateChestData[0];
         var _loc3_:Number = _loc2_.endTime / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc3_ >= 60)
         {
            _countDown.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullTimeString(_loc3_));
         }
         else if(_loc3_ > 0)
         {
            _countDown.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullDateString(_loc3_));
         }
         else
         {
            _countDown.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
         }
         if(_loc2_.startTime == -1 || _loc2_.startTime > playerModel.nowDate)
         {
            _countDown.visible = false;
            removeTimeEvent();
         }
         else
         {
            _countDown.visible = true;
            addTimeEvent();
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         FunnyManager.instance.addEventListener("REFRESH_ITEM",__refreshHandler);
         _payBtn.addEventListener("click",__onPayBtnClick);
         _helpBtn.addEventListener("click",__onHelpBtnClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         FunnyManager.instance.removeEventListener("REFRESH_ITEM",__refreshHandler);
         _payBtn.removeEventListener("click",__onPayBtnClick);
         _helpBtn.removeEventListener("click",__onHelpBtnClick);
      }
      
      protected function __onPayBtnClick(param1:MouseEvent) : void
      {
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function __onHelpBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("continuePayRebate.helperFrame");
         _loc2_.show();
      }
      
      private function __refreshHandler(param1:FunnyEvent) : void
      {
         intitData();
      }
      
      private function get model() : FunnyModel
      {
         return FunnyManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         titleText = LanguageMgr.GetTranslation("continuePayRebate.ContinuePayRebateFrame.titleText");
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_chestView);
         _chestView = null;
         ObjectUtils.disposeObject(_rewardView);
         _rewardView = null;
         ObjectUtils.disposeObject(_payBtn);
         _payBtn = null;
         ObjectUtils.disposeObject(_payText);
         _payText = null;
         super.dispose();
      }
   }
}

