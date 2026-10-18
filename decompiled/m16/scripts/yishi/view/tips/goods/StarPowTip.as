package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import manager.LanguageMgr;
   import mvc.module.star.StarInfo;
   import mvc.module.star.StarTroughInfo;
   import yishi.manager.StarManager;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StarHelper;
   import yishi.utils.StringHelper;
   import yishi.view.tips.BaseTip;
   
   public class StarPowTip extends BaseTip
   {
      
      private var _title:FilterFrameText;
      
      private var _value:FilterFrameText;
      
      private var _totalVBox:VBox;
      
      public function StarPowTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 220;
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.StarPowTipTitleText");
         _value = ComponentFactory.Instance.creatComponentByStylename("tips.StarPowTipTitleText");
         _totalVBox = ComponentFactory.Instance.creatComponentByStylename("tips.StarsTotalBox");
         _title.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.title");
         _value.x = _title.x + _title.width + 10;
         _totalVBox.width = _bg.width;
         _totalVBox.y = _title.y + _title.height + 5;
         addChild(_title);
         addChild(_value);
         addChild(_totalVBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:SimpleDictionary = null;
         var _loc8_:* = undefined;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:StarTroughInfo = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         clean();
         if(tipData)
         {
            _loc7_ = 0;
            if(tipData.hasOwnProperty("starList"))
            {
               _loc1_ = tipData["starList"] as SimpleDictionary;
               if(tipData.hasOwnProperty("troughList"))
               {
                  _loc8_ = tipData["troughList"] as Vector.<StarTroughInfo>;
                  _loc2_ = int(_loc8_.length);
                  _loc6_ = 0;
                  while(_loc6_ < _loc2_)
                  {
                     _loc5_ = _loc8_[_loc6_] as StarTroughInfo;
                     _loc7_ += _loc5_.grade;
                     _loc6_++;
                  }
               }
            }
            else
            {
               _loc1_ = tipData as SimpleDictionary;
            }
            if(_loc1_)
            {
               _value.text = StarHelper.getStarPowerByList(_loc1_ as SimpleDictionary,_loc7_ / 8).toString();
               for each(var _loc3_:Object in _loc1_)
               {
                  if(_loc3_ is StarInfo)
                  {
                     _loc4_ = 0;
                     if(_loc8_ && _loc3_.pos < 8)
                     {
                        _loc4_ = int(_loc8_[_loc3_.pos].grade);
                     }
                     creatStarItem(_loc3_ as StarInfo,_loc4_);
                  }
               }
            }
            else
            {
               _value.text = tipData.toString();
            }
         }
         _totalVBox.width + 40 > 220 ? (_bg.width = _totalVBox.width + 40) : (Number(_bg.width = 220));
         _bg.height = _totalVBox.y + _totalVBox.height + 10;
      }
      
      private function clean() : void
      {
         var _loc1_:DisplayObject = null;
         while(_totalVBox.numChildren > 0)
         {
            _loc1_ = _totalVBox.getChildAt(0);
            _totalVBox.removeChild(_loc1_);
            ObjectUtils.disposeObject(_loc1_);
         }
      }
      
      private function creatStarItem(param1:StarInfo, param2:int = 0) : void
      {
         var _loc6_:HBox = ComponentFactory.Instance.creatComponentByStylename("tips.StarsItemBox");
         var _loc3_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("tips.StarItemNameText");
         var _loc4_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("tips.StarItemNameText");
         var _loc5_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("tips.StarItemNameText");
         _loc3_.text = param1.template.TemplateName;
         _loc3_.setFrame(param1.template.Profile);
         _loc4_.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.starLevel",param1.grade);
         _loc4_.setFrame(param1.template.Profile);
         _loc5_.text = initAttribute(param1,param2);
         _loc6_.addChild(_loc3_);
         _loc6_.addChild(_loc4_);
         _loc6_.addChild(_loc5_);
         _totalVBox.addChild(_loc6_);
      }
      
      private function initAttribute(param1:StarInfo, param2:int = 0) : String
      {
         var _loc3_:String = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.Power");
         var _loc4_:int = int(param1.pos);
         if(param1.template.Power > 0)
         {
            _loc3_ += String(int(param1.template.Power * param1.grade + param1.template.Power * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + (int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.Agility");
         if(param1.template.Agility > 0)
         {
            _loc3_ += String(int(param1.template.Agility * param1.grade + param1.template.Agility * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + (int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.Intellect");
         if(param1.template.Intellect > 0)
         {
            _loc3_ += String(int(param1.template.Intellect * param1.grade + param1.template.Intellect * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + (int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.Physique");
         if(param1.template.Physique > 0)
         {
            _loc3_ += String(int(param1.template.Physique * param1.grade + param1.template.Physique * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + (int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.Captain");
         if(param1.template.Captain > 0)
         {
            _loc3_ += String(int(param1.template.Captain * param1.grade + param1.template.Captain * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + (int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.Attack");
         if(param1.template.Attack > 0)
         {
            _loc3_ += String(int(param1.template.Attack * param1.grade + param1.template.Attack * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + (int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.Defence");
         if(param1.template.Defence > 0)
         {
            _loc3_ += String(int(param1.template.Defence * param1.grade + param1.template.Defence * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + (param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01) + " ";
            }
            return _loc3_;
         }
         _loc3_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.MagicAttack");
         if(param1.template.MagicAttack > 0)
         {
            _loc3_ += String(int(param1.template.MagicAttack * param1.grade + param1.template.MagicAttack * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + (int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.MagicDefence");
         if(param1.template.MagicDefence > 0)
         {
            _loc3_ += String(int(param1.template.MagicDefence * param1.grade + param1.template.MagicDefence * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + (int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.ForceHit");
         if(param1.template.ForceHit > 0)
         {
            _loc3_ += String(int(param1.template.ForceHit * param1.grade + param1.template.ForceHit * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + (int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.Live");
         if(param1.template.Live > 0)
         {
            _loc3_ += String(int(param1.template.Live * param1.grade + param1.template.Live * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + (int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.Conat");
         if(param1.template.Conat > 0)
         {
            _loc3_ += String(int(param1.template.Conat * param1.grade + param1.template.Conat * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + (int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         _loc3_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.StarPowTip.Parry");
         if(param1.template.Parry > 0)
         {
            _loc3_ += String(int(param1.template.Parry * param1.grade + param1.template.Parry * param1.grade * param2 * 0.01));
            if(param1.template.Penetrate * param1.grade > 0)
            {
               _loc3_ += "," + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
               _loc3_ = _loc3_ + "+" + (int(param1.template.Penetrate * param1.grade + param1.template.Penetrate * param1.grade * param2 * 0.01)) + " ";
            }
            return _loc3_;
         }
         if(!StringHelper.isNullOrEmpty(param1.template.DefaultSkill))
         {
            return StarHelper.getStarBufferName(param1,param2);
         }
         return "";
      }
      
      private function get starManager() : StarManager
      {
         return StarManager.instance;
      }
      
      override public function dispose() : void
      {
         if(_title)
         {
            _title.dispose();
         }
         _title = null;
         if(_value)
         {
            _value.dispose();
         }
         _value = null;
         if(_totalVBox)
         {
            _totalVBox.dispose();
         }
         _totalVBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

