package simplegame.roses
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FriendManager;
   import yishi.manager.GoodsManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.tips.MessageTipManager;
   
   public class IMQuickRosePresentView extends Frame
   {
      
      public static const ROSEID_1:int = 2170001;
      
      private var _bg:MutipleImage;
      
      private var _inputTipTxt:FilterFrameText;
      
      private var _inputNumTxt:FilterFrameText;
      
      private var _inputBg:ScaleBitmapImage;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _targetName:String;
      
      public function IMQuickRosePresentView(param1:String)
      {
         super();
         _targetName = param1;
         initView();
         addEvent();
      }
      
      public static function getHaveRoseNumber() : int
      {
         return GoodsManager.instance.getGoodsNumByTempId(2170001);
      }
      
      public static function getFriendInfoByName(param1:String) : ThaneInfo
      {
         for each(var _loc2_:ThaneInfo in FriendManager.getInstance().friendList)
         {
            if(_loc2_.nickName == param1 && _loc2_.relation == 1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("friends.view.RosePresentView.title");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewConfirmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewCancleBtn");
         _confirmBtn.icon["setFrame"](1);
         _cancelBtn.icon["setFrame"](1);
         _inputTipTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewInputTipTxt");
         _inputNumTxt = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewInputNumTxt");
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("friends.RosePresentBackViewInputNumBg");
         _inputTipTxt.text = LanguageMgr.GetTranslation("simplegame.roses.RosePresentBackView.inputNum");
         _inputNumTxt.text = "1";
         _inputNumTxt.setSelection(0,_inputNumTxt.length);
         _inputNumTxt.setFocus();
         addToContent(_inputBg);
         addToContent(_inputTipTxt);
         addToContent(_inputNumTxt);
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _confirmBtn.addEventListener("click",__onConfirmClick);
         _cancelBtn.addEventListener("click",__onCancleClick);
         if(_inputNumTxt)
         {
            _inputNumTxt.addEventListener("change",__numInputHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _confirmBtn.removeEventListener("click",__onConfirmClick);
         _cancelBtn.removeEventListener("click",__onCancleClick);
         if(_inputNumTxt)
         {
            _inputNumTxt.removeEventListener("change",__numInputHandler);
         }
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
            case 4:
               dispose();
         }
      }
      
      private function __onConfirmClick(param1:MouseEvent) : void
      {
         sendRosePresent(true,2170001,_targetName,int(_inputNumTxt.text),"");
         dispose();
      }
      
      private function __onCancleClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __numInputHandler(param1:Event) : void
      {
         var _loc2_:int = int(_inputNumTxt.text);
         var _loc3_:int = IMQuickRosePresentView.getHaveRoseNumber();
         if(_loc2_ <= 0 || _loc3_ <= 0)
         {
            _inputNumTxt.text = "";
            return;
         }
         if(_loc2_ > _loc3_)
         {
            _inputNumTxt.text = _loc3_.toString();
            return;
         }
      }
      
      private function sendRosePresent(param1:Boolean, param2:int, param3:String, param4:int, param5:String) : Boolean
      {
         var _loc6_:ThaneInfo = null;
         if(!param1 || param4 <= 0)
         {
            return false;
         }
         var _loc7_:Array = GoodsManager.instance.getBagGoodsByTemplateId(param2);
         if(_loc7_.length == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("Auction.ResultAlert2"));
            return false;
         }
         _loc6_ = IMQuickRosePresentView.getFriendInfoByName(param3);
         if(!_loc6_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.im.IMFrame.present.NotFriends"));
            return false;
         }
         _loc7_.sortOn("isBinds",2);
         SocketSendManager.instance.sendUseItem(_loc7_[0].pos,param4,1,param5,_loc6_.userId);
         return true;
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_inputTipTxt);
         _inputTipTxt = null;
         ObjectUtils.disposeObject(_inputNumTxt);
         _inputNumTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

