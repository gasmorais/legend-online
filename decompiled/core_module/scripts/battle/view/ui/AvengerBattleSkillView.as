package battle.view.ui
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   import utils.LogicUtils;
   import yishi.datas.BattleModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   
   public class AvengerBattleSkillView extends Component
   {
      
      private var _skillBack:Bitmap;
      
      private var _avengerImage:Image;
      
      private var _mask:Component;
      
      private var _splitLine:Bitmap;
      
      private var _waitView:Component;
      
      private var _waitBg:MutipleImage;
      
      private var _majorText:FilterFrameText;
      
      private var _minorText:FilterFrameText;
      
      private var _fightSkillHbox:HBox;
      
      private var _waitSkillCon:Component;
      
      private var _numBit:BitmapData;
      
      private var _avengerSpCon:Component;
      
      private var _openBtn:BaseButton;
      
      private var _closeImage:Bitmap;
      
      private var _leftTimeText:FilterFrameText;
      
      private var _btnKeyImage:Image;
      
      private var _btnKeyText:FilterFrameText;
      
      private var _avengerSp:int = -1;
      
      private var fightSkillList:Vector.<BattleSkillItemII>;
      
      private var waitSkillList:Vector.<BattleSkillItemII>;
      
      private var controller:AvengerSkillItemListController;
      
      private var _enable:Boolean = false;
      
      public function AvengerBattleSkillView()
      {
         super();
         initView();
         initSkillView();
         controller = new AvengerSkillItemListController(this);
         addEvent();
      }
      
      private function initView() : void
      {
         _skillBack = ComponentFactory.Instance.creatBitmap("asset.SelfAvengerView.skillBack");
         _avengerImage = ComponentFactory.Instance.creatComponentByStylename("SelfAvengerView.avengerImage");
         _splitLine = ComponentFactory.Instance.creatBitmap("asset.SelfAvengerView.splitLine");
         _waitBg = ComponentFactory.Instance.creatComponentByStylename("SelfAvengerView.waitBg");
         _majorText = ComponentFactory.Instance.creatComponentByStylename("SelfAvengerView.majorText");
         _minorText = ComponentFactory.Instance.creatComponentByStylename("SelfAvengerView.minorText");
         _fightSkillHbox = ComponentFactory.Instance.creatComponentByStylename("SelfAvengerView.fightSkillHbox");
         _waitSkillCon = ComponentFactory.Instance.creatComponentByStylename("SelfAvengerView.waitSkillCon");
         _numBit = ComponentFactory.Instance.creatBitmapData("asset.SelfAvengerView.numBmd");
         _avengerSpCon = ComponentFactory.Instance.creatComponentByStylename("SelfAvengerView.avengerSpCon");
         _waitView = ComponentFactory.Instance.creatComponentByStylename("SelfAvengerView.waitView");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("SelfAvengerView.openBtn");
         _closeImage = ComponentFactory.Instance.creatBitmap("asset.SelfAvengerView.closeImage");
         _leftTimeText = ComponentFactory.Instance.creatComponentByStylename("SelfAvengerView.leftTimeText");
         _btnKeyImage = ComponentFactory.Instance.creatComponentByStylename("AvengerBattleSkillView.btnKeyImage");
         _btnKeyText = ComponentFactory.Instance.creatComponentByStylename("AvengerBattleSkillView.btnKeyText");
         _mask = new Component();
         _mask.mouseChildren = _mask.mouseEnabled = false;
         addChild(_skillBack);
         addChild(_avengerImage);
         addChild(_mask);
         addChild(_splitLine);
         addChild(_avengerSpCon);
         addChild(_fightSkillHbox);
         addChild(_waitView);
         addChild(_closeImage);
         addChild(_openBtn);
         addChild(_leftTimeText);
         addChild(_btnKeyImage);
         addChild(_btnKeyText);
         _waitView.addChild(_waitBg);
         _waitView.addChild(_majorText);
         _waitView.addChild(_minorText);
         _waitView.addChild(_waitSkillCon);
         _waitView.visible = false;
         _closeImage.visible = false;
         _majorText.text = LanguageMgr.GetTranslation("SelfAvengerView.majorText.text");
         _minorText.text = LanguageMgr.GetTranslation("SelfAvengerView.minorText.text");
         _btnKeyText.text = "M";
         _avengerImage.mask = getMask(0);
      }
      
      private function getMask(param1:int) : Component
      {
         _mask.graphics.clear();
         _mask.graphics.beginFill(16777215,1);
         _mask.graphics.drawRect(15,18,param1,24);
         _mask.graphics.endFill();
         return _mask;
      }
      
      private function initSkillView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:BattleSkillItemII = null;
         fightSkillList = new Vector.<BattleSkillItemII>();
         waitSkillList = new Vector.<BattleSkillItemII>();
         var _loc1_:Array = getFightSkillAry();
         var _loc4_:Array = getWaitSkillAry();
         _loc3_ = 0;
         while(_loc3_ < 2)
         {
            _loc2_ = new BattleSkillItemII();
            _loc2_.numCount = 200 + _loc3_;
            _loc2_.data = _loc1_[_loc3_];
            _loc2_.addEventListener("SKILL_CLICK_BattleEvent",__skillClick);
            _fightSkillHbox.addChild(_loc2_);
            fightSkillList.push(_loc2_);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc2_ = new BattleSkillItemII();
            _loc2_.numCount = 202 + _loc3_;
            _loc2_.data = _loc4_[_loc3_];
            _loc2_.x = int(_loc3_ / 2) <= 0 ? 0 : 75;
            _loc2_.y = int(_loc3_ % 2) * 60 + 30;
            _loc2_.parentEnable = true;
            _loc2_.buttonSkiner.enable = true;
            _loc2_.addEventListener("SKILL_CLICK_BattleEvent",__waitSkillClick);
            _waitSkillCon.addChild(_loc2_);
            waitSkillList.push(_loc2_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         _openBtn.addEventListener("click",__openWaitViewHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updateLeftTimeHandler);
         KeyboardManager.getInstance().addEventListener("keyDown",__onKeyDownHandler);
      }
      
      private function removeEvent() : void
      {
         if(_openBtn)
         {
            _openBtn.removeEventListener("click",__openWaitViewHandler);
         }
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateLeftTimeHandler);
         KeyboardManager.getInstance().removeEventListener("keyDown",__onKeyDownHandler);
      }
      
      public function setEnable(param1:Boolean) : void
      {
         var _loc2_:SkillTempInfo = null;
         if(param1 == _enable)
         {
            return;
         }
         _enable = param1;
         for each(var _loc3_:BattleSkillItemII in fightSkillList)
         {
            if(!_loc3_.isLock)
            {
               if(!_enable)
               {
                  _loc3_.setDownEffect();
               }
               _loc2_ = _loc3_.data as SkillTempInfo;
               if(_loc2_)
               {
                  _loc3_.parentEnable = _enable;
                  _loc3_.buttonSkiner.enable = _enable;
               }
            }
         }
         refreshSkillStateByAvengerSp();
      }
      
      public function refreshSkillStateByAvengerSp() : void
      {
         var _loc2_:SkillTempInfo = null;
         if(!battleModel.selfHero || battleModel.selfHero.totalBloodA <= 0)
         {
            return;
         }
         for each(var _loc1_:BattleSkillItemII in fightSkillList)
         {
            if(!_loc1_.isLock)
            {
               _loc2_ = _loc1_.data as SkillTempInfo;
               if(_loc2_)
               {
                  if(_enable)
                  {
                     if(battleModel.selfHero.avengerSp < _loc2_.Cost)
                     {
                        _loc1_.buttonSkiner.enable = false;
                        _loc1_.setState(1);
                     }
                     else
                     {
                        _loc1_.buttonSkiner.enable = true;
                     }
                  }
                  else if(battleModel.selfHero.avengerSp < _loc2_.Cost)
                  {
                     _loc1_.setState(1);
                  }
               }
            }
         }
      }
      
      private function __updateLeftTimeHandler(param1:PlayerEvent) : void
      {
         if(battleModel.selfHero.avengerWaitSec > 0)
         {
            _leftTimeText.text = battleModel.selfHero.avengerWaitSec + "";
            battleModel.selfHero.avengerWaitSec--;
            _closeImage.visible = true;
            _openBtn.visible = false;
            _waitView.visible = false;
         }
         else
         {
            _leftTimeText.text = "";
            _closeImage.visible = false;
            _openBtn.visible = true;
         }
      }
      
      private function __onKeyDownHandler(param1:KeyboardEvent) : void
      {
         if(battleModel.selfHero.avengerWaitSec > 0)
         {
            return;
         }
         if(param1.charCode == KeyStroke.VK_M.getCode() || param1.charCode == KeyStroke.VK_M.getCode() + 32)
         {
            _waitView.visible = !_waitView.visible;
         }
      }
      
      private function __openWaitViewHandler(param1:MouseEvent) : void
      {
         if(battleModel.selfHero.avengerWaitSec > 0)
         {
            return;
         }
         _waitView.visible = !_waitView.visible;
      }
      
      private function __skillClick(param1:BattleEvent) : void
      {
         var _loc3_:SkillTempInfo = param1.data as SkillTempInfo;
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:Array = battleModel.selfHero.avengerFightSkills;
         if(_loc2_.indexOf(_loc3_.TemplateId) == -1)
         {
            return;
         }
         NotificationManager.instance.sendNotification("ACTION_SKILL_BattleNotic",param1.data);
      }
      
      private function __waitSkillClick(param1:BattleEvent) : void
      {
         var _loc2_:SkillTempInfo = param1.data as SkillTempInfo;
         if(!_loc2_)
         {
            return;
         }
         if(battleModel.selfHero.avengerWaitSec > 0)
         {
            return;
         }
         var _loc3_:Array = battleModel.selfHero.getWaitSkillIds();
         if(_loc3_.indexOf(_loc2_.TemplateId) == -1)
         {
            return;
         }
         NotificationManager.instance.sendNotification("AVENGER_SKILL_REPLACE",param1.data);
      }
      
      public function updateAvengerSp(param1:int) : void
      {
         if(_avengerSp == param1)
         {
            return;
         }
         _avengerSp = param1;
         var _loc3_:Number = 182 * _avengerSp / battleModel.selfHero.avengerSpMax;
         _avengerImage.mask = getMask(_loc3_);
         var _loc2_:int = _avengerSp / 10;
         NumberViewUtils.refreshValue(_loc2_,_avengerSpCon,_numBit,12,18,10,13,"0123456789");
         refreshSkillStateByAvengerSp();
      }
      
      public function updateAvengerSkills() : void
      {
         var _loc3_:int = 0;
         var _loc2_:BattleSkillItemII = null;
         var _loc1_:Array = getFightSkillAry();
         var _loc4_:Array = getWaitSkillAry();
         _loc3_ = 0;
         while(_loc3_ < fightSkillList.length)
         {
            _loc2_ = fightSkillList[_loc3_];
            _loc2_.data = _loc1_[_loc3_];
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < waitSkillList.length)
         {
            _loc2_ = waitSkillList[_loc3_];
            _loc2_.data = _loc4_[_loc3_];
            _loc3_++;
         }
         __updateLeftTimeHandler(null);
      }
      
      private function getFightSkillAry() : Array
      {
         var _loc3_:SkillTempInfo = null;
         var _loc1_:Array = [];
         for each(var _loc2_:int in battleModel.selfHero.avengerFightSkills)
         {
            _loc3_ = TempleteManager.instance.skillTemplateDic[_loc2_];
            _loc1_.push(_loc3_);
         }
         _loc1_.sortOn("MasterType",16);
         return _loc1_;
      }
      
      private function getWaitSkillAry() : Array
      {
         var _loc3_:SkillTempInfo = null;
         var _loc1_:Array = [];
         for each(var _loc2_:int in battleModel.selfHero.avengerAllSkills)
         {
            if(battleModel.selfHero.avengerFightSkills.indexOf(_loc2_) == -1)
            {
               _loc3_ = TempleteManager.instance.skillTemplateDic[_loc2_];
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn(["MasterType","Index"],[16,16]);
         return _loc1_;
      }
      
      public function get fightList() : Vector.<BattleSkillItemII>
      {
         return fightSkillList;
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_skillBack);
         _skillBack = null;
         ObjectUtils.disposeObject(_avengerImage);
         _avengerImage = null;
         ObjectUtils.disposeObject(_splitLine);
         _splitLine = null;
         ObjectUtils.disposeObject(_waitBg);
         _waitBg = null;
         ObjectUtils.disposeObject(_majorText);
         _majorText = null;
         ObjectUtils.disposeObject(_minorText);
         _minorText = null;
         ObjectUtils.disposeObject(_fightSkillHbox);
         _fightSkillHbox = null;
         ObjectUtils.disposeObject(_waitSkillCon);
         _waitSkillCon = null;
         ObjectUtils.disposeObject(_numBit);
         _numBit = null;
         ObjectUtils.disposeObject(_avengerSpCon);
         _avengerSpCon = null;
         ObjectUtils.disposeObject(_openBtn);
         _openBtn = null;
         ObjectUtils.disposeObject(_closeImage);
         _closeImage = null;
         ObjectUtils.disposeObject(_leftTimeText);
         _leftTimeText = null;
         ObjectUtils.disposeObject(_waitView);
         _waitView = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeObject(_btnKeyImage);
         _btnKeyImage = null;
         ObjectUtils.disposeObject(_btnKeyText);
         _btnKeyText = null;
         LogicUtils.disposeDisplayCollection(fightSkillList);
         fightSkillList = null;
         LogicUtils.disposeDisplayCollection(waitSkillList);
         waitSkillList = null;
         controller.dispose();
         super.dispose();
      }
   }
}

