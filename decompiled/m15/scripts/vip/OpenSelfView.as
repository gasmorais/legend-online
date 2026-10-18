package vip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.VIPEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import mvc.module.vip.VIPModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.NoviceBtnGlowEffect;
   import yishi.utils.SimpleAlertHelper;
   
   public class OpenSelfView extends Sprite implements Disposeable
   {
      
      private var _currentPointTxt:FilterFrameText;
      
      private var _openVipBtn:IconButton;
      
      private var _renewVipBtn:IconButton;
      
      private var _giftBagBtn:IconButton;
      
      private var _giftBagFrame:VipGiftFrame;
      
      private var _vIPPromptTxt:FilterFrameText;
      
      private var _itemList:Array;
      
      private var _currentItem:OpenVipItem;
      
      private var _privilegeContentBg:MutipleImage;
      
      private var _privilegeTitleTxt:GradientText;
      
      private var _privilegeContentTextArea:TextArea;
      
      private var _privilegeImg:ScaleFrameImage;
      
      private var _disEffect:NoviceBtnGlowEffect;
      
      private var _disOpenEffect:NoviceBtnGlowEffect;
      
      private var _privilegeNumList:Array = [11,13,13,20];
      
      public function OpenSelfView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:OpenVipItem = null;
         _giftBagBtn = ComponentFactory.Instance.creatComponentByStylename("vip.GiftBagBtn");
         _vIPPromptTxt = ComponentFactory.Instance.creatComponentByStylename("vip.VIPPromptTxt");
         _privilegeContentBg = ComponentFactory.Instance.creatComponentByStylename("vip.OpenSelfViewPrivilegeContentMultipleBg");
         _privilegeTitleTxt = ComponentFactory.Instance.creatComponentByStylename("vip.OpenSelfViewPrivilegeTitleGradientTxt");
         _privilegeContentTextArea = ComponentFactory.Instance.creatComponentByStylename("vip.OpenSelfViewPrivilegeContentTextArea");
         _privilegeImg = ComponentFactory.Instance.creatComponentByStylename("vip.OpenSelfViewPrivilegeImg");
         _renewVipBtn = ComponentFactory.Instance.creatComponentByStylename("vip.RenewVipBtn");
         _openVipBtn = ComponentFactory.Instance.creatComponentByStylename("vip.OpenVipBtn");
         _disEffect = new NoviceBtnGlowEffect(_giftBagBtn);
         _disOpenEffect = new NoviceBtnGlowEffect(_openVipBtn);
         if(vipModel.vipInfo.IsVipAndNoExpirt)
         {
            if(vipModel.vipInfo.IsTakeGift && Boolean(vipModel.vipInfo.IsVipAndNoExpirt))
            {
               _disEffect.play();
            }
            else
            {
               _disEffect.stop();
            }
            _disOpenEffect.stop();
            _giftBagBtn.visible = true;
            _renewVipBtn.visible = true;
            _openVipBtn.visible = false;
         }
         else
         {
            _disOpenEffect.play();
            _giftBagBtn.visible = false;
            _renewVipBtn.visible = false;
            _openVipBtn.visible = true;
         }
         addChild(_openVipBtn);
         addChild(_renewVipBtn);
         addChild(_giftBagBtn);
         addChild(_vIPPromptTxt);
         addChild(_privilegeContentBg);
         addChild(_privilegeTitleTxt);
         addChild(_privilegeContentTextArea);
         addChild(_privilegeImg);
         _renewVipBtn.x = 297;
         _itemList = [];
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new OpenVipItem();
            addChild(_loc1_);
            _loc1_.index = _loc2_;
            _loc1_.y = -11;
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _itemList[0].x = 12;
         _itemList[1].x = 237;
         _itemList[2].x = 390;
      }
      
      private function initEvent() : void
      {
         _giftBagBtn.addEventListener("click",__giftBagHandler);
         _openVipBtn.addEventListener("click",__openVipHandler);
         _renewVipBtn.addEventListener("click",__openVipHandler);
         _itemList[0].addEventListener("click",__clickHnadler);
         _itemList[1].addEventListener("click",__clickHnadler);
         _itemList[2].addEventListener("click",__clickHnadler);
         vipModel.addEventListener("upframeview_change",__UpViewFrame);
         _itemList[0].dispatchEvent(new MouseEvent("click"));
      }
      
      private function removeEvent() : void
      {
         _giftBagBtn.removeEventListener("click",__giftBagHandler);
         _openVipBtn.removeEventListener("click",__openVipHandler);
         _renewVipBtn.removeEventListener("click",__openVipHandler);
         _itemList[0].removeEventListener("click",__clickHnadler);
         _itemList[1].removeEventListener("click",__clickHnadler);
         _itemList[2].removeEventListener("click",__clickHnadler);
         vipModel.removeEventListener("upframeview_change",__UpViewFrame);
      }
      
      private function __clickHnadler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _itemList[_loc2_].isSelect = param1.currentTarget == _itemList[_loc2_];
            _loc2_++;
         }
         _currentItem = param1.currentTarget as OpenVipItem;
         var _loc3_:int = getPrivilegeIndex(_currentItem.index);
         _privilegeImg.setFrame(_loc3_);
         _privilegeTitleTxt.text = LanguageMgr.GetTranslation("vip.VipPrivilegeFrame.privilegeTitle",_loc3_,VipContentHelper.getnumByGrade(_loc3_));
         _privilegeContentTextArea.htmlText = VipContentHelper.getContentByGrade(_loc3_);
      }
      
      private function __openVipHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(playerInfo.point < _currentItem.point)
         {
            RechargeAlertMannager.show();
            return;
         }
         var _loc5_:String = LanguageMgr.GetTranslation("vip.view.OpenFriendView.command01",_currentItem.index,_currentItem.point);
         SimpleAlertHelper.instance.data = [_confirmFun];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
      }
      
      private function _confirmFun(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            VIPManager.Instance.openVip(false,0,"",_currentItem.index * 31);
         }
      }
      
      private function __giftBagHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.vipController.showGiftFrame();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __UpViewFrame(param1:VIPEvent) : void
      {
         if(vipModel.vipInfo.IsVipAndNoExpirt)
         {
            if(vipModel.vipInfo.IsTakeGift && Boolean(vipModel.vipInfo.IsVipAndNoExpirt))
            {
               _disEffect.play();
            }
            else
            {
               _disEffect.stop();
            }
            _disOpenEffect.stop();
            _giftBagBtn.visible = true;
            _renewVipBtn.visible = true;
            _openVipBtn.visible = false;
         }
         else
         {
            _disOpenEffect.play();
            _giftBagBtn.visible = false;
            _renewVipBtn.visible = false;
            _openVipBtn.visible = true;
         }
      }
      
      private function getPrivilegeIndex(param1:int) : int
      {
         switch(param1 - 3)
         {
            case 0:
               return 2;
            case 3:
               return 4;
            default:
               return param1;
         }
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _privilegeNumList = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

