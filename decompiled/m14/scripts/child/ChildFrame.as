package child
{
   import child.attribute.ChildAttributeTabView;
   import child.emblem.ChildEmblemTabView;
   import child.equip.ChildEquipTabView;
   import child.handbook.ChildHandBookView;
   import child.skill.ChildSkillTabView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import yishi.datas.VersionSwitch;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildFrame extends Frame implements IManualSize
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _lineImage:ScaleBitmapImage;
      
      private var _attributeBtn:SelectedIconButton;
      
      private var _equipBtn:SelectedIconButton;
      
      private var _skillBtn:SelectedIconButton;
      
      private var _badgeBtn:SelectedIconButton;
      
      private var _handBookBtn:SelectedIconButton;
      
      private var _btnHbox:HBox;
      
      private var _group1:SelectedButtonGroup;
      
      private var _tabView1:ChildAttributeTabView;
      
      private var _tabView2:ChildEquipTabView;
      
      private var _tabView3:ChildSkillTabView;
      
      private var _tabView4:ChildEmblemTabView;
      
      private var _tabView5:ChildHandBookView;
      
      private var _chillListView:ChildListView;
      
      private var _helpBtn:BaseButton;
      
      public function ChildFrame()
      {
         super();
         model.collectionTempList.sort(model.sortByTypeAndGrade);
         initView();
         initEvent();
         _group1.selectIndex = 0;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,796,570);
      }
      
      override public function get groups() : Array
      {
         return ["BAG_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("child.ChildFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildFrame.describeBackground");
         _lineImage = ComponentFactory.Instance.creatComponentByStylename("ChildFrame.lineImage");
         _attributeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFrame.attributeBtn");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFrame.equipBtn");
         _skillBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFrame.skillBtn");
         _badgeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFrame.badgeBtn");
         _handBookBtn = ComponentFactory.Instance.creatComponentByStylename("ChildFrame.handBookBtn");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("ChildFrame.btnHbox");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("childFrame.helpbtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("childFrame.helpBtn.tipText");
         _chillListView = ComponentFactory.Instance.creatCustomObject("ChildFrame.chillListView");
         _group1 = new SelectedButtonGroup();
         _btnHbox.addChild(_attributeBtn);
         _btnHbox.addChild(_equipBtn);
         _btnHbox.addChild(_skillBtn);
         if(VersionSwitch.CHILD_EMBLEM)
         {
            _btnHbox.addChild(_badgeBtn);
         }
         _btnHbox.addChild(_handBookBtn);
         _group1.addSelectItem(_attributeBtn);
         _group1.addSelectItem(_equipBtn);
         _group1.addSelectItem(_skillBtn);
         _group1.addSelectItem(_badgeBtn);
         _group1.addSelectItem(_handBookBtn);
         addToContent(_bg);
         addToContent(_lineImage);
         addToContent(_chillListView);
         addToContent(_btnHbox);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         addEventListener("click",__ballBtnHandler);
         if(_group1)
         {
            _group1.addEventListener("change",__tabChangeHandler);
         }
         MsgMan.addObserver("ChildEvent.CHILD_DELETE",this,__deleteChildHandler);
         _helpBtn.addEventListener("click",__helpBtnHandler);
         MsgMan.addObserver("ChildEvent.HEAD_CHANGE",this,__itemSelectHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         removeEventListener("click",__ballBtnHandler);
         if(_group1)
         {
            _group1.removeEventListener("change",__tabChangeHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         MsgMan.removeObserver("ChildEvent.CHILD_DELETE",this,__deleteChildHandler);
         MsgMan.removeObserver("ChildEvent.HEAD_CHANGE",this,__itemSelectHandler);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("child.help");
         _loc2_["show"]();
      }
      
      private function __ballBtnHandler(param1:MouseEvent) : void
      {
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
      
      private function __itemSelectHandler(param1:String, param2:Object) : void
      {
         if(!model.selectedChild)
         {
            return;
         }
         model.moveGoodsBack();
      }
      
      private function getCurrentList() : Vector.<ChildData>
      {
         return model.childList;
      }
      
      private function __deleteChildHandler(param1:String, param2:Object) : void
      {
         model.selectedChild = null;
         if(_chillListView && _chillListView.visible)
         {
            _chillListView.resetSelect();
         }
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         model.moveGoodsBack();
         if(_group1)
         {
            if(_group1.selectIndex == 0)
            {
               showTab1();
            }
            else if(_group1.selectIndex == 1)
            {
               showTab2();
            }
            else if(_group1.selectIndex == 2)
            {
               showTab3();
            }
            else if(_group1.selectIndex == 3)
            {
               showTab4();
            }
            else if(_group1.selectIndex == 4)
            {
               showTab5();
            }
         }
         model.collectionTempList.sort(model.sortByTypeAndGrade);
         if(_chillListView && _chillListView.visible)
         {
            _chillListView.refreshSortView();
         }
         MsgMan.notifyObserver("ChildEvent.HEAD_CHANGE");
      }
      
      public function changeToTab(param1:int, param2:Object = null) : void
      {
         _group1.selectIndex = param1;
         if(param1 == 0)
         {
            showTab1();
         }
         else if(param1 == 1)
         {
            if(param2)
            {
               showTab2(param2.index);
               if(param2.index == 0)
               {
                  if(model.selectedChild)
                  {
                     ChildSender.moveBagToBag(param2.bagType,param2.pos,29,0,model.selectedChild.childId);
                  }
               }
               else if(param2.index == 1)
               {
                  if(model.selectedChild)
                  {
                     ChildSender.moveBagToBag(param2.bagType,param2.pos,29,0,model.selectedChild.childId);
                  }
               }
            }
            else
            {
               showTab2();
            }
         }
         else if(param1 == 2)
         {
            showTab3();
         }
         else if(param1 == 3)
         {
            showTab4();
         }
      }
      
      private function showTab1() : void
      {
         ChildManager.instance.currSelectedPage = "CHILD_ATTRIBUTE_PAGE";
         if(_tabView1 == null)
         {
            _tabView1 = new ChildAttributeTabView();
            _tabView1.x = 203;
            _tabView1.y = 32;
            _tabView1.mouseEnabled = false;
            addToContent(_tabView1);
         }
         _tabView1.visible = true;
         if(_lineImage)
         {
            _lineImage.visible = true;
         }
         if(_chillListView)
         {
            _chillListView.visible = true;
         }
         if(_tabView2)
         {
            _tabView2.visible = false;
         }
         if(_tabView3)
         {
            _tabView3.visible = false;
         }
         if(_tabView4)
         {
            _tabView4.visible = false;
         }
         if(_tabView5)
         {
            _tabView5.visible = false;
         }
      }
      
      private function showTab2(param1:int = 0) : void
      {
         if(model.selectedChild == null || model.selectedChild.job <= 0)
         {
            _group1.selectIndex = 0;
            if(model.selectedChild == null)
            {
               return;
            }
            if(model.selectedChild.state == 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.childFrame.notOpen01"));
            }
            else if(model.selectedChild.state == 1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.attribute.ChildFosterViewII.selectJob"));
            }
            return;
         }
         if(_tabView2 == null)
         {
            _tabView2 = new ChildEquipTabView();
            _tabView2.x = 205;
            _tabView2.y = 45;
            addToContent(_tabView2);
         }
         _tabView2.visible = true;
         _tabView2.changeToTab(param1);
         if(_lineImage)
         {
            _lineImage.visible = true;
         }
         if(_chillListView)
         {
            _chillListView.visible = true;
         }
         if(_tabView1)
         {
            _tabView1.visible = false;
         }
         if(_tabView3)
         {
            _tabView3.visible = false;
         }
         if(_tabView4)
         {
            _tabView4.visible = false;
         }
         if(_tabView5)
         {
            _tabView5.visible = false;
         }
         ChildManager.instance.currSelectedPage = "CHILD_EQUIP_PAGE";
         MsgMan.notifyObserver("ChildEvent.REFRESH_BAG");
      }
      
      private function showTab3() : void
      {
         if(model.selectedChild == null || model.selectedChild.job <= 0)
         {
            _group1.selectIndex = 0;
            if(model.selectedChild == null)
            {
               return;
            }
            if(model.selectedChild.state == 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.childFrame.notOpen02"));
            }
            else if(model.selectedChild.state == 1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.attribute.ChildFosterViewII.selectJob"));
            }
            return;
         }
         ChildManager.instance.currSelectedPage = "CHILD_SKILL_PAGE";
         if(_tabView3 == null)
         {
            _tabView3 = new ChildSkillTabView();
            _tabView3.x = 205;
            _tabView3.y = 45;
            addToContent(_tabView3);
         }
         _tabView3.visible = true;
         if(_lineImage)
         {
            _lineImage.visible = true;
         }
         if(_chillListView)
         {
            _chillListView.visible = true;
         }
         if(_tabView1)
         {
            _tabView1.visible = false;
         }
         if(_tabView2)
         {
            _tabView2.visible = false;
         }
         if(_tabView4)
         {
            _tabView4.visible = false;
         }
         if(_tabView5)
         {
            _tabView5.visible = false;
         }
      }
      
      private function showTab4() : void
      {
         if(model.selectedChild == null || model.selectedChild.job <= 0)
         {
            _group1.selectIndex = 0;
            if(model.selectedChild == null)
            {
               return;
            }
            if(model.selectedChild.state == 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.childFrame.notOpen02"));
            }
            else if(model.selectedChild.state == 1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.attribute.ChildFosterViewII.selectJob"));
            }
            return;
         }
         ChildManager.instance.currSelectedPage = "CHILD_BADGE_PAGE";
         if(_tabView4 == null)
         {
            _tabView4 = new ChildEmblemTabView();
            _tabView4.x = 204;
            _tabView4.y = 33;
            addToContent(_tabView4);
         }
         _tabView4.visible = true;
         if(_lineImage)
         {
            _lineImage.visible = true;
         }
         if(_chillListView)
         {
            _chillListView.visible = true;
         }
         if(_tabView1)
         {
            _tabView1.visible = false;
         }
         if(_tabView2)
         {
            _tabView2.visible = false;
         }
         if(_tabView3)
         {
            _tabView3.visible = false;
         }
         if(_tabView5)
         {
            _tabView5.visible = false;
         }
      }
      
      private function showTab5() : void
      {
         ChildManager.instance.currSelectedPage = "CHILD_HANDBOOK_PAGE";
         if(_tabView5 == null)
         {
            _tabView5 = new ChildHandBookView();
            _tabView5.x = 10;
            _tabView5.y = 45;
            addToContent(_tabView5);
         }
         _tabView5.visible = true;
         _tabView5.refreshBookView();
         if(_lineImage)
         {
            _lineImage.visible = false;
         }
         if(_chillListView)
         {
            _chillListView.visible = false;
         }
         if(_tabView1)
         {
            _tabView1.visible = false;
         }
         if(_tabView2)
         {
            _tabView2.visible = false;
         }
         if(_tabView3)
         {
            _tabView3.visible = false;
         }
         if(_tabView4)
         {
            _tabView4.visible = false;
         }
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         _group1.selectIndex = ChildManager.instance.openFrame - 1;
         ChildManager.instance.openFrame = 1;
         ChildManager.instance.frameShowType = 1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_group1);
         _group1 = null;
         ObjectUtils.disposeObject(_lineImage);
         _lineImage = null;
         ObjectUtils.disposeObject(_attributeBtn);
         _attributeBtn = null;
         ObjectUtils.disposeObject(_equipBtn);
         _equipBtn = null;
         ObjectUtils.disposeObject(_skillBtn);
         _skillBtn = null;
         ObjectUtils.disposeObject(_badgeBtn);
         _badgeBtn = null;
         ObjectUtils.disposeObject(_handBookBtn);
         _handBookBtn = null;
         ObjectUtils.disposeObject(_btnHbox);
         _btnHbox = null;
         ObjectUtils.disposeObject(_tabView1);
         _tabView1 = null;
         ObjectUtils.disposeObject(_tabView2);
         _tabView2 = null;
         ObjectUtils.disposeObject(_tabView3);
         _tabView3 = null;
         ObjectUtils.disposeObject(_tabView4);
         _tabView4 = null;
         ObjectUtils.disposeObject(_tabView5);
         _tabView5 = null;
         ObjectUtils.disposeObject(_chillListView);
         _chillListView = null;
         ChildManager.instance.currSelectedPage = "";
         ChildManager.instance.currSelectedView = "";
         ChildManager.instance.frameShowType = 0;
         model.selectedChildTemp = null;
         model.selectItemTemp = null;
         model.selectedChild = null;
         model.moveGoodsBack();
         super.dispose();
      }
   }
}

