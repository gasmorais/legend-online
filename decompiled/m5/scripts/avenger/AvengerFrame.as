package avenger
{
   import avenger.view.AvengerBodyView;
   import avenger.view.AvengerChildNsView;
   import avenger.view.AvengerDevilArmorView;
   import avenger.view.AvengerEyeView;
   import avenger.view.AvengerSkillView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import yishi.datas.VersionSwitch;
   import yishi.manager.AvengerManager;
   import yishi.manager.PlayerManager;
   
   public class AvengerFrame extends Frame
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _bodyBtn:SelectedIconButton;
      
      private var _eyeBtn:SelectedIconButton;
      
      private var _skillBtn:SelectedIconButton;
      
      private var _devilArmorBtn:SelectedIconButton;
      
      private var _childNsBtn:SelectedIconButton;
      
      private var _skillView:AvengerSkillView;
      
      private var _bodyView:AvengerBodyView;
      
      private var _eyeView:AvengerEyeView;
      
      private var _devilArmorView:AvengerDevilArmorView;
      
      private var _childNsView:AvengerChildNsView;
      
      private var _btnGroup:SelectedButtonGroup;
      
      public function AvengerFrame()
      {
         super();
         initView();
         addEvent();
         _btnGroup.selectIndex = 0;
         AvengerManager.instance.sendAvengerDataRequest();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,757,562);
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerFrame.border");
         _bodyBtn = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerFrame.bodyBtn");
         _eyeBtn = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerFrame.eyeBtn");
         _skillBtn = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerFrame.skillBtn");
         _devilArmorBtn = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerFrame.devilArmorBtn");
         _childNsBtn = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerFrame.childNsBtn");
         addToContent(_border);
         addToContent(_skillBtn);
         addToContent(_bodyBtn);
         addToContent(_eyeBtn);
         if(VersionSwitch.DEVIL_ARMOR)
         {
            addToContent(_devilArmorBtn);
         }
         if(VersionSwitch.CHILD_NS)
         {
            addToContent(_childNsBtn);
         }
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_skillBtn);
         _btnGroup.addSelectItem(_bodyBtn);
         _btnGroup.addSelectItem(_eyeBtn);
         if(VersionSwitch.DEVIL_ARMOR)
         {
            _btnGroup.addSelectItem(_devilArmorBtn);
         }
         if(VersionSwitch.CHILD_NS)
         {
            _btnGroup.addSelectItem(_childNsBtn);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_btnGroup.getSelectedItem())
         {
            case _skillBtn:
               if(!_skillView)
               {
                  _skillView = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerFrame.skillView");
               }
               addToContent(_skillView);
               ObjectUtils.disposeObject(_bodyView);
               _bodyView = null;
               ObjectUtils.disposeObject(_eyeView);
               _eyeView = null;
               ObjectUtils.disposeObject(_devilArmorView);
               _devilArmorView = null;
               ObjectUtils.disposeObject(_childNsView);
               _childNsView = null;
               break;
            case _bodyBtn:
               if(!_bodyView)
               {
                  _bodyView = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerFrame.bodyView");
               }
               addToContent(_bodyView);
               ObjectUtils.disposeObject(_skillView);
               _skillView = null;
               ObjectUtils.disposeObject(_eyeView);
               _eyeView = null;
               ObjectUtils.disposeObject(_devilArmorView);
               _devilArmorView = null;
               ObjectUtils.disposeObject(_childNsView);
               _childNsView = null;
               break;
            case _eyeBtn:
               if(!_eyeView)
               {
                  _eyeView = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerFrame.eyeView");
               }
               addToContent(_eyeView);
               ObjectUtils.disposeObject(_skillView);
               _skillView = null;
               ObjectUtils.disposeObject(_bodyView);
               _bodyView = null;
               ObjectUtils.disposeObject(_devilArmorView);
               _devilArmorView = null;
               ObjectUtils.disposeObject(_childNsView);
               _childNsView = null;
               break;
            case _devilArmorBtn:
               if(!_devilArmorView)
               {
                  _devilArmorView = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerFrame.devilArmorView");
               }
               addToContent(_devilArmorView);
               ObjectUtils.disposeObject(_skillView);
               _skillView = null;
               ObjectUtils.disposeObject(_bodyView);
               _bodyView = null;
               ObjectUtils.disposeObject(_eyeView);
               _eyeView = null;
               ObjectUtils.disposeObject(_childNsView);
               _childNsView = null;
               break;
            case _childNsBtn:
               if(!_childNsView)
               {
                  _childNsView = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerFrame.childNsView");
               }
               addToContent(_childNsView);
               ObjectUtils.disposeObject(_skillView);
               _skillView = null;
               ObjectUtils.disposeObject(_bodyView);
               _bodyView = null;
               ObjectUtils.disposeObject(_eyeView);
               _eyeView = null;
               ObjectUtils.disposeObject(_devilArmorView);
               _devilArmorView = null;
         }
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         this.titleText = LanguageMgr.GetTranslation("AvengerFrame.title.text");
         if(param1 && param1.frameData)
         {
            _btnGroup.selectIndex = int(param1.frameData);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_skillView);
         _skillView = null;
         ObjectUtils.disposeObject(_eyeView);
         _eyeView = null;
         ObjectUtils.disposeObject(_bodyView);
         _bodyView = null;
         ObjectUtils.disposeObject(_devilArmorView);
         _devilArmorView = null;
         ObjectUtils.disposeObject(_childNsView);
         _childNsView = null;
         ObjectUtils.disposeObject(_bodyBtn);
         _bodyBtn = null;
         ObjectUtils.disposeObject(_eyeBtn);
         _eyeBtn = null;
         ObjectUtils.disposeObject(_skillBtn);
         _skillBtn = null;
         ObjectUtils.disposeObject(_devilArmorBtn);
         _devilArmorBtn = null;
         ObjectUtils.disposeObject(_childNsBtn);
         _childNsBtn = null;
         _btnGroup = null;
         super.dispose();
      }
   }
}

