package publicegg
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.sumpassion.LevelMsg;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.PublicEggManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   
   public class PublicGiftItem extends Component
   {
      
      private var _giftMsg:LevelMsg;
      
      private var _giftType:int;
      
      private var _itemBg:Bitmap;
      
      private var _itemline:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      private var _leftTxt:FilterFrameText;
      
      private var _buyBtn:IconButton;
      
      private var _smallPointImg:Image;
      
      private var _exchargeBtn:TextButton;
      
      private var _receiveBtn:IconButton;
      
      private var _rewardsHBox:HBox;
      
      private var _rewardsPanel:ScrollPanel;
      
      public function PublicGiftItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatBitmap("asset.publicgift.itemBg");
         _itemline = ComponentFactory.Instance.creatBitmap("asset.publicgift.itemline");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("publicgift.item.nameTxt");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("publicgift.item.pointTxt");
         _leftTxt = ComponentFactory.Instance.creatComponentByStylename("publicgift.item.leftTxt");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("publicgift.item.buyBtn");
         _smallPointImg = ComponentFactory.Instance.creatComponentByStylename("publicgift.SmallPointImg");
         _exchargeBtn = ComponentFactory.Instance.creatComponentByStylename("publicgift.item.exchargeBtn");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("publicgift.item.receiveBtn");
         _rewardsHBox = ComponentFactory.Instance.creatComponentByStylename("publicgift.item.RewardsHBox");
         _rewardsPanel = ComponentFactory.Instance.creatComponentByStylename("publicgift.item.panel");
         addChild(_itemBg);
         addChild(_itemline);
         addChild(_nameTxt);
         addChild(_pointTxt);
         addChild(_leftTxt);
         addChild(_buyBtn);
         addChild(_smallPointImg);
         addChild(_exchargeBtn);
         addChild(_receiveBtn);
         addChild(_rewardsHBox);
         addChild(_rewardsPanel);
         _rewardsPanel.setView(_rewardsHBox);
         _itemBg.visible = false;
      }
      
      private function initEvent() : void
      {
         _buyBtn.addEventListener("click",__buyHandler);
         _exchargeBtn.addEventListener("click",__exchargeHandler);
         _receiveBtn.addEventListener("click",__receiveHandler);
         NotificationManager.instance.addEventListener("PUBLIC_GIFT_UPDATE",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         _buyBtn.removeEventListener("click",__buyHandler);
         _exchargeBtn.removeEventListener("click",__exchargeHandler);
         _receiveBtn.removeEventListener("click",__receiveHandler);
         NotificationManager.instance.removeEventListener("PUBLIC_GIFT_UPDATE",__updateViewHandler);
      }
      
      private function __buyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SimpleAlertHelper.instance.data = [alertHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("publicegg.PublicGiftItem.buyBtn",_giftMsg.needPoint,_giftMsg.maxTakeDays - _giftMsg.takeDays);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true);
      }
      
      private function alertHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _giftMsg.needPoint)
            {
               RechargeAlertMannager.show();
               return;
            }
            PublicEggManager.instance.OperateGiftReq(2,_giftType,_giftMsg.levelId);
         }
      }
      
      private function __exchargeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function __receiveHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         PublicEggManager.instance.OperateGiftReq(3,_giftType,_giftMsg.levelId);
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         data = _giftMsg;
      }
      
      public function set giftType(param1:int) : void
      {
         _giftType = param1;
      }
      
      public function set data(param1:LevelMsg) : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         var _loc4_:int = 0;
         _giftMsg = param1;
         _nameTxt.text = LanguageMgr.GetTranslation("publicegg.PublicGiftItem.nameTxt",_giftMsg.maxTakeDays);
         _pointTxt.text = _giftMsg.needPoint.toString();
         _leftTxt.text = LanguageMgr.GetTranslation("publicchairs.PublicGiftItem.leftTxt",_giftMsg.maxTakeDays - _giftMsg.takeDays);
         _exchargeBtn.text = LanguageMgr.GetTranslation("publicchairs.PublicGiftItem.exchargeBtn",_giftMsg.needPoint,_giftMsg.maxTakeDays);
         _loc4_ = 0;
         while(_loc4_ < _giftMsg.item.length)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("publicgift.item.BaseItemView");
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _giftMsg.item[_loc4_].templateId;
            _loc3_.count = _giftMsg.item[_loc4_].counts;
            _loc2_.data = _loc3_;
            _rewardsHBox.addChild(_loc2_);
            _loc4_++;
         }
         _rewardsPanel.invalidateViewport();
         _buyBtn.visible = false;
         _smallPointImg.visible = false;
         _pointTxt.visible = false;
         _exchargeBtn.visible = false;
         _receiveBtn.visible = false;
         _receiveBtn.enable = false;
         _leftTxt.visible = false;
         if(_giftType == 1)
         {
            _buyBtn.visible = !_giftMsg.isFinish;
            _smallPointImg.visible = !_giftMsg.isFinish;
            _pointTxt.visible = !_giftMsg.isFinish;
            _receiveBtn.visible = _giftMsg.isFinish;
            _leftTxt.visible = _giftMsg.isFinish;
            _receiveBtn.enable = _giftMsg.canTake;
         }
         else if(_giftType == 2)
         {
            _exchargeBtn.visible = !_giftMsg.isFinish;
            _receiveBtn.visible = _giftMsg.isFinish;
            _leftTxt.visible = _giftMsg.isFinish;
            _receiveBtn.enable = _giftMsg.canTake;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_itemline);
         _itemline = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_leftTxt);
         _leftTxt = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_smallPointImg);
         _smallPointImg = null;
         ObjectUtils.disposeObject(_exchargeBtn);
         _exchargeBtn = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_rewardsHBox);
         _rewardsHBox = null;
         ObjectUtils.disposeObject(_rewardsPanel);
         _rewardsPanel = null;
         _giftMsg = null;
         super.dispose();
      }
   }
}

