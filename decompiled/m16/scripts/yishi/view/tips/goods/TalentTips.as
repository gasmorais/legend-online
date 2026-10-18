package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.BaseTip;
   
   public class TalentTips extends BaseTip
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
      
      public function TalentTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 310;
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
         _describe2.width = 250;
         _describe1.width = 250;
         _need = ComponentFactory.Instance.creatComponentByStylename("tips.SkillNeedTxt");
         addChild(_method);
         addChild(_totalBox);
         _bg.height = _totalBox.x + _totalBox.height + 10;
      }
      
      override protected function updateTransform() : void
      {
         var _loc4_:Array = null;
         var _loc1_:* = null;
         var _loc2_:String = null;
         var _loc7_:SkillInfo = null;
         var _loc3_:SkillTempInfo = null;
         var _loc6_:int = 0;
         var _loc5_:SkillTempInfo = null;
         if(tipData is SkillInfo)
         {
            clean();
            _loc7_ = tipData as SkillInfo;
            _loc3_ = _loc7_.nextTemplateInfo;
            _method.text = getSkillType(_loc7_.templateInfo);
            if(_loc7_.grade == 0)
            {
               _title2.htmlText = _loc3_.TemplateName;
               _vBox2.addChild(_title2);
               if(_loc3_.CoolDown > 0)
               {
                  _cooldown2.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc3_.CoolDown * 0.001);
                  _vBox2.addChild(_cooldown2);
               }
               if(int(_loc3_.Cost) < 0)
               {
                  _loc6_ = Math.abs(int(_loc3_.Cost));
                  _cost2.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown02",_loc6_);
                  _vBox2.addChild(_cost2);
               }
               _describe2.text = _loc3_.Description;
               _describe2.height = _describe2.textHeight + 10;
               _vBox2.addChild(_describe2);
               _loc4_ = _loc7_.checkTalentUpgradeCondition(_loc3_);
               if(_loc4_.length > 0)
               {
                  _need.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.need");
                  _vBox2.addChild(_need);
               }
               for each(_loc1_ in _loc4_)
               {
                  _condition1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillConditionTxt");
                  _condition1.text = _loc1_;
                  _vBox2.addChild(_condition1);
               }
               _totalBox.addChild(_vBox2);
            }
            else if(_loc3_)
            {
               _loc2_ = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc7_.templateInfo.Grades);
               if(_loc7_.templateInfo.Grades > 0)
               {
                  _title1.htmlText = _loc7_.templateInfo.TemplateName + " <font color=\'#ffffff\'>" + _loc2_ + "</font>";
               }
               else
               {
                  _title1.htmlText = _loc7_.templateInfo.TemplateName;
               }
               _vBox1.addChild(_title1);
               if(_loc7_.templateInfo.CoolDown > 0)
               {
                  _cooldown1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc7_.templateInfo.CoolDown * 0.001);
                  _vBox1.addChild(_cooldown1);
               }
               if(int(_loc7_.templateInfo.Cost) < 0)
               {
                  _loc6_ = Math.abs(int(_loc7_.templateInfo.Cost));
                  _cost1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown02",_loc6_);
                  _vBox1.addChild(_cost1);
               }
               _describe1.text = _loc7_.templateInfo.Description;
               _describe1.height = _describe1.textHeight + 10;
               _vBox1.addChild(_describe1);
               _totalBox.addChild(_vBox1);
               _nextGrade.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.nextGrade");
               _totalBox.addChild(_spliceLine);
               _totalBox.addChild(_nextGrade);
               _loc2_ = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc3_.Grades);
               _title2.htmlText = _loc3_.TemplateName + " <font color=\'#ffffff\'>" + _loc2_ + "</font>";
               _vBox2.addChild(_title2);
               if(_loc3_.CoolDown > 0)
               {
                  _cooldown2.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc3_.CoolDown * 0.001);
                  _vBox2.addChild(_cooldown2);
               }
               if(int(_loc3_.Cost) < 0)
               {
                  _cost2.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown02",Math.abs(int(_loc3_.Cost)));
                  _vBox2.addChild(_cost2);
               }
               _describe2.text = _loc3_.Description;
               _describe2.height = _describe2.textHeight + 10;
               _vBox2.addChild(_describe2);
               _loc4_ = _loc7_.checkTalentUpgradeCondition(_loc3_);
               if(_loc4_.length > 0)
               {
                  _need.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.need");
                  _vBox2.addChild(_need);
               }
               for each(_loc1_ in _loc4_)
               {
                  _condition1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillConditionTxt");
                  _condition1.text = _loc1_;
                  _vBox2.addChild(_condition1);
               }
               _totalBox.addChild(_vBox2);
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc7_.templateInfo.Grades);
               if(_loc7_.templateInfo.Grades > 0)
               {
                  _title1.htmlText = _loc7_.templateInfo.TemplateName + " <font color=\'#ffffff\'>" + _loc2_ + "</font>";
               }
               else
               {
                  _title1.htmlText = _loc7_.templateInfo.TemplateName;
               }
               _vBox1.addChild(_title1);
               if(_loc7_.templateInfo.CoolDown > 0)
               {
                  _cooldown1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc7_.templateInfo.CoolDown * 0.001);
                  _vBox1.addChild(_cooldown1);
               }
               if(int(_loc7_.templateInfo.Cost) < 0)
               {
                  _cost1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown02",Math.abs(int(_loc7_.templateInfo.Cost)));
                  _vBox1.addChild(_cost1);
               }
               _describe1.text = _loc7_.templateInfo.Description;
               _describe1.height = _describe1.textHeight + 10;
               _vBox1.addChild(_describe1);
               _totalBox.addChild(_vBox1);
               _nextGrade.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.maxGrade");
               _totalBox.addChild(_nextGrade);
            }
            _bg.height = _totalBox.x + _totalBox.height + 10;
            _bg.width = 310;
         }
         else if(tipData is SkillTempInfo)
         {
            clean();
            _loc5_ = tipData as SkillTempInfo;
            _loc2_ = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_loc5_.Grades);
            if(_loc5_.Grades > 0)
            {
               _title1.htmlText = _loc5_.TemplateName + " <font color=\'#ffffff\'>" + _loc2_ + "</font>";
            }
            else
            {
               _title1.htmlText = _loc5_.TemplateName;
            }
            _method.text = getSkillType(_loc5_);
            _vBox1.addChild(_title1);
            if(_loc5_.CoolDown > 0)
            {
               _cooldown1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc5_.CoolDown * 0.001);
               _vBox1.addChild(_cooldown1);
            }
            if(int(_loc5_.Cost) < 0)
            {
               _cost1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown02",Math.abs(int(_loc5_.Cost)));
               _vBox1.addChild(_cost1);
            }
            _describe1.text = _loc5_.Description;
            _describe1.height = _describe1.textHeight + 8;
            _vBox1.addChild(_describe1);
            _totalBox.addChild(_vBox1);
            _bg.height = _totalBox.x + _totalBox.height + 10;
            _bg.width = 310;
         }
      }
      
      private function checkCondition(param1:SkillTempInfo) : void
      {
         var _loc3_:SkillTempInfo = null;
         var _loc2_:Array = thane.skillCate.skillScript.split(",");
         for each(var _loc4_:int in _loc2_)
         {
            _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(_loc4_);
            if(_loc3_ && param1.SonType == _loc3_.SonType && param1.Grades <= _loc3_.Grades)
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
      
      private function getSkillType(param1:SkillTempInfo) : String
      {
         if(param1.UseWay == 2)
         {
            return "";
         }
         switch(int(param1.AcceptObject) - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type01");
            case 1:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type02");
            case 2:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type03");
            case 3:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type04");
            case 4:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type05");
            case 5:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type06");
            case 6:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type07");
            case 7:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type08");
            case 8:
               return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.Type09");
            case 9:
               return LanguageMgr.GetTranslation("SkillTips.Type10");
            case 10:
               return LanguageMgr.GetTranslation("SkillTips.Type11");
            case 11:
               return LanguageMgr.GetTranslation("SkillTips.Type12");
            case 12:
               return LanguageMgr.GetTranslation("SkillTips.Type13");
            case 13:
               return LanguageMgr.GetTranslation("SkillTips.Type14");
            case 14:
               return LanguageMgr.GetTranslation("SkillTips.Type15");
            case 15:
               return LanguageMgr.GetTranslation("SkillTips.Type16");
            case 16:
               return LanguageMgr.GetTranslation("SkillTips.Type17");
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
      
      override public function dispose() : void
      {
         if(_totalBox)
         {
            _totalBox.dispose();
         }
         _totalBox = null;
         if(_method)
         {
            _method.dispose();
         }
         _method = null;
         if(_vBox1)
         {
            _vBox1.dispose();
         }
         _vBox1 = null;
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
         if(_vBox2)
         {
            _vBox2.dispose();
         }
         _vBox2 = null;
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
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

