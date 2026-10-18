package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import mvc.module.star.StarInfo;
   import mvc.module.star.StarTroughInfo;
   import yishi.datas.templates.StarTemplate;
   import yishi.manager.StarManager;
   import yishi.utils.StarHelper;
   import yishi.view.tips.BaseTip;
   
   public class StarTip extends BaseTip
   {
      
      protected var _totalVBox:VBox;
      
      protected var _title:FilterFrameText;
      
      private var _gp:FilterFrameText;
      
      private var _price:FilterFrameText;
      
      private var _subVBox1:VBox;
      
      private var _power:GoodAttributeItem;
      
      private var _agility:GoodAttributeItem;
      
      private var _intellect:GoodAttributeItem;
      
      private var _physique:GoodAttributeItem;
      
      private var _captain:GoodAttributeItem;
      
      private var _attack:GoodAttributeItem;
      
      private var _defence:GoodAttributeItem;
      
      private var _magicAttack:GoodAttributeItem;
      
      private var _magicDefence:GoodAttributeItem;
      
      private var _forceHit:GoodAttributeItem;
      
      private var _parry:GoodAttributeItem;
      
      private var _live:GoodAttributeItem;
      
      private var _conat:GoodAttributeItem;
      
      private var _penetrate:GoodAttributeItem;
      
      private var _defaultSkill:FilterFrameText;
      
      public function StarTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 170;
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.StarNameText");
         _gp = ComponentFactory.Instance.creatComponentByStylename("tips.StarGpText");
         _price = ComponentFactory.Instance.creatComponentByStylename("tips.StarPriceText");
         _totalVBox = ComponentFactory.Instance.creatComponentByStylename("tips.StarsTotalBox");
         _totalVBox.width = _bg.width;
         _totalVBox.y = _title.y + _title.height + 15;
         addChild(_title);
         addChild(_totalVBox);
         _subVBox1 = ComponentFactory.Instance.creatComponentByStylename("tips.StarsSubBox");
         _power = new GoodAttributeItem();
         _agility = new GoodAttributeItem();
         _intellect = new GoodAttributeItem();
         _physique = new GoodAttributeItem();
         _captain = new GoodAttributeItem();
         _attack = new GoodAttributeItem();
         _defence = new GoodAttributeItem();
         _magicAttack = new GoodAttributeItem();
         _magicDefence = new GoodAttributeItem();
         _forceHit = new GoodAttributeItem();
         _parry = new GoodAttributeItem();
         _live = new GoodAttributeItem();
         _conat = new GoodAttributeItem();
         _penetrate = new GoodAttributeItem();
         _defaultSkill = ComponentFactory.Instance.creatComponentByStylename("tips.StarSkillText");
      }
      
      private function initAttribute(param1:StarInfo, param2:StarTemplate, param3:int = 0) : void
      {
         var _loc4_:String = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01");
         updateAttributeTxt(_power,_loc4_ + "+",param2.Power * param1.grade + int(param2.Power * param1.grade * param3 * 0.01));
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02");
         updateAttributeTxt(_agility,_loc4_ + "+",param2.Agility * param1.grade + int(param2.Agility * param1.grade * param3 * 0.01));
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03");
         updateAttributeTxt(_intellect,_loc4_ + "+",param2.Intellect * param1.grade + int(param2.Intellect * param1.grade * param3 * 0.01));
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04");
         updateAttributeTxt(_physique,_loc4_ + "+",param2.Physique * param1.grade + int(param2.Physique * param1.grade * param3 * 0.01));
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05");
         updateAttributeTxt(_captain,_loc4_ + "+",param2.Captain * param1.grade + int(param2.Captain * param1.grade * param3 * 0.01));
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
         updateAttributeTxt(_attack,_loc4_ + "+",param2.Attack * param1.grade + int(param2.Attack * param1.grade * param3 * 0.01));
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
         updateAttributeTxt(_defence,_loc4_ + "+",param2.Defence * param1.grade + int(param2.Defence * param1.grade * param3 * 0.01));
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
         updateAttributeTxt(_magicAttack,_loc4_ + "+",param2.MagicAttack * param1.grade + int(param2.MagicAttack * param1.grade * param3 * 0.01));
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
         updateAttributeTxt(_magicDefence,_loc4_ + "+",param2.MagicDefence * param1.grade + int(param2.MagicDefence * param1.grade * param3 * 0.01));
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10");
         updateAttributeTxt(_forceHit,_loc4_ + "+",param2.ForceHit * param1.grade + int(param2.ForceHit * param1.grade * param3 * 0.01));
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19");
         updateAttributeTxt(_parry,_loc4_ + "+",param2.Parry * param1.grade + int(param2.Parry * param1.grade * param3 * 0.01));
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
         updateAttributeTxt(_live,_loc4_ + "+",param2.Live * param1.grade + int(param2.Live * param1.grade * param3 * 0.01));
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip17");
         updateAttributeTxt(_conat,_loc4_ + "+",param2.Conat * param1.grade + int(param2.Conat * param1.grade * param3 * 0.01));
         _loc4_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
         updateAttributeTxt(_penetrate,_loc4_ + "+",param2.Penetrate * param1.grade + int(param2.Penetrate * param1.grade * param3 * 0.01));
         if(param2.DefaultSkill != null && param2.DefaultSkill != "")
         {
            _defaultSkill.text = StarHelper.getStarBufferName(param1,param3);
            _subVBox1.addChild(_defaultSkill);
            _bg.width = Math.max(_defaultSkill.width + 40,180);
         }
         else
         {
            _bg.width = 180;
         }
      }
      
      private function updateAttributeTxt(param1:GoodAttributeItem, param2:String, param3:Number) : void
      {
         if(param3 > 0)
         {
            param1.updateText(param2,param3);
            _subVBox1.addChild(param1);
         }
      }
      
      override protected function updateTransform() : void
      {
         var _loc8_:StarInfo = null;
         var _loc5_:StarTroughInfo = null;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:String = null;
         var _loc2_:MagicSpringSlotInfo = null;
         var _loc6_:int = 0;
         if(tipData)
         {
            clean();
            if(tipData.hasOwnProperty("starData"))
            {
               _loc8_ = tipData.starData as StarInfo;
            }
            else
            {
               _loc8_ = tipData as StarInfo;
            }
            if(tipData.hasOwnProperty("troughInfo"))
            {
               _loc5_ = tipData.troughInfo as StarTroughInfo;
            }
            else
            {
               _loc5_ = null;
            }
            _title.setFrame(_loc8_.template.Profile);
            _title.text = LanguageMgr.GetTranslation("public.level.name",_loc8_.template.TemplateName,String(_loc8_.grade));
            if(_loc8_.template.Profile >= 2)
            {
               _loc7_ = StarHelper.getStarMaxGradeByProfile(_loc8_.template.Profile);
               if(_loc8_.grade >= _loc7_)
               {
                  _gp.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarTip.gp01");
               }
               else
               {
                  _loc3_ = StarHelper.getStarExp(_loc8_.grade + 1,_loc8_.template.Profile);
                  if(_loc8_.template.Profile == 6)
                  {
                     _gp.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarTip.gp02",_loc8_.gp);
                  }
                  else
                  {
                     _gp.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarTip.gp02",toArialBold(String(_loc8_.gp) + " / " + String(_loc3_)));
                  }
               }
               _totalVBox.addChild(_gp);
            }
            if(_loc5_)
            {
               _loc4_ = starManager.getStarTroughInfoByPos(_loc5_.pos).grade;
               initAttribute(_loc8_,_loc8_.template,_loc4_);
            }
            else
            {
               initAttribute(_loc8_,_loc8_.template);
            }
            if(_subVBox1.numChildren > 0)
            {
               _totalVBox.addChild(_subVBox1);
            }
            if(_loc8_.bagType == 0)
            {
               _loc1_ = _loc8_.template.SellGold + "";
               _loc2_ = MagicSpringManager.instance.model.checkIsExistBuffer(5);
               if(_loc2_)
               {
                  _loc6_ = Math.floor(_loc2_.tempInfo.AddValue * _loc8_.template.SellGold / 100);
                  _loc1_ += LanguageMgr.GetTranslation("MagicSpringFrame.buffer.reduceText",_loc6_);
               }
               _price.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarTip.price",_loc1_);
               _totalVBox.addChild(_price);
            }
            _bg.height = _totalVBox.y + _totalVBox.height + 10;
            _bg.width = _totalVBox.width + 10 > _bg.width ? _totalVBox.width + 10 : _bg.width;
         }
      }
      
      private function toArialBold(param1:String) : String
      {
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
      
      override public function get width() : Number
      {
         if(_bg)
         {
            return _bg.width;
         }
         return 0;
      }
      
      private function clean() : void
      {
         if(_price && _price.parent)
         {
            _price.parent.removeChild(_price);
         }
         _subVBox1.removeAllChild();
         _totalVBox.removeAllChild();
      }
      
      private function get starManager() : StarManager
      {
         return StarManager.instance;
      }
      
      override public function dispose() : void
      {
         if(_totalVBox)
         {
            _totalVBox.dispose();
         }
         _totalVBox = null;
         if(_title)
         {
            _title.dispose();
         }
         _title = null;
         if(_gp)
         {
            _gp.dispose();
         }
         _gp = null;
         if(_price)
         {
            _price.dispose();
         }
         _price = null;
         if(_subVBox1)
         {
            _subVBox1.dispose();
         }
         _subVBox1 = null;
         if(_power)
         {
            _power.dispose();
         }
         _power = null;
         if(_agility)
         {
            _agility.dispose();
         }
         _agility = null;
         if(_intellect)
         {
            _intellect.dispose();
         }
         _intellect = null;
         if(_physique)
         {
            _physique.dispose();
         }
         _physique = null;
         if(_captain)
         {
            _captain.dispose();
         }
         _captain = null;
         if(_attack)
         {
            _attack.dispose();
         }
         _attack = null;
         if(_defence)
         {
            _defence.dispose();
         }
         _defence = null;
         if(_magicAttack)
         {
            _magicAttack.dispose();
         }
         _magicAttack = null;
         if(_magicDefence)
         {
            _magicDefence.dispose();
         }
         _magicDefence = null;
         if(_forceHit)
         {
            _forceHit.dispose();
         }
         _forceHit = null;
         if(_parry)
         {
            _parry.dispose();
         }
         _parry = null;
         if(_live)
         {
            _live.dispose();
         }
         _live = null;
         if(_conat)
         {
            _conat.dispose();
         }
         _conat = null;
         if(_defaultSkill)
         {
            _defaultSkill.dispose();
         }
         _defaultSkill = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

