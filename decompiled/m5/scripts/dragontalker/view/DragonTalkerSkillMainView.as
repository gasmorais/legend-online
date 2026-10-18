package dragontalker.view
{
   import armyII.viewII.rune.FastRuneItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dragontalker.item.DragonTalkerFastSkillItem;
   import dragontalker.item.DragonTalkerSkillItemView;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import managers.KingContractManager;
   import mvc.module.armyII.RuneInfo;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerSkillInfo;
   import utils.LogicUtils;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.frame.NewKingContractView;
   
   public class DragonTalkerSkillMainView extends Component
   {
      
      private static var skillPostion:Array = [[244,62],[325,62],[404,62],[483,62],[165,131],[245,131],[320,131],[485,131],[565,131],[642,131],[324,206],[403,206],[484,206],[563,206],[245,273],[403,273],[484,273]];
      
      private var _pointText:FilterFrameText;
      
      private var _typeImage:ScaleFrameImage;
      
      private var _returnBtn:IconButton;
      
      private var _washBtn:IconButton;
      
      private var _back:MutipleImage;
      
      private var _newKingContract:NewKingContractView;
      
      private var _bottomContiner:Component;
      
      private var _fastHbox:HBox;
      
      private var _indexBack1:Image;
      
      private var _indexTxt1:FilterFrameText;
      
      private var _indexBack2:Image;
      
      private var _indexTxt2:FilterFrameText;
      
      private var _fastKeyList:Array;
      
      private var _runeKeyList:Array;
      
      private var _skillContiner:Component;
      
      private var _skillDic:Dictionary;
      
      private var _curSkillInfo:DragonTalkerSkillInfo;
      
      public function DragonTalkerSkillMainView()
      {
         super();
         initView();
         initFastKeyView();
         initRuneView();
         initSkillView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _pointText = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n1_ppj0vhuak");
         _typeImage = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.vhuak.typeImage");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.vhuak.returnBtn");
         _washBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.vhuak.washBtn");
         _back = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.vhuak.back");
         _newKingContract = ComponentFactory.Instance.creatCustomObject("DragonTalkerSkillMainView.newKingContract");
         _skillContiner = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillMainView.skillContiner");
         _bottomContiner = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillMainView.bottomContiner");
         _fastHbox = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillMainView.fastHbox");
         addChild(_back);
         addChild(_pointText);
         addChild(_washBtn);
         addChild(_returnBtn);
         addChild(_newKingContract);
         addChild(_typeImage);
         addChild(_skillContiner);
         addChild(_bottomContiner);
         _bottomContiner.addChild(_fastHbox);
      }
      
      private function initFastKeyView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DragonTalkerFastSkillItem = null;
         _fastKeyList = [];
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new DragonTalkerFastSkillItem();
            _loc1_.index = _loc2_ + 1;
            _fastHbox.addChild(_loc1_);
            _fastKeyList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initRuneView() : void
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
            _bottomContiner.addChild(_loc2_);
            _loc2_.x = 540 + _loc5_ * 82;
            _loc2_.y = 12;
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
            _loc2_.setBySkillView(true);
            _loc2_.addEventListener("click",__clickRuneHandler);
            _loc2_.width = _loc2_.height = 62;
            _loc2_.mouseEnabled = _loc2_.mouseChildren = thane.grades >= 35;
            _loc5_++;
         }
         _indexBack1 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillMainView.FastKeyItemIndex1");
         _indexTxt1 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillMainView.FastKeyItemIndexTxt1");
         _indexBack2 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillMainView.FastKeyItemIndex2");
         _indexTxt2 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillMainView.FastKeyItemIndexTxt2");
         _indexTxt1.text = "Z";
         _indexTxt2.text = "X";
         _bottomContiner.addChild(_indexBack1);
         _bottomContiner.addChild(_indexTxt1);
         _bottomContiner.addChild(_indexBack2);
         _bottomContiner.addChild(_indexTxt2);
      }
      
      private function initSkillView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DragonTalkerSkillItemView = null;
         _skillDic = new Dictionary(true);
         _loc1_ = 0;
         while(_loc1_ < 17)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("DragonTalkerSkillMainView.SkillItem");
            _loc2_.x = skillPostion[_loc1_][0];
            _loc2_.y = skillPostion[_loc1_][1];
            _skillContiner.addChild(_loc2_);
            _skillDic[_loc1_ + 1] = _loc2_;
            _loc1_++;
         }
      }
      
      private function addEvent() : void
      {
         _returnBtn.addEventListener("click",clickreturnBtnHandler);
         _washBtn.addEventListener("click",clickwashBtnHandler);
         MsgMan.addObserver("SET_FAST_KEY",this,__setFastKeyHandler);
         MsgMan.addObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateSkillViewHandler);
      }
      
      private function removeEvent() : void
      {
         if(_returnBtn)
         {
            _returnBtn.removeEventListener("click",clickreturnBtnHandler);
         }
         if(_washBtn)
         {
            _washBtn.removeEventListener("click",clickwashBtnHandler);
         }
         MsgMan.removeObserver("SET_FAST_KEY",this,__setFastKeyHandler);
         MsgMan.removeObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateSkillViewHandler);
      }
      
      private function clickwashBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc6_:int = int(TempleteManager.instance.getConfigInfoByConfigName("ResetSkill_NeedPay").ConfigValue);
         var _loc2_:String = LanguageMgr.GetTranslation("armyII.viewII.skill.content01",_loc6_);
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         if(KingContractManager.Instance.checkHasBuffById(9))
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.skill.content02");
            SimpleAlertHelper.instance.data = [alertBackHandler];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_);
         }
         else
         {
            SimpleAlertHelper.instance.data = [payCallBackHandler,_loc6_];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_loc6_);
         }
      }
      
      private function alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            DragonTalkerManager.instance.sendSkillRequest(12,model.skillTabIndex);
         }
      }
      
      private function payCallBackHandler(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!param1)
         {
            return;
         }
         if(param2)
         {
            _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         else
         {
            _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(_loc4_ >= param3)
         {
            _loc5_ = param2 ? 2 : 1;
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function clickreturnBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         model.skillTabIndex = 0;
      }
      
      private function __clickRuneHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.SKILL_PANEL,1);
      }
      
      private function refreshView() : void
      {
         _curSkillInfo = model.getSkillInfoByIndex(model.skillTabIndex);
         refreshSkillList();
         refreshRuneKeyList();
         refreshFastList();
         _pointText.text = _curSkillInfo ? _curSkillInfo.skillPoint + "" : "0";
         _washBtn.enable = _curSkillInfo ? !StringHelper.isNullOrEmpty(_curSkillInfo.hasLearnSkill) : false;
         _typeImage.setFrame(model.skillTabIndex);
      }
      
      private function refreshSkillList() : void
      {
         for(var _loc1_:String in _skillDic)
         {
         }
      }
      
      private function refreshFastList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DragonTalkerFastSkillItem = null;
         var _loc3_:Array = _curSkillInfo ? _curSkillInfo.fastKeySkills : [];
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = _fastKeyList[_loc2_] as DragonTalkerFastSkillItem;
            if(_loc2_ >= _loc3_.length)
            {
               _loc1_.data = null;
            }
            _loc1_.refreshView();
            _loc2_++;
         }
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
      
      private function __updateSkillViewHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __setFastKeyHandler(param1:String, param2:Object) : void
      {
      }
      
      public function get fastKey() : String
      {
         var _loc4_:int = 0;
         var _loc2_:DragonTalkerFastSkillItem = null;
         var _loc1_:String = "";
         var _loc3_:int = int(_fastKeyList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _fastKeyList[_loc4_] as DragonTalkerFastSkillItem;
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
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_pointText);
         _pointText = null;
         ObjectUtils.disposeObject(_typeImage);
         _typeImage = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_washBtn);
         _washBtn = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_newKingContract);
         _newKingContract = null;
         ObjectUtils.disposeObject(_bottomContiner);
         _bottomContiner = null;
         ObjectUtils.disposeObject(_fastHbox);
         _fastHbox = null;
         ObjectUtils.disposeObject(_skillContiner);
         _skillContiner = null;
         ObjectUtils.disposeObject(_indexBack1);
         _indexBack1 = null;
         ObjectUtils.disposeObject(_indexBack2);
         _indexBack2 = null;
         ObjectUtils.disposeObject(_indexTxt1);
         _indexTxt1 = null;
         ObjectUtils.disposeObject(_indexTxt2);
         _indexTxt2 = null;
         LogicUtils.disposeDisplayCollection(_skillDic);
         _skillDic = null;
         LogicUtils.disposeDisplayCollection(_fastKeyList);
         _fastKeyList = null;
         LogicUtils.disposeDisplayCollection(_runeKeyList);
         _runeKeyList = null;
         super.dispose();
      }
   }
}

