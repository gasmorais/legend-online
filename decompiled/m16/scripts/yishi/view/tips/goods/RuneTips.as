package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   import mvc.module.armyII.RuneInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.BaseTip;
   import yishi.view.tips.rune.RuneStoneGroupContent;
   
   public class RuneTips extends BaseTip
   {
      
      private var _totalBox:VBox;
      
      private var _method:FilterFrameText;
      
      private var _vBox1:VBox;
      
      private var _title1:FilterFrameText;
      
      private var _cooldown1:FilterFrameText;
      
      private var _cost1:FilterFrameText;
      
      private var _describe1:FilterFrameText;
      
      private var _spliceLine:ScaleBitmapImage;
      
      private var _nextGrade:FilterFrameText;
      
      private var _vBox2:VBox;
      
      private var _title2:FilterFrameText;
      
      private var _cooldown2:FilterFrameText;
      
      private var _cost2:FilterFrameText;
      
      private var _describe2:FilterFrameText;
      
      private var _need:FilterFrameText;
      
      private var _condition1:FilterFrameText;
      
      private var _needGoods:FilterFrameText;
      
      private var _stoneContents:RuneStoneGroupContent;
      
      private const LOW_RUNESECRET_TEMPID:int = 3021001;
      
      public function RuneTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 360;
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.SkillTotalBox");
         _method = ComponentFactory.Instance.creatComponentByStylename("tips.SkillTypeText");
         _vBox1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillSubBox");
         _title1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillNameText");
         _cooldown1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _cost1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _describe1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillDescribe1");
         _spliceLine = ComponentFactory.Instance.creatComponentByStylename("tips.SkillSpliceLine");
         _nextGrade = ComponentFactory.Instance.creatComponentByStylename("tips.SkillNextGradeTxt");
         _vBox2 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillSubBox");
         _title2 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillNameText");
         _cooldown2 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _cost2 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _describe2 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillDescribe2");
         _need = ComponentFactory.Instance.creatComponentByStylename("tips.SkillNeedTxt");
         _needGoods = ComponentFactory.Instance.creatComponentByStylename("tips.RuneTipsNeedTxt");
         _stoneContents = new RuneStoneGroupContent();
         addChild(_totalBox);
         _bg.height = _totalBox.x + _totalBox.height + 10;
         _method.x = 185;
         _describe1.width = 320;
         _describe2.width = 320;
         _bg.width = _totalBox.width + 30 > _bg.width ? _totalBox.width + 30 : Number(_bg.width);
      }
      
      override protected function updateTransform() : void
      {
         var _loc8_:Array = null;
         var _loc6_:* = null;
         var _loc7_:String = null;
         var _loc13_:RuneInfo = null;
         var _loc11_:SkillTempInfo = null;
         var _loc1_:RuneTemplateInfo = null;
         var _loc10_:SkillTempInfo = null;
         var _loc12_:* = null;
         var _loc9_:Array = null;
         var _loc5_:String = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc2_:String = null;
         var _loc3_:RuneTemplateInfo = null;
         var _loc14_:SkillTempInfo = null;
         if(tipData is RuneInfo)
         {
            clean();
            _loc13_ = tipData as RuneInfo;
            _loc11_ = TempleteManager.instance.getSkillTemplateInfoById(_loc13_.templateInfo.SkillTemplateId);
            _loc1_ = _loc13_.nextTemplateInfo;
            if(_loc1_)
            {
               _loc10_ = TempleteManager.instance.getSkillTemplateInfoById(_loc1_.SkillTemplateId);
            }
            _method.text = getSkillType(_loc11_);
            _method.width = _method.textWidth + 10;
            if(_loc13_.grade == 0)
            {
               _title2.htmlText = _loc1_.TemplateName;
               _vBox2.addChild(_title2);
               _vBox2.addChild(_method);
               if(_loc10_.CoolDown > 0)
               {
                  _cooldown2.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc10_.CoolDown * 0.001);
                  _vBox2.addChild(_cooldown2);
               }
               if(_loc1_.UseCount > 0)
               {
                  _cost2.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.RuneTips.userCount",_loc1_.UseCount);
                  _vBox2.addChild(_cost2);
               }
               _describe2.text = _loc1_.Description;
               _describe2.height = _describe2.textHeight + 10;
               _vBox2.addChild(_describe2);
               _loc8_ = _loc13_.checkUpgradeCondition(_loc1_);
               if(_loc8_.length > 0)
               {
                  _need.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.need");
                  _vBox2.addChild(_need);
               }
               for each(_loc6_ in _loc8_)
               {
                  _condition1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillConditionTxt");
                  _condition1.text = _loc6_;
                  _vBox2.addChild(_condition1);
               }
               if(_loc13_.nextTemplateInfo.Level < 1)
               {
                  _loc9_ = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonType(302);
                  for each(_loc12_ in _loc9_)
                  {
                     if(_loc12_.Property1 == _loc13_.templateInfo.RuneType)
                     {
                        _loc5_ = _loc12_.TemplateName;
                        _needGoods.text = LanguageMgr.GetTranslation("mounts.MountTip.NeedGood",_loc5_);
                        _needGoods.height = _needGoods.textHeight + 10;
                        _vBox2.addChild(_needGoods);
                     }
                  }
               }
               else if(_loc13_.nextTemplateInfo.Level >= 1)
               {
                  _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(3021001);
                  _loc2_ = _loc4_.TemplateName;
                  _needGoods.text = LanguageMgr.GetTranslation("mounts.MountTip.NeedGood",_loc2_) + "x10";
                  _vBox2.addChild(_needGoods);
               }
               _totalBox.addChild(_vBox2);
            }
            else if(_loc1_)
            {
               _loc7_ = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc13_.templateInfo.RuneGrade);
               if(_loc13_.templateInfo.RuneGrade > 0)
               {
                  _title1.htmlText = _loc13_.templateInfo.TemplateName + " <font color=\'#ffffff\'>" + _loc7_ + "</font>";
               }
               else
               {
                  _title1.htmlText = _loc13_.templateInfo.TemplateName;
               }
               _vBox1.addChild(_title1);
               _vBox1.addChild(_method);
               if(_loc11_.CoolDown > 0)
               {
                  _cooldown1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc11_.CoolDown * 0.001);
                  _vBox1.addChild(_cooldown1);
               }
               if(_loc13_.templateInfo.UseCount > 0)
               {
                  _cost1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.RuneTips.userCount",_loc13_.templateInfo.UseCount);
                  _vBox1.addChild(_cost1);
               }
               _describe1.text = _loc13_.templateInfo.Description;
               _describe1.height = _describe1.textHeight + 10;
               _vBox1.addChild(_describe1);
               _totalBox.addChild(_vBox1);
               _nextGrade.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.nextGrade");
               _totalBox.addChild(_spliceLine);
               _totalBox.addChild(_nextGrade);
               _loc7_ = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc1_.RuneGrade);
               _title2.htmlText = _loc1_.TemplateName + " <font color=\'#ffffff\'>" + _loc7_ + "</font>";
               _vBox2.addChild(_title2);
               if(_loc10_.CoolDown > 0)
               {
                  _cooldown2.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc10_.CoolDown * 0.001);
                  _vBox2.addChild(_cooldown2);
               }
               if(_loc1_.UseCount > 0)
               {
                  _cost2.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.RuneTips.userCount",_loc1_.UseCount);
                  _vBox2.addChild(_cost2);
               }
               _describe2.text = _loc1_.Description;
               _describe2.height = _describe2.textHeight + 10;
               _vBox2.addChild(_describe2);
               _loc8_ = _loc13_.checkUpgradeCondition(_loc1_);
               if(_loc8_.length > 0)
               {
                  _need.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.need");
                  _vBox2.addChild(_need);
               }
               for each(_loc6_ in _loc8_)
               {
                  _condition1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillConditionTxt");
                  _condition1.text = _loc6_;
                  _vBox2.addChild(_condition1);
               }
               _totalBox.addChild(_vBox2);
            }
            else
            {
               _loc7_ = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc13_.templateInfo.RuneGrade);
               if(_loc13_.templateInfo.RuneGrade > 0)
               {
                  _title1.htmlText = _loc13_.templateInfo.TemplateName + " <font color=\'#ffffff\'>" + _loc7_ + "</font>";
               }
               else
               {
                  _title1.htmlText = _loc13_.templateInfo.TemplateName;
               }
               _vBox1.addChild(_title1);
               _vBox1.addChild(_method);
               if(_loc11_.CoolDown > 0)
               {
                  _cooldown1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc11_.CoolDown * 0.001);
                  _vBox1.addChild(_cooldown1);
               }
               if(_loc13_.templateInfo.UseCount > 0)
               {
                  _cost1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.RuneTips.userCount",_loc13_.templateInfo.UseCount);
                  _vBox1.addChild(_cost1);
               }
               _describe1.text = _loc13_.templateInfo.Description;
               _describe1.height = _describe1.textHeight + 10;
               _vBox1.addChild(_describe1);
               _totalBox.addChild(_vBox1);
               _nextGrade.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.maxGrade");
               _totalBox.addChild(_nextGrade);
            }
            if(_loc13_.runeHole != null)
            {
               _stoneContents.updateView(_loc13_);
               _totalBox.addChild(_stoneContents);
            }
            _bg.height = _totalBox.x + _totalBox.height + 10;
            _bg.width = _totalBox.width + 30 > _bg.width ? _totalBox.width + 30 : Number(_bg.width);
         }
         else if(tipData is RuneTemplateInfo)
         {
            clean();
            _loc3_ = tipData as RuneTemplateInfo;
            _loc14_ = TempleteManager.instance.getSkillTemplateInfoById(_loc3_.SkillTemplateId);
            _loc7_ = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc3_.RuneGrade);
            if(_loc3_.RuneGrade > 0)
            {
               _title1.htmlText = _loc3_.TemplateName + " <font color=\'#ffffff\'>" + _loc7_ + "</font>";
            }
            else
            {
               _title1.htmlText = _loc3_.TemplateName;
            }
            _method.text = getSkillType(_loc14_);
            _vBox1.addChild(_title1);
            _vBox1.addChild(_method);
            if(_loc14_.CoolDown > 0)
            {
               _cooldown1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc14_.CoolDown * 0.001);
               _vBox1.addChild(_cooldown1);
            }
            if(_loc3_.UseCount > 0)
            {
               _cost1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.RuneTips.userCount",_loc3_.UseCount);
               _vBox1.addChild(_cost1);
            }
            _describe1.text = _loc3_.Description;
            _describe1.height = _describe1.textHeight + 8;
            _vBox1.addChild(_describe1);
            _totalBox.addChild(_vBox1);
            _bg.height = _totalBox.x + _totalBox.height + 10;
            _bg.width = _totalBox.width + 30 > _bg.width ? _totalBox.width + 30 : Number(_bg.width);
         }
      }
      
      private function checkCondition(param1:RuneTemplateInfo) : void
      {
         var _loc3_:SkillTempInfo = null;
         var _loc4_:RuneTemplateInfo = null;
         var _loc6_:SkillTempInfo = null;
         var _loc2_:Array = thane.runeCate.runeScript.split(",");
         for each(var _loc5_:int in _loc2_)
         {
            _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(param1.SkillTemplateId);
            _loc4_ = TempleteManager.instance.getRuneTemplateByTid(_loc5_);
            _loc6_ = TempleteManager.instance.getSkillTemplateInfoById(_loc4_.SkillTemplateId);
            if(_loc4_ && param1.SonType == _loc4_.SonType && _loc3_.Grades <= _loc6_.Grades)
            {
               _condition1.setFrame(1);
               return;
            }
         }
         _condition1.setFrame(2);
      }
      
      private function clean() : void
      {
         _vBox1.removeAllChild();
         _vBox2.removeAllChild();
         _totalBox.removeAllChild();
      }
      
      override public function dispose() : void
      {
         if(_method)
         {
            _method.dispose();
         }
         _method = null;
         if(_title1)
         {
            _title1.dispose();
         }
         _title1 = null;
         if(_cooldown1)
         {
            _cooldown1.dispose();
         }
         _cooldown1 = null;
         if(_cost1)
         {
            _cost1.dispose();
         }
         _cost1 = null;
         if(_describe1)
         {
            _describe1.dispose();
         }
         _describe1 = null;
         if(_spliceLine)
         {
            _spliceLine.dispose();
         }
         _spliceLine = null;
         if(_nextGrade)
         {
            _nextGrade.dispose();
         }
         _nextGrade = null;
         if(_title2)
         {
            _title2.dispose();
         }
         _title2 = null;
         if(_cooldown2)
         {
            _cooldown2.dispose();
         }
         _cooldown2 = null;
         if(_cost2)
         {
            _cost2.dispose();
         }
         _cost2 = null;
         if(_describe2)
         {
            _describe2.dispose();
         }
         _describe2 = null;
         if(_need)
         {
            _need.dispose();
         }
         _need = null;
         if(_condition1)
         {
            _condition1.dispose();
         }
         _condition1 = null;
         if(_needGoods)
         {
            _needGoods.dispose();
         }
         _needGoods = null;
         if(_totalBox)
         {
            _totalBox.dispose();
         }
         _totalBox = null;
         if(_vBox1)
         {
            _vBox1.dispose();
         }
         _vBox1 = null;
         if(_vBox2)
         {
            _vBox2.dispose();
         }
         _vBox2 = null;
         if(_stoneContents)
         {
            _stoneContents.dispose();
         }
         _stoneContents = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function getSkillType(param1:SkillTempInfo) : String
      {
         if(param1.UseWay == 2)
         {
            return "";
         }
         switch(param1.AcceptObject)
         {
            case 1:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type01");
            case 2:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type02");
            case 3:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type03");
            case 4:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type04");
            case 5:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type05");
            case 6:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type06");
            case 7:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type07");
            case 8:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type08");
            case 9:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type09");
            case 10:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type10");
            case 11:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type11");
            case 12:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type12");
            case 13:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type13");
            case 14:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type14");
            case 15:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type15");
            case 16:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type16");
            case 17:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type17");
            case 18:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type18");
            case 19:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type19");
            case 20:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type20");
            case 21:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type21");
            default:
               return "";
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

