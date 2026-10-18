package dayguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.DayGuideEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DayGuideManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.PetBossModel;
   import mvc.controler.BuildingControler;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.dayGuide.DailyItemInfo;
   import yishi.SwitchPageHelp;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   import yishi.view.tips.MessageTipManager;
   
   public class DailyItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _gap:ScaleLeftRightImage;
      
      private var _routineImage:ScaleFrameImage;
      
      private var _selectedBg:ScaleFrameImage;
      
      private var _timeText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _finishText:FilterFrameText;
      
      private var _joinText:FilterFrameText;
      
      private var _closedText:FilterFrameText;
      
      private var _conditionText:FilterFrameText;
      
      private var _selected:Boolean;
      
      private var _data:DailyItemInfo;
      
      private var _hitSprite:Sprite;
      
      public function DailyItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _gap = ComponentFactory.Instance.creatComponentByStylename("dayGuide.dailyItemBg");
         _routineImage = ComponentFactory.Instance.creatComponentByStylename("dayGuide.routineImage");
         _selectedBg = ComponentFactory.Instance.creatComponentByStylename("dayGuide.selectedHightline");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("dayGuide.dailyTimeText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("dayGuide.dailyNameText");
         _finishText = ComponentFactory.Instance.creatComponentByStylename("dayGuide.dailyFinishText");
         _joinText = ComponentFactory.Instance.creatComponentByStylename("dayGuide.dailyJoinText");
         _closedText = ComponentFactory.Instance.creatComponentByStylename("dayGuide.dailyClosedText");
         _conditionText = ComponentFactory.Instance.creatComponentByStylename("daily.conditionText");
         addChild(_gap);
         addChild(_selectedBg);
         _selectedBg.setFrame(1);
         addChild(_routineImage);
         addChild(_timeText);
         addChild(_nameText);
         addChild(_finishText);
         addChild(_joinText);
         addChild(_closedText);
         addChild(_conditionText);
         _joinText.text = LanguageMgr.GetTranslation("dayGuide.view.DailyItem.joinText.text");
         _closedText.text = LanguageMgr.GetTranslation("dayGuide.view.DailyItem.closedText.text");
         _hitSprite = new Sprite();
         setJoinHitArea();
         addChild(_hitSprite);
         buttonMode = true;
      }
      
      private function setJoinHitArea() : void
      {
         _hitSprite.graphics.clear();
         _hitSprite.graphics.beginFill(0,0);
         _hitSprite.graphics.drawRect(0,0,_joinText.width,_joinText.height);
         _hitSprite.x = _joinText.x;
         _hitSprite.y = _joinText.y;
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
         _hitSprite.addEventListener("click",__joinHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
         if(_hitSprite)
         {
            _hitSprite.removeEventListener("click",__joinHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         NotificationManager.instance.dispatchEvent(new DayGuideEvent("DAILY_ITEM_CLICK",data ? data : null));
      }
      
      private function __joinHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:BuildInfo = null;
         var _loc3_:PetBossModel = null;
         SoundManager.instance.play("022");
         if(data == null)
         {
            return;
         }
         if(ArmyManager.instance.thane.grades < data.Levels)
         {
            _loc2_ = LanguageMgr.GetTranslation("dayGuide.view.DailyItem.UnderLevel");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("taskTrace.SinglepassHasBugleYipsView.TipInfo"));
            return;
         }
         switch(int(data.ActiveType) - 1)
         {
            case 0:
               SwitchPageHelp.gotoWorldBossFrame();
               break;
            case 1:
               SwitchPageHelp.gotoPvpFrame();
               break;
            case 2:
               SwitchPageHelp.gotoWorldFightFrame();
               break;
            case 3:
               if(SwitchPageHelp.checkScene())
               {
                  FrameControllerManager.instance.openControllerByInfo("vehicleroomlist");
               }
               break;
            case 4:
               if(ArmyManager.instance.thane.grades < 15)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command19"));
                  return;
               }
               DayGuideManager.instance.switchScene(5);
         }
         if(data == null)
         {
            return;
         }
         switch(data.TemplateId)
         {
            case "8":
               SwitchPageHelp.gotoPvpFrame();
               break;
            case "6":
            case "11":
            case "18":
            case "1600":
               if(ArmyManager.instance.thane.grades < 15)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command19"));
                  return;
               }
               DayGuideManager.instance.switchScene(5);
               break;
            case "7":
               _loc4_ = BuildingManager.instance.getBuildingInfoBySonType(501);
               FrameControllerManager.instance.openControllerByInfo(BuildingControler.getModelNameByInfo(_loc4_),null,_loc4_);
               break;
            case "9":
               DayGuideManager.instance.switchScene(24);
               break;
            case "13":
               DayGuideManager.instance.switchScene(29);
               break;
            case "14":
               DayGuideManager.instance.switchScene(30);
               break;
            case "15":
               DayGuideManager.instance.switchScene(56);
               break;
            case "17":
               DayGuideManager.instance.switchScene(40);
               break;
            case "28":
               SwitchPageHelp.gotoWorldFightFrame();
               break;
            case "19":
               DayGuideManager.instance.switchScene(34);
               break;
            case "20":
            case "21":
               _loc3_ = CampaignManager.instance.petBossModel;
               if(_loc3_.isOpen)
               {
                  SwitchPageHelp.walkToCrossMapTarget(_loc3_.mapId + "," + _loc3_.nodeId);
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("dayGuide.view.DailyItem.PetBossUnOpen"));
               }
               break;
            case "1000":
               DayGuideManager.instance.switchScene(46);
               break;
            case "25":
               SwitchPageHelp.gotoMonopolyFrame();
         }
      }
      
      public function setBgColour(param1:int, param2:DailyItemInfo) : void
      {
         _gap.setFrame(param1);
         if(!param2)
         {
            _routineImage.visible = false;
            _closedText.visible = false;
            _hitSprite.visible = false;
            _joinText.visible = false;
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selected && _selectedBg)
         {
            _selectedBg.visible = true;
            _selectedBg.setFrame(2);
         }
         else if(_selectedBg)
         {
            _selectedBg.setFrame(1);
         }
      }
      
      public function get data() : DailyItemInfo
      {
         return _data;
      }
      
      public function set data(param1:DailyItemInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         _selectedBg.setFrame(1);
         if(_data)
         {
            setValue();
         }
         else
         {
            clear();
         }
      }
      
      private function setValue() : void
      {
         setRoutineImage();
         _timeText.text = _data.ActiveTime;
         _nameText.text = _data.ActiveName;
         _nameText.height = _nameText.textHeight + 6;
         _nameText.y = 8 - (_nameText.numLines - 1) * 8;
         _conditionText.text = _data.condition;
         if(ArmyManager.instance.thane.grades < _data.Levels)
         {
            _nameText.setFrame(2);
            _timeText.setFrame(2);
            _finishText.setFrame(2);
            _conditionText.setFrame(2);
         }
         else
         {
            _nameText.setFrame(1);
            _timeText.setFrame(1);
            _finishText.setFrame(1);
            _conditionText.setFrame(1);
         }
         if(_data.MaxCount == 0 || _data.TemplateId == "1000" || _data.TemplateId == "20")
         {
            _finishText.text = "- / -";
         }
         else
         {
            _finishText.text = _data.currentFinsh + " / " + _data.MaxCount;
         }
         _conditionText.text = data.condition;
         _conditionText.height = _conditionText.textHeight + 6;
         _conditionText.y = 10 - (_conditionText.textHeight - 6) / 2;
         checkFinish();
         canJoin();
      }
      
      private function checkFinish() : void
      {
         if(_data.currentFinsh == _data.MaxCount || _data.state == 1)
         {
            _timeText.setFrame(3);
            _nameText.setFrame(3);
            _finishText.setFrame(3);
            _conditionText.setFrame(3);
         }
      }
      
      private function setRoutineImage() : void
      {
         switch(int(data.ActiveType) - 1)
         {
            case 0:
               _routineImage.setFrame(1);
               break;
            case 1:
               _routineImage.setFrame(2);
               break;
            case 2:
               _routineImage.setFrame(3);
               break;
            case 3:
               _routineImage.setFrame(9);
               break;
            case 4:
               _routineImage.setFrame(2);
         }
         switch(_data.TemplateId)
         {
            case "8":
               _routineImage.setFrame(4);
               break;
            case "6":
               _routineImage.setFrame(5);
               break;
            case "9":
               _routineImage.setFrame(6);
               break;
            case "7":
               _routineImage.setFrame(7);
               break;
            case "11":
            case "18":
               _routineImage.setFrame(8);
               break;
            case "13":
               _routineImage.setFrame(10);
               break;
            case "14":
               _routineImage.setFrame(11);
               break;
            case "15":
               _routineImage.setFrame(12);
               break;
            case "16":
               _routineImage.setFrame(13);
               break;
            case "17":
               _routineImage.setFrame(14);
               break;
            case "19":
               _routineImage.setFrame(16);
               break;
            case "20":
            case "21":
               _routineImage.setFrame(17);
               break;
            case "1000":
               _routineImage.setFrame(13);
               break;
            case "25":
               _routineImage.setFrame(18);
               break;
            case "1600":
               _routineImage.setFrame(19);
         }
      }
      
      private function canJoin() : void
      {
         if(data.state != 1)
         {
            _joinText.visible = true;
            _hitSprite.visible = true;
            _closedText.visible = false;
         }
         else
         {
            _joinText.visible = false;
            _hitSprite.visible = false;
            _closedText.visible = true;
         }
      }
      
      private function clear() : void
      {
         _timeText.text = "";
         _nameText.text = "";
         _finishText.text = "";
         _conditionText.text = "";
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_gap);
         _gap = null;
         ObjectUtils.disposeViolentMc(_routineImage);
         _routineImage = null;
         ObjectUtils.disposeViolentMc(_selectedBg);
         _selectedBg = null;
         ObjectUtils.disposeObject(_timeText);
         _timeText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_finishText);
         _finishText = null;
         ObjectUtils.disposeObject(_conditionText);
         _conditionText = null;
         ObjectUtils.disposeObject(_joinText);
         _joinText = null;
         ObjectUtils.disposeObject(_closedText);
         _closedText = null;
         ObjectUtils.disposeObject(_conditionText);
         _conditionText = null;
         ObjectUtils.disposeObject(_hitSprite);
         _hitSprite = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

