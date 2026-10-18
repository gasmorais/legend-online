package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.GameHallManager;
   import managers.RoomManager;
   import mvc.module.children.ChildData;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.TempleteManager;
   
   public class ThaneTip extends BaseTip
   {
      
      private var _totalVBox:VBox;
      
      private var _levelHBox:HBox;
      
      private var _jobHBox:HBox;
      
      private var _combatPowerHBox:HBox;
      
      private var _name:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _job:FilterFrameText;
      
      private var _combatPower:FilterFrameText;
      
      private var _levelVal:FilterFrameText;
      
      private var _jobVal:FilterFrameText;
      
      private var _combatPowerVal:FilterFrameText;
      
      private var _line1:ScaleBitmapImage;
      
      public function ThaneTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 260;
         _bg.height = 115;
         _totalVBox = ComponentFactory.Instance.creatComponentByStylename("tips.TipContain");
         _levelHBox = ComponentFactory.Instance.creatComponentByStylename("tip.TipItemBox");
         _jobHBox = ComponentFactory.Instance.creatComponentByStylename("tip.TipItemBox");
         _combatPowerHBox = ComponentFactory.Instance.creatComponentByStylename("tip.TipItemBox");
         _name = ComponentFactory.Instance.creatComponentByStylename("tips.ThaneNameText");
         _level = ComponentFactory.Instance.creatComponentByStylename("tips.ThaneLevelText");
         _job = ComponentFactory.Instance.creatComponentByStylename("tips.ThaneLevelText");
         _combatPower = ComponentFactory.Instance.creatComponentByStylename("tips.CombatPowerText");
         _level.text = LanguageMgr.GetTranslation("yishi.view.tips.HeroTip.level");
         _job.text = LanguageMgr.GetTranslation("yishi.view.tips.HeroTip.vocation");
         _combatPower.text = LanguageMgr.GetTranslation("public.playerInfo.ap");
         _levelVal = ComponentFactory.Instance.creatComponentByStylename("tips.ThaneLevelValueText");
         _jobVal = ComponentFactory.Instance.creatComponentByStylename("tips.ThaneLevelValueText");
         _combatPowerVal = ComponentFactory.Instance.creatComponentByStylename("tips.CombatPowerText");
         _line1 = ComponentFactory.Instance.creatComponentByStylename("tips.PawnTipLine1");
         _levelHBox.addChild(_level);
         _levelHBox.addChild(_levelVal);
         _jobHBox.addChild(_job);
         _jobHBox.addChild(_jobVal);
         _combatPowerHBox.addChild(_combatPower);
         _combatPowerHBox.addChild(_combatPowerVal);
         _totalVBox.addChild(_name);
         _totalVBox.addChild(_levelHBox);
         _totalVBox.addChild(_jobHBox);
         _totalVBox.addChild(_line1);
         _totalVBox.addChild(_combatPowerHBox);
         addChild(_totalVBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:ThaneInfo = null;
         var _loc3_:ChildData = null;
         var _loc1_:ChildTempInfo = null;
         if(tipData)
         {
            if(tipData is ThaneInfo)
            {
               _loc2_ = tipData as ThaneInfo;
               _name.text = _loc2_.nickName;
               _levelVal.text = LanguageMgr.GetTranslation("public.level2",_loc2_.grades);
               _jobVal.text = JobType.getJobName(_loc2_.templateInfo.Job);
               _combatPowerVal.text = getCombatPower(_loc2_.userId,_loc2_.serviceName);
            }
            else if(tipData is ChildData)
            {
               _loc3_ = tipData as ChildData;
               _loc1_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc3_.job,_loc3_.growthGrade);
               _name.text = _loc3_.name;
               _levelVal.text = LanguageMgr.GetTranslation("public.level2",_loc3_.growthGrade);
               if(_loc1_)
               {
                  _jobVal.text = _loc1_.JobName;
               }
               _combatPowerVal.text = _loc3_.fightValue.toString();
            }
         }
      }
      
      private function getCombatPower(param1:int, param2:String = "") : String
      {
         var _loc3_:String = "";
         if(FreedomTeamManager.instance.hasTeam)
         {
            _loc3_ = String(FreedomTeamManager.instance.memberFightCapacity(param1));
         }
         else if(RoomManager.instance.roomInfo)
         {
            _loc3_ = String(RoomManager.instance.roomInfo.getPlayerByUserId(param1,param2).combatPower);
         }
         else if(GameHallManager.instance.model.selfTeam)
         {
            _loc3_ = String(GameHallManager.instance.model.getUserArmyByUserId(param1).baseHero.fightingCapacity);
         }
         return _loc3_;
      }
      
      override public function dispose() : void
      {
         if(_totalVBox)
         {
            ObjectUtils.disposeObject(_totalVBox);
         }
         _totalVBox = null;
         if(_levelHBox)
         {
            ObjectUtils.disposeObject(_levelHBox);
         }
         _levelHBox = null;
         if(_jobHBox)
         {
            ObjectUtils.disposeObject(_jobHBox);
         }
         _jobHBox = null;
         if(_combatPowerHBox)
         {
            ObjectUtils.disposeObject(_combatPowerHBox);
         }
         _combatPowerHBox = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_level)
         {
            ObjectUtils.disposeObject(_level);
         }
         _level = null;
         if(_job)
         {
            ObjectUtils.disposeObject(_job);
         }
         _job = null;
         if(_combatPower)
         {
            ObjectUtils.disposeObject(_combatPower);
         }
         _combatPower = null;
         if(_levelVal)
         {
            ObjectUtils.disposeObject(_levelVal);
         }
         _levelVal = null;
         if(_jobVal)
         {
            ObjectUtils.disposeObject(_jobVal);
         }
         _jobVal = null;
         if(_combatPowerVal)
         {
            ObjectUtils.disposeObject(_combatPowerVal);
         }
         _combatPowerVal = null;
         if(_line1)
         {
            ObjectUtils.disposeObject(_line1);
         }
         _line1 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

