package armyII.viewII.talent
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.TalentEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.ArmySocketOutManager;
   import managers.KingContractManager;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.FormularySets;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.frame.NewKingContractView;
   import yishi.view.frame.TodayNotAlertFrame;
   
   public class TransferTalentView extends Component
   {
      
      public static const STEP:Number = 9999999;
      
      private static var needAlert:Boolean = true;
      
      private var _back:Bitmap;
      
      private var _pointBm:Bitmap;
      
      private var _washBtn:BaseButton;
      
      private var _remainPointTxt:FilterFrameText;
      
      private var _talentLevelTxt:FilterFrameText;
      
      private var _arrows:Sprite;
      
      private var _arrowDic:Dictionary;
      
      private var _container:Component;
      
      private var _skillDic:Dictionary;
      
      private var _filter:IFilterFormat;
      
      private var _levelFlagBm:Bitmap;
      
      private var _talentLvMv:MovieClip;
      
      private var _talentStoneImage:Bitmap;
      
      private var _talentStoneCount:FilterFrameText;
      
      private var _levelUpUse:Bitmap;
      
      private var _diamondView:Bitmap;
      
      private var _needDiamondTxt:FilterFrameText;
      
      private var _numBit:BitmapData;
      
      private var _nextLevelNeedCoin:int;
      
      private var _nextLevelDiamond:int;
      
      private var _payType:int;
      
      private var _upGrade:BaseButton;
      
      private const GAP_X:Number = 122;
      
      private const GAP_Y:Number = 106;
      
      private var _siteArr:Array = [[150,-34],[351,-34],[28,52],[250,79],[473,55],[124,128],[376,127]];
      
      private var _descArr:Array = [];
      
      private var _talentTemplateId:int = 208053;
      
      private var chargeRate:int;
      
      private var _newKingContract:NewKingContractView;
      
      public function TransferTalentView()
      {
         super();
         _filter = new UIFilter();
         initView();
         refreshData();
         addEvent();
         refreshTalentSkill();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("army.transferTalent.BackBmdBG");
         _back.x = 41;
         _back.y = 2;
         addChild(_back);
         _back.visible = true;
         _pointBm = ComponentFactory.Instance.creatBitmap("army.talent.TalentPointBmd");
         addChild(_pointBm);
         _washBtn = ComponentFactory.Instance.creatComponentByStylename("army.talent.WashBtn");
         _washBtn.x = 195;
         _washBtn.y = 7;
         addChild(_washBtn);
         _newKingContract = new NewKingContractView();
         _newKingContract.x = 47;
         _newKingContract.y = 35;
         addChild(_newKingContract);
         _remainPointTxt = ComponentFactory.Instance.creatComponentByStylename("army.talent.RemainTalentPointTxt");
         _remainPointTxt.text = "100";
         addChild(_remainPointTxt);
         _talentLvMv = ComponentFactory.Instance.creat("army.transferTalent.TalentLvView");
         addChild(_talentLvMv);
         _levelUpUse = ComponentFactory.Instance.creatBitmap("army.talent.GradeUpUse");
         _levelUpUse.x = 302;
         _levelUpUse.y = 284;
         addChild(_levelUpUse);
         _diamondView = ComponentFactory.Instance.creatBitmap("army.transferTalent.diamond");
         _diamondView.x = 305;
         _diamondView.y = 308;
         addChild(_diamondView);
         _needDiamondTxt = ComponentFactory.Instance.creatComponentByStylename("army.talent.GradeUpExpendTxt");
         _needDiamondTxt.x = 326;
         _needDiamondTxt.y = 307;
         addChild(_needDiamondTxt);
         _talentStoneImage = ComponentFactory.Instance.creatBitmap("army.transferTalent._talentStoneImage");
         _talentStoneCount = ComponentFactory.Instance.creatComponentByStylename("TransferTalentView.talentStoneCount");
         _upGrade = ComponentFactory.Instance.creatComponentByStylename("armyII.upgradeButton");
         _upGrade.x = 290;
         _upGrade.y = 332;
         addChild(_upGrade);
         addChild(_talentStoneImage);
         addChild(_talentStoneCount);
         _container = ComponentFactory.Instance.creatComponentByStylename("army.talent.TileContainer");
         addChild(_container);
         _container.visible = true;
         _numBit = ComponentFactory.Instance.creatBitmapData("asset.core.PawnLevelNum_1").clone();
         chargeRate = int(TempleteManager.instance.getConfigInfoByConfigName("Talent_PointItem").ConfigValue);
         initSkillList();
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("TALENT_UPGRADE",__talenChangeHanler);
         NotificationManager.instance.addEventListener("TALENT_RESET",__talenChangeHanler);
         _washBtn.addEventListener("click",__washPoint);
         _upGrade.addEventListener("click",__upGrade);
      }
      
      protected function __talenChangeHanler(param1:NotificationEvent) : void
      {
         refreshTalentSkill();
         refreshData();
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("TALENT_UPGRADE",__talenChangeHanler);
         NotificationManager.instance.removeEventListener("TALENT_RESET",__talenChangeHanler);
         if(_washBtn)
         {
            _washBtn.removeEventListener("click",__washPoint);
         }
         if(_upGrade)
         {
            _upGrade.removeEventListener("click",__upGrade);
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function refreshData() : void
      {
         var _loc2_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(thane.talentData.talentGrade + 1,112);
         if(_loc2_)
         {
            _nextLevelDiamond = _loc2_.Data;
            _needDiamondTxt.text = FormularySets.toStringSelf(_nextLevelDiamond,9999999);
         }
         else
         {
            _needDiamondTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
            _upGrade.enable = false;
         }
         _remainPointTxt.text = thane.talentData.talentPoint.toString();
         _washBtn.enable = thane.talentData.talentScript != thane.templateInfo.Job + "00199,";
         NumberViewUtils.refreshValue(thane.talentData.talentGrade,_talentLvMv.container,_numBit,19,25,15,19,"0123456789");
         var _loc1_:int = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208053));
         _talentStoneCount.text = _loc1_ + "";
      }
      
      private function initSkillList() : void
      {
         var _loc3_:int = 0;
         var _loc4_:TalentItemView = null;
         var _loc1_:Bitmap = null;
         var _loc2_:FilterFrameText = null;
         _skillDic = new Dictionary(true);
         _loc3_ = 0;
         while(_loc3_ < 7)
         {
            _loc4_ = new TalentItemView();
            _loc4_.x = _siteArr[_loc3_][0];
            _loc4_.y = _siteArr[_loc3_][1];
            _container.addChild(_loc4_);
            _skillDic[_loc3_] = _loc4_;
            _loc1_ = ComponentFactory.Instance.creatBitmap("army.transferTalent.shadow");
            _loc1_.x = _siteArr[_loc3_][0] - 13;
            _loc1_.y = _siteArr[_loc3_][1] + 95;
            _container.addChild(_loc1_);
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("army.talent.descTxt");
            _loc2_.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip24");
            _loc2_.x = _siteArr[_loc3_][0] - 41;
            _loc2_.y = _siteArr[_loc3_][1] + 94;
            _container.addChild(_loc2_);
            _descArr.push(_loc2_);
            _loc3_++;
         }
      }
      
      protected function __upGrade(param1:MouseEvent) : void
      {
         var _loc4_:TodayNotAlertFrame = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         if(needAlert)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert3");
            _loc3_ = LanguageMgr.GetTranslation("TransferTalentView.confirmUpgradeTalent",_nextLevelDiamond / chargeRate,_nextLevelDiamond);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_.show(_loc3_,_loc2_,__todayNotAlert,null,"center",2,true);
         }
         else
         {
            doTalentUpgrade(SharedManager.instance.upgradeTalentUseBind);
         }
      }
      
      private function __todayNotAlert(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            needAlert = false;
            SharedManager.instance.upgradeTalentUseBind = param2;
            SharedManager.instance.saveUpgradeTalentUseBind();
         }
         doTalentUpgrade(param2);
      }
      
      private function doTalentUpgrade(param1:Boolean = true) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = int(playerInfo.point);
         if(param1)
         {
            _loc4_ = playerInfo.point + playerInfo.giftToken;
         }
         var _loc2_:int = int(GoodsManager.instance.getBagCountByTempId(1,_talentTemplateId));
         if(_loc2_ * chargeRate + _loc4_ >= _nextLevelDiamond)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            ArmyManager.instance.addEventListener("TALENT_GRADUP_SUCC",__talentGradeUpSucc);
            control.sendUpTalentGrade(false,param1 ? 2 : 1);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      protected function __talentGradeUpSucc(param1:TalentEvent) : void
      {
         ArmyManager.instance.removeEventListener("TALENT_GRADUP_SUCC",__talentGradeUpSucc);
         __talenChangeHanler(null);
      }
      
      protected function __washPoint(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = LanguageMgr.GetTranslation("armyII.viewII.talent.content01",100);
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         if(KingContractManager.Instance.checkHasBuffById(9))
         {
            _loc2_ = LanguageMgr.GetTranslation("armyII.viewII.talent.content02");
            SimpleAlertHelper.instance.data = [alertBack];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_);
         }
         else
         {
            SimpleAlertHelper.instance.data = [payCallBack];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",100);
         }
      }
      
      private function alertBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            ArmySocketOutManager.sendWashSkillPoint(0,1,true);
         }
      }
      
      private function payCallBack(param1:Boolean, param2:Boolean, param3:int = 0, param4:int = 0) : void
      {
         if(param1)
         {
            control.sendWashTalentSkillPoint(param4,1,param2);
         }
      }
      
      private function refreshTalentSkill() : void
      {
         var _loc3_:int = 0;
         var _loc2_:SkillInfo = null;
         var _loc5_:TalentItemView = null;
         var _loc1_:FilterFrameText = null;
         for(var _loc4_:String in _skillDic)
         {
            _loc3_ = int(_loc4_);
            _loc2_ = thane.talentData.allTalentList[_loc3_] as SkillInfo;
            _loc5_ = _skillDic[_loc4_] as TalentItemView;
            _loc1_ = _descArr[_loc4_] as FilterFrameText;
            if(_loc2_)
            {
               _loc5_.data = _loc2_;
               _loc1_.text = _loc2_.templateInfo.TemplateName;
            }
            else
            {
               _loc5_.data = null;
            }
         }
      }
      
      private function refreshAdvData() : void
      {
         var _loc1_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(thane.talentData.advTalentGrade + 1,38);
         if(_loc1_)
         {
            _nextLevelNeedCoin = _loc1_.TemplateId;
            _nextLevelDiamond = _loc1_.Data;
            _needDiamondTxt.text = FormularySets.toStringSelf(_nextLevelDiamond,9999999);
         }
         else
         {
            _needDiamondTxt.text = LanguageMgr.GetTranslation("public.defaultnumber");
            _upGrade.enable = false;
         }
         _remainPointTxt.text = thane.talentData.advTalentPoint.toString();
         _washBtn.enable = !StringHelper.isNullOrEmpty(thane.talentData.advTalentScript);
         NumberViewUtils.refreshValue(thane.talentData.advTalentGrade,_talentLvMv.container,_numBit,19,25,15,19,"0123456789");
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_container);
         _container = null;
         ObjectUtils.disposeObject(_talentStoneImage);
         _talentStoneImage = null;
         ObjectUtils.disposeObject(_talentStoneCount);
         _talentStoneCount = null;
         super.dispose();
      }
   }
}

