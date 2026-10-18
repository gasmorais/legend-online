package svs.view.warteam
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.data.SvsModel;
   import map.campaign.data.SvsUserInfo;
   import map.campaign.event.SvsEvent;
   import mvc.controler.SvsController;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   
   public class SvsEnterWarFrame extends Frame implements IManualSize
   {
      
      private var _listView:SvsEnterWarRightView;
      
      private var _addMemberBtn:IconButton;
      
      private var _tips:FilterFrameText;
      
      private var _controller:SvsController;
      
      private var _model:SvsModel;
      
      private var _isHostPlayer:Boolean;
      
      public function SvsEnterWarFrame()
      {
         super();
         _controller = FrameControllerManager.instance.svsController;
         _model = _controller.model;
         initView();
         addEvent();
         _controller.sendSvsUserInfoReq();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,this.width,this.height);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("gvg.view.ready.EnterWarFrame.title");
         _listView = ComponentFactory.Instance.creatCustomObject("svs.SvsEnterWarRightView");
         _addMemberBtn = ComponentFactory.Instance.creatComponentByStylename("svs.AddMemberButton");
         _tips = ComponentFactory.Instance.creatComponentByStylename("gvg.WarmanTipsTxt");
         _listView.x = 0;
         _listView.y = 0;
         _addMemberBtn.text = LanguageMgr.GetTranslation("map.campaign.view.frame.ArmyManageFrame.add");
         addToContent(_tips);
         addToContent(_listView);
         addToContent(_addMemberBtn);
         _addMemberBtn.enable = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _addMemberBtn.addEventListener("click",__addMemberBtnClickHandler);
         _model.addEventListener("SVS_USER_LIST_CHANGE",__userListChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _addMemberBtn.removeEventListener("click",__addMemberBtnClickHandler);
         _model.removeEventListener("SVS_USER_LIST_CHANGE",__userListChangeHandler);
      }
      
      private function __userListChangeHandler(param1:SvsEvent) : void
      {
         if(_listView)
         {
            _listView.setListView();
         }
         setTips();
         _addMemberBtn.enable = _isHostPlayer;
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
      
      private function __addMemberBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("svsmap",2);
      }
      
      private function setTips() : void
      {
         var _loc1_:* = null;
         if(_tips)
         {
            _tips.setFrame(1);
            _tips.text = LanguageMgr.GetTranslation("gvg.InwarTips") + LanguageMgr.GetTranslation("gvg.NotinWarList");
            for each(_loc1_ in _model.warFightUserList)
            {
               if(_loc1_.userId == ArmyManager.instance.thane.userId && (_loc1_.isExist || _loc1_.hostPlayer == 1))
               {
                  _isHostPlayer = _loc1_.hostPlayer == 1;
                  _tips.setFrame(2);
                  _tips.text = LanguageMgr.GetTranslation("gvg.InwarTips") + LanguageMgr.GetTranslation("gvg.InWarList");
                  break;
               }
            }
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

