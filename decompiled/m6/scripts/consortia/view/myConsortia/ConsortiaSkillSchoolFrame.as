package consortia.view.myConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.view.myConsortia.newui.ConsortiaSkillSchoolView;
   import events.ConsortiaEvent;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   
   public class ConsortiaSkillSchoolFrame extends Frame
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _skillView:ConsortiaSkillSchoolView;
      
      private var _btnHbox:HBox;
      
      private var _masterBtn:SelectedIconButton;
      
      private var _schoolBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _isShow:Boolean = false;
      
      private var _openFromConsortiaFrame:int;
      
      public function ConsortiaSkillSchoolFrame()
      {
         super();
         initView();
         addEvent();
         _btnGroup.selectIndex = 0;
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaSkillSchoolFrame.border");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSkillSchoolFrame.btnHbox");
         _masterBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSkillSchoolView.masterBtn");
         _schoolBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSkillSchoolView.schoolBtn");
         _skillView = ComponentFactory.Instance.creatCustomObject("Consortia.ConsortiaSkillSchoolFrame.skillView");
         addToContent(_border);
         addToContent(_btnHbox);
         addToContent(_skillView);
         _btnHbox.addChild(_masterBtn);
         _btnHbox.addChild(_schoolBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_masterBtn);
         _btnGroup.addSelectItem(_schoolBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
         model.addEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdata);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
         model.removeEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdata);
      }
      
      private function __onConsortiaInfoUpdata(param1:ConsortiaEvent) : void
      {
         refreshView();
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         refreshView();
      }
      
      private function refreshView() : void
      {
         _skillView.refreshView(_btnGroup.selectIndex + 1);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _isShow = true;
               dispose();
         }
      }
      
      public function show(param1:int) : void
      {
         _openFromConsortiaFrame = param1;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("ConsortiaFacilitiesView.masterChurchText.text");
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_btnHbox);
         _btnHbox = null;
         ObjectUtils.disposeObject(_masterBtn);
         _masterBtn = null;
         ObjectUtils.disposeObject(_schoolBtn);
         _schoolBtn = null;
         ObjectUtils.disposeObject(_skillView);
         _skillView = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         super.dispose();
         FrameControllerManager.instance.consortiaController.closeSkillFrame(_openFromConsortiaFrame,_isShow);
      }
   }
}

