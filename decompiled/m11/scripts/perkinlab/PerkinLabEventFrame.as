package perkinlab
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
   import events.PerkinLabEvent;
   import manager.LanguageMgr;
   import managers.PerkinLabManager;
   import mvc.module.perkinlab.PerkinLabModel;
   import yishi.keyboard.KeyBoardRegister;
   
   public class PerkinLabEventFrame extends Frame
   {
      
      private var _titlebarBg:MutipleImage;
      
      private var _contentBg:ScaleBitmapImage;
      
      private var _bg:ScaleBitmapImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _listPanel:ListPanel;
      
      private var _eventList:Array;
      
      public function PerkinLabEventFrame()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("PerkinLabEventFrame.title.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("PerkinLabEventFrame.Background");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("PerkinLabEventFrame.eventFrameBg");
         _titlebarBg = ComponentFactory.Instance.creatComponentByStylename("PerkinLabEventFrame.TitleBarBack");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("PerkinLabEventFrame.EventFrameNameTextStyle");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("PerkinLabEventFrame.EventFrameTimeTextStyle");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("PerkinLabEventFrame.EventListPanel");
         _nameTxt.text = LanguageMgr.GetTranslation("PerkinLabEventFrame.name.text");
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
         PerkinLabManager.instance.sendLabOperate(8);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         PerkinLabManager.instance.addEventListener("UPDATE_LOG_LIST",__onEventListUpdata);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         PerkinLabManager.instance.removeEventListener("UPDATE_LOG_LIST",__onEventListUpdata);
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
      
      private function __onEventListUpdata(param1:PerkinLabEvent) : void
      {
         var _loc3_:int = 0;
         _eventList = model.logList;
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
      
      private function get model() : PerkinLabModel
      {
         return PerkinLabManager.instance.model;
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
         if(_bg)
         {
            ObjectUtils.disposeObject(_listPanel);
         }
         _bg = null;
         if(_contentBg)
         {
            ObjectUtils.disposeObject(_contentBg);
         }
         _contentBg = null;
         if(_titlebarBg)
         {
            ObjectUtils.disposeObject(_titlebarBg);
         }
         _titlebarBg = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_timeTxt)
         {
            ObjectUtils.disposeObject(_timeTxt);
         }
         _timeTxt = null;
         if(_listPanel)
         {
            ObjectUtils.disposeObject(_listPanel);
            _listPanel = null;
         }
         _eventList = null;
         super.dispose();
      }
   }
}

