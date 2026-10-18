package godsevening
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import manager.LanguageMgr;
   
   public class GECheckRewardFrame extends Frame
   {
      
      private var _hbox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _btnServer:SelectedIconButton;
      
      private var _btnPersonal:SelectedIconButton;
      
      private var _serverView:GECheckRewardServerView;
      
      private var _personalView:GECheckRewardPersonalView;
      
      public function GECheckRewardFrame()
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
         _serverView = ComponentFactory.Instance.creatCustomObject("godsevening.GECheckRewardServerView");
         _personalView = ComponentFactory.Instance.creatCustomObject("godsevening.GECheckRewardPersonalView");
         _btnServer = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardFrame.ServerBtn");
         _btnPersonal = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardFrame.PersonalBtn");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("GECheckRewardFrame.SelectedIconButtonHbox");
         addToContent(_serverView);
         addToContent(_personalView);
         addToContent(_hbox);
         _hbox.addChild(_btnServer);
         _hbox.addChild(_btnPersonal);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_btnServer);
         _btnGroup.addSelectItem(_btnPersonal);
         titleText = LanguageMgr.GetTranslation("godsEvening.checkRewardFrame.title");
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_btnServer);
         _btnServer = null;
         ObjectUtils.disposeObject(_btnPersonal);
         _btnPersonal = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_serverView);
         _serverView = null;
         ObjectUtils.disposeObject(_personalView);
         _personalView = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btnGroup.addEventListener("change",__selectedChangHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _btnGroup.removeEventListener("change",__selectedChangHandler);
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
      
      private function __selectedChangHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_btnGroup.getSelectedItem())
         {
            case _btnServer:
               _serverView.visible = true;
               _personalView.visible = false;
               break;
            case _btnPersonal:
               _serverView.visible = false;
               _personalView.visible = true;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

