package mainBar.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.player.PlayerAASReqMsg;
   import com.road.yishi.proto.player.PlayerAASRspMsg;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import manager.LanguageMgr;
   import ui.resourcebar.ResourcesBar;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.UserInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CertiCodeHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class IndulgeFrame extends Frame
   {
      
      private var _back1:ScaleBitmapImage;
      
      private var _back2:ScaleLeftRightImage;
      
      private var _back3:ScaleBitmapImage;
      
      private var _back4:ScaleBitmapImage;
      
      private var _spliceLine:ScaleBitmapImage;
      
      private var _descTxt:FilterFrameText;
      
      private var _alertTxt1:FilterFrameText;
      
      private var _alertTxt2:FilterFrameText;
      
      private var _alertTxt3:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _pIdTxt:FilterFrameText;
      
      private var _nameInput:FilterFrameText;
      
      private var _pIdInput:FilterFrameText;
      
      private var _button:IconButton;
      
      private var _notButton:IconButton;
      
      public function IndulgeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.Back1");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.Back2");
         _back3 = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.Back3");
         _back4 = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.Back4");
         _spliceLine = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.SpliceLine");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.Describe");
         _alertTxt1 = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.Alert1");
         _alertTxt2 = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.Alert2");
         _alertTxt3 = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.Alert3");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.NameAlert1");
         _pIdTxt = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.PidAlert1");
         _nameInput = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.Name");
         _pIdInput = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.Pid");
         _pIdInput.maxChars = 18;
         _pIdInput.restrict = "0-9,x,X";
         _button = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.Button");
         _notButton = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeFrame.NotButton");
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_back3);
         addToContent(_back4);
         addToContent(_spliceLine);
         addToContent(_descTxt);
         addToContent(_alertTxt1);
         addToContent(_alertTxt2);
         addToContent(_alertTxt3);
         addToContent(_nameTxt);
         addToContent(_pIdTxt);
         addToContent(_nameInput);
         addToContent(_pIdInput);
         addToContent(_button);
         addToContent(_notButton);
         _descTxt.mouseEnabled = true;
         _descTxt.selectable = false;
         _descTxt.htmlText = LanguageMgr.GetTranslation("mainBar.view.IndulgeFrame.desc");
         _alertTxt1.text = LanguageMgr.GetTranslation("mainBar.view.IndulgeFrame.aler1");
         _alertTxt2.text = LanguageMgr.GetTranslation("mainBar.view.IndulgeFrame.aler2");
         _alertTxt3.text = LanguageMgr.GetTranslation("mainBar.view.IndulgeFrame.aler3");
         _nameTxt.text = LanguageMgr.GetTranslation("mainBar.view.IndulgeFrame.name");
         _pIdTxt.text = LanguageMgr.GetTranslation("mainBar.view.IndulgeFrame.pId");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _button.addEventListener("click",__clickHandler);
         _notButton.addEventListener("click",__clickHandler);
         _nameInput.addEventListener("keyDown",__keyDownHandler);
         _pIdInput.addEventListener("keyDown",__keyDownHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4172,__changeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _button.removeEventListener("click",__clickHandler);
         _notButton.removeEventListener("click",__clickHandler);
         _nameInput.removeEventListener("keyDown",__keyDownHandler);
         _pIdInput.removeEventListener("keyDown",__keyDownHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4172,__changeHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(param1 && param1.currentTarget == _notButton)
         {
            dispose();
            return;
         }
         var _loc2_:String = "";
         if(!_nameInput.text)
         {
            _loc2_ = LanguageMgr.GetTranslation("mainBar.view.IndulgeFrame.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(!CertiCodeHelper.checkCertiCode(_pIdInput.text))
         {
            _loc2_ = LanguageMgr.GetTranslation("mainBar.view.IndulgeFrame.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc4_:PackageOut = new PackageOut(8260);
         var _loc3_:PlayerAASReqMsg = new PlayerAASReqMsg();
         _loc3_.cardId = _pIdInput.text;
         _loc3_.cardName = _nameInput.text;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
         if(param1.keyCode == 13)
         {
            __clickHandler(null);
         }
      }
      
      private function __changeHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:UserInfo = null;
         var _loc6_:URLLoader = null;
         var _loc5_:String = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerAASRspMsg = new PlayerAASRspMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as PlayerAASRspMsg;
         var _loc3_:String = "";
         if(_loc2_.result)
         {
            _loc4_ = PlayerManager.instance.currentPlayerModel.userInfo;
            _loc3_ = LanguageMgr.GetTranslation("mainBar.view.IndulgeFrame.command03");
            MessageTipManager.instance().show(_loc3_);
            if(_loc2_.age >= 18)
            {
               ResourcesBar.instance.closeIndulgeView();
               PlayerManager.instance.currentPlayerModel.isInAAS = false;
            }
            else if(_loc4_.site.indexOf("7road_") < 0)
            {
               _loc6_ = new URLLoader();
               _loc6_.addEventListener("complete",__aasTimeloadComplete);
               _loc5_ = "http://fcm.ddshenqu.cn/aasservlet?op=1&UserName=" + _loc4_.user + "&Site=" + _loc4_.site + "&CardId=" + _loc2_.cardId;
               _loc6_.load(new URLRequest(_loc5_ + "&rnd=" + Math.random().toString()));
            }
            dispose();
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("mainBar.view.IndulgeFrame.command04");
            MessageTipManager.instance().show(_loc3_);
         }
      }
      
      private function __aasTimeloadComplete(param1:Event) : void
      {
      }
      
      private function get model() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("mainBar.view.IndulgeFrame.title");
         LayerManager.Instance.addToLayer(this,2,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

