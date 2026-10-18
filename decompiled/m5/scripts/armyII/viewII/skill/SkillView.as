package armyII.viewII.skill
{
   import armyII.viewII.rune.FastRuneItem;
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.ArmySocketOutManager;
   import managers.KingContractManager;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.RuneInfo;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.frame.NewKingContractView;
   
   public class SkillView extends Component
   {
      
      private static var DURATION:Number = 1;
      
      private static var LIGHT:Number = 1.2;
      
      private static var NORMAL:Number = 1;
      
      private var _filter:IFilterFormat;
      
      private var _back2:MutipleImage;
      
      private var _skillBack:ScaleFrameImage;
      
      private var _spliceLine2:ScaleBitmapImage;
      
      private var _remain:Bitmap;
      
      private var _remainTxt:FilterFrameText;
      
      private var _describeTxt:FilterFrameText;
      
      private var _washBtn:BaseButton;
      
      private var _doubleSkillBtn:IconButton;
      
      private var _switchSkillBtn:SelectedIconButton;
      
      private var _switchSkillBtn2:SelectedIconButton;
      
      private var _contain:Component;
      
      private var _contain2:Component;
      
      private var _hBox:HBox;
      
      private var _fastKeyList:Array;
      
      private var _skillDic:Dictionary;
      
      private var _runeKeyList:Array;
      
      private var _indexBack1:Bitmap;
      
      private var _indexTxt1:FilterFrameText;
      
      private var _indexBack2:Bitmap;
      
      private var _indexTxt2:FilterFrameText;
      
      private var _vocationSkillTxt:Bitmap;
      
      private var _bottomContainer:Component;
      
      private var _normalContainer:Component;
      
      private var _changeJobContainer:Component;
      
      private var _topBg:Image;
      
      private var _twoSkbg:ScaleFrameImage;
      
      private var _mask:Sprite;
      
      private var _changeToBranch:int;
      
      private var _newKingContract:NewKingContractView;
      
      private var _icon:Sprite;
      
      public function SkillView()
      {
         super();
         _fastKeyList = [];
         _skillDic = new Dictionary(true);
         _filter = new UIFilter();
         initView();
         initSkillList();
         initFastKeyList();
         initRuneKeyList();
         refreshSkill();
         refreshBranch();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _spliceLine2 = ComponentFactory.Instance.creatComponentByStylename("army.skill.SpliceBottom");
         _remainTxt = ComponentFactory.Instance.creatComponentByStylename("army.skill.RemainPointTxt");
         _washBtn = ComponentFactory.Instance.creatComponentByStylename("army.skill.WashBtn");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("army.skill.FastKeyBox");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("army.skill.FastKeyBack");
         _remain = ComponentFactory.Instance.creatBitmap("asset.army.RemainPoint");
         _newKingContract = new NewKingContractView();
         _newKingContract.x = 23;
         _newKingContract.y = 34;
         _bottomContainer = new Component();
         _bottomContainer.addChild(_back2);
         _bottomContainer.addChild(_hBox);
         addChild(_bottomContainer);
         if(thane.vocationIndex == 0)
         {
            _normalContainer = new Component();
            _skillBack = ComponentFactory.Instance.creatComponentByStylename("army.SkillBack");
            _describeTxt = ComponentFactory.Instance.creatComponentByStylename("army.skill.SkillDescribeTxt");
            _doubleSkillBtn = ComponentFactory.Instance.creatComponentByStylename("army.skill.DoubleSkillBtn");
            _switchSkillBtn = ComponentFactory.Instance.creatComponentByStylename("army.skill.SwitchSkillBtn");
            _contain = ComponentFactory.Instance.creatComponentByStylename("army.skill.TileContainer");
            _vocationSkillTxt = ComponentFactory.Instance.creatBitmap("asset.army.VocationSkillTxt");
            _normalContainer.addChild(_skillBack);
            _normalContainer.addChild(_describeTxt);
            if(VersionSwitch.DOUBLE_SKILL)
            {
               _normalContainer.addChild(_doubleSkillBtn);
               _normalContainer.addChild(_switchSkillBtn);
            }
            _normalContainer.addChild(_contain);
            _normalContainer.addChild(_vocationSkillTxt);
            addChild(_normalContainer);
            _describeTxt.text = LanguageMgr.GetTranslation("armyII.viewII.skill.describe");
            _doubleSkillBtn.visible = thane.grades >= 38 && !thane.skillCate.activeDouble;
            _switchSkillBtn.autoSelect = false;
            _switchSkillBtn.visible = thane.skillCate.activeDouble;
         }
         else if(thane.vocationIndex > 0)
         {
            _newKingContract.x = 426;
            _newKingContract.y = 12;
            _changeJobContainer = new Component();
            _topBg = ComponentFactory.Instance.creatComponentByStylename("changeJob.topBg");
            _twoSkbg = ComponentFactory.Instance.creatComponentByStylename("changeJob.skill.newBg");
            _contain2 = ComponentFactory.Instance.creatComponentByStylename("army.skill.TileContainer2");
            _switchSkillBtn2 = ComponentFactory.Instance.creatComponentByStylename("army.skill.SwitchSkillBtnII");
            _doubleSkillBtn = ComponentFactory.Instance.creatComponentByStylename("army.skill.DoubleSkillBtnII");
            if(VersionSwitch.DOUBLE_SKILL)
            {
               _contain2.addChild(_switchSkillBtn2);
               _contain2.addChild(_doubleSkillBtn);
            }
            _doubleSkillBtn.visible = thane.grades >= 38 && !thane.skillCate.activeDouble;
            _switchSkillBtn2.autoSelect = false;
            _switchSkillBtn2.visible = thane.skillCate.activeDouble;
            _loc1_ = int(ArmyManager.instance.thane.templateInfo.Job);
            _topBg.mouseChildren = _topBg.mouseEnabled = false;
            _changeJobContainer.addChild(_topBg);
            _changeJobContainer.addChild(_twoSkbg);
            _twoSkbg.setFrame(_loc1_);
            _changeJobContainer.addChild(_contain2);
            addChild(_changeJobContainer);
            _mask = new Sprite();
            _mask.x = 0;
            _mask.y = 0;
            _mask.graphics.lineStyle(1,0,0);
            _mask.graphics.beginFill(0,0.2);
            _mask.graphics.drawRect(0,0,615,403);
            _mask.graphics.endFill();
            _mask.width = 616;
            _mask.height = 404;
            _mask.visible = false;
            _newKingContract.x = 235;
            _newKingContract.y = 11;
         }
         addChild(_remain);
         addChild(_remainTxt);
         addChild(_washBtn);
         addChild(_newKingContract);
         if(_mask)
         {
            addChild(_mask);
         }
      }
      
      private function initRuneKeyList() : void
      {
         var _loc4_:int = 0;
         var _loc2_:FastRuneItem = null;
         var _loc1_:Boolean = false;
         var _loc5_:int = 0;
         var _loc3_:RuneTemplateInfo = null;
         var _loc7_:RuneInfo = null;
         _runeKeyList = [];
         var _loc6_:Array = thane.runeCate.runeScript.split(",");
         _loc5_ = 0;
         while(_loc5_ < 2)
         {
            _loc2_ = new FastRuneItem();
            _bottomContainer.addChild(_loc2_);
            _loc2_.x = 469 + _loc5_ * 75;
            _loc2_.y = 345;
            _loc1_ = thane.grades < 35 + _loc5_ * 5;
            _loc2_.isLock = _loc1_;
            _loc2_.buttonMode = true;
            if(!_loc2_.isLock && _loc5_ < _loc6_.length)
            {
               _loc3_ = TempleteManager.instance.getRuneTemplateByTid(_loc6_[_loc5_]);
               if(_loc3_)
               {
                  _loc7_ = thane.runeCate.getInfoByIndex(_loc3_.RuneIndex);
                  _loc2_.data = _loc7_;
                  _loc2_.refreshView();
               }
            }
            else
            {
               _loc2_.data = null;
            }
            _runeKeyList.push(_loc2_);
            _loc2_.setBySkillView();
            _loc2_.width = _loc2_.height = 62;
            _loc2_.mouseEnabled = _loc2_.mouseChildren = thane.grades >= 35;
            _loc5_++;
         }
         _indexBack1 = ComponentFactory.Instance.creatBitmap("asset.army.FastKeyItemIndex");
         _indexTxt1 = ComponentFactory.Instance.creatComponentByStylename("army.FastKeyItemIndexTxt");
         _indexBack2 = ComponentFactory.Instance.creatBitmap("asset.army.FastKeyItemIndex");
         _indexTxt2 = ComponentFactory.Instance.creatComponentByStylename("army.FastKeyItemIndexTxt");
         _indexBack1.x = 497;
         _indexBack1.y = 381;
         _indexTxt1.x = 483;
         _indexTxt1.y = 380;
         _indexBack2.x = 572;
         _indexBack2.y = 381;
         _indexTxt2.x = 558;
         _indexTxt2.y = 380;
         _indexTxt1.text = "Z";
         _indexTxt2.text = "X";
         _bottomContainer.addChild(_indexBack1);
         _bottomContainer.addChild(_indexTxt1);
         _bottomContainer.addChild(_indexBack2);
         _bottomContainer.addChild(_indexTxt2);
      }
      
      private function initSkillList() : void
      {
         var _loc6_:int = 0;
         var _loc10_:SkillitemView = null;
         var _loc1_:int = 0;
         _loc1_ = 80;
         var _loc3_:int = 0;
         _loc3_ = 72;
         var _loc4_:Array = null;
         var _loc7_:int = 0;
         _loc7_ = 2;
         var _loc5_:int = 0;
         _loc5_ = 4;
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _skillBack && _skillBack.setFrame(thane.templateInfo.Job);
         if(thane.isChangeJob)
         {
            _loc4_ = [[39,159],[119,159],[198,50]];
            _loc6_ = 0;
            while(_loc6_ < 22)
            {
               _loc10_ = ComponentFactory.Instance.creatCustomObject("army.skill.SkillItem");
               if(_loc6_ < _loc7_)
               {
                  _loc10_.x = _loc4_[_loc6_][0];
                  _loc10_.y = _loc4_[_loc6_][1];
               }
               else
               {
                  _loc8_ = _loc9_ / _loc5_;
                  _loc2_ = _loc9_ % 4;
                  _loc9_++;
                  _loc10_.x = _loc4_[_loc7_][0] + _loc1_ * _loc8_;
                  _loc10_.y = _loc4_[_loc7_][1] + _loc3_ * _loc2_;
               }
               _contain2.addChild(_loc10_);
               _skillDic[_loc6_] = _loc10_;
               _loc6_++;
            }
         }
         else
         {
            _loc6_ = 0;
            while(_loc6_ < 32)
            {
               _loc10_ = ComponentFactory.Instance.creatCustomObject("army.skill.SkillItem");
               _loc10_.x = int(_loc6_ % 8) * 77;
               _loc10_.y = int(_loc6_ / 8) * 63;
               _contain.addChild(_loc10_);
               _skillDic[_loc6_] = _loc10_;
               _loc6_++;
            }
         }
      }
      
      private function setObjectVisible(param1:DisplayObject, param2:Boolean) : void
      {
         if(param1)
         {
            param1.visible = param2;
         }
      }
      
      private function refreshSkill() : void
      {
         if(thane.isChangeJob)
         {
            refreshSkill2();
         }
         else
         {
            refreshSkill1();
         }
      }
      
      private function refreshSkill1() : void
      {
         var _loc6_:String = null;
         var _loc3_:int = 0;
         var _loc1_:SkillInfo = null;
         var _loc7_:SkillitemView = null;
         var _loc5_:DisplayObject = null;
         var _loc4_:DisplayObject = null;
         if(playerInfo.vocationGrades > 0)
         {
            _vocationSkillTxt.visible = false;
            _skillBack.setFrame(thane.templateInfo.Job + 3);
         }
         else
         {
            _vocationSkillTxt.visible = true;
            _skillBack.setFrame(thane.templateInfo.Job);
         }
         var _loc2_:MovieClip = _skillBack.getFrameImage(_skillBack.getFrame - 1) as MovieClip;
         for(_loc6_ in _skillDic)
         {
            _loc3_ = int(_loc6_);
            _loc1_ = thane.skillCate.allSkillList[_loc3_] as SkillInfo;
            _loc7_ = _skillDic[_loc6_] as SkillitemView;
            _loc5_ = _loc2_["p_" + _loc3_ + "_1"] as DisplayObject;
            _loc4_ = _loc2_["p_" + _loc3_] as DisplayObject;
            if(int(_loc3_ % 8) >= 6)
            {
               if(playerInfo.vocationGrades > 0)
               {
                  setObjectVisible(_loc7_,true);
                  setObjectVisible(_loc5_,true);
                  setObjectVisible(_loc4_,true);
               }
               else
               {
                  setObjectVisible(_loc7_,false);
                  setObjectVisible(_loc5_,false);
                  setObjectVisible(_loc4_,false);
               }
            }
            if(_loc1_)
            {
               _loc7_.data = _loc1_;
               setArraw(_loc7_,_loc5_);
               setArraw(_loc7_,_loc4_);
            }
            else
            {
               _loc7_.data = null;
            }
         }
         _remainTxt.text = thane.skillCate.skillPoint.toString();
         _washBtn.enable = !StringHelper.isNullOrEmpty(thane.skillCate.skillScript);
         _switchSkillBtn.selected = thane.skillCate.skillIndex == 1;
      }
      
      private function refreshSkill2() : void
      {
         var _loc7_:String = null;
         var _loc4_:int = 0;
         var _loc2_:SkillInfo = null;
         var _loc8_:SkillitemView = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         for(_loc7_ in _skillDic)
         {
            _loc4_ = int(_loc7_) + 1;
            _loc2_ = thane.skillCate.allSkillList[_loc4_] as SkillInfo;
            _loc8_ = _skillDic[_loc7_] as SkillitemView;
            if(_loc2_)
            {
               _loc8_.data = _loc2_;
            }
            else
            {
               _loc8_.data = null;
            }
         }
         _remainTxt.text = thane.skillCate.skillPoint.toString();
         var _loc3_:SkillInfo = thane.skillCate.allSkillList[1] as SkillInfo;
         var _loc1_:SkillInfo = thane.skillCate.allSkillList[2] as SkillInfo;
         _washBtn.enable = thane.skillCate.skillScript != _loc3_.templateId + "," + _loc1_.templateId + ",";
         if(_loc3_.grade > 1 || _loc1_.grade > 1)
         {
            _washBtn.enable = true;
         }
      }
      
      private function setArraw(param1:SkillitemView, param2:DisplayObject) : void
      {
         if(param2)
         {
            _filter.setNormalFilter(param2);
            if(param1.isOpen)
            {
               _filter.setGrayFilter(param2);
            }
         }
      }
      
      private function initFastKeyList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:FastSkillItem = null;
         var _loc2_:SkillInfo = null;
         var _loc4_:Array = thane.skillCate.fastKey.split(",");
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc1_ = new FastSkillItem();
            _hBox.addChild(_loc1_);
            if(_loc3_ < _loc4_.length)
            {
               _loc2_ = thane.getSkillBySontype(_loc4_[_loc3_]);
               _loc1_.data = _loc2_;
               _loc1_.refreshView();
            }
            else
            {
               _loc1_.data = null;
            }
            _loc1_.index = _loc3_ + 1;
            _fastKeyList.push(_loc1_);
            _loc3_++;
         }
      }
      
      protected function initEvent() : void
      {
         _washBtn.addEventListener("click",__washHandler);
         _doubleSkillBtn && _doubleSkillBtn.addEventListener("click",__activeDoubleSkillHandler);
         _switchSkillBtn && _switchSkillBtn.addEventListener("click",__switchHandler);
         _switchSkillBtn2 && _switchSkillBtn2.addEventListener("click",__switchHandler2);
         thane.skillCate.addEventListener("SKILL_INDEX",__switchSkillHandler);
         thane.skillCate.addEventListener("ACTIVE_DOUBLE_SKILL",__doubleSkillHandler);
         thane.addEventListener("VOCATION_INDEX",__updateVocationIndexHandler);
         NotificationManager.instance.addEventListener("FAST_KEY_MOVE",__fastKeyMoveHandler);
         NotificationManager.instance.addEventListener("SET_FAST_KEY",__setFastKeyHandler);
         NotificationManager.instance.addEventListener("SKILL_UPGRADE",__skillChangeHandler);
         NotificationManager.instance.addEventListener("SKILL_RESET",__skillChangeHandler);
         NotificationManager.instance.addEventListener("DOUBLE_KEY_CHANGE",__runeKeyHandler);
      }
      
      protected function __updateVocationIndexHandler(param1:Event) : void
      {
         _mask.visible = false;
         refreshSkill();
         refreshBranch();
      }
      
      private function refreshBranch() : void
      {
         if(thane.vocationIndex > 0)
         {
            _switchSkillBtn2.selected = thane.skillCate.skillIndex == 1;
         }
      }
      
      private function setDisable() : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc4_:SkillitemView = null;
         for(_loc3_ in _skillDic)
         {
            _loc2_ = int(_loc3_) + 1;
            _loc4_ = _skillDic[_loc3_] as SkillitemView;
            if(!(_loc2_ == 1 || _loc2_ == 2))
            {
               if(int((_loc2_ + 4) / 7) != vocationBranch + 1)
               {
                  _loc4_.setDisabled();
               }
            }
         }
      }
      
      protected function _branch1ClickHandle(param1:MouseEvent = null) : void
      {
         if(vocationBranch == 0)
         {
            return;
         }
         _changeToBranch = 1;
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc3_:String = LanguageMgr.GetTranslation("SkillView.branchClickHandle",LanguageMgr.GetTranslation("army.skill.switchSuit",1));
         SharedManagerHelper.ins.needAlert("SkillView_branchClickHandle",sendChangeBranch,_loc2_,_loc3_);
      }
      
      private function sendChangeBranch() : void
      {
         _mask.visible = true;
         FrameControllerManager.instance.changeJobControler.sendChangeBranch(_changeToBranch);
      }
      
      protected function _branch2ClickHandle(param1:MouseEvent = null) : void
      {
         if(vocationBranch == 1)
         {
            return;
         }
         _changeToBranch = 2;
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc3_:String = LanguageMgr.GetTranslation("SkillView.branchClickHandle",LanguageMgr.GetTranslation("army.skill.switchSuit",2));
         SharedManagerHelper.ins.needAlert("SkillView_branchClickHandle",sendChangeBranch,_loc2_,_loc3_);
      }
      
      protected function removeEvent() : void
      {
         _washBtn.removeEventListener("click",__washHandler);
         _doubleSkillBtn && _doubleSkillBtn.removeEventListener("click",__activeDoubleSkillHandler);
         _switchSkillBtn && _switchSkillBtn.removeEventListener("click",__switchHandler);
         _switchSkillBtn2 && _switchSkillBtn2.removeEventListener("click",__switchHandler2);
         thane.skillCate.removeEventListener("SKILL_INDEX",__switchSkillHandler);
         thane.skillCate.removeEventListener("ACTIVE_DOUBLE_SKILL",__doubleSkillHandler);
         thane.removeEventListener("VOCATION_INDEX",__updateVocationIndexHandler);
         NotificationManager.instance.removeEventListener("FAST_KEY_MOVE",__fastKeyMoveHandler);
         NotificationManager.instance.removeEventListener("SET_FAST_KEY",__setFastKeyHandler);
         NotificationManager.instance.removeEventListener("SKILL_UPGRADE",__skillChangeHandler);
         NotificationManager.instance.removeEventListener("SKILL_RESET",__skillChangeHandler);
         NotificationManager.instance.removeEventListener("DOUBLE_KEY_CHANGE",__runeKeyHandler);
      }
      
      private function __activeDoubleSkillHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc5_:String = TempleteManager.instance.getConfigInfoByConfigName("Second_SkillPoint").ConfigValue;
         SimpleAlertHelper.instance.data = [activeAlertBack,[_loc5_]];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("armyII.viewII.skill.ActiveAlertContent",_loc5_);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc6_,_loc2_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc5_);
      }
      
      private function activeAlertBack(param1:Boolean, param2:Boolean, param3:String) : void
      {
         if(param1)
         {
            control.sendActiveSecond(param2);
         }
      }
      
      private function hasMoney(param1:Boolean) : int
      {
         if(param1)
         {
            return PlayerManager.instance.currentPlayerModel.playerInfo.point + PlayerManager.instance.currentPlayerModel.playerInfo.giftToken;
         }
         return PlayerManager.instance.currentPlayerModel.playerInfo.point;
      }
      
      private function __switchHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = 0;
         if(thane.skillCate.skillIndex == 1)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = 1;
         }
         control.sendSkillChange(_loc2_);
      }
      
      private function __switchHandler2(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = 0;
         if(thane.skillCate.skillIndex == 1)
         {
            _branch1ClickHandle();
         }
         else
         {
            _branch2ClickHandle();
         }
      }
      
      private function __washHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc6_:int = int(TempleteManager.instance.getConfigInfoByConfigName("ResetSkill_NeedPay").ConfigValue);
         var _loc2_:String = LanguageMgr.GetTranslation("armyII.viewII.skill.content01",_loc6_);
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         if(thane.grades < 25 || Boolean(KingContractManager.Instance.checkHasBuffById(9)))
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.skill.content02");
            SimpleAlertHelper.instance.data = [alertBack];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_);
         }
         else
         {
            SimpleAlertHelper.instance.data = [payCallBack];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc6_);
         }
      }
      
      private function alertBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            control.sendWashSkillPoint(0,true);
         }
      }
      
      private function payCallBack(param1:Boolean, param2:Boolean, param3:int = 0, param4:int = 0) : void
      {
         if(param1)
         {
            control.sendWashSkillPoint(param4,param2);
         }
      }
      
      private function __doubleSkillHandler(param1:PlayerEvent) : void
      {
         _doubleSkillBtn.visible = thane.grades >= 38 && !thane.skillCate.activeDouble;
         if(_switchSkillBtn)
         {
            _switchSkillBtn.visible = thane.skillCate.activeDouble;
         }
         if(_switchSkillBtn2)
         {
            _switchSkillBtn2.visible = thane.skillCate.activeDouble;
         }
      }
      
      private function __skillChangeHandler(param1:NotificationEvent) : void
      {
         refreshSkill();
         refreshFastList();
         refreshBranch();
      }
      
      private function __setFastKeyHandler(param1:NotificationEvent = null) : void
      {
         control.sendSetFastKey(fastKey);
      }
      
      private function __fastKeyMoveHandler(param1:NotificationEvent) : void
      {
         var _loc5_:SkillInfo = param1.data["data"];
         var _loc4_:Point = param1.data["point"];
         _icon = param1.data["icon"];
         var _loc2_:FastSkillItem = getEmputyItem();
         if(!_loc2_)
         {
            return;
         }
         _loc2_.data = _loc5_;
         __setFastKeyHandler();
         _icon.x = _loc4_.x;
         _icon.y = _loc4_.y;
         stage.addChild(_icon);
         var _loc3_:Point = _loc2_.parent.localToGlobal(new Point(_loc2_.x,_loc2_.y));
         TweenMax.to(_icon,1,{
            "x":_loc3_.x,
            "y":_loc3_.y,
            "onComplete":_moveComplete,
            "onCompleteParams":[_loc2_,_loc5_,_icon]
         });
      }
      
      private function _moveComplete(param1:FastSkillItem, param2:SkillInfo, param3:Sprite) : void
      {
         param3 && TweenMax.killTweensOf(param3);
         if(param1)
         {
            param1.refreshView();
         }
         ObjectUtils.disposeObject(param3);
      }
      
      private function __switchSkillHandler(param1:PlayerEvent) : void
      {
         if(_mask)
         {
            _mask.visible = false;
         }
         refreshSkill();
         refreshFastList();
         refreshBranch();
         ArmySocketOutManager.sendTakeRune(runefastKey);
      }
      
      private function __runeKeyHandler(param1:Event) : void
      {
         refreshRuneKeyList();
      }
      
      private function refreshRuneKeyList() : void
      {
         var _loc4_:int = 0;
         var _loc2_:FastRuneItem = null;
         var _loc1_:Boolean = false;
         var _loc5_:int = 0;
         var _loc3_:RuneTemplateInfo = null;
         var _loc7_:RuneInfo = null;
         var _loc6_:Array = thane.runeCate.runeScript.split(",");
         _loc5_ = 0;
         while(_loc5_ < 2)
         {
            _loc2_ = _runeKeyList[_loc5_] as FastRuneItem;
            _loc1_ = thane.grades < 35 + _loc5_ * 5;
            _loc2_.isLock = _loc1_;
            _loc2_.buttonMode = true;
            _loc2_.data = null;
            if(!_loc2_.isLock && _loc5_ < _loc6_.length)
            {
               _loc3_ = TempleteManager.instance.getRuneTemplateByTid(_loc6_[_loc5_]);
               if(_loc3_)
               {
                  _loc7_ = thane.runeCate.getInfoByIndex(_loc3_.RuneIndex);
                  _loc2_.data = _loc7_;
               }
            }
            _loc2_.refreshView();
            _loc5_++;
         }
      }
      
      public function get fastKey() : String
      {
         var _loc4_:int = 0;
         var _loc2_:FastSkillItem = null;
         var _loc1_:String = "";
         var _loc3_:int = int(_fastKeyList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _fastKeyList[_loc4_] as FastSkillItem;
            if(_loc2_.data)
            {
               _loc1_ += _loc2_.data.templateInfo.SonType + ",";
            }
            else
            {
               _loc1_ += "-1,";
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      private function refreshFastList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FastSkillItem = null;
         var _loc4_:SkillInfo = null;
         var _loc3_:Array = thane.skillCate.fastKey.split(",");
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = _fastKeyList[_loc2_] as FastSkillItem;
            if(_loc2_ < _loc3_.length)
            {
               _loc4_ = thane.getSkillBySontype(_loc3_[_loc2_]);
               _loc1_.data = _loc4_;
            }
            else
            {
               _loc1_.data = null;
               _loc1_.isUsed = false;
            }
            _loc1_.refreshView();
            _loc2_++;
         }
      }
      
      public function get runefastKey() : String
      {
         var _loc2_:RuneTemplateInfo = null;
         var _loc3_:int = 0;
         var _loc5_:RuneInfo = null;
         var _loc1_:String = "";
         var _loc4_:Array = thane.runeCate.runeScript.split(",");
         _loc3_ = 0;
         while(_loc3_ < 2)
         {
            _loc2_ = TempleteManager.instance.getRuneTemplateByTid(_loc4_[_loc3_]);
            if(_loc2_)
            {
               _loc5_ = thane.runeCate.getInfoByIndex(_loc2_.RuneIndex);
               _loc1_ += _loc5_.runeId + ",";
            }
            else
            {
               _loc1_ += "-1,";
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function getEmputyItem() : FastSkillItem
      {
         var _loc2_:int = 0;
         var _loc1_:FastSkillItem = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = _fastKeyList[_loc2_] as FastSkillItem;
            if(!_loc1_.data && !_loc1_.isUsed)
            {
               _loc1_.isUsed = true;
               return _loc1_;
            }
            _loc2_++;
         }
         return null;
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get vocationBranch() : int
      {
         return thane.skillCate.skillIndex;
      }
      
      public function getSkillItemByIndex(param1:int) : SkillitemView
      {
         return _skillDic[param1];
      }
      
      public function getSkillItemByInfo(param1:SkillInfo) : SkillitemView
      {
         for each(var _loc2_:SkillitemView in _skillDic)
         {
            if(_loc2_.data == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_icon)
         {
            TweenMax.killTweensOf(_icon);
            ObjectUtils.disposeAllChildren(_icon);
            _icon.parent && _icon.parent.removeChild(_icon);
            _icon = null;
         }
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_skillBack);
         _skillBack = null;
         ObjectUtils.disposeObject(_spliceLine2);
         _spliceLine2 = null;
         ObjectUtils.disposeObject(_remain);
         _remain = null;
         ObjectUtils.disposeObject(_remainTxt);
         _remainTxt = null;
         ObjectUtils.disposeObject(_washBtn);
         _washBtn = null;
         ObjectUtils.disposeObject(_newKingContract);
         _newKingContract = null;
         ObjectUtils.disposeObject(_contain);
         _contain = null;
         ObjectUtils.disposeObject(_contain2);
         _contain2 = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_indexBack1);
         _indexBack1 = null;
         ObjectUtils.disposeObject(_indexTxt1);
         _indexTxt1 = null;
         ObjectUtils.disposeObject(_indexBack2);
         _indexBack2 = null;
         ObjectUtils.disposeObject(_indexTxt2);
         _indexTxt2 = null;
         ObjectUtils.disposeObject(_describeTxt);
         _describeTxt = null;
         ObjectUtils.disposeObject(_doubleSkillBtn);
         _doubleSkillBtn = null;
         ObjectUtils.disposeObject(_switchSkillBtn);
         _switchSkillBtn = null;
         ObjectUtils.disposeObject(_switchSkillBtn2);
         _switchSkillBtn2 = null;
         ObjectUtils.disposeObject(_vocationSkillTxt);
         _vocationSkillTxt = null;
         ObjectUtils.disposeObject(_bottomContainer);
         _bottomContainer = null;
         ObjectUtils.disposeObject(_normalContainer);
         _normalContainer = null;
         ObjectUtils.disposeObject(_changeJobContainer);
         _changeJobContainer = null;
         ObjectUtils.disposeObject(_topBg);
         _topBg = null;
         ObjectUtils.disposeObject(_twoSkbg);
         _twoSkbg = null;
         _mask && _mask.parent && _mask.parent.removeChild(_mask);
         _mask = null;
         cleanList();
         ObjectUtils.disposeAllChildren(this);
         _filter = null;
      }
      
      private function cleanList() : void
      {
         if(_fastKeyList)
         {
            for each(var _loc1_:FastSkillItem in _fastKeyList)
            {
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
            _fastKeyList = null;
         }
         if(_runeKeyList)
         {
            for each(var _loc2_:FastRuneItem in _runeKeyList)
            {
               ObjectUtils.disposeObject(_loc2_);
               _loc2_ = null;
            }
            _runeKeyList = null;
         }
         if(_skillDic)
         {
            for each(var _loc3_:SkillitemView in _skillDic)
            {
               ObjectUtils.disposeObject(_loc3_);
               _loc3_ = null;
            }
            _skillDic = null;
         }
      }
   }
}

