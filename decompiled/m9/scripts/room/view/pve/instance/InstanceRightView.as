package room.view.pve.instance
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.InstanceEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.RankInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.CampaignRankManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class InstanceRightView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _bgScale:Scale9CornerImage;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _bg2:ScaleBitmapImage;
      
      private var _areaNameTxt:GradientText;
      
      private var _recommendGrades:FilterFrameText;
      
      private var _contain1:Sprite;
      
      private var _normalBtn:SelectedIconButton;
      
      private var _difficultBtn:SelectedIconButton;
      
      private var _hellBtn:SelectedIconButton;
      
      private var _okBtn:BaseButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _mapIcon:BaseIconView;
      
      private var _iconBackMc:MovieClip;
      
      private var _notesBitmapData:BitmapData;
      
      private var _fontBG:Bitmap;
      
      private var _instanceHard:int = -1;
      
      private var _instanceLv:int = 0;
      
      private var _difficultBtnShin:MovieImage;
      
      private var _optimzeText:FilterFrameText;
      
      private var _optimzeValueText:FilterFrameText;
      
      private var gradeTextARR:Array;
      
      private var _goods:DisplayObject;
      
      private var _areaInfo:CampaignAreaInfo;
      
      private var _todayAlertText:GradientText;
      
      private var _todayText:FilterFrameText;
      
      private var _todayLeftCount:FilterFrameText;
      
      private var _difText:FilterFrameText;
      
      private var _bloodyContain:Sprite;
      
      private var _molongContain:Sprite;
      
      private var _nalanContain:Sprite;
      
      private var _tailaContain:Sprite;
      
      private var _wasteContain:Sprite;
      
      private var _sacristyContain:Sprite;
      
      private var _skyStepContain:Sprite;
      
      private var difficutlyCount:int = -1;
      
      private var _twoBtnGSP:Sprite;
      
      private var _buttonGroupII:SelectedButtonGroup;
      
      private var _normalBtnII:SelectedButton;
      
      private var _difficultBtnII:SelectedButton;
      
      private var _threeBtnGSP:Sprite;
      
      private var _buttonGroupIII:SelectedButtonGroup;
      
      private var _normalBtnIII:SelectedButton;
      
      private var _difficultBtnIII:SelectedButton;
      
      private var _hellBtnIII:SelectedButton;
      
      public function InstanceRightView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _group = new SelectedButtonGroup();
         _bgScale = ComponentFactory.Instance.creatComponentByStylename("room.InstaneRightDescribeBackgroundScale");
         _bg = ComponentFactory.Instance.creatComponentByStylename("room.InstaneRightBG.MutipleImage");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("room.InstaneRightDescribeBackground1");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("room.InstaneRightDescribeBackground2");
         _areaNameTxt = ComponentFactory.Instance.creatComponentByStylename("room.InstaneRight.areaNameTxt");
         _recommendGrades = ComponentFactory.Instance.creatComponentByStylename("room.InstaneRight.recommendGrades");
         _mapIcon = ComponentFactory.Instance.creatCustomObject("room.InstanceBigMapIcon",[loadComplete]);
         _iconBackMc = ComponentFactory.Instance.creatCustomObject("room.InstanceBigMapIcon.iconBackMc");
         _fontBG = ComponentFactory.Instance.creatBitmap("asset.room.instanceRightNoteFontBG");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("room.RightInstance.OKBtn");
         _optimzeText = ComponentFactory.Instance.creatComponentByStylename("room.instanceRight.optimzeText");
         _optimzeValueText = ComponentFactory.Instance.creatComponentByStylename("room.instanceRight.optimzeValueText");
         _todayAlertText = ComponentFactory.Instance.creatComponentByStylename("room.instanceRight.todayAlertText");
         _todayText = ComponentFactory.Instance.creatComponentByStylename("room.instanceRight.todayText");
         _todayLeftCount = ComponentFactory.Instance.creatComponentByStylename("room.instanceRight.todayLeftCount");
         _contain1 = ComponentFactory.Instance.creatCustomObject("room.RightInstance.Contain1");
         _goods = ComponentFactory.Instance.creatCustomObject("room.instanceRight.PveFallGoodsView");
         _difText = ComponentFactory.Instance.creatComponentByStylename("room.instanceRight.difText");
         _bloodyContain = ComponentFactory.Instance.creatCustomObject("room.RightInstance.Contain4");
         _bloodyContain.visible = false;
         _molongContain = ComponentFactory.Instance.creatCustomObject("room.RightInstance.Contain5");
         _molongContain.visible = false;
         _nalanContain = ComponentFactory.Instance.creatCustomObject("room.RightInstance.Contain6");
         _nalanContain.visible = false;
         _tailaContain = ComponentFactory.Instance.creatCustomObject("room.RightInstance.Contain7");
         _tailaContain.visible = false;
         _wasteContain = ComponentFactory.Instance.creatCustomObject("room.RightInstance.Contain8");
         _wasteContain.visible = false;
         _sacristyContain = ComponentFactory.Instance.creatCustomObject("room.RightInstance.Contain9");
         _sacristyContain.visible = false;
         _skyStepContain = ComponentFactory.Instance.creatCustomObject("room.RightInstance.Contain11");
         _skyStepContain.visible = false;
         _twoBtnGSP = ComponentFactory.Instance.creatCustomObject("room.RightInstance.Contain2");
         _normalBtnII = ComponentFactory.Instance.creatComponentByStylename("room.RightInstance.NormalBtnII");
         _difficultBtnII = ComponentFactory.Instance.creatComponentByStylename("room.RightInstance.DifficultBtnII");
         _buttonGroupII = new SelectedButtonGroup();
         _buttonGroupII.addSelectItem(_normalBtnII);
         _buttonGroupII.addSelectItem(_difficultBtnII);
         _twoBtnGSP.addChild(_normalBtnII);
         _twoBtnGSP.addChild(_difficultBtnII);
         _twoBtnGSP.visible = false;
         _threeBtnGSP = ComponentFactory.Instance.creatCustomObject("room.RightInstance.Contain2");
         _normalBtnIII = ComponentFactory.Instance.creatComponentByStylename("room.RightInstance.NormalBtnIII");
         _difficultBtnIII = ComponentFactory.Instance.creatComponentByStylename("room.RightInstance.DifficultBtnIII");
         _hellBtnIII = ComponentFactory.Instance.creatComponentByStylename("room.RightInstance.HellBtnIII");
         _threeBtnGSP.y = 283;
         _buttonGroupIII = new SelectedButtonGroup();
         _buttonGroupIII.addSelectItem(_normalBtnIII);
         _buttonGroupIII.addSelectItem(_difficultBtnIII);
         _buttonGroupIII.addSelectItem(_hellBtnIII);
         _threeBtnGSP.addChild(_normalBtnIII);
         _threeBtnGSP.addChild(_difficultBtnIII);
         _threeBtnGSP.addChild(_hellBtnIII);
         _threeBtnGSP.visible = false;
         addChild(_bgScale);
         addChild(_bg);
         addChild(_bg1);
         addChild(_bg2);
         addChild(_mapIcon);
         addChild(_areaNameTxt);
         addChild(_recommendGrades);
         addChild(_optimzeText);
         _optimzeText.visible = false;
         addChild(_optimzeValueText);
         _optimzeValueText.visible = false;
         addChild(_iconBackMc);
         _iconBackMc.gotoAndStop(1);
         addChild(_okBtn);
         addChild(_contain1);
         _contain1.visible = false;
         addChild(_twoBtnGSP);
         addChild(_threeBtnGSP);
         addChild(_goods);
         _goods.visible = false;
         addChild(_difText);
         addChild(_bloodyContain);
         addChild(_molongContain);
         addChild(_nalanContain);
         addChild(_tailaContain);
         addChild(_wasteContain);
         addChild(_sacristyContain);
         addChild(_skyStepContain);
         addChild(_todayAlertText);
         addChild(_todayText);
         addChild(_todayLeftCount);
         _todayAlertText.mouseEnabled = false;
         _todayText.mouseEnabled = false;
         _todayLeftCount.mouseEnabled = false;
         _optimzeText.text = LanguageMgr.GetTranslation("InstanceRightView.optimzeText.text");
         gradeTextARR = LanguageMgr.GetTranslation("room.InstanceItem.gradeText").split("|");
      }
      
      private function loadComplete(param1:BaseIconView = null) : void
      {
         (_mapIcon.content as Bitmap).smoothing = false;
      }
      
      private function initEvents() : void
      {
         _okBtn.addEventListener("click",__okClick);
         _group.addEventListener("change",__hardChange);
         _buttonGroupII.addEventListener("change",__difficultyChangeII);
         _buttonGroupIII.addEventListener("change",__difficultyChangeIII);
      }
      
      private function removeEvents() : void
      {
         if(_okBtn)
         {
            _okBtn.removeEventListener("click",__okClick);
         }
         _group.removeEventListener("change",__hardChange);
         _buttonGroupII.removeEventListener("change",__difficultyChangeII);
         _buttonGroupIII.removeEventListener("change",__difficultyChangeIII);
      }
      
      private function __okClick(param1:MouseEvent) : void
      {
         var _loc3_:InstanceEvent = null;
         SoundManager.instance.play("022");
         var _loc2_:String = "";
         if(!_areaInfo)
         {
            __dontSelectInstance();
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.instance.InstanceRightView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_areaInfo.areaId == 302)
         {
            _loc3_ = new InstanceEvent("confirm_instance");
            _loc3_.selectedMapInfo = _areaInfo.getMapList()[_instanceLv];
            dispatchEvent(_loc3_);
            __backClick(null);
            return;
         }
         if(_instanceHard < 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.instance.InstanceRightView.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(RoomManager.instance.roomInfo.houseOwnerId == thane.userId && thane.grades < _areaInfo.getMapByDifficult(_instanceHard).MinLevel)
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.instance.InstanceRightView.command03");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_instanceHard >= 0)
         {
            _loc3_ = new InstanceEvent("confirm_instance");
            _loc3_.selectedMapInfo = _areaInfo.getMapByDifficult(_instanceHard);
            dispatchEvent(_loc3_);
            __backClick(null);
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __dontSelectInstance() : void
      {
         dispatchEvent(new InstanceEvent("dont_select_instance"));
      }
      
      public function get bloodyIsOver() : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("Random_Boss_Count");
         var _loc3_:int = int(_loc1_.ConfigValue);
         var _loc2_:int = _loc3_ - PlayerManager.instance.currentPlayerModel.playerInfo.randomBossCount;
         return _loc2_ <= 0;
      }
      
      private function __backClick(param1:MouseEvent) : void
      {
         var _loc2_:InstanceEvent = new InstanceEvent("close_instance_frame");
         dispatchEvent(_loc2_);
      }
      
      private function __difficultyChangeII(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_buttonGroupII.getSelectedItem())
         {
            case _normalBtnII:
               _instanceHard = 1;
               break;
            case _difficultBtnII:
               _instanceHard = 2;
               break;
            default:
               _instanceHard = -1;
         }
         if(_areaInfo && _areaInfo.getMapByDifficult(_instanceHard))
         {
            _goods.visible = true;
            _goods["data"] = _areaInfo.getMapByDifficult(_instanceHard).Item;
            _mapIcon.visible = true;
            _iconBackMc.gotoAndStop(_instanceHard);
            _difText.text = LanguageMgr.GetTranslation("room.instanceRight.difText.text" + _instanceHard * 2);
            if(_areaInfo.getMapByDifficult(1).isTaila)
            {
               if(_instanceHard == 2)
               {
                  _recommendGrades.text = LanguageMgr.GetTranslation("room.rightView.recommendGrades.text5");
               }
               else
               {
                  _recommendGrades.text = LanguageMgr.GetTranslation("room.rightView.recommendGrades.text1");
               }
            }
         }
         else
         {
            _buttonGroupII.selectIndex = -1;
         }
      }
      
      private function __difficultyChangeIII(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_buttonGroupIII.getSelectedItem())
         {
            case _normalBtnIII:
               _instanceHard = 1;
               break;
            case _difficultBtnIII:
               _instanceHard = 2;
               break;
            case _hellBtnIII:
               _instanceHard = 3;
               break;
            default:
               _instanceHard = -1;
         }
         if(_areaInfo && _areaInfo.getMapByDifficult(_instanceHard))
         {
            _goods.visible = true;
            _goods["data"] = _areaInfo.getMapByDifficult(_instanceHard).Item;
            _mapIcon.visible = true;
            _iconBackMc.gotoAndStop(_instanceHard);
            _difText.text = LanguageMgr.GetTranslation("room.instanceRight.difText.text" + _instanceHard * 2);
         }
         else
         {
            _buttonGroupIII.selectIndex = -1;
         }
      }
      
      private function __hardChange(param1:Event) : void
      {
         SoundManager.instance.play("022");
         _mapIcon.filters = [];
         if(_normalBtn && _group.getSelectedItem() == _normalBtn)
         {
            _instanceHard = 1;
         }
         else if(_difficultBtn && _group.getSelectedItem() == _difficultBtn)
         {
            _instanceHard = 2;
         }
         else if(_hellBtn && _group.getSelectedItem() == _hellBtn)
         {
            _instanceHard = 3;
         }
         else
         {
            _instanceHard = 1;
         }
         if(_areaInfo && _areaInfo.getMapByDifficult(_instanceHard))
         {
            _optimzeText.visible = true;
            _optimzeValueText.visible = true;
            checkOptimizeProfile(_areaInfo.getMapByDifficult(_instanceHard).CampaignId);
            _fontBG.visible = true;
            _goods.visible = true;
            _goods["data"] = _areaInfo.getMapByDifficult(_instanceHard).Item;
            if(_areaInfo.getMapByDifficult(_instanceHard).NeedFourTransfer)
            {
               _recommendGrades.text = LanguageMgr.GetTranslation("room.rightView.recommendGrades.text6");
            }
            else if(_areaInfo.getMapByDifficult(_instanceHard).NeedThirdTransfer)
            {
               _recommendGrades.text = LanguageMgr.GetTranslation("room.rightView.recommendGrades.text5");
            }
            else if(_areaInfo.getMapByDifficult(_instanceHard).NeedChangeJob)
            {
               _recommendGrades.text = LanguageMgr.GetTranslation("room.rightView.recommendGrades.text4");
            }
            else if(_areaInfo.getMapByDifficult(_instanceHard).NeedTransfer)
            {
               _recommendGrades.text = LanguageMgr.GetTranslation("room.rightView.recommendGrades.text1");
            }
            else if(_areaInfo.getMapByDifficult(_instanceHard).MinLevel == 80)
            {
               _recommendGrades.text = LanguageMgr.GetTranslation("room.rightView.recommendGrades.text3",_areaInfo.getMapByDifficult(_instanceHard).MinLevel);
            }
            else
            {
               _recommendGrades.text = LanguageMgr.GetTranslation("room.rightView.recommendGrades.text2",_areaInfo.getMapByDifficult(_instanceHard).MinLevel,_areaInfo.getMapByDifficult(_instanceHard).MaxLevel);
            }
            _mapIcon.icon = PathManager.mapInstanceBigIconPath(_areaInfo.areaId);
            _iconBackMc.gotoAndStop(_instanceHard);
            if(_instanceHard != 1)
            {
               _mapIcon.filters = [UIFilter.getRoomIconFilter()];
            }
         }
         else
         {
            _group.selectIndex = -1;
            _recommendGrades.text = "";
         }
      }
      
      private function __upDateView() : void
      {
         var _loc2_:int = 0;
         var _loc10_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc13_:int = 0;
         var _loc12_:int = 0;
         var _loc11_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc14_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         _contain1.visible = false;
         _twoBtnGSP.visible = false;
         _threeBtnGSP.visible = false;
         _bloodyContain.visible = false;
         _molongContain.visible = false;
         _nalanContain.visible = false;
         _tailaContain.visible = false;
         _wasteContain.visible = false;
         _sacristyContain.visible = false;
         _skyStepContain.visible = false;
         _difText.text = "";
         _todayAlertText.text = "";
         _todayText.text = "";
         _todayLeftCount.text = "";
         _areaNameTxt.text = "";
         _bg2.visible = true;
         difficutlyCount = -1;
         if(_areaInfo == null)
         {
            return;
         }
         _group.selectIndex = -1;
         _fontBG.visible = false;
         _optimzeText.visible = false;
         _optimzeValueText.visible = false;
         _goods.visible = false;
         _normalBtnII.visible = true;
         _difficultBtnII.visible = true;
         _normalBtnIII.visible = true;
         _difficultBtnIII.visible = true;
         _hellBtnIII.visible = true;
         _instanceHard = -1;
         __hardChange(null);
         _okBtn.y = 367;
         _areaNameTxt.text = _areaInfo.areaName;
         if(_areaInfo.getMapByDifficult(1).SonTypes != 0)
         {
            _todayText.text = LanguageMgr.GetTranslation("InstanceRightView.thisWeekText.text");
            _optimzeText.visible = false;
            _optimzeValueText.visible = false;
            _todayAlertText.y = 298;
            _todayText.y = 334;
            _todayLeftCount.y = 330;
            _bg2.height = 62;
            _bg2.y = 296;
            if(_areaInfo.getMapByDifficult(1).isTrailTower)
            {
               _bg2.height = 95;
               _bg2.y = 285;
               _difText.text = LanguageMgr.GetTranslation("room.instanceRight.difText.text1");
               _todayAlertText.y = 290;
               _todayText.y = 309;
               _todayText.x = 145;
               _todayLeftCount.y = 306;
               _okBtn.y = 377;
               _hellBtnIII.visible = VersionSwitch.TRAILTOWER_HALL;
               _normalBtnIII.enable = checkExist(1);
               _difficultBtnIII.enable = checkExist(2) && _areaInfo.getMapByDifficult(1).state == 1;
               _hellBtnIII.enable = checkExist(3) && _areaInfo.getMapByDifficult(2).state == 1;
               _buttonGroupIII.selectIndex = 0;
               _threeBtnGSP.visible = true;
               _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.trialTowerCampaignCount);
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.trialTowerCampaignMaxCount);
               _todayLeftCount.text = _loc3_ + "/" + _loc2_;
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.trial");
            }
            else if(_areaInfo.getMapByDifficult(1).isBloodyPandemoniue)
            {
               _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.randomBossCount);
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.randomBossMaxCount);
               _todayLeftCount.text = _loc3_ + "/" + _loc2_;
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.bloody");
            }
            else if(_areaInfo.getMapByDifficult(1).isMolongCampaign)
            {
               _molongContain.visible = true;
               _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.molongRestNum);
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.molongMaxNum);
               _todayLeftCount.text = _loc3_ + "/" + _loc2_;
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.molong");
            }
            else if(_areaInfo.getMapByDifficult(1).isNaLan)
            {
               _nalanContain.visible = true;
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.teamMaxCount);
               _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.teamCount);
               _todayLeftCount.text = _loc4_ + "/" + _loc2_;
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.nanlan");
            }
            else if(_areaInfo.getMapByDifficult(1).isTaila)
            {
               _tailaContain.visible = true;
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.tailaMaxCount);
               _loc1_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.tailaCount);
               _todayLeftCount.text = _loc1_ + "/" + _loc2_;
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.taila");
               _bg2.height = 100;
               _bg2.y = 285;
               _todayLeftCount.y = 306;
               _todayAlertText.y = 290;
               _okBtn.y = 380;
               _todayText.y = 309;
               _normalBtnII.enable = checkExist(1);
               _difficultBtnII.enable = checkExist(2) && _areaInfo.getMapByDifficult(1).state == 1;
               _twoBtnGSP.visible = true;
               _buttonGroupII.selectIndex = 0;
               _difficultBtnII.visible = VersionSwitch.ISTAILAEMENG;
            }
            else if(_areaInfo.getMapByDifficult(1).isWasteCampaign)
            {
               _wasteContain.visible = true;
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.wasteMaxCount);
               _loc13_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.wasteCount);
               _todayLeftCount.text = _loc13_ + "/" + _loc2_;
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.waste");
            }
            else if(_areaInfo.getMapByDifficult(1).isSacristyCampaign)
            {
               _sacristyContain.visible = true;
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.petPveMaxCount);
               _loc12_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.petPveCount);
               _todayLeftCount.text = _loc12_ + "/" + _loc2_;
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.sacristy");
            }
            else if(_areaInfo.getMapByDifficult(1).isFantasyMatrix)
            {
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.fantasyMatrixMaxNum);
               _loc11_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.fantasyMatrixRestNum);
               _todayLeftCount.text = _loc11_ + "/" + _loc2_;
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.fantasyMatrix");
            }
            else if(_areaInfo.getMapByDifficult(1).isChildWarCampaign)
            {
               _bg2.height = 100;
               _bg2.y = 285;
               _difText.text = LanguageMgr.GetTranslation("room.instanceRight.difText.text1");
               _todayAlertText.y = 290;
               _todayText.y = 309;
               _todayLeftCount.y = 306;
               _okBtn.y = 380;
               _normalBtnIII.enable = checkExist(1);
               _difficultBtnIII.enable = checkExist(2) && _areaInfo.getMapByDifficult(1).state == 1;
               _hellBtnIII.enable = checkExist(3) && _areaInfo.getMapByDifficult(2).state == 1;
               _buttonGroupIII.selectIndex = 0;
               _threeBtnGSP.visible = true;
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.childWarMaxCount);
               _loc6_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.childWarCount);
               _todayLeftCount.text = _loc6_ + "/" + _loc2_;
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.childWar");
            }
            else if(_areaInfo.getMapByDifficult(1).isSpacetimeFault)
            {
               _bg2.height = 95;
               _bg2.y = 285;
               _difText.text = LanguageMgr.GetTranslation("room.instanceRight.difText.text1");
               _todayAlertText.y = 290;
               _todayText.y = 309;
               _todayLeftCount.y = 306;
               _okBtn.y = 377;
               _normalBtnII.enable = checkExist(1);
               _difficultBtnII.enable = checkExist(2) && _areaInfo.getMapByDifficult(1).state == 1;
               _twoBtnGSP.visible = true;
               _buttonGroupII.selectIndex = 0;
               _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.spacetimeRestNum);
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.spacetimeMaxNum);
               _todayLeftCount.text = _loc3_ + "/" + _loc2_;
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.spacetimeFault");
               RoomManager.instance.requestSpacetimeInfo(1);
            }
            else if(_areaInfo.getMapByDifficult(1).isDungeoTurn)
            {
               _molongContain.visible = true;
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.dungeoTurnMaxNum);
               _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.dungeoRestNum);
               _todayLeftCount.text = _loc3_ + "/" + _loc2_;
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.dungeoturn");
            }
            else if(_areaInfo.getMapByDifficult(1).isDeepPrison)
            {
               _bg2.height = 100;
               _bg2.y = 285;
               _difText.text = LanguageMgr.GetTranslation("room.instanceRight.difText.text1");
               _todayAlertText.y = 285;
               _todayText.y = 314;
               _todayLeftCount.y = 311;
               _okBtn.y = 380;
               _normalBtnIII.enable = checkExist(1);
               _difficultBtnIII.enable = checkExist(2) && _areaInfo.getMapByDifficult(1).state == 1;
               _hellBtnIII.enable = checkExist(3) && _areaInfo.getMapByDifficult(2).state == 1;
               _buttonGroupIII.selectIndex = 0;
               _threeBtnGSP.visible = true;
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.deepPrisonMaxCount);
               _loc8_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.deepPrisonCount);
               _todayLeftCount.text = _loc8_ + "/" + _loc2_;
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.deepPrison");
            }
            else if(_areaInfo.getMapByDifficult(1).isDarkKing)
            {
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.darkKing");
               _todayText.text = LanguageMgr.GetTranslation("InstanceRightView.todayLeftText.text");
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.darkKingMaxCount);
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.darkKIngLeftCount);
               _todayLeftCount.text = _loc5_ + "/" + _loc2_;
            }
            else if(_areaInfo.getMapByDifficult(1).isRaceAgainstTime)
            {
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.raceAgainstTime");
               _todayText.text = LanguageMgr.GetTranslation("InstanceRightView.todayLeftText.text");
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.raceAgainstTimeMaxCount);
               _loc14_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.raceAgainstTimeLeftCount);
               _todayLeftCount.text = _loc14_ + "/" + _loc2_;
            }
            else if(_areaInfo.getMapByDifficult(1).isForest)
            {
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.forest");
               _todayText.text = LanguageMgr.GetTranslation("InstanceRightView.todayLeftText.text");
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.elementSilvaMaxCount);
               _loc9_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.elementSilvaLeftCount);
               _todayLeftCount.text = _loc9_ + "/" + _loc2_;
            }
            else if(_areaInfo.getMapByDifficult(1).isSkyStepCampaign)
            {
               _skyStepContain.visible = true;
               _loc2_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.skyStepMaxCount);
               _loc7_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.skyStepCount);
               _todayLeftCount.text = _loc7_ + "/" + _loc2_;
               _todayAlertText.text = LanguageMgr.GetTranslation("room.instanceRight.todayAlertText.skyStep");
            }
         }
         else
         {
            _optimzeText.visible = true;
            _optimzeValueText.visible = true;
            checkOptimizeProfile(_areaInfo.getMapByDifficult(_instanceHard).CampaignId);
            _contain1.visible = true;
            difficutlyCount = _areaInfo.getMapList().length;
            setBtnState();
         }
      }
      
      private function setBtnState() : void
      {
         if(_normalBtn)
         {
            ObjectUtils.disposeObject(_normalBtn);
         }
         _normalBtn = null;
         if(_difficultBtn)
         {
            ObjectUtils.disposeObject(_difficultBtn);
         }
         _difficultBtn = null;
         if(_hellBtn)
         {
            ObjectUtils.disposeObject(_hellBtn);
         }
         _hellBtn = null;
         _group.removeAllItem();
         switch(difficutlyCount - 1)
         {
            case 0:
               _normalBtn = ComponentFactory.Instance.creatComponentByStylename("room.RightInstance.NormalBtn1");
               break;
            case 1:
               _normalBtn = ComponentFactory.Instance.creatComponentByStylename("room.RightInstance.NormalBtn2");
               _difficultBtn = ComponentFactory.Instance.creatComponentByStylename("room.RightInstance.DifficultBtn2");
               break;
            case 2:
               _normalBtn = ComponentFactory.Instance.creatComponentByStylename("room.RightInstance.NormalBtn3");
               _difficultBtn = ComponentFactory.Instance.creatComponentByStylename("room.RightInstance.DifficultBtn3");
               _hellBtn = ComponentFactory.Instance.creatComponentByStylename("room.RightInstance.hellBtn3");
         }
         if(_normalBtn)
         {
            _contain1.addChild(_normalBtn);
            _normalBtn.enable = false;
            _group.addSelectItem(_normalBtn);
            _normalBtn.enable = checkExist(1);
         }
         if(_difficultBtn)
         {
            _contain1.addChild(_difficultBtn);
            _difficultBtn.enable = false;
            _group.addSelectItem(_difficultBtn);
            _difficultBtn.enable = checkExist(2) && _areaInfo.getMapByDifficult(1).state == 1;
         }
         if(_hellBtn)
         {
            _contain1.addChild(_hellBtn);
            _hellBtn.enable = false;
            _group.addSelectItem(_hellBtn);
            _hellBtn.enable = checkExist(3) && _areaInfo.getMapByDifficult(2).state == 1;
         }
         _group.selectIndex = 0;
      }
      
      private function checkExist(param1:int) : Boolean
      {
         if(!_areaInfo)
         {
            return false;
         }
         if(!_areaInfo.getMapByDifficult(param1))
         {
            return false;
         }
         return true;
      }
      
      private function checkOpen(param1:int) : Boolean
      {
         if(!checkExist(param1))
         {
            return false;
         }
         if(_areaInfo.getMapByDifficult(param1).state != 0)
         {
            return true;
         }
         return false;
      }
      
      private function checkOptimizeProfile(param1:int) : void
      {
         _optimzeValueText.text = gradeTextARR[0];
         for each(var _loc2_:RankInfo in rankInfoList)
         {
            if(_loc2_.campaignId == param1 && _loc2_.rank != 0)
            {
               _optimzeValueText.text = gradeTextARR[_loc2_.rank];
            }
         }
      }
      
      public function set selectedAreaInfo(param1:CampaignAreaInfo) : void
      {
         _areaInfo = param1;
         __upDateView();
      }
      
      public function get normalBtn() : SelectedButton
      {
         return _normalBtn;
      }
      
      public function get okBtn() : BaseButton
      {
         return _okBtn;
      }
      
      public function get isSeectedInstance() : Boolean
      {
         return !(!_areaInfo || !_areaInfo.getMapByDifficult(_instanceHard));
      }
      
      public function get rankInfoList() : SimpleDictionary
      {
         return CampaignRankManager.instance.rankDic;
      }
      
      private function disoposeContiner(param1:Sprite) : void
      {
         ObjectUtils.disposeAllChildren(param1);
         ObjectUtils.disposeObject(param1);
         param1 = null;
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(_mapIcon)
         {
            _mapIcon.dispose();
         }
         _mapIcon = null;
         if(_iconBackMc)
         {
            ObjectUtils.disposeObject(_iconBackMc);
         }
         _iconBackMc = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_bgScale)
         {
            ObjectUtils.disposeObject(_bgScale);
         }
         _bgScale = null;
         if(_bg1)
         {
            ObjectUtils.disposeObject(_bg1);
         }
         _bg1 = null;
         if(_bg2)
         {
            ObjectUtils.disposeObject(_bg2);
         }
         _bg2 = null;
         if(_normalBtn)
         {
            ObjectUtils.disposeObject(_normalBtn);
         }
         _normalBtn = null;
         if(_difficultBtn)
         {
            ObjectUtils.disposeObject(_difficultBtn);
         }
         _difficultBtn = null;
         if(_hellBtn)
         {
            ObjectUtils.disposeObject(_hellBtn);
         }
         _hellBtn = null;
         if(_okBtn)
         {
            ObjectUtils.disposeObject(_okBtn);
         }
         _okBtn = null;
         if(_notesBitmapData)
         {
            ObjectUtils.disposeObject(_notesBitmapData);
         }
         _notesBitmapData = null;
         if(_fontBG)
         {
            ObjectUtils.disposeObject(_fontBG);
         }
         _fontBG = null;
         if(_optimzeText)
         {
            ObjectUtils.disposeObject(_optimzeText);
         }
         _optimzeText = null;
         if(_optimzeValueText)
         {
            ObjectUtils.disposeObject(_optimzeValueText);
         }
         _optimzeValueText = null;
         if(_todayAlertText)
         {
            ObjectUtils.disposeObject(_todayAlertText);
         }
         _todayAlertText = null;
         if(_todayLeftCount)
         {
            ObjectUtils.disposeObject(_todayLeftCount);
         }
         _todayLeftCount = null;
         if(_todayText)
         {
            ObjectUtils.disposeObject(_todayText);
         }
         _todayText = null;
         if(_goods)
         {
            _goods["dispose"]();
         }
         _goods = null;
         if(_difText)
         {
            ObjectUtils.disposeObject(_difText);
         }
         _difText = null;
         if(_recommendGrades)
         {
            ObjectUtils.disposeObject(_recommendGrades);
         }
         _recommendGrades = null;
         if(_areaNameTxt)
         {
            ObjectUtils.disposeObject(_areaNameTxt);
         }
         _areaNameTxt = null;
         if(_normalBtnII)
         {
            ObjectUtils.disposeObject(_normalBtnII);
         }
         _normalBtnII = null;
         if(_difficultBtnII)
         {
            ObjectUtils.disposeObject(_difficultBtnII);
         }
         _difficultBtnII = null;
         if(_normalBtnIII)
         {
            ObjectUtils.disposeObject(_normalBtnIII);
         }
         _normalBtnIII = null;
         if(_difficultBtnIII)
         {
            ObjectUtils.disposeObject(_difficultBtnIII);
         }
         _difficultBtnIII = null;
         if(_hellBtnIII)
         {
            ObjectUtils.disposeObject(_hellBtnIII);
         }
         _hellBtnIII = null;
         disoposeContiner(_contain1);
         disoposeContiner(_twoBtnGSP);
         disoposeContiner(_bloodyContain);
         disoposeContiner(_molongContain);
         disoposeContiner(_nalanContain);
         disoposeContiner(_tailaContain);
         disoposeContiner(_wasteContain);
         disoposeContiner(_sacristyContain);
         disoposeContiner(_skyStepContain);
         if(_group)
         {
            _group.dispose();
         }
         _group = null;
         _areaInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

