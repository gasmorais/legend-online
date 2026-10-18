package child
{
   import child.equip.ChildEquipTabView;
   import child.nursingspirit.ChildNSAttributeView;
   import child.nursingspirit.ChildNSComposeView;
   import child.nursingspirit.ChildNSLifeWheelView;
   import child.nursingspirit.ChildNSSkillView;
   import child.nursingspirit.ChildNSTalentView;
   import child.nursingspirit.ChildNSTreasureMostView;
   import child.nursingspirit.ChildNursingSpiritListView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildNursingSpiritModel;
   import mvc.module.children.ChildSender;
   import yishi.datas.VersionSwitch;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   
   public class ChildNursingSpiritFrame extends Frame
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _lineImage:ScaleBitmapImage;
      
      private var _attributeBtn:SelectedIconButton;
      
      private var _skillBtn:SelectedIconButton;
      
      private var _whileLifeBtn:SelectedIconButton;
      
      private var _talentBtn:SelectedIconButton;
      
      private var _equipBtn:SelectedIconButton;
      
      private var _treasureMostBtn:SelectedIconButton;
      
      private var _btnHbox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var attributeView:ChildNSAttributeView;
      
      private var composeView:ChildNSComposeView;
      
      private var skillView:ChildNSSkillView;
      
      private var lifeWheelView:ChildNSLifeWheelView;
      
      private var talentView:ChildNSTalentView;
      
      private var equipView:ChildEquipTabView;
      
      private var treasureMostView:ChildNSTreasureMostView;
      
      private var nsListView:ChildNursingSpiritListView;
      
      public function ChildNursingSpiritFrame()
      {
         super();
         nsModel.nsTempList.sort(nsModel.sortNsTempList);
         initView();
         addEvent();
         _btnGroup.selectIndex = 0;
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,796,570);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildFrame.describeBackground");
         _lineImage = ComponentFactory.Instance.creatComponentByStylename("ChildFrame.lineImage");
         _attributeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritFrame.attributeBtn");
         _skillBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritFrame.skillBtn");
         _whileLifeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritFrame.whileLifeBtn");
         _talentBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritFrame.talentBtn");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritFrame.equipBtn");
         _treasureMostBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritFrame.treasureMostBtn");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpiritFrame.btnHbox");
         nsListView = ComponentFactory.Instance.creatCustomObject("ChildNursingSpiritFrame.nsListView");
         _btnGroup = new SelectedButtonGroup();
         _btnHbox.addChild(_attributeBtn);
         _btnHbox.addChild(_skillBtn);
         _btnHbox.addChild(_whileLifeBtn);
         _btnHbox.addChild(_talentBtn);
         _btnHbox.addChild(_equipBtn);
         if(VersionSwitch.TREASURE_MOST)
         {
            _btnHbox.addChild(_treasureMostBtn);
         }
         _btnGroup.addSelectItem(_attributeBtn);
         _btnGroup.addSelectItem(_skillBtn);
         _btnGroup.addSelectItem(_whileLifeBtn);
         _btnGroup.addSelectItem(_talentBtn);
         _btnGroup.addSelectItem(_equipBtn);
         if(VersionSwitch.TREASURE_MOST)
         {
            _btnGroup.addSelectItem(_treasureMostBtn);
         }
         addToContent(_bg);
         addToContent(_lineImage);
         addToContent(_btnHbox);
         addToContent(nsListView);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
         MsgMan.addObserver("ChildEvent.CHILD_NS_OP_BACK",this,__nsOpBackHandler);
         MsgMan.addObserver("ChildEvent.CHILD_NS_TEMP_SELECT",this,__nsTempSelectHandler);
         MsgMan.addObserver("ChildEvent.CHILD_NSINFO_UPDATE",this,__childInfoHandler);
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__childInfoHandler);
         MsgMan.addObserver("ChildEvent.CHILD_NS_LIFEWHEEL_BTNENABLE",this,__itemeEnableChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
         MsgMan.removeObserver("ChildEvent.CHILD_NS_OP_BACK",this,__nsOpBackHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_NS_TEMP_SELECT",this,__nsTempSelectHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_NSINFO_UPDATE",this,__childInfoHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__childInfoHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_NS_LIFEWHEEL_BTNENABLE",this,__itemeEnableChange);
      }
      
      private function get isActive() : Boolean
      {
         if(!nsModel.selectedNsChildTemp)
         {
            return false;
         }
         if(nsModel.getNsChildDataByJob(nsModel.selectedNsChildTemp.JobType))
         {
            return true;
         }
         return false;
      }
      
      private function __nsOpBackHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = param2 as int;
         if(_loc3_ == 28)
         {
            nsModel.nsTempList.sort(nsModel.sortNsTempList);
            __tabChangeHandler(null);
         }
      }
      
      private function __itemeEnableChange(param1:String, param2:Object) : void
      {
         var _loc3_:Boolean = param2 as Boolean;
         closeButton.enable = _loc3_;
         _btnHbox.mouseChildren = _btnHbox.mouseEnabled = _loc3_;
      }
      
      private function __nsTempSelectHandler(param1:String, param2:Object) : void
      {
         if(!nsModel.selectedNsChild && _btnGroup.selectIndex != 0)
         {
            _btnGroup.selectIndex = 0;
         }
         else
         {
            __tabChangeHandler(null);
         }
      }
      
      private function __childInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         childModel.moveGoodsBack();
         ChildManager.instance.currSelectedPage = "";
         switch(_btnGroup.getSelectedItem())
         {
            case _attributeBtn:
               if(isActive)
               {
                  ObjectUtils.disposeObject(composeView);
                  composeView = null;
                  if(!attributeView)
                  {
                     attributeView = ComponentFactory.Instance.creatCustomObject("ChildNursingSpiritFrame.attributeView");
                  }
                  addToContent(attributeView);
               }
               else
               {
                  ObjectUtils.disposeObject(attributeView);
                  attributeView = null;
                  if(!composeView)
                  {
                     composeView = ComponentFactory.Instance.creatCustomObject("ChildNursingSpiritFrame.composeView");
                  }
                  addToContent(composeView);
               }
               ObjectUtils.disposeObject(skillView);
               skillView = null;
               ObjectUtils.disposeObject(talentView);
               talentView = null;
               ObjectUtils.disposeObject(lifeWheelView);
               lifeWheelView = null;
               ObjectUtils.disposeObject(equipView);
               equipView = null;
               ObjectUtils.disposeObject(treasureMostView);
               treasureMostView = null;
               break;
            case _skillBtn:
               if(!skillView)
               {
                  skillView = ComponentFactory.Instance.creatCustomObject("ChildNursingSpiritFrame.skillView");
               }
               addToContent(skillView);
               ObjectUtils.disposeObject(attributeView);
               attributeView = null;
               ObjectUtils.disposeObject(composeView);
               composeView = null;
               ObjectUtils.disposeObject(talentView);
               talentView = null;
               ObjectUtils.disposeObject(lifeWheelView);
               lifeWheelView = null;
               ObjectUtils.disposeObject(equipView);
               equipView = null;
               ObjectUtils.disposeObject(treasureMostView);
               treasureMostView = null;
               break;
            case _whileLifeBtn:
               if(!lifeWheelView)
               {
                  lifeWheelView = ComponentFactory.Instance.creatCustomObject("ChildNursingSpiritFrame.lifeWheelView");
               }
               addToContent(lifeWheelView);
               ObjectUtils.disposeObject(attributeView);
               attributeView = null;
               ObjectUtils.disposeObject(composeView);
               composeView = null;
               ObjectUtils.disposeObject(skillView);
               skillView = null;
               ObjectUtils.disposeObject(talentView);
               talentView = null;
               ObjectUtils.disposeObject(equipView);
               equipView = null;
               ObjectUtils.disposeObject(treasureMostView);
               treasureMostView = null;
               break;
            case _talentBtn:
               if(!talentView)
               {
                  talentView = ComponentFactory.Instance.creatCustomObject("ChildNursingSpiritFrame.talentView");
               }
               addToContent(talentView);
               ObjectUtils.disposeObject(attributeView);
               attributeView = null;
               ObjectUtils.disposeObject(composeView);
               composeView = null;
               ObjectUtils.disposeObject(skillView);
               skillView = null;
               ObjectUtils.disposeObject(lifeWheelView);
               lifeWheelView = null;
               ObjectUtils.disposeObject(equipView);
               equipView = null;
               ObjectUtils.disposeObject(treasureMostView);
               treasureMostView = null;
               break;
            case _equipBtn:
               ChildManager.instance.currSelectedPage = "CHILD_EQUIP_PAGE";
               if(!equipView)
               {
                  equipView = ComponentFactory.Instance.creatCustomObject("ChildNursingSpiritFrame.equipView");
               }
               addToContent(equipView);
               ObjectUtils.disposeObject(attributeView);
               attributeView = null;
               ObjectUtils.disposeObject(composeView);
               composeView = null;
               ObjectUtils.disposeObject(skillView);
               skillView = null;
               ObjectUtils.disposeObject(talentView);
               talentView = null;
               ObjectUtils.disposeObject(lifeWheelView);
               lifeWheelView = null;
               ObjectUtils.disposeObject(treasureMostView);
               treasureMostView = null;
               break;
            case _treasureMostBtn:
               ChildManager.instance.currSelectedPage = "CHILD_MOST_PAGE";
               if(!treasureMostView)
               {
                  treasureMostView = ComponentFactory.Instance.creatCustomObject("ChildNursingSpiritFrame.treasureMostView");
               }
               addToContent(treasureMostView);
               ObjectUtils.disposeObject(attributeView);
               attributeView = null;
               ObjectUtils.disposeObject(composeView);
               composeView = null;
               ObjectUtils.disposeObject(skillView);
               skillView = null;
               ObjectUtils.disposeObject(talentView);
               talentView = null;
               ObjectUtils.disposeObject(lifeWheelView);
               lifeWheelView = null;
               ObjectUtils.disposeObject(equipView);
               equipView = null;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(!nsModel.selectedNsChildTemp)
         {
            return;
         }
         if(nsListView)
         {
            nsListView.refreshView();
         }
         if(attributeView)
         {
            attributeView.data = nsModel.selectedNsChild;
         }
         if(composeView)
         {
            composeView.refreshView();
         }
         if(skillView)
         {
            skillView.refreshView();
         }
         if(talentView)
         {
            talentView.refreshView();
         }
         if(treasureMostView)
         {
            treasureMostView.data = nsModel.selectedNsChild;
         }
         if(nsModel.selectedNsChild)
         {
            _equipBtn.enable = _skillBtn.enable = _whileLifeBtn.enable = _talentBtn.enable = _treasureMostBtn.enable = true;
         }
         else
         {
            _equipBtn.enable = _skillBtn.enable = _whileLifeBtn.enable = _talentBtn.enable = _treasureMostBtn.enable = false;
         }
      }
      
      public function changeToTab(param1:int, param2:Object = null) : void
      {
         _btnGroup.selectIndex = param1;
         if(param2)
         {
            if(equipView)
            {
               equipView.changeToTab(param2.index);
            }
            if(param2.index == 0)
            {
               if(nsModel.selectedNsChild)
               {
                  ChildSender.moveBagToBag(param2.bagType,param2.pos,29,0,nsModel.selectedNsChild.childId);
               }
            }
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
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
         this.titleText = LanguageMgr.GetTranslation("ChildNursingSpiritFrame.title.text");
         LayerManager.Instance.addToLayer(this,3,true,true);
         ChildManager.instance.frameShowType = 2;
         if(param1 && param1.frameData)
         {
            _btnGroup.selectIndex = int(param1.frameData);
         }
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      private function get childModel() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         childModel.moveGoodsBack();
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_btnGroup)
         {
            _btnGroup.dispose();
         }
         _btnGroup = null;
         if(_lineImage)
         {
            ObjectUtils.disposeObject(_lineImage);
         }
         _lineImage = null;
         if(_attributeBtn)
         {
            ObjectUtils.disposeObject(_attributeBtn);
         }
         _attributeBtn = null;
         if(_equipBtn)
         {
            ObjectUtils.disposeObject(_equipBtn);
         }
         _equipBtn = null;
         if(_skillBtn)
         {
            ObjectUtils.disposeObject(_skillBtn);
         }
         _skillBtn = null;
         if(_whileLifeBtn)
         {
            ObjectUtils.disposeObject(_whileLifeBtn);
         }
         _whileLifeBtn = null;
         if(_talentBtn)
         {
            ObjectUtils.disposeObject(_talentBtn);
         }
         _talentBtn = null;
         if(_treasureMostBtn)
         {
            ObjectUtils.disposeObject(_treasureMostBtn);
         }
         _treasureMostBtn = null;
         if(_btnHbox)
         {
            ObjectUtils.disposeObject(_btnHbox);
         }
         _btnHbox = null;
         if(nsListView)
         {
            ObjectUtils.disposeObject(nsListView);
         }
         nsListView = null;
         ObjectUtils.disposeObject(attributeView);
         attributeView = null;
         ObjectUtils.disposeObject(composeView);
         composeView = null;
         ObjectUtils.disposeObject(skillView);
         skillView = null;
         ObjectUtils.disposeObject(talentView);
         talentView = null;
         ObjectUtils.disposeObject(lifeWheelView);
         lifeWheelView = null;
         ObjectUtils.disposeObject(equipView);
         equipView = null;
         ChildManager.instance.frameShowType = 0;
         nsModel.selectedNsChildTemp = null;
         nsModel.selectedNsChild = null;
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
         super.dispose();
      }
   }
}

