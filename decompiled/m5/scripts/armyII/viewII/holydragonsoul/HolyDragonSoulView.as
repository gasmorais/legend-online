package armyII.viewII.holydragonsoul
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class HolyDragonSoulView extends Sprite implements Disposeable
   {
      
      private static var LEVEL_NUMBER:int = 6;
      
      private static var ATTACK:int = 1000;
      
      private static var DEFENCE:int = 1000;
      
      private static var MAGICATTACK:int = 1000;
      
      private static var MAGICDEFENCE:int = 1000;
      
      private static var FORCEHIT:int = 1000;
      
      private static var PARRY:int = 1000;
      
      private static var LIVE:int = 5000;
      
      private static var PENETRATE:int = 1000;
      
      private var _bg:MutipleImage;
      
      private var _advaceBtn:IconButton;
      
      private var _levelTxt:FilterFrameText;
      
      private var _line1:Image;
      
      private var _line2:Image;
      
      private var _line3:Image;
      
      private var _line4:Image;
      
      private var _line5:Image;
      
      private var _star1:MovieImage;
      
      private var _star2:MovieImage;
      
      private var _star3:MovieImage;
      
      private var _star4:MovieImage;
      
      private var _star5:MovieImage;
      
      private var _star6:MovieImage;
      
      private var _strip1:StripView;
      
      private var _strip2:StripView;
      
      private var _strip3:StripView;
      
      private var _strip4:StripView;
      
      private var _strip5:StripView;
      
      private var _strip6:StripView;
      
      private var _costNumberTxt:FilterFrameText;
      
      private var _addPrecentTxt:FilterFrameText;
      
      private var _attackTxt:FilterFrameText;
      
      private var _defenceTxt:FilterFrameText;
      
      private var _magicAttackTxt:FilterFrameText;
      
      private var _magicDefenceTxt:FilterFrameText;
      
      private var _forceHitTxt:FilterFrameText;
      
      private var _parryTxt:FilterFrameText;
      
      private var _liveTxt:FilterFrameText;
      
      private var _penetrateTxt:FilterFrameText;
      
      private var _fallLinkSprite:Component;
      
      private var _fallLinkTxt:FilterFrameText;
      
      private var _iconImage:Image;
      
      private var _isSelf:Boolean;
      
      private var _thaneInfo:ThaneInfo;
      
      private var _itemList:Vector.<HolyDragonSoulLeadItem>;
      
      private var _linePosArray:Array = [{
         "x":102,
         "y":72
      },{
         "x":107,
         "y":142
      },{
         "x":177,
         "y":143
      },{
         "x":244,
         "y":73
      },{
         "x":180,
         "y":72
      }];
      
      private var _leadUpgradeTempArray:Array = [];
      
      private var _holyDragonSoulUpgradeArray:Array = [];
      
      public function HolyDragonSoulView(param1:Boolean = true, param2:ThaneInfo = null)
      {
         super();
         _isSelf = param1;
         _thaneInfo = param2;
         initLeadData();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.bg");
         _advaceBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.advaceBtn");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.levelTxt");
         _costNumberTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.costNumberTxt");
         _addPrecentTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.addPrecentTxt");
         _attackTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.attackTxt");
         _defenceTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.defenceTxt");
         _magicAttackTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.magicAttackTxt");
         _magicDefenceTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.magicDefenceTxt");
         _forceHitTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.forceHitTxt");
         _parryTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.parryTxt");
         _liveTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.liveTxt");
         _penetrateTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.penetrateTxt");
         _iconImage = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.iconImage");
         _fallLinkSprite = ComponentFactory.Instance.creatCustomObject("armyII.HolySoulView.fallItemsLinkTxt.Sprite");
         _fallLinkTxt = ComponentFactory.Instance.creatComponentByStylename("armyII.HolySoulView.fallLinkTxt");
         addChild(_bg);
         addChild(_advaceBtn);
         addChild(_levelTxt);
         addChild(_costNumberTxt);
         addChild(_addPrecentTxt);
         addChild(_attackTxt);
         addChild(_defenceTxt);
         addChild(_magicAttackTxt);
         addChild(_magicDefenceTxt);
         addChild(_forceHitTxt);
         addChild(_parryTxt);
         addChild(_liveTxt);
         addChild(_penetrateTxt);
         addChild(_iconImage);
         addChild(_fallLinkSprite);
         _fallLinkSprite.addChild(_fallLinkTxt);
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(PlayerModel.HOLY_DRAGONSOUL_COSTTEMPID);
         if(_loc2_)
         {
            _iconImage.tipData = _loc2_.TemplateName + ":" + _loc2_.Description;
         }
         if(_isSelf)
         {
            _fallLinkSprite.visible = true;
            _advaceBtn.enable = true;
         }
         else
         {
            _fallLinkSprite.visible = false;
            _advaceBtn.enable = false;
         }
         _addPrecentTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addPrecentTxt");
         _attackTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addAttackTxt");
         _defenceTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addDefenceTxt");
         _magicAttackTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addMagicAttackTxt");
         _magicDefenceTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addMagicDefenceTxt");
         _forceHitTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addForceHitTxt");
         _parryTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addParryTxt");
         _liveTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addLiveTxt");
         _penetrateTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addPenetrateTxt");
         var _loc1_:String = LanguageMgr.GetTranslation("AncientMiddleView.fallLink");
         _fallLinkTxt.htmlText = "<a href =\'event: \'><u><b>" + _loc1_ + " </b></u></a>";
         _fallLinkTxt.mouseEnabled = true;
         _fallLinkSprite.tipData = initEndTip();
         initImage();
         initStarAndStrip();
      }
      
      private function uninitView() : void
      {
         var _loc1_:int = 0;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_advaceBtn);
         _advaceBtn = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_costNumberTxt);
         _costNumberTxt = null;
         ObjectUtils.disposeObject(_addPrecentTxt);
         _addPrecentTxt = null;
         ObjectUtils.disposeObject(_attackTxt);
         _attackTxt = null;
         ObjectUtils.disposeObject(_defenceTxt);
         _defenceTxt = null;
         ObjectUtils.disposeObject(_magicAttackTxt);
         _magicAttackTxt = null;
         ObjectUtils.disposeObject(_magicDefenceTxt);
         _magicDefenceTxt = null;
         ObjectUtils.disposeObject(_forceHitTxt);
         _forceHitTxt = null;
         ObjectUtils.disposeObject(_parryTxt);
         _parryTxt = null;
         ObjectUtils.disposeObject(_liveTxt);
         _liveTxt = null;
         ObjectUtils.disposeObject(_penetrateTxt);
         _penetrateTxt = null;
         ObjectUtils.disposeObject(_fallLinkSprite);
         _fallLinkSprite = null;
         ObjectUtils.disposeObject(_fallLinkTxt);
         _fallLinkTxt = null;
         _loc1_ = 1;
         while(_loc1_ <= LEVEL_NUMBER)
         {
            ObjectUtils.disposeObject(this["_star" + _loc1_]);
            this["_star" + _loc1_] = null;
            ObjectUtils.disposeObject(this["_strip" + _loc1_]);
            this["_strip" + _loc1_] = null;
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            ObjectUtils.disposeObject(this["_line" + _loc1_]);
            this["_line" + _loc1_] = null;
            _loc1_++;
         }
      }
      
      private function initEvent() : void
      {
         playerInfo.addEventListener("DRAGON_SOUL_GRADE",__dragonSoulUpdateHandler);
         if(_advaceBtn)
         {
            _advaceBtn.addEventListener("click",__advanceBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         playerInfo.removeEventListener("DRAGON_SOUL_GRADE",__dragonSoulUpdateHandler);
         if(_advaceBtn)
         {
            _advaceBtn.removeEventListener("click",__advanceBtnHandler);
         }
      }
      
      private function initEndTip() : String
      {
         var _loc1_:String = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.endLookTitle") + "\n";
         _loc1_ += LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addAttackEndTxt") + "\n";
         _loc1_ += LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addDefenceEndTxt") + "\n";
         _loc1_ += LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addMagicAttackEndTxt") + "\n";
         _loc1_ += LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addMagicDefenceEndTxt") + "\n";
         _loc1_ += LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addLiveEndTxt") + "\n";
         _loc1_ += LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addForceHitEndTxt") + "\n";
         _loc1_ += LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addParryEndTxt") + "\n";
         return _loc1_ + (LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addPenetrateEndTxt") + "\n");
      }
      
      private function __advanceBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = int(GoodsManager.instance.getGoodsNumByTempId(PlayerModel.HOLY_DRAGONSOUL_COSTTEMPID));
         var _loc4_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(dragonSoulGrade + 1,dragonSoulType);
         if(_loc4_)
         {
            _loc2_ = int(_loc4_.Data);
            if(_loc3_ < _loc2_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.HolyDragonSoulView.Tips01"));
               return;
            }
            PlayerManager.instance.sendDragonSoulFeed(1);
            return;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.HolyDragonSoulView.Tips02"));
      }
      
      private function get nextUpgradeTemplateInfo() : UpgradeTemplateInfo
      {
         return TempleteManager.instance.getTemplateByLevelAndType(dragonSoulGrade + 1,dragonSoulType);
      }
      
      private function get currentUpgradeTemplateInfo() : UpgradeTemplateInfo
      {
         return TempleteManager.instance.getTemplateByLevelAndType(dragonSoulGrade,dragonSoulType);
      }
      
      private function __dragonSoulUpdateHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc6_:int = 0;
         var _loc3_:String = null;
         var _loc1_:HolyDragonSoulLeadItem = null;
         var _loc4_:int = 0;
         _loc6_ = 1;
         while(_loc6_ <= LEVEL_NUMBER)
         {
            this["_star" + _loc6_].visible = false;
            this["_strip" + _loc6_].visible = false;
            _loc6_++;
         }
         _loc6_ = 1;
         while(_loc6_ <= 5)
         {
            this["_line" + _loc6_].visible = false;
            _loc6_++;
         }
         var _loc5_:int = Math.ceil(dragonSoulGrade / LEVEL_NUMBER);
         _levelTxt.text = _loc5_.toString();
         var _loc2_:int = dragonSoulGrade % LEVEL_NUMBER;
         if(_loc2_ == 0 && _loc5_ != 0)
         {
            _loc2_ = LEVEL_NUMBER;
         }
         if(currentUpgradeTemplateInfo)
         {
            _loc3_ = currentUpgradeTemplateInfo.TemplateName;
            refreshAddTxt(_loc3_);
         }
         if(nextUpgradeTemplateInfo)
         {
            _costNumberTxt.text = nextUpgradeTemplateInfo.Data.toString();
         }
         else
         {
            _costNumberTxt.text = "0";
            _loc2_ = LEVEL_NUMBER;
         }
         _loc6_ = 1;
         while(_loc6_ <= LEVEL_NUMBER)
         {
            if(_loc5_ > 0)
            {
               _loc4_ = _loc6_ + (_loc5_ - 1) * LEVEL_NUMBER;
            }
            else
            {
               _loc4_ = _loc6_;
            }
            if(_loc6_ <= _loc2_)
            {
               this["_star" + _loc6_].visible = true;
               this["_strip" + _loc6_].visible = false;
               this["_star" + _loc6_].tipData = LanguageMgr.GetTranslation("armyII.viewII.dragonsoul.DragonSoulView.add") + getSkillTemplateName(_loc4_,dragonSoulType,_loc6_);
            }
            else if(_loc6_ == _loc2_ + 1)
            {
               this["_star" + _loc6_].visible = false;
               this["_strip" + _loc6_].visible = true;
               this["_strip" + _loc6_].tipData = LanguageMgr.GetTranslation("armyII.viewII.dragonsoul.DragonSoulView.Tips07",getSkillTemplateName(_loc4_,dragonSoulType,_loc6_));
            }
            else
            {
               this["_star" + _loc6_].visible = false;
               this["_strip" + _loc6_].visible = true;
               this["_strip" + _loc6_].tipData = LanguageMgr.GetTranslation("armyII.viewII.dragonsoul.DragonSoulView.Tips06");
            }
            _loc1_ = _itemList[_loc6_ - 1];
            if(_loc6_ <= _leadUpgradeTempArray.length)
            {
               _loc1_.data = _leadUpgradeTempArray[_loc6_ - 1] as UpgradeTemplateInfo;
            }
            else
            {
               _loc1_.data = null;
            }
            _loc6_++;
         }
         _loc6_ = 1;
         while(_loc6_ <= 5)
         {
            if(_loc6_ < _loc2_)
            {
               this["_line" + _loc6_].visible = true;
            }
            else
            {
               this["_line" + _loc6_].visible = false;
            }
            _loc6_++;
         }
      }
      
      private function refreshAddTxt(param1:String) : void
      {
         var _loc3_:Array = null;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         if(!StringHelper.isNullOrEmpty(param1))
         {
            _loc3_ = param1.split(",");
            if(_loc3_)
            {
               _loc2_ = int(_loc3_.length);
               _loc5_ = 0;
               while(_loc5_ < _loc2_)
               {
                  if(_loc5_ == 3)
                  {
                     _loc6_ = _loc3_[_loc5_] * 50;
                  }
                  else
                  {
                     _loc6_ = _loc3_[_loc5_] * 10;
                  }
                  if(_loc6_ != 0)
                  {
                     _loc4_ = "+<font color=\'#59cd41\'>" + _loc6_ + "</font>";
                     if(_loc5_ == 0)
                     {
                        _forceHitTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addForceHitTxt") + _loc4_;
                     }
                     else if(_loc5_ == 1)
                     {
                        _parryTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addParryTxt") + _loc4_;
                     }
                     else if(_loc5_ == 2)
                     {
                        _penetrateTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addPenetrateTxt") + _loc4_;
                     }
                     else if(_loc5_ == 3)
                     {
                        _liveTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addLiveTxt") + _loc4_;
                     }
                     else if(_loc5_ == 4)
                     {
                        _defenceTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addDefenceTxt") + _loc4_;
                        _magicDefenceTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addMagicDefenceTxt") + _loc4_;
                     }
                     else if(_loc5_ == 5)
                     {
                        _attackTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addAttackTxt") + _loc4_;
                        _magicAttackTxt.htmlText = LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.addMagicAttackTxt") + _loc4_;
                     }
                  }
                  _loc5_++;
               }
            }
         }
      }
      
      private function initImage() : void
      {
         var _loc3_:String = null;
         var _loc1_:String = null;
         var _loc2_:int = 0;
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            _loc3_ = "armyII.HolySoulView.Image" + _loc2_;
            _loc1_ = "_line" + _loc2_;
            this[_loc1_] = ComponentFactory.Instance.creatComponentByStylename(_loc3_);
            this[_loc1_].x = _linePosArray[_loc2_ - 1].x;
            this[_loc1_].y = _linePosArray[_loc2_ - 1].y;
            addChild(this[_loc1_]);
            _loc2_++;
         }
      }
      
      private function initLeadData() : void
      {
         var _loc1_:UpgradeTemplateInfo = null;
         var _loc3_:int = 0;
         _holyDragonSoulUpgradeArray = TempleteManager.instance.getTemplatesByType(153);
         var _loc2_:int = int(_holyDragonSoulUpgradeArray.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _holyDragonSoulUpgradeArray[_loc3_] as UpgradeTemplateInfo;
            if(_loc1_ && _loc1_.ActiveObject > 0)
            {
               _leadUpgradeTempArray.push(_loc1_);
            }
            _loc3_++;
         }
         _leadUpgradeTempArray.sortOn("Id",16);
      }
      
      private function initStarAndStrip() : void
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc5_:String = null;
         var _loc1_:HolyDragonSoulLeadItem = null;
         var _loc3_:int = 1;
         _itemList = new Vector.<HolyDragonSoulLeadItem>();
         _loc3_ = 1;
         while(_loc3_ <= LEVEL_NUMBER)
         {
            _loc4_ = "armyII.HolySoulView.Star" + _loc3_;
            _loc2_ = "_star" + _loc3_;
            _loc5_ = "_strip" + _loc3_;
            this[_loc2_] = ComponentFactory.Instance.creatComponentByStylename(_loc4_);
            this[_loc5_] = ComponentFactory.Instance.creatCustomObject("armyII.SoulView.StripView");
            this[_loc5_].x = this[_loc2_].x - 5;
            this[_loc5_].y = this[_loc2_].y + 5;
            this[_loc5_].setHitArea(-12,-12,28,28);
            this[_loc5_].tipData = LanguageMgr.GetTranslation("armyII.viewII.dragonsoul.DragonSoulView.Tips06");
            _loc1_ = new HolyDragonSoulLeadItem();
            _loc1_.index = _loc3_;
            _loc1_.x = _loc3_ % 2 == 0 ? 300 : 20;
            _loc1_.y = 30 + int((_loc3_ - 1) / 2) * 70;
            addChild(this[_loc2_]);
            addChild(this[_loc5_]);
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function getSkillTemplateName(param1:int, param2:int, param3:int) : String
      {
         var _loc6_:UpgradeTemplateInfo = null;
         var _loc7_:int = 0;
         var _loc4_:String = "";
         var _loc5_:String = "";
         _loc6_ = TempleteManager.instance.getTemplateByLevelAndType(param1,param2);
         if(_loc6_)
         {
            if(param3 == 4)
            {
               _loc7_ = 2500;
            }
            else
            {
               _loc7_ = 500;
            }
            if(param3 == 1)
            {
               _loc5_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10") + "+" + _loc7_ + "<br/>";
            }
            else if(param3 == 2)
            {
               _loc5_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19") + "+" + _loc7_ + "<br/>";
            }
            else if(param3 == 3)
            {
               _loc5_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25") + "+" + _loc7_ + "<br/>";
            }
            else if(param3 == 4)
            {
               _loc5_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11") + "+" + _loc7_ + "<br/>";
            }
            else if(param3 == 5)
            {
               _loc5_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip07") + "+" + _loc7_ + "<br/>";
               _loc5_ = _loc5_ + (LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip09") + "+" + _loc7_ + "<br/>");
            }
            else if(param3 == 6)
            {
               _loc5_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip06") + "+" + _loc7_ + "<br/>";
               _loc5_ = _loc5_ + (LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip08") + "+" + _loc7_ + "<br/>");
            }
         }
         return _loc5_;
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

