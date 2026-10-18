package dragontalker
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dragontalker.view.DragonTalkerBattleBeastView;
   import dragontalker.view.DragonTalkerMainView;
   import dragontalker.view.DragonTalkerProficiencyView;
   import dragontalker.view.DragonTalkerSkillActiveView;
   import dragontalker.view.DragonTalkerSkillMainViewII;
   import dragontalker.view.DragonTalkerSymbioteView;
   import dragontalker.view.DragonTalkerTalismanView;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import playerinfo.view.ThaneAttributeFrame;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class DragonTalkerFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _btnHbox:HBox;
      
      private var _dragonTalkerBtn:SelectedIconButton;
      
      private var _symbioteBtn:SelectedIconButton;
      
      private var _talismanBtn:SelectedIconButton;
      
      private var _skillBtn:SelectedIconButton;
      
      private var _battleBeastBtn:SelectedIconButton;
      
      private var _proficiencyBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _mainView:DragonTalkerMainView;
      
      private var _skillMainView:DragonTalkerSkillMainViewII;
      
      private var _activeSkillView:DragonTalkerSkillActiveView;
      
      private var _talismanView:DragonTalkerTalismanView;
      
      private var _symbioteView:DragonTalkerSymbioteView;
      
      private var _beastView:DragonTalkerBattleBeastView;
      
      private var _proficiencyView:DragonTalkerProficiencyView;
      
      private var _helpBtn:BaseButton;
      
      private var _attributeView:ThaneAttributeFrame;
      
      private var _rect:Rectangle;
      
      private var _mutiIntensifyFrame:DragonTalkerMutipleIntensifyFrame;
      
      public function DragonTalkerFrame()
      {
         super();
         initView();
         addEvent();
         _btnGroup.selectIndex = 0;
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,761,563);
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.vhua8.border");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerFrame.btnHbox");
         _dragonTalkerBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerFrame.dragonTalkerBtn");
         _symbioteBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerFrame.symbioteBtn");
         _talismanBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerFrame.talismanBtn");
         _skillBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerFrame.skillBtn");
         _battleBeastBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerFrame.battleBeastBtn");
         _proficiencyBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerFrame.proficiencyBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerFrame.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("DragonTalkerFrame.helpBtn.tipData");
         addToContent(_border);
         addToContent(_btnHbox);
         addToContent(_helpBtn);
         _btnHbox.addChild(_dragonTalkerBtn);
         _btnHbox.addChild(_symbioteBtn);
         _btnHbox.addChild(_talismanBtn);
         _btnHbox.addChild(_skillBtn);
         _btnHbox.addChild(_battleBeastBtn);
         if(VersionSwitch.DRAGON_PROFICIENCY)
         {
            _btnHbox.addChild(_proficiencyBtn);
         }
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_dragonTalkerBtn);
         _btnGroup.addSelectItem(_symbioteBtn);
         _btnGroup.addSelectItem(_talismanBtn);
         _btnGroup.addSelectItem(_skillBtn);
         _btnGroup.addSelectItem(_battleBeastBtn);
         if(VersionSwitch.DRAGON_PROFICIENCY)
         {
            _btnGroup.addSelectItem(_proficiencyBtn);
         }
         _rect = new Rectangle(0,0,212,520);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
         MsgMan.addObserver("DRAGON_TALKER_SKILLVIEW_CHANGE",this,__skillViewUpdate);
         MsgMan.addObserver("ATTRIBUTE_CLICK",this,__showAttributeHandler);
         _helpBtn.addEventListener("click",__helpClickHandler);
         MsgMan.addObserver("ADD_INTENSIFY_TALISMAN",this,__openIntensifyFrameHandler);
         MsgMan.addObserver("TALISMAN_PAGE_CHANGE",this,__talismanPageChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
         if(_attributeView)
         {
            _attributeView.removeEventListener("response",__hideHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpClickHandler);
         }
         if(_attributeView)
         {
            _attributeView.removeEventListener("response",__hideHandler);
         }
         if(_mutiIntensifyFrame)
         {
            _mutiIntensifyFrame.removeEventListener("dispose",__disposeIntensifyFrameHandler);
         }
         MsgMan.removeObserver("DRAGON_TALKER_SKILLVIEW_CHANGE",this,__skillViewUpdate);
         MsgMan.removeObserver("ATTRIBUTE_CLICK",this,__showAttributeHandler);
         MsgMan.removeObserver("ADD_INTENSIFY_TALISMAN",this,__openIntensifyFrameHandler);
         MsgMan.removeObserver("TALISMAN_PAGE_CHANGE",this,__talismanPageChangeHandler);
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerFrame.helperFrame");
         _loc2_.show();
      }
      
      private function __showAttributeHandler(param1:String, param2:Object) : void
      {
         TweenLite.killTweensOf(_rect);
         if(!_attributeView)
         {
            showAttributeView();
         }
         else if(attributeViewIsTweening())
         {
            _attributeView.dispose();
            _attributeView = null;
         }
         else
         {
            _rect.x = -20;
            TweenLite.to(_rect,0.7,{
               "x":-232,
               "onUpdate":updateRec,
               "onComplete":completeTween
            });
         }
      }
      
      private function showAttributeView() : void
      {
         if(!_attributeView)
         {
            _attributeView = ComponentFactory.Instance.creatComponentByStylename("army.ThaneAttribute");
            _attributeView.addEventListener("response",__hideHandler);
            addChild(_attributeView);
            _attributeView.x = -203;
            _attributeView.y = 19;
            _attributeView.thane = thane;
            _attributeView.refresh();
            _rect.x = -232;
            TweenLite.to(_rect,0.7,{
               "x":-20,
               "onUpdate":updateRec
            });
         }
      }
      
      private function attributeViewIsTweening() : Boolean
      {
         return _rect.x < -20 || _attributeView.x != -193 || _attributeView.y != 41;
      }
      
      private function updateRec() : void
      {
         if(_attributeView)
         {
            _attributeView.scrollRect = _rect;
         }
      }
      
      private function completeTween() : void
      {
         TweenLite.killTweensOf(_rect);
         if(_attributeView)
         {
            _attributeView.dispose();
            _attributeView = null;
         }
      }
      
      private function __hideHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0)
         {
            param1.currentTarget.removeEventListener("response",__hideHandler);
            __showAttributeHandler(null,null);
         }
      }
      
      private function __skillViewUpdate(param1:String, param2:Object) : void
      {
         __tabChangeHandler(null);
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         ObjectUtils.disposeObject(_mutiIntensifyFrame);
         _mutiIntensifyFrame = null;
         switch(_btnGroup.getSelectedItem())
         {
            case _dragonTalkerBtn:
               if(!_mainView)
               {
                  _mainView = ComponentFactory.Instance.creatCustomObject("DragonTalker.vhua8.mainView");
               }
               addToContent(_mainView);
               ObjectUtils.disposeObject(_activeSkillView);
               _activeSkillView = null;
               ObjectUtils.disposeObject(_skillMainView);
               _skillMainView = null;
               ObjectUtils.disposeObject(_talismanView);
               _talismanView = null;
               ObjectUtils.disposeObject(_symbioteView);
               _symbioteView = null;
               ObjectUtils.disposeObject(_beastView);
               _beastView = null;
               ObjectUtils.disposeObject(_proficiencyView);
               _proficiencyView = null;
               break;
            case _symbioteBtn:
               if(!_symbioteView)
               {
                  _symbioteView = ComponentFactory.Instance.creatCustomObject("DragonTalker.vhua8.symbioteView");
               }
               addToContent(_symbioteView);
               ObjectUtils.disposeObject(_activeSkillView);
               _activeSkillView = null;
               ObjectUtils.disposeObject(_skillMainView);
               _skillMainView = null;
               ObjectUtils.disposeObject(_talismanView);
               _talismanView = null;
               ObjectUtils.disposeObject(_mainView);
               _mainView = null;
               ObjectUtils.disposeObject(_beastView);
               _beastView = null;
               ObjectUtils.disposeObject(_proficiencyView);
               _proficiencyView = null;
               break;
            case _talismanBtn:
               if(!_talismanView)
               {
                  _talismanView = ComponentFactory.Instance.creatCustomObject("DragonTalker.vhua8.talismanView");
               }
               addToContent(_talismanView);
               ObjectUtils.disposeObject(_activeSkillView);
               _activeSkillView = null;
               ObjectUtils.disposeObject(_skillMainView);
               _skillMainView = null;
               ObjectUtils.disposeObject(_mainView);
               _mainView = null;
               ObjectUtils.disposeObject(_symbioteView);
               _symbioteView = null;
               ObjectUtils.disposeObject(_beastView);
               _beastView = null;
               ObjectUtils.disposeObject(_proficiencyView);
               _proficiencyView = null;
               break;
            case _battleBeastBtn:
               if(!_beastView)
               {
                  _beastView = ComponentFactory.Instance.creatCustomObject("DragonTalker.vhua8.beastView");
               }
               addToContent(_beastView);
               ObjectUtils.disposeObject(_activeSkillView);
               _activeSkillView = null;
               ObjectUtils.disposeObject(_skillMainView);
               _skillMainView = null;
               ObjectUtils.disposeObject(_talismanView);
               _talismanView = null;
               ObjectUtils.disposeObject(_symbioteView);
               _symbioteView = null;
               ObjectUtils.disposeObject(_mainView);
               _mainView = null;
               ObjectUtils.disposeObject(_proficiencyView);
               _proficiencyView = null;
               break;
            case _skillBtn:
               if(model.skillTabIndex == 0)
               {
                  ObjectUtils.disposeObject(_skillMainView);
                  _skillMainView = null;
                  if(!_activeSkillView)
                  {
                     _activeSkillView = ComponentFactory.Instance.creatCustomObject("DragonTalker.vhua8.skillActiveView");
                  }
                  addToContent(_activeSkillView);
               }
               else
               {
                  ObjectUtils.disposeObject(_activeSkillView);
                  _activeSkillView = null;
                  if(!_skillMainView)
                  {
                     _skillMainView = ComponentFactory.Instance.creatCustomObject("DragonTalker.vhua8.skillMainViewII");
                  }
                  addToContent(_skillMainView);
               }
               ObjectUtils.disposeObject(_mainView);
               _mainView = null;
               ObjectUtils.disposeObject(_talismanView);
               _talismanView = null;
               ObjectUtils.disposeObject(_symbioteView);
               _symbioteView = null;
               ObjectUtils.disposeObject(_beastView);
               _beastView = null;
               ObjectUtils.disposeObject(_proficiencyView);
               _proficiencyView = null;
               break;
            case _proficiencyBtn:
               if(!_proficiencyView)
               {
                  _proficiencyView = ComponentFactory.Instance.creatCustomObject("DragonTalkerFrame.proficiencyView");
               }
               addToContent(_proficiencyView);
               ObjectUtils.disposeObject(_activeSkillView);
               _activeSkillView = null;
               ObjectUtils.disposeObject(_skillMainView);
               _skillMainView = null;
               ObjectUtils.disposeObject(_talismanView);
               _talismanView = null;
               ObjectUtils.disposeObject(_symbioteView);
               _symbioteView = null;
               ObjectUtils.disposeObject(_mainView);
               _mainView = null;
               ObjectUtils.disposeObject(_beastView);
               _beastView = null;
         }
      }
      
      private function __talismanPageChangeHandler(param1:String, param2:Object) : void
      {
         ObjectUtils.disposeObject(_mutiIntensifyFrame);
         _mutiIntensifyFrame = null;
      }
      
      private function __openIntensifyFrameHandler(param1:String, param2:Object) : void
      {
         var _loc3_:DragonTalkerTalismanInfo = param2 as DragonTalkerTalismanInfo;
         if(!_mutiIntensifyFrame)
         {
            _mutiIntensifyFrame = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerFrame.mutiIntensifyFrame");
            _mutiIntensifyFrame.addEventListener("dispose",__disposeIntensifyFrameHandler);
            addChild(_mutiIntensifyFrame);
         }
         _mutiIntensifyFrame.addIntensifyGoods(_loc3_);
      }
      
      private function __disposeIntensifyFrameHandler(param1:Event) : void
      {
         if(_mutiIntensifyFrame)
         {
            _mutiIntensifyFrame.removeEventListener("dispose",__disposeIntensifyFrameHandler);
         }
         _mutiIntensifyFrame = null;
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
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         this.titleText = LanguageMgr.GetTranslation("DragonTalkerFrame.title.text");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         model.skillTabIndex = model.skillActiveIndex;
         model.bagViewType = -1;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_btnHbox);
         _btnHbox = null;
         ObjectUtils.disposeObject(_dragonTalkerBtn);
         _dragonTalkerBtn = null;
         ObjectUtils.disposeObject(_symbioteBtn);
         _symbioteBtn = null;
         ObjectUtils.disposeObject(_talismanBtn);
         _talismanBtn = null;
         ObjectUtils.disposeObject(_skillBtn);
         _skillBtn = null;
         ObjectUtils.disposeObject(_battleBeastBtn);
         _battleBeastBtn = null;
         ObjectUtils.disposeObject(_proficiencyBtn);
         _proficiencyBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_mainView);
         _mainView = null;
         ObjectUtils.disposeObject(_activeSkillView);
         _activeSkillView = null;
         ObjectUtils.disposeObject(_skillMainView);
         _skillMainView = null;
         ObjectUtils.disposeObject(_talismanView);
         _talismanView = null;
         ObjectUtils.disposeObject(_symbioteView);
         _symbioteView = null;
         ObjectUtils.disposeObject(_beastView);
         _beastView = null;
         ObjectUtils.disposeObject(_attributeView);
         _attributeView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_proficiencyView);
         _proficiencyView = null;
         ObjectUtils.disposeObject(_mutiIntensifyFrame);
         _mutiIntensifyFrame = null;
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
         super.dispose();
      }
   }
}

