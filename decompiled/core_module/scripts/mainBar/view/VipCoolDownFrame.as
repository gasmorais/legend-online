package mainBar.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.view.tips.MessageTipManager;
   
   public class VipCoolDownFrame extends Frame
   {
      
      public static const PAY_TYPE_POINT:int = 1;
      
      public static const PAY_TYPE_GIFT:int = 2;
      
      public static const PAY_MONEY:int = 3;
      
      private var _pointIcon:Image;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _useBindBtn:SelectedCheckButton;
      
      private var _tipTxt:FilterFrameText;
      
      private var _vipCoolTxt:FilterFrameText;
      
      private var _promptTxt:FilterFrameText;
      
      private var _type:int;
      
      private var _objectId:int;
      
      private var _point:int;
      
      private var _gift:int;
      
      private var _callBack:Function;
      
      public function VipCoolDownFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function initView() : void
      {
         _pointIcon = ComponentFactory.Instance.creatComponentByStylename("queueBar.VoucherBack");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("queueBar.QuickCodeButton");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("queueBar.CloseButton");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("queueBar.AlertTextStyle_2");
         _vipCoolTxt = ComponentFactory.Instance.creatComponentByStylename("queueBar.VipCoolTextStyle");
         _useBindBtn = ComponentFactory.Instance.creatComponentByStylename("queuebar.useBindPointBtn");
         addToContent(_pointIcon);
         _promptTxt = ComponentFactory.Instance.creatComponentByStylename("queueBar.promptTxt");
         _promptTxt.text = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.promptTxt");
         addToContent(_confirmBtn);
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm1");
         addToContent(_cancelBtn);
         _cancelBtn.text = LanguageMgr.GetTranslation("public.close1");
         addToContent(_tipTxt);
         _tipTxt.text = LanguageMgr.GetTranslation("mainBar.view.ChoosePayTypeFrame.tipTxtText");
         addToContent(_vipCoolTxt);
         addToContent(_useBindBtn);
         _useBindBtn.text = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.useBind");
         addToContent(_promptTxt);
         var _loc2_:String = LanguageMgr.GetTranslation("mainBar.view.ChoosePayTypeFrame.vipCoolTxt");
         var _loc3_:String = LanguageMgr.GetTranslation("mainBar.view.ChoosePayTypeFrame.openVipTxt");
         var _loc1_:String = LanguageMgr.GetTranslation("public.parentheses1","<font color=\'#06ff00\'><a href=\'event:clickLink\'><u>" + _loc3_ + "</u></a></font>");
         _vipCoolTxt.htmlText = _loc2_ + _loc1_;
         _vipCoolTxt.mouseEnabled = true;
         _useBindBtn.selected = true;
      }
      
      private function setChildPosition() : void
      {
         _tipTxt.x = (width - _tipTxt.textWidth) / 2 - _pointIcon.width;
         _vipCoolTxt.x = (width - _vipCoolTxt.textWidth) / 2;
         _pointIcon.x = _tipTxt.x + _tipTxt.textWidth + 5;
         _promptTxt.x = (width - _promptTxt.textWidth) / 2;
         _useBindBtn.x = (width - _useBindBtn.width) / 2;
         _promptTxt.y = _useBindBtn.y + _useBindBtn.height + 5;
         _confirmBtn.y = _cancelBtn.y = _promptTxt.y + _promptTxt.height + 5;
         height = _container.height + _containerY + 50;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _callBack = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
         _vipCoolTxt.addEventListener("link",__link);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",__confirmHandler);
         _cancelBtn.removeEventListener("click",__cancelHandler);
         _vipCoolTxt.removeEventListener("link",__link);
      }
      
      public function initData(param1:String, param2:String, param3:int, param4:int, param5:int, param6:Function, param7:String, param8:String) : void
      {
         _objectId = param3;
         _point = param4;
         _gift = param5;
         titleText = param1;
         _tipTxt.htmlText = param2;
         _confirmBtn.text = param7;
         _cancelBtn.text = param8;
         _callBack = param6;
         _type = 3;
         _pointIcon.x = _tipTxt.x + _tipTxt.textWidth + 3;
         _pointIcon.y = _tipTxt.y;
         setChildPosition();
      }
      
      private function __link(param1:TextEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("vip");
         _callBack(false);
         dispose();
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _callBack(false);
         dispose();
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         SoundManager.instance.play("022");
         if(_type == 1)
         {
            SharedManager.instance.payChooseType = 1;
            _loc5_ = PlayerManager.instance.currentPlayerModel.playerInfo.point;
            if(_loc5_ < _point)
            {
               RechargeAlertMannager.show();
               return;
            }
         }
         else if(_type == 3)
         {
            SharedManager.instance.payChooseType = 3;
            _loc5_ = PlayerManager.instance.currentPlayerModel.playerInfo.point + PlayerManager.instance.currentPlayerModel.playerInfo.giftToken;
            if(_loc5_ < _point)
            {
               _loc2_ = LanguageMgr.GetTranslation("yishi.manager.RechargeAlertMannager.content");
               RechargeAlertMannager.show();
               return;
            }
         }
         else
         {
            SharedManager.instance.payChooseType = 2;
            _loc5_ = PlayerManager.instance.currentPlayerModel.playerInfo.giftToken;
            if(_loc5_ < _point)
            {
               _loc3_ = LanguageMgr.GetTranslation("mainBar.view.ChoosePayTypeFrame.command01");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
         }
         if(_useBindBtn.selected)
         {
            _loc4_ = PlayerManager.instance.currentPlayerModel.playerInfo.point + PlayerManager.instance.currentPlayerModel.playerInfo.giftToken;
         }
         else
         {
            _loc4_ = PlayerManager.instance.currentPlayerModel.playerInfo.point;
         }
         if(_loc4_ < _point)
         {
            _callBack(false);
            RechargeAlertMannager.show();
            dispose();
            return;
         }
         _callBack(true,_objectId,_type,_useBindBtn.selected);
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode - 2)
         {
            case 0:
            case 1:
               __confirmHandler(null);
               return;
            default:
               _callBack(false);
               dispose();
               return;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,false,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

