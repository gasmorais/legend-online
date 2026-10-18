package yishi.view.tips.goods
{
   import battle.data.SkillData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.BaseTip;
   
   public class SkillTips extends BaseTip
   {
      
      private var _totalBox:VBox;
      
      private var _sp1:Sprite;
      
      private var _sp2:Sprite;
      
      private var _line01:Bitmap;
      
      private var _line02:Bitmap;
      
      private var _line03:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _method:FilterFrameText;
      
      private var _title1:FilterFrameText;
      
      private var _level1:FilterFrameText;
      
      private var _cooldown1:FilterFrameText;
      
      private var _costSp1:FilterFrameText;
      
      private var _costHitPoint1:FilterFrameText;
      
      private var _costAvengerSp:FilterFrameText;
      
      private var _describe1:FilterFrameText;
      
      private var _nextGrade:FilterFrameText;
      
      private var _title2:FilterFrameText;
      
      private var _level2:FilterFrameText;
      
      private var _cooldown2:FilterFrameText;
      
      private var _costSp2:FilterFrameText;
      
      private var _costHitPoint2:FilterFrameText;
      
      private var _describe2:FilterFrameText;
      
      private var _method2:FilterFrameText;
      
      private var _need:FilterFrameText;
      
      private var _condition1:FilterFrameText;
      
      private var _spliceLine:ScaleBitmapImage;
      
      private var _petSkillIcon:ScaleFrameImage;
      
      private var _conditionVbox:VBox;
      
      private var _petTypeList:Array;
      
      private var _petTypeNameList:Array;
      
      public function SkillTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 300;
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.SkillTotalBox");
         _icon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _method = ComponentFactory.Instance.creatComponentByStylename("tips.skillCostTxt");
         _title1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillNameText_2");
         _level1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _cooldown1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _costSp1 = ComponentFactory.Instance.creatComponentByStylename("tips.skillCostTxt");
         _costHitPoint1 = ComponentFactory.Instance.creatComponentByStylename("tips.skillCostTxt");
         _describe1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillDescribe1");
         _spliceLine = ComponentFactory.Instance.creatComponentByStylename("tips.SkillSpliceLine");
         _nextGrade = ComponentFactory.Instance.creatComponentByStylename("tips.SkillNextGradeTxt");
         _title2 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillNameText_2");
         _level2 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _method2 = ComponentFactory.Instance.creatComponentByStylename("tips.skillCostTxt");
         _cooldown2 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillCoolDownText");
         _costSp2 = ComponentFactory.Instance.creatComponentByStylename("tips.skillCostTxt");
         _costHitPoint2 = ComponentFactory.Instance.creatComponentByStylename("tips.skillCostTxt");
         _describe2 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillDescribe1");
         _need = ComponentFactory.Instance.creatComponentByStylename("tips.SkillNeedTxt");
         _line01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _line02 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _line03 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _petSkillIcon = ComponentFactory.Instance.creatComponentByStylename("petTip.PetTypeImage");
         _costAvengerSp = ComponentFactory.Instance.creatComponentByStylename("tips.skillCostTxt");
         _sp1 = new Sprite();
         _sp2 = new Sprite();
         _conditionVbox = new VBox();
         _petTypeList = [101,102,103,104,105,106,117,118,119,107];
         _petTypeNameList = LanguageMgr.GetTranslation("pet.petTypeList").split("|");
         _bg.width = 300;
         _petSkillIcon.x = 260;
         _petSkillIcon.y = 23;
         addChild(_totalBox);
         addChild(_icon);
      }
      
      override protected function updateTransform() : void
      {
         var _loc5_:SkillInfo = null;
         var _loc1_:SkillTempInfo = null;
         var _loc2_:SkillTempInfo = null;
         var _loc4_:int = 0;
         var _loc3_:Boolean = false;
         clean();
         if(tipData is SkillInfo)
         {
            _loc5_ = tipData as SkillInfo;
            if(_loc5_.templateInfo.MasterType != 4)
            {
               _loc1_ = _loc5_.nextTemplateInfo;
            }
            _method.text = getSkillType(_loc5_.templateInfo);
            _icon.x = 11;
            _icon.y = -11;
            _icon.icon = IconFactory.getTecIconByIcon(_loc5_.templateInfo.Icons);
            _loc4_ = int(_loc5_.templateInfo.MasterType);
            _loc3_ = _petTypeList.indexOf(_loc4_) >= 0;
            if(_loc3_ && _petTypeNameList[_petTypeList.indexOf(_loc4_)])
            {
               _petSkillIcon.setFrame(_petTypeList.indexOf(_loc4_) + 1);
               addChild(_petSkillIcon);
            }
            else if(_petSkillIcon.parent)
            {
               _petSkillIcon.parent.removeChild(_petSkillIcon);
            }
            if(_loc5_.grade == 0)
            {
               notLearn(_loc5_);
            }
            else if(_loc1_)
            {
               notFull(_loc5_);
            }
            else
            {
               fullSkill(_loc5_);
            }
         }
         else if(tipData is SkillTempInfo)
         {
            _loc2_ = tipData as SkillTempInfo;
            _icon.x = 11;
            _icon.y = -11;
            _icon.icon = IconFactory.getTecIconByIcon(_loc2_.Icons);
            _loc4_ = int(_loc2_.MasterType);
            _loc3_ = _petTypeList.indexOf(_loc4_) >= 0;
            if(_loc3_ && _petTypeNameList[_petTypeList.indexOf(_loc4_)])
            {
               _petSkillIcon.setFrame(_petTypeList.indexOf(_loc4_) + 1);
               addChild(_petSkillIcon);
            }
            else if(_petSkillIcon.parent)
            {
               _petSkillIcon.parent.removeChild(_petSkillIcon);
            }
            _level1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.levelTxt",_loc2_.Grades);
            _title1.htmlText = _loc2_.TemplateName;
            _method.text = getSkillType(_loc2_);
            _method.y = 41;
            _level1.y = 41;
            _sp1.addChild(_title1);
            if(_loc2_.Grades > 0 || isTalent(_loc2_))
            {
               _sp1.addChild(_level1);
            }
            _sp1.addChild(_method);
            if(_loc2_.CoolDown > 0)
            {
               _cooldown1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc2_.CoolDown * 0.001);
               _sp1.addChild(_cooldown1);
               _cooldown1.y = 73;
            }
            else if(_loc3_)
            {
               _cooldown1.text = "";
               _sp1.addChild(_cooldown1);
               _cooldown1.y = 73;
            }
            if(int(_loc2_.Cost) < 0)
            {
               _costSp1.text = getCostString(_loc3_,int(_loc2_.Cost));
               _sp1.addChild(_costSp1);
               _costSp1.y = 59;
            }
            if(int(_loc2_.HitPointCost) < 0)
            {
               _costHitPoint1.text = getCostString(_loc3_,int(_loc2_.HitPointCost),true);
               _sp1.addChild(_costHitPoint1);
               _costHitPoint1.y = 77;
            }
            if((_loc2_.MasterType == 500 || _loc2_.MasterType == 501) && int(_loc2_.Cost) > 0)
            {
               _costAvengerSp.text = getAvengerCostString(int(_loc2_.Cost / 10));
               _sp1.addChild(_costAvengerSp);
               _costAvengerSp.y = 77;
            }
            _sp1.addChild(_line01);
            _line01.y = 0;
            if(!_cooldown1.parent && !_costSp1.parent && !_costHitPoint1.parent)
            {
               _line01.y = _method.y + _method.textHeight + 20;
            }
            else if(_costHitPoint1.parent)
            {
               _line01.y = _costHitPoint1.y + _costHitPoint1.textHeight + 18;
            }
            else if(_costAvengerSp.parent)
            {
               _line01.y = _costAvengerSp.y + _costAvengerSp.textHeight + 11;
            }
            else if(_cooldown1.parent)
            {
               _line01.y = _cooldown1.y + _cooldown1.textHeight + 11;
            }
            else if(_costSp1.parent)
            {
               _line01.y = _costSp1.y + _costSp1.textHeight + 20;
            }
            _line01.y = _line01.y == 0 ? _level1.y + _level1.textHeight + 6 : _line01.y;
            _describe1.text = _loc2_.Description;
            _describe1.height = _describe1.textHeight + 8;
            _sp1.addChild(_describe1);
            _describe1.y = _line01.y + 11;
            _totalBox.addChild(_sp1);
            _bg.height = _totalBox.height + 20;
         }
      }
      
      private function fullSkill(param1:SkillInfo) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",param1.templateInfo.Grades);
         var _loc4_:int = int(param1.templateInfo.MasterType);
         var _loc3_:Boolean = _petTypeList.indexOf(_loc4_) >= 0;
         _title1.htmlText = param1.templateInfo.TemplateName;
         _sp1.addChild(_title1);
         _sp1.addChild(_method);
         _method.y = 41;
         if(param1.templateInfo.Grades > 0 && _loc4_ != 4)
         {
            _level1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.levelTxt",param1.templateInfo.Grades);
            _sp1.addChild(_level1);
            _level1.y = 41;
         }
         if(param1.templateInfo.CoolDown > 0)
         {
            _cooldown1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",param1.templateInfo.CoolDown * 0.001);
            _sp1.addChild(_cooldown1);
            _cooldown1.y = 73;
         }
         if(int(param1.templateInfo.Cost) < 0)
         {
            _costSp1.text = getCostString(_loc3_,int(param1.templateInfo.Cost));
            _sp1.addChild(_costSp1);
            _costSp1.y = 59;
         }
         if(int(param1.templateInfo.HitPointCost) < 0)
         {
            _costHitPoint1.text = getCostString(_loc3_,int(param1.templateInfo.HitPointCost),true);
            _sp1.addChild(_costHitPoint1);
            _costHitPoint1.y = 77;
         }
         _sp1.addChild(_line01);
         _line01.y = 0;
         if(!_cooldown1.parent && !_costSp1.parent && _costHitPoint1.parent)
         {
            _line01.y = _method.y + _method.textHeight + 20;
         }
         else if(_costHitPoint1.parent)
         {
            _line01.y = _costHitPoint1.y + _costHitPoint1.textHeight + 18;
         }
         else if(_cooldown1.parent)
         {
            _line01.y = _cooldown1.y + _cooldown1.textHeight + 20;
         }
         else if(_costSp1.parent)
         {
            _line01.y = _costSp1.y + _costSp1.textHeight + 20;
         }
         else
         {
            _line01.y = 72;
         }
         _line01.y = _line01.y == 0 ? _level1.y + _level1.textHeight + 6 : _line01.y;
         _describe1.text = param1.templateInfo.Description;
         _describe1.height = _describe1.textHeight + 10;
         _sp1.addChild(_describe1);
         _describe1.y = _line01.y + 11;
         _sp1.addChild(_line02);
         _line02.y = _describe1.y + _describe1.textHeight + 18;
         _nextGrade.text = LanguageMgr.GetTranslation("buildings.BaseBuildFrame.maxGrade");
         if(_loc4_ != 4)
         {
            _sp1.addChild(_nextGrade);
         }
         _nextGrade.y = _line02.y + 11;
         _totalBox.addChild(_sp1);
         _bg.height = _totalBox.height + 20;
      }
      
      private function notFull(param1:SkillInfo) : void
      {
         var _loc4_:Array = null;
         var _loc2_:* = null;
         var _loc6_:int = int(param1.templateInfo.MasterType);
         var _loc5_:Boolean = _petTypeList.indexOf(_loc6_) >= 0;
         var _loc3_:SkillTempInfo = param1.nextTemplateInfo;
         _title1.htmlText = param1.templateInfo.TemplateName;
         _sp1.addChild(_title1);
         _sp1.addChild(_method);
         _method.y = 41;
         if(param1.templateInfo.Grades > 0)
         {
            _level1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.levelTxt",param1.templateInfo.Grades);
            _sp1.addChild(_level1);
            _level1.y = 41;
         }
         if(param1.templateInfo.CoolDown > 0)
         {
            _cooldown1.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",param1.templateInfo.CoolDown * 0.001);
            _sp1.addChild(_cooldown1);
            _cooldown1.y = 73;
         }
         if(int(param1.templateInfo.Cost) < 0)
         {
            _costSp1.text = getCostString(_loc5_,int(param1.templateInfo.Cost));
            _sp1.addChild(_costSp1);
            _costSp1.y = 59;
         }
         if(int(param1.templateInfo.HitPointCost) < 0)
         {
            _costHitPoint1.text = getCostString(_loc5_,int(param1.templateInfo.HitPointCost),true);
            _sp1.addChild(_costHitPoint1);
            _costHitPoint1.y = 77;
         }
         _sp1.addChild(_line01);
         _line01.y = 0;
         if(!_costSp1.parent && !_cooldown1.parent && !_costHitPoint1.parent)
         {
            _line01.y = _method.y + _method.textHeight + 20;
         }
         else if(_costHitPoint1.parent)
         {
            _line01.y = _costHitPoint1.y + _costHitPoint1.textHeight + 18;
         }
         else if(_cooldown1.parent)
         {
            _line01.y = _cooldown1.y + _cooldown1.textHeight + 20;
         }
         else if(_costSp1.parent)
         {
            _line01.y = _costSp1.y + _costSp1.textHeight + 20;
         }
         _line01.y = _line01.y == 0 ? _level1.y + _level1.textHeight + 6 : _line01.y;
         _describe1.text = param1.templateInfo.Description;
         _describe1.height = _describe1.textHeight + 10;
         _sp1.addChild(_describe1);
         _describe1.y = _line01.y + 11;
         _totalBox.addChild(_sp1);
         _nextGrade.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.nextGrade");
         _totalBox.addChild(_spliceLine);
         _sp2.addChild(_nextGrade);
         _nextGrade.y = 6;
         _title2.htmlText = _loc3_.TemplateName;
         _level2.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.levelTxt",_loc3_.Grades);
         _sp2.addChild(_title2);
         _title2.numLines == 2 ? (_title2.y = -5) : (Number(_title2.y = 6));
         _method2.text = _method.text;
         _sp2.addChild(_method2);
         _method2.y = 29;
         _sp2.addChild(_level2);
         _level2.y = 29;
         if(_loc3_.CoolDown > 0)
         {
            _cooldown2.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc3_.CoolDown * 0.001);
            _sp2.addChild(_cooldown2);
            _cooldown2.y = 60;
         }
         if(int(_loc3_.Cost) < 0)
         {
            _costSp2.text = getCostString(_loc5_,int(_loc3_.Cost));
            _sp2.addChild(_costSp2);
            _costSp2.y = 47;
         }
         if(int(_loc3_.HitPointCost) < 0)
         {
            _costHitPoint2.text = getCostString(_loc5_,int(_loc3_.HitPointCost),true);
            _sp2.addChild(_costHitPoint2);
            _costHitPoint2.y = 65;
         }
         _sp2.addChild(_line02);
         if(!_costSp2.parent && !_cooldown2.parent && !_costHitPoint2.parent)
         {
            _line02.y = _method2.y + _method2.textHeight + 20;
         }
         else if(_costHitPoint2.parent)
         {
            _line02.y = _costHitPoint2.y + _costHitPoint2.textHeight + 18;
         }
         else if(_cooldown2.parent)
         {
            _line02.y = _cooldown2.y + _cooldown2.textHeight + 20;
         }
         else if(_costSp2.parent)
         {
            _line02.y = _costSp2.y + _costSp2.textHeight + 20;
         }
         _describe2.text = _loc3_.Description;
         _describe2.height = _describe2.textHeight + 10;
         _sp2.addChild(_describe2);
         _describe2.y = _line02.y + 11;
         _loc4_ = param1.checkUpgradeCondition(_loc3_);
         if(_loc4_.length > 0)
         {
            _sp2.addChild(_line03);
            _line03.y = _describe2.y + _describe2.height;
            _need.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.need");
            _sp2.addChild(_need);
            _need.y = _line03.y + 10;
            _sp2.addChild(_conditionVbox);
            _conditionVbox.y = _need.y + _need.textHeight + 3;
         }
         for each(_loc2_ in _loc4_)
         {
            _condition1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillConditionTxt");
            _condition1.text = _loc2_;
            _conditionVbox.addChild(_condition1);
         }
         _totalBox.addChild(_sp2);
         if(_conditionVbox.parent)
         {
            _bg.height = _totalBox.height + 26;
         }
         else
         {
            _bg.height = _totalBox.height + 20;
         }
      }
      
      private function notLearn(param1:SkillInfo) : void
      {
         var _loc4_:Array = null;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc7_:String = null;
         var _loc8_:int = int(param1.templateInfo.MasterType);
         var _loc6_:Boolean = _petTypeList.indexOf(_loc8_) >= 0;
         var _loc3_:SkillTempInfo = param1.nextTemplateInfo;
         _title1.htmlText = _loc3_.TemplateName;
         _sp2.addChild(_title1);
         _sp2.addChild(_method);
         _method.y = 41;
         if(_loc3_.CoolDown > 0)
         {
            _cooldown2.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc3_.CoolDown * 0.001);
            _sp2.addChild(_cooldown2);
            _cooldown2.y = 73;
         }
         else if(_loc6_)
         {
            _cooldown2.text = "";
            _sp2.addChild(_cooldown2);
         }
         if(int(_loc3_.Cost) < 0)
         {
            _costSp2.text = getCostString(_loc6_,int(_loc3_.Cost));
            _sp2.addChild(_costSp2);
            _costSp2.y = 59;
         }
         if(int(_loc3_.HitPointCost) < 0)
         {
            _line01.y = _method.y + _method.height + 20;
            _costHitPoint2.text = getCostString(_loc6_,int(_loc3_.HitPointCost),true);
            _sp2.addChild(_costHitPoint2);
            _costHitPoint2.y = 77;
         }
         if(!_costSp2.parent && !_cooldown2.parent && !_costHitPoint2.parent)
         {
            _line01.y = _method.y + _method.height + 18;
         }
         else if(_costHitPoint2.parent)
         {
            _line01.y = _costHitPoint2.y + _costHitPoint2.textHeight + 20;
         }
         else if(_costSp2.parent)
         {
            _line01.y = _costSp2.y + _costSp2.textHeight + 18;
         }
         else if(_cooldown2.parent)
         {
            _line01.y = _cooldown2.y + _cooldown2.textHeight + 20;
         }
         _sp2.addChild(_line01);
         _line01.x = 0;
         _describe2.text = _loc3_.Description;
         _describe2.height = _describe2.textHeight + 10;
         _describe2.y = _line01.y + 11;
         _sp2.addChild(_describe2);
         _need.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.need");
         if(param1.templateInfo.MasterType == 200)
         {
            _need.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.remoteneed");
            _loc5_ = int(TempleteManager.instance.remotePetTemplateCate.getTemplateBySkillId(param1.templateId).Index);
            _loc7_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.remoteValue",_loc5_);
            _loc4_ = [_loc7_];
         }
         else if(TempleteManager.instance.childPveBossTemplateCate && TempleteManager.instance.childPveBossTemplateCate.getAllSkillId().indexOf(param1.templateId) > -1 && SceneManager.instance.currentType != "BATTLE_SCENE")
         {
            _need.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.remoteneed");
            _loc5_ = int(TempleteManager.instance.childPveBossTemplateCate.getChildPveSkillUnlockGrade(param1.templateId));
            _loc7_ = LanguageMgr.GetTranslation("childpve.skilltip.unlock",_loc5_);
            _loc4_ = [_loc7_];
         }
         else
         {
            _loc4_ = param1.checkUpgradeCondition(_loc3_);
         }
         if(_loc4_.length > 0 && _loc8_ != 4)
         {
            _sp2.addChild(_line02);
            _line02.y = _describe2.y + _describe2.height;
            _sp2.addChild(_need);
            _need.y = _line02.y + 11;
            _sp2.addChild(_conditionVbox);
            _conditionVbox.y = _need.y + _need.textHeight + 3;
         }
         else
         {
            if(_line02.parent)
            {
               _line02.parent.removeChild(_line02);
            }
            if(_need.parent)
            {
               _need.parent.removeChild(_need);
            }
            if(_conditionVbox.parent)
            {
               _conditionVbox.parent.removeChild(_conditionVbox);
            }
         }
         for each(_loc2_ in _loc4_)
         {
            _condition1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillConditionTxt");
            _condition1.text = _loc2_;
            _conditionVbox.addChild(_condition1);
         }
         _conditionVbox.refreshChildPos();
         _totalBox.addChild(_sp2);
         if(_conditionVbox.parent)
         {
            _bg.height = _conditionVbox.height + _totalBox.height + 20;
         }
         else
         {
            _bg.height = _totalBox.height + 30;
         }
      }
      
      private function isTalent(param1:SkillTempInfo) : Boolean
      {
         return SkillData.SKILL_SONTYPE_TALENT_ARR.indexOf(param1.SonType) != -1;
      }
      
      public function getCostString(param1:Boolean, param2:int, param3:Boolean = false) : String
      {
         var _loc4_:String = "";
         param2 = Math.abs(param2);
         if(param1)
         {
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown03",param2);
         }
         else if(param3)
         {
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown04",param2);
         }
         else if(param3)
         {
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown04",param2);
         }
         else
         {
            _loc4_ = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown02",param2);
         }
         return _loc4_;
      }
      
      public function getAvengerCostString(param1:int) : String
      {
         return LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.avengerCost",Math.abs(param1));
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
         _totalBox.removeAllChild();
         _conditionVbox.removeAllChild();
         while(_sp2.numChildren > 0)
         {
            _sp2.removeChildAt(_sp2.numChildren - 1);
         }
         while(_sp1.numChildren)
         {
            _sp1.removeChildAt(_sp1.numChildren - 1);
         }
      }
      
      override public function dispose() : void
      {
         if(_method)
         {
            _method.dispose();
         }
         _method = null;
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
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
         if(_costSp1)
         {
            _costSp1.dispose();
         }
         _costSp1 = null;
         if(_costHitPoint1)
         {
            _costHitPoint1.dispose();
         }
         _costHitPoint1 = null;
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
         if(_costSp2)
         {
            _costSp2.dispose();
         }
         _costSp2 = null;
         if(_costHitPoint2)
         {
            _costHitPoint2.dispose();
         }
         _costHitPoint2 = null;
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
         if(_petSkillIcon)
         {
            _petSkillIcon.dispose();
         }
         _petSkillIcon = null;
         if(_method2)
         {
            _method2.dispose();
         }
         _method2 = null;
         if(_level1)
         {
            _level1.dispose();
         }
         _level1 = null;
         if(_level2)
         {
            _level2.dispose();
         }
         _level2 = null;
         if(_conditionVbox)
         {
            _conditionVbox.dispose();
         }
         _conditionVbox = null;
         if(_totalBox)
         {
            _totalBox.dispose();
         }
         _totalBox = null;
         if(_line01)
         {
            ObjectUtils.disposeObject(_line01);
         }
         _line01 = null;
         if(_line02)
         {
            ObjectUtils.disposeObject(_line02);
         }
         _line02 = null;
         if(_line03)
         {
            ObjectUtils.disposeObject(_line03);
         }
         _line03 = null;
         if(_sp1)
         {
            ObjectUtils.disposeAllChildren(_sp1);
         }
         _sp1 = null;
         if(_sp2)
         {
            ObjectUtils.disposeAllChildren(_sp2);
         }
         _sp2 = null;
         _petTypeList = null;
         _petTypeNameList = null;
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
            return "[" + LanguageMgr.GetTranslation("yishi.datas.templates.SkillTempInfo.UseWay02") + "]";
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

