package marry.income
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.marry.MarriageData;
   import mvc.module.marry.MarrySender;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.Progress;
   import yishi.view.tips.MessageTipManager;
   
   public class MateRightView extends Sprite implements Disposeable
   {
      
      private var _mateSatisfactoryLevel:FilterFrameText;
      
      private var _mateSatisfactoryEXP:FilterFrameText;
      
      private var _mateProgress:Progress;
      
      private var _helpCountText:FilterFrameText;
      
      private var _helpCountCost:FilterFrameText;
      
      private var _satisfactoryFrameHelpButton:BaseButton;
      
      private var _progressBack:Bitmap;
      
      private var _diamondIcon:Bitmap;
      
      private var _info:MarriageData;
      
      public function MateRightView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _progressBack = ComponentFactory.Instance.creatBitmap("asset.marry.marrySatisfactoryProgressBack");
         _mateSatisfactoryLevel = ComponentFactory.Instance.creatComponentByStylename("marrySatisfactoryRateView.satisfactoryLevel");
         _mateSatisfactoryEXP = ComponentFactory.Instance.creatComponentByStylename("marrySatisfactoryRateView.satisfactoryEXP");
         _mateProgress = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.progress");
         _helpCountText = ComponentFactory.Instance.creatComponentByStylename("MateRightView.meiguizhenxin");
         _helpCountCost = ComponentFactory.Instance.creatComponentByStylename("MateRightView.meiguizhenxin");
         _satisfactoryFrameHelpButton = ComponentFactory.Instance.creatComponentByStylename("marrySatisfactoryFrame.helpButton");
         _diamondIcon = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         addChild(_diamondIcon);
         _diamondIcon.x = 763;
         _diamondIcon.y = 325;
         addChild(_progressBack);
         _progressBack.x = 586;
         _progressBack.y = 252;
         addChild(_mateSatisfactoryLevel);
         _mateSatisfactoryLevel.x = 600;
         addChild(_mateSatisfactoryEXP);
         _mateSatisfactoryEXP.x = 600;
         _mateSatisfactoryEXP.text = LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.marrySatisfactoryEXP");
         addChild(_mateProgress);
         _mateProgress.x = 593;
         addChild(_helpCountText);
         _helpCountText.x = 600;
         _helpCountCost.y = 290;
         addChild(_helpCountCost);
         _helpCountCost.x = 600;
         _helpCountCost.y = 324;
         _helpCountCost.text = LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.helpCost",TempleteManager.instance.getConfigValue("marriage_happy_help_point"));
         addChild(_satisfactoryFrameHelpButton);
         _satisfactoryFrameHelpButton.tipData = LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.helpBtnTip");
         _satisfactoryFrameHelpButton.addEventListener("click",_satisfactoryFrameHelpButtonHandler);
      }
      
      public function setData(param1:MarriageData, param2:UpgradeTemplateInfo) : void
      {
         _info = param1;
         _mateProgress.setData(param1.mateHappyInfo.happyGp,param2.Data);
         _helpCountText.text = LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.leftHelpCount",TempleteManager.instance.getConfigValue("marriage_happy_help_count") - param1.happyInfo.happyHelp);
         _diamondIcon.x = _helpCountCost.x + _helpCountCost.textWidth + 5;
         var _loc3_:String = param1.mateHappyInfo.happyGrade >= 9 ? LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.xinfudu") : LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.meimandu");
         _mateSatisfactoryLevel.text = LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.marrySatisfactoryLevel",param1.mateHappyInfo.happyGrade,_loc3_);
         _mateSatisfactoryEXP.text = LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.marrySatisfactoryEXP",_loc3_);
      }
      
      private function _satisfactoryFrameHelpButtonHandler(param1:Event) : void
      {
         if(5 - _info.happyInfo.happyHelp <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("godarrive.GodArriveFrame.NoLeftCount"));
            return;
         }
         showPromptAlert(TempleteManager.instance.getConfigValue("marriage_happy_help_point"));
      }
      
      private function showPromptAlert(param1:int) : void
      {
         SimpleAlertHelper.instance.data = [showPromptAlertBack,param1];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("marry.marrySatisfactoryRateView.leftHelpDialog",param1);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,false,2,"USEBINDPOINT_ALERT");
      }
      
      private function showPromptAlertBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            if(param2)
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
            }
            else
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            }
            if(_loc5_ < param3)
            {
               RechargeAlertMannager.show();
            }
            else
            {
               _loc4_ = param2 ? 0 : 1;
               MarrySender.helpMateTrain(_loc4_);
            }
         }
      }
      
      public function dispose() : void
      {
         if(_satisfactoryFrameHelpButton)
         {
            _satisfactoryFrameHelpButton.removeEventListener("click",_satisfactoryFrameHelpButtonHandler);
         }
         ObjectUtils.disposeAllChildren(this);
         if(_mateSatisfactoryLevel)
         {
            _mateSatisfactoryLevel.dispose();
         }
         _mateSatisfactoryLevel = null;
         if(_mateSatisfactoryEXP)
         {
            _mateSatisfactoryEXP.dispose();
         }
         _mateSatisfactoryEXP = null;
         if(_mateProgress)
         {
            _mateProgress.dispose();
         }
         _mateProgress = null;
         if(_helpCountText)
         {
            _helpCountText.dispose();
         }
         _helpCountText = null;
         if(_helpCountCost)
         {
            _helpCountCost.dispose();
         }
         _helpCountCost = null;
         ObjectUtils.disposeObject(_progressBack);
         _progressBack = null;
         if(_satisfactoryFrameHelpButton)
         {
            _satisfactoryFrameHelpButton.dispose();
         }
         _satisfactoryFrameHelpButton = null;
         if(_diamondIcon)
         {
            ObjectUtils.disposeObject(_diamondIcon);
         }
         _diamondIcon = null;
      }
   }
}

