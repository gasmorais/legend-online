package armyII.viewII.dragonsoul
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonSoulView extends Sprite implements Disposeable
   {
      
      public const MAX_GRADE_1:int = 5;
      
      public const MAX_GRADE_2:int = 8;
      
      private var _bgTop1:Bitmap;
      
      private var _bgTop2:Bitmap;
      
      private var _bgTop3:Bitmap;
      
      private var _bgButtom:Bitmap;
      
      private var _expView:DragonSoulExpView;
      
      private var _blessBar:MovieImage;
      
      private var _blessTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _tipBtn:Image;
      
      private var _feedBtn:BaseButton;
      
      private var _quickFeedBtn:BaseButton;
      
      private var _helpbtn:BaseButton;
      
      private var _star101_1:MovieImage;
      
      private var _star101_2:MovieImage;
      
      private var _star101_3:MovieImage;
      
      private var _star101_4:MovieImage;
      
      private var _star101_5:MovieImage;
      
      private var _star102_1:MovieImage;
      
      private var _star102_2:MovieImage;
      
      private var _star102_3:MovieImage;
      
      private var _star102_4:MovieImage;
      
      private var _star102_5:MovieImage;
      
      private var _star102_6:MovieImage;
      
      private var _star102_7:MovieImage;
      
      private var _star102_8:MovieImage;
      
      private var _strip101_1:StripView;
      
      private var _strip101_2:StripView;
      
      private var _strip101_3:StripView;
      
      private var _strip101_4:StripView;
      
      private var _strip101_5:StripView;
      
      private var _strip102_1:StripView;
      
      private var _strip102_2:StripView;
      
      private var _strip102_3:StripView;
      
      private var _strip102_4:StripView;
      
      private var _strip102_5:StripView;
      
      private var _strip102_6:StripView;
      
      private var _strip102_7:StripView;
      
      private var _strip102_8:StripView;
      
      private var _thaneInfo:ThaneInfo;
      
      private var _isSelf:Boolean;
      
      private var maxUpLevel:int;
      
      private var _dragonSoulBtnInfoTipsView:MovieClip;
      
      private var _awakenBtn:BaseButton;
      
      public function DragonSoulView(param1:Boolean = true, param2:ThaneInfo = null)
      {
         super();
         _isSelf = param1;
         _thaneInfo = param2;
         initView();
         initEvent();
         setMaxUpLevel();
         refreshView(true);
      }
      
      private function initView() : void
      {
         _bgTop1 = ComponentFactory.Instance.creatBitmap("asset.dragonsoul.BackTopAsset1");
         _bgTop2 = ComponentFactory.Instance.creatBitmap("asset.dragonsoul.BackTopAsset2");
         _bgTop3 = ComponentFactory.Instance.creatBitmap("asset.dragonsoul.BackTopAsset3");
         _bgButtom = ComponentFactory.Instance.creatBitmap("asset.dragonsoul.BackButtomAsset");
         _blessBar = ComponentFactory.Instance.creatComponentByStylename("armyII.SoulView.BlessBar");
         _blessTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.SoulView.BlessBarTxt");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.SoulView.LevelTxt");
         _tipBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.SoulView.TipBtn");
         _feedBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.SoulView.FeedBtn");
         _quickFeedBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.SoulView.QuickFeedBtn");
         _helpbtn = ComponentFactory.Instance.creatComponentByStylename("armyII.SoulView.HelpBtn");
         _awakenBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.SoulView.awakenBtn");
         addChild(_bgTop1);
         addChild(_bgTop2);
         addChild(_bgTop3);
         addChild(_bgButtom);
         _expView = new DragonSoulExpView(this);
         _expView.setVisible(false);
         _expView.showBall(true);
         addChild(_blessBar);
         addChild(_blessTxt);
         addChild(_levelTxt);
         addChild(_tipBtn);
         addChild(_feedBtn);
         addChild(_quickFeedBtn);
         if(VersionSwitch.HOLY_DRAGON_SOUL)
         {
            addChild(_awakenBtn);
         }
         _awakenBtn.visible = false;
         initStarAndStrip(101,5);
         initStarAndStrip(102,8);
         _blessBar.setFrame(1);
         _helpbtn.tipData = LanguageMgr.GetTranslation("public.help");
         if(_isSelf)
         {
            _feedBtn.enable = true;
            _quickFeedBtn.enable = true;
            PlayerManager.instance.sendDragonSoulRequest();
         }
         else
         {
            _feedBtn.enable = false;
            _quickFeedBtn.enable = false;
         }
      }
      
      private function initStarAndStrip(param1:int, param2:int) : void
      {
         var _loc5_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc4_:int = 1;
         _loc4_ = 1;
         while(_loc4_ <= param2)
         {
            _loc5_ = "armyII.SoulView.Star" + param1 + "_" + _loc4_;
            _loc3_ = "_star" + param1 + "_" + _loc4_;
            _loc6_ = "_strip" + param1 + "_" + _loc4_;
            this[_loc3_] = ComponentFactory.Instance.creatComponentByStylename(_loc5_);
            this[_loc3_].tipData = getSkillTemplateName(_loc4_,param1);
            this[_loc6_] = ComponentFactory.Instance.creatCustomObject("armyII.SoulView.StripView");
            this[_loc6_].x = this[_loc3_].x;
            this[_loc6_].y = this[_loc3_].y;
            this[_loc6_].setHitArea(-12,-12,24,24);
            this[_loc6_].tipData = LanguageMgr.GetTranslation("armyII.viewII.dragonsoul.DragonSoulView.Tips06");
            addChild(this[_loc3_]);
            addChild(this[_loc6_]);
            _loc4_++;
         }
      }
      
      private function setMaxUpLevel() : void
      {
         var _loc1_:Array = TempleteManager.instance.getTemplatesByType(102);
         for each(var _loc2_:UpgradeTemplateInfo in _loc1_)
         {
            if(_loc2_.Grades > maxUpLevel)
            {
               maxUpLevel = _loc2_.Grades;
            }
         }
      }
      
      private function getSkillTemplateName(param1:int, param2:int) : String
      {
         var _loc5_:UpgradeTemplateInfo = null;
         var _loc4_:SkillTempInfo = null;
         var _loc3_:String = "";
         _loc5_ = TempleteManager.instance.getTemplateByLevelAndType(param1,param2);
         if(_loc5_)
         {
            _loc4_ = TempleteManager.instance.getSkillTemplateInfoById(_loc5_.ActiveObject);
            if(_loc4_)
            {
               _loc3_ = _loc4_.TemplateName;
            }
         }
         return _loc3_;
      }
      
      private function uninitView() : void
      {
         var _loc1_:int = 0;
         ObjectUtils.disposeObject(_dragonSoulBtnInfoTipsView);
         _dragonSoulBtnInfoTipsView = null;
         ObjectUtils.disposeObject(_bgTop1);
         _bgTop1 = null;
         ObjectUtils.disposeObject(_bgTop2);
         _bgTop2 = null;
         ObjectUtils.disposeObject(_bgTop3);
         _bgTop3 = null;
         ObjectUtils.disposeObject(_bgButtom);
         _bgButtom = null;
         ObjectUtils.disposeObject(_expView);
         _expView = null;
         ObjectUtils.disposeObject(_blessBar);
         _blessBar = null;
         ObjectUtils.disposeObject(_blessTxt);
         _blessTxt = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_tipBtn);
         _tipBtn = null;
         ObjectUtils.disposeObject(_feedBtn);
         _feedBtn = null;
         ObjectUtils.disposeObject(_quickFeedBtn);
         _quickFeedBtn = null;
         ObjectUtils.disposeObject(_helpbtn);
         _helpbtn = null;
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            ObjectUtils.disposeObject(this["_star101_" + _loc1_]);
            this["_star101_" + _loc1_] = null;
            ObjectUtils.disposeObject(this["_strip101_" + _loc1_]);
            this["_strip101_" + _loc1_] = null;
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= 8)
         {
            ObjectUtils.disposeObject(this["_star102_" + _loc1_]);
            this["_star102_" + _loc1_] = null;
            ObjectUtils.disposeObject(this["_strip102_" + _loc1_]);
            this["_strip102_" + _loc1_] = null;
            _loc1_++;
         }
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initEvent() : void
      {
         _helpbtn.addEventListener("click",__openHelpFrame);
         if(_isSelf)
         {
            _feedBtn.addEventListener("click",__feedBtnClickHandler);
            _quickFeedBtn.addEventListener("click",__quickFeedBtnClickHandler);
            _awakenBtn.addEventListener("click",__awakenBtnClickHandler);
            playerInfo.addEventListener("DRAGON_SOUL_TYPE",__dragonSoulUpdateHandler);
            playerInfo.addEventListener("DRAGON_SOUL_GRADE",__dragonSoulUpdateHandler);
            playerInfo.addEventListener("DRAGON_SOUL_GP",__dragonSoulUpdateHandler);
            NotificationManager.instance.addEventListener("INFO_TIPS_DATA_UPDATE",updateGoodsNum);
            updateGoodsNum();
         }
      }
      
      private function removeEvent() : void
      {
         _helpbtn.removeEventListener("click",__openHelpFrame);
         if(_isSelf)
         {
            _feedBtn.removeEventListener("click",__feedBtnClickHandler);
            _quickFeedBtn.removeEventListener("click",__quickFeedBtnClickHandler);
            _awakenBtn.removeEventListener("click",__awakenBtnClickHandler);
            playerInfo.removeEventListener("DRAGON_SOUL_TYPE",__dragonSoulUpdateHandler);
            playerInfo.removeEventListener("DRAGON_SOUL_GRADE",__dragonSoulUpdateHandler);
            playerInfo.removeEventListener("DRAGON_SOUL_GP",__dragonSoulUpdateHandler);
            NotificationManager.instance.removeEventListener("INFO_TIPS_DATA_UPDATE",updateGoodsNum);
         }
      }
      
      private function __feedBtnClickHandler(param1:MouseEvent) : void
      {
         if(checkBeforeFeed())
         {
            PlayerManager.instance.sendDragonSoulFeed(1);
         }
      }
      
      private function __quickFeedBtnClickHandler(param1:MouseEvent) : void
      {
         if(checkBeforeFeed())
         {
            PlayerManager.instance.sendDragonSoulFeed(2);
         }
      }
      
      private function __awakenBtnClickHandler(param1:MouseEvent) : void
      {
         PlayerManager.instance.sendHolyDragonSoulActive();
      }
      
      private function checkBeforeFeed() : Boolean
      {
         var _loc5_:String = null;
         var _loc3_:* = null;
         var _loc4_:int = int(GoodsManager.instance.getGoodsNumBySonType(319));
         var _loc1_:int = getCurrentGp();
         var _loc2_:int = getMaxGp();
         if(dragonSoulType == 102 && dragonSoulGrade == getMaxGrade() && _loc1_ + 1 >= _loc2_)
         {
            _loc5_ = LanguageMgr.GetTranslation("armyII.viewII.dragonsoul.DragonSoulView.Tips09");
            MessageTipManager.instance().show(_loc5_);
            return false;
         }
         if(_loc4_ <= 0)
         {
            _loc5_ = LanguageMgr.GetTranslation("armyII.viewII.dragonsoul.DragonSoulView.Tips01");
            MessageTipManager.instance().show(_loc5_);
            return false;
         }
         return true;
      }
      
      private function getTotleGp(param1:int) : int
      {
         var _loc4_:UpgradeTemplateInfo = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 1;
         while(_loc3_ <= param1)
         {
            _loc4_ = TempleteManager.instance.getTemplateByLevelAndType(_loc3_,dragonSoulType);
            if(_loc4_)
            {
               _loc2_ += _loc4_.Data;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function getCurrentGp() : int
      {
         var _loc1_:int = dragonSoulGrade;
         var _loc2_:int = getTotleGp(_loc1_);
         return int(_loc2_ + dragonSoulGp);
      }
      
      private function getMaxGp() : int
      {
         var _loc1_:int = getMaxGrade();
         var _loc2_:int = getTotleGp(_loc1_);
         var _loc3_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc1_ + 1,dragonSoulType);
         if(_loc3_)
         {
            _loc2_ += _loc3_.Data;
         }
         return _loc2_;
      }
      
      private function getMaxGrade() : int
      {
         if(dragonSoulType == 101)
         {
            if(thane.grades >= 40 && thane.grades < 50)
            {
               return 1;
            }
            if(thane.grades >= 50 && thane.grades < 60)
            {
               return 2;
            }
            if(thane.grades >= 60 && thane.grades < 70)
            {
               return 3;
            }
            if(thane.grades >= 70 && thane.grades < 80)
            {
               return 4;
            }
            if(thane.grades >= 80)
            {
               return 5;
            }
         }
         else if(dragonSoulType == 102)
         {
            return maxUpLevel;
         }
         return 0;
      }
      
      private function __openHelpFrame(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("armyII.SoulView.HelpFrame");
         _loc2_.show();
      }
      
      private function __dragonSoulUpdateHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function get dragonSoulGrade() : int
      {
         if(_isSelf)
         {
            return playerInfo.dragonSoulGrade;
         }
         return _thaneInfo.dragonSoulGrade;
      }
      
      private function get dragonSoulType() : int
      {
         if(_isSelf)
         {
            return playerInfo.dragonSoulType;
         }
         return _thaneInfo.dragonSoulType;
      }
      
      private function get dragonSoulGp() : int
      {
         if(_isSelf)
         {
            return playerInfo.dragonSoulGp;
         }
         return _thaneInfo.dragonSoulGp;
      }
      
      private function refreshView(param1:Boolean = false) : void
      {
         var _loc7_:int = 0;
         var _loc5_:String = null;
         var _loc9_:* = null;
         if(dragonSoulType == 153)
         {
            return;
         }
         var _loc2_:int = getCurrentGp();
         var _loc3_:int = getMaxGp();
         if(dragonSoulType == 102 && dragonSoulGrade == getMaxGrade() && _loc2_ + 1 >= _loc3_)
         {
            _awakenBtn.visible = true;
         }
         var _loc10_:int = 0;
         var _loc8_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(dragonSoulGrade,dragonSoulType);
         var _loc6_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(dragonSoulGrade + 1,dragonSoulType);
         var _loc4_:Array = [];
         _bgTop1.visible = false;
         _bgTop2.visible = false;
         _bgTop3.visible = false;
         _tipBtn.visible = false;
         _blessBar.visible = false;
         _loc7_ = 1;
         while(_loc7_ <= 5)
         {
            this["_star101_" + _loc7_].visible = false;
            this["_strip101_" + _loc7_].visible = false;
            _loc7_++;
         }
         _loc7_ = 1;
         while(_loc7_ <= 8)
         {
            this["_star102_" + _loc7_].visible = false;
            this["_strip102_" + _loc7_].visible = false;
            _loc7_++;
         }
         if(_loc8_)
         {
            _levelTxt.text = _loc8_.TemplateName;
         }
         if(_loc6_)
         {
            _loc5_ = dragonSoulGp + " / " + _loc6_.Data;
            _blessTxt.text = _loc5_;
            _expView.updateExp(dragonSoulGp,_loc6_.Data,param1);
            _loc10_ = Math.floor(dragonSoulGp * 100 / _loc6_.Data);
         }
         else
         {
            _expView.reset(param1);
            _loc10_ = 100;
         }
         if(dragonSoulType == 101)
         {
            if(dragonSoulGrade == 0)
            {
               _bgTop1.visible = true;
               _tipBtn.visible = false;
               _blessBar.visible = true;
               _blessTxt.visible = true;
               _levelTxt.visible = false;
               _expView.setVisible(false);
               _blessBar.setFrame(_loc10_);
               _expView.setTopBall(1);
            }
            else
            {
               _bgTop2.visible = true;
               _tipBtn.visible = true;
               _blessBar.visible = false;
               _blessTxt.visible = false;
               _levelTxt.visible = true;
               _expView.setVisible(true);
               _expView.setPosition(144,143);
               _expView.setTopBall(2);
               _loc7_ = 1;
               while(_loc7_ <= 5)
               {
                  if(_loc7_ <= dragonSoulGrade)
                  {
                     this["_star101_" + _loc7_].visible = true;
                     this["_strip101_" + _loc7_].visible = false;
                     _loc4_.push(getSkillPropertyTemp(_loc7_,dragonSoulType));
                  }
                  else if(_loc7_ == dragonSoulGrade + 1)
                  {
                     this["_star101_" + _loc7_].visible = false;
                     this["_strip101_" + _loc7_].visible = true;
                     this["_strip101_" + _loc7_].tipData = LanguageMgr.GetTranslation("armyII.viewII.dragonsoul.DragonSoulView.Tips07",getSkillTemplateName(_loc7_,dragonSoulType));
                  }
                  else
                  {
                     this["_star101_" + _loc7_].visible = false;
                     this["_strip101_" + _loc7_].visible = true;
                     this["_strip101_" + _loc7_].tipData = LanguageMgr.GetTranslation("armyII.viewII.dragonsoul.DragonSoulView.Tips06");
                  }
                  _loc7_++;
               }
            }
         }
         else if(dragonSoulType == 102)
         {
            _bgTop3.visible = true;
            _tipBtn.visible = true;
            _blessBar.visible = false;
            _blessTxt.visible = false;
            _levelTxt.visible = true;
            _expView.setVisible(true);
            _expView.setPosition(127.5,142);
            _expView.setTopBall(3);
            _loc7_ = 1;
            while(_loc7_ <= 5)
            {
               _loc4_.push(getSkillPropertyTemp(_loc7_,101));
               _loc7_++;
            }
            _loc7_ = 1;
            while(_loc7_ <= 8)
            {
               if(_loc7_ <= dragonSoulGrade)
               {
                  this["_star102_" + _loc7_].visible = true;
                  this["_strip102_" + _loc7_].visible = false;
                  _loc4_.push(getSkillPropertyTemp(_loc7_,dragonSoulType));
               }
               else if(_loc7_ == dragonSoulGrade + 1)
               {
                  this["_star102_" + _loc7_].visible = false;
                  this["_strip102_" + _loc7_].visible = true;
                  this["_strip102_" + _loc7_].tipData = LanguageMgr.GetTranslation("armyII.viewII.dragonsoul.DragonSoulView.Tips07",getSkillTemplateName(_loc7_,dragonSoulType));
               }
               else
               {
                  this["_star102_" + _loc7_].visible = false;
                  this["_strip102_" + _loc7_].visible = true;
                  this["_strip102_" + _loc7_].tipData = LanguageMgr.GetTranslation("armyII.viewII.dragonsoul.DragonSoulView.Tips06");
               }
               _loc7_++;
            }
         }
         _tipBtn.tipData = buildSkillPropertyTip(_loc4_);
      }
      
      private function updateGoodsNum(param1:Event = null) : void
      {
         var _loc2_:int = int(InfoTipsManager.instance.getValueByKey(11));
         if(_dragonSoulBtnInfoTipsView == null)
         {
            _dragonSoulBtnInfoTipsView = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
            _dragonSoulBtnInfoTipsView.x = 148;
            _dragonSoulBtnInfoTipsView.y = 363;
            addChild(_dragonSoulBtnInfoTipsView);
         }
         if(_loc2_ > 0)
         {
            _dragonSoulBtnInfoTipsView.visible = true;
            _dragonSoulBtnInfoTipsView.txt.text = _loc2_ > 99 ? "99+" : _loc2_.toString();
         }
         else
         {
            _dragonSoulBtnInfoTipsView.visible = false;
         }
      }
      
      private function getSkillPropertyTemp(param1:int, param2:int) : SkillPropertyTempInfo
      {
         var _loc4_:UpgradeTemplateInfo = null;
         var _loc5_:SkillTempInfo = null;
         var _loc3_:SkillPropertyTempInfo = null;
         _loc4_ = TempleteManager.instance.getTemplateByLevelAndType(param1,param2);
         if(_loc4_)
         {
            _loc5_ = TempleteManager.instance.getSkillTemplateInfoById(_loc4_.ActiveObject);
            if(_loc5_)
            {
               _loc3_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc5_.TemplateId);
            }
         }
         return _loc3_;
      }
      
      private function buildSkillPropertyTip(param1:Array) : String
      {
         var _loc4_:* = null;
         var _loc5_:String = "";
         var _loc2_:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0];
         var _loc3_:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0];
         for each(_loc4_ in param1)
         {
            if(_loc4_)
            {
               if(_loc4_.AddType)
               {
                  var _loc6_:int = 0;
                  var _loc7_:Number = _loc2_[_loc6_] + _loc4_.Power;
                  _loc2_[_loc6_] = _loc7_;
                  _loc2_[1] += _loc4_.Agility;
                  _loc2_[2] += _loc4_.Intellect;
                  _loc2_[3] += _loc4_.Captain;
                  _loc2_[4] += _loc4_.Physique;
                  _loc2_[5] += _loc4_.Attack;
                  _loc2_[6] += _loc4_.Defence;
                  _loc2_[7] += _loc4_.MagicAttack;
                  _loc2_[8] += _loc4_.MagicDefence;
                  _loc2_[9] += _loc4_.ForceHit;
                  _loc2_[10] += _loc4_.Parry;
                  _loc2_[11] += _loc4_.Live;
                  _loc2_[12] += _loc4_.Conat;
                  _loc2_[13] += _loc4_.Penetrate;
               }
               else
               {
                  _loc6_ = 0;
                  _loc7_ = _loc3_[_loc6_] + _loc4_.Power;
                  _loc3_[_loc6_] = _loc7_;
                  _loc3_[1] += _loc4_.Agility;
                  _loc3_[2] += _loc4_.Intellect;
                  _loc3_[3] += _loc4_.Captain;
                  _loc3_[4] += _loc4_.Physique;
                  _loc3_[5] += _loc4_.Attack;
                  _loc3_[6] += _loc4_.Defence;
                  _loc3_[7] += _loc4_.MagicAttack;
                  _loc3_[8] += _loc4_.MagicDefence;
                  _loc3_[9] += _loc4_.ForceHit;
                  _loc3_[10] += _loc4_.Parry;
                  _loc3_[11] += _loc4_.Live;
                  _loc3_[12] += _loc4_.Conat;
                  _loc3_[13] += _loc4_.Penetrate;
               }
            }
         }
         _loc5_ += getPropertyTip(_loc2_[0],"armyII.ThaneAttributeView.Tip01",true);
         _loc5_ = _loc5_ + getPropertyTip(_loc2_[1],"armyII.ThaneAttributeView.Tip02",true);
         _loc5_ = _loc5_ + getPropertyTip(_loc2_[2],"armyII.ThaneAttributeView.Tip03",true);
         _loc5_ = _loc5_ + getPropertyTip(_loc2_[3],"armyII.ThaneAttributeView.Tip05",true);
         _loc5_ = _loc5_ + getPropertyTip(_loc2_[4],"armyII.ThaneAttributeView.Tip04",true);
         _loc5_ = _loc5_ + getPropertyTip(_loc2_[5],"armyII.ThaneAttributeView.Tip06",true);
         _loc5_ = _loc5_ + getPropertyTip(_loc2_[6],"armyII.ThaneAttributeView.Tip07",true);
         _loc5_ = _loc5_ + getPropertyTip(_loc2_[7],"armyII.ThaneAttributeView.Tip08",true);
         _loc5_ = _loc5_ + getPropertyTip(_loc2_[8],"armyII.ThaneAttributeView.Tip09",true);
         _loc5_ = _loc5_ + getPropertyTip(_loc2_[9],"armyII.ThaneAttributeView.Tip10",true);
         _loc5_ = _loc5_ + getPropertyTip(_loc2_[10],"armyII.ThaneAttributeView.Tip19",true);
         _loc5_ = _loc5_ + getPropertyTip(_loc2_[11],"armyII.viewII.dragonsoul.DragonSoulView.Tips08",true);
         _loc5_ = _loc5_ + getPropertyTip(_loc2_[12],"armyII.ThaneAttributeView.Tip12",true);
         _loc5_ = _loc5_ + getPropertyTip(_loc2_[13],"armyII.ThaneAttributeView.Tip25",true);
         _loc5_ = _loc5_ + getPropertyTip(_loc3_[0],"armyII.ThaneAttributeView.Tip01",false);
         _loc5_ = _loc5_ + getPropertyTip(_loc3_[1],"armyII.ThaneAttributeView.Tip02",false);
         _loc5_ = _loc5_ + getPropertyTip(_loc3_[2],"armyII.ThaneAttributeView.Tip03",false);
         _loc5_ = _loc5_ + getPropertyTip(_loc3_[3],"armyII.ThaneAttributeView.Tip05",false);
         _loc5_ = _loc5_ + getPropertyTip(_loc3_[4],"armyII.ThaneAttributeView.Tip04",false);
         _loc5_ = _loc5_ + getPropertyTip(_loc3_[5],"armyII.ThaneAttributeView.Tip06",false);
         _loc5_ = _loc5_ + getPropertyTip(_loc3_[6],"armyII.ThaneAttributeView.Tip07",false);
         _loc5_ = _loc5_ + getPropertyTip(_loc3_[7],"armyII.ThaneAttributeView.Tip08",false);
         _loc5_ = _loc5_ + getPropertyTip(_loc3_[8],"armyII.ThaneAttributeView.Tip09",false);
         _loc5_ = _loc5_ + getPropertyTip(_loc3_[9],"armyII.ThaneAttributeView.Tip10",false);
         _loc5_ = _loc5_ + getPropertyTip(_loc3_[10],"armyII.ThaneAttributeView.Tip19",false);
         _loc5_ = _loc5_ + getPropertyTip(_loc3_[11],"armyII.viewII.dragonsoul.DragonSoulView.Tips08",false);
         _loc5_ = _loc5_ + getPropertyTip(_loc3_[12],"armyII.ThaneAttributeView.Tip12",false);
         _loc5_ = _loc5_ + getPropertyTip(_loc3_[13],"armyII.ThaneAttributeView.Tip25",false);
         return LanguageMgr.GetTranslation("armyII.viewII.dragonsoul.DragonSoulView.Tips04",_loc5_);
      }
      
      private function getPropertyTip(param1:int, param2:String, param3:Boolean) : String
      {
         var _loc4_:String = "";
         if(param1 > 0)
         {
            _loc4_ = LanguageMgr.GetTranslation(param2);
            if(param3)
            {
               _loc4_ += "+" + param1 + "<br/>";
            }
            else
            {
               _loc4_ += "+" + param1 + "%" + "<br/>";
            }
         }
         return _loc4_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

