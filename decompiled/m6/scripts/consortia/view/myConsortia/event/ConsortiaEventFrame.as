package consortia.view.myConsortia.event
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   
   public class ConsortiaEventFrame extends Frame
   {
      
      private var _titlebarBg:MutipleImage;
      
      private var _contentBg:ScaleBitmapImage;
      
      private var _bg:ScaleBitmapImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _listPanel:ListPanel;
      
      private var _data:ConsortiaModel;
      
      private var _eventList:Array;
      
      public function ConsortiaEventFrame()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.event.ConsortiaEventFrame.title");
         _data = FrameControllerManager.instance.consortiaController.model;
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.EventFrameDescribeBackground");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("consortia.eventFrameBg");
         _titlebarBg = ComponentFactory.Instance.creatComponentByStylename("consortia.TitleBarBack");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.EventFrameNameTextStyle");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.EventFrameTimeTextStyle");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("consortia.EventListPanel");
         _nameTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.event.ConsortiaEventFrame.title");
         _timeTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.event.ConsortiaEventFrame.time");
         _listPanel.hScrollProxy = 2;
         _listPanel.viewPort.verticalUnitIncrement = 56;
         _listPanel.beginChanges();
         _listPanel.commitChanges();
         addToContent(_bg);
         addToContent(_contentBg);
         addToContent(_titlebarBg);
         addToContent(_nameTxt);
         addToContent(_timeTxt);
         addToContent(_listPanel);
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.consortiaController.getConsortiaEventInfos();
      }
      
      private function uninit() : void
      {
         if(_listPanel)
         {
            ObjectUtils.disposeObject(_listPanel);
         }
         _listPanel = null;
         _data = null;
         _eventList = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _data.addEventListener("UPDA_CONSORTIA_EVENT_LIST",__onEventListUpdata);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _data.removeEventListener("UPDA_CONSORTIA_EVENT_LIST",__onEventListUpdata);
         playerInfo.removeEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __existConsortiaHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID == 0)
         {
            dispose();
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function __onEventListUpdata(param1:ConsortiaEvent) : void
      {
         var _loc3_:int = 0;
         _eventList = _data.consortiaEventList;
         var _loc2_:int = int(_eventList.length > 11 ? _eventList.length : 11);
         _listPanel.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _listPanel.vectorListModel.append(_eventList[_loc3_]);
            _loc3_++;
         }
         _listPanel.commitChanges();
         _listPanel.invalidateViewport();
         _listPanel.list.updateListView();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
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

