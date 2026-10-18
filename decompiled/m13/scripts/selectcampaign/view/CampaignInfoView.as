package selectcampaign.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.SelectCampaignEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.MopupManager;
   import mvc.module.selectcampaign.SelectCampaignModel;
   import net.SingWarSocketSendManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.RankInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.CampaignRankManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class CampaignInfoView extends Sprite implements Disposeable
   {
      
      private var _back1:MovieClip;
      
      private var _mapMask:ScaleBitmapImage;
      
      private var _mapIcon:BaseIconView;
      
      private var _mapNameIcon:BaseIconView;
      
      private var _goods:FallGoodsView;
      
      private var _optimizeTxt:ScaleBitmapImage;
      
      private var _optimizeProfile:ScaleFrameImage;
      
      private var _normalBtn:SelectedIconButton;
      
      private var _heroBtn:SelectedIconButton;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _startBtn:BaseButton;
      
      private var _mopupBtnSprite:StripView;
      
      private var _mopupBtn:BaseButton;
      
      private var _checkFallGoodsBtn:TextButton;
      
      private var _info9CornerBg:Scale9CornerImage;
      
      private var _closeBtn:BaseButton;
      
      public function CampaignInfoView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creat("asset.selectCP.CampaignInfoBackMc");
         _info9CornerBg = ComponentFactory.Instance.creatComponentByStylename("core.CampaignInfoView.9CornerBg");
         _mapMask = ComponentFactory.Instance.creatComponentByStylename("selectCP.mapMask.back");
         _normalBtn = ComponentFactory.Instance.creatComponentByStylename("selecteCP.NormalBtn");
         _heroBtn = ComponentFactory.Instance.creatComponentByStylename("selecteCP.HeroBtn");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("selecteCP.StartBtn");
         _mopupBtnSprite = ComponentFactory.Instance.creatCustomObject("selecteCP.MopupBtnStripView");
         _mopupBtn = ComponentFactory.Instance.creatComponentByStylename("selecteCP.MopupBtn");
         _mapIcon = ComponentFactory.Instance.creatCustomObject("selecteCP.MapIcon",[loadComplete]);
         _mapNameIcon = ComponentFactory.Instance.creatCustomObject("selecteCP.MapNameBmp",[loadNameComplete]);
         _optimizeTxt = ComponentFactory.Instance.creatComponentByStylename("selecteCP.ProfileTxt");
         _optimizeProfile = ComponentFactory.Instance.creatComponentByStylename("selecteCP.Profile");
         _checkFallGoodsBtn = ComponentFactory.Instance.creatComponentByStylename("selecteCP.checkFallGoodsBtn");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("campaignInfoView.CloseBtn");
         _goods = new FallGoodsView();
         _goods.x = 30;
         _goods.y = 192;
         _back1.y = 62;
         _mopupBtnSprite.addChild(_mopupBtn);
         addChild(_goods);
         addChild(_back1);
         addChild(_info9CornerBg);
         addChild(_mapIcon);
         addChild(_mapNameIcon);
         addChild(_mapMask);
         addChild(_optimizeTxt);
         addChild(_optimizeProfile);
         addChild(_normalBtn);
         addChild(_heroBtn);
         addChild(_startBtn);
         addChild(_mopupBtnSprite);
         addChild(_checkFallGoodsBtn);
         addChild(_closeBtn);
         _checkFallGoodsBtn.text = LanguageMgr.GetTranslation("selectcampaign.view.CampaignInfoView.checkFallGoodsBtn.text");
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(_normalBtn);
         _buttonGroup.addSelectItem(_heroBtn);
         _goods.visible = false;
         _optimizeTxt.visible = false;
         _optimizeProfile.visible = false;
         if(ArmyManager.instance.thane.grades < 20)
         {
            _mopupBtn.enable = false;
            _mopupBtnSprite.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",20);
         }
         else
         {
            _mopupBtn.enable = true;
         }
      }
      
      public function tipsGotoFrame(param1:int) : void
      {
         _back1.gotoAndStop(param1);
      }
      
      private function loadComplete(param1:BaseIconView = null) : void
      {
         (_mapIcon.content as Bitmap).smoothing = false;
      }
      
      private function loadNameComplete(param1:BaseIconView = null) : void
      {
         (_mapNameIcon.content as Bitmap).smoothing = false;
      }
      
      private function initEvent() : void
      {
         _buttonGroup.addEventListener("change",__selectedChangeHandler);
         _startBtn.addEventListener("click",__clickHandler);
         _mopupBtn.addEventListener("click",__mopupHandler);
         model.addEventListener("SELECTED_AREA_CHANGE",__selectedAreaChangeHandler);
         _checkFallGoodsBtn.addEventListener("click",__checkFallGoodsHandler);
         _closeBtn.addEventListener("click",__onCloseBtnClick);
         _normalBtn.addEventListener("click",__normalBtnClick);
         _heroBtn.addEventListener("click",__normalBtnClick);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4192,__createFailHandler);
      }
      
      private function removeEvent() : void
      {
         if(_buttonGroup)
         {
            _buttonGroup.removeEventListener("change",__selectedChangeHandler);
         }
         if(_startBtn)
         {
            _startBtn.removeEventListener("click",__clickHandler);
         }
         if(_mopupBtn)
         {
            _mopupBtn.removeEventListener("click",__mopupHandler);
         }
         if(model)
         {
            model.removeEventListener("SELECTED_AREA_CHANGE",__selectedAreaChangeHandler);
         }
         if(_checkFallGoodsBtn)
         {
            _checkFallGoodsBtn.removeEventListener("click",__checkFallGoodsHandler);
         }
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__onCloseBtnClick);
         }
         if(_normalBtn)
         {
            _normalBtn.removeEventListener("click",__normalBtnClick);
         }
         if(_heroBtn)
         {
            _heroBtn.removeEventListener("click",__normalBtnClick);
         }
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4192,__createFailHandler);
      }
      
      protected function __normalBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
      }
      
      protected function __onCloseBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         this.visible = false;
      }
      
      private function __createFailHandler(param1:SLGSocketEvent) : void
      {
      }
      
      private function __checkFallGoodsHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _goods.visible = !_goods.visible;
      }
      
      private function clean() : void
      {
         _buttonGroup.selectIndex = -1;
         _optimizeProfile.setFrame(6);
         _mapIcon.icon = null;
         _mapNameIcon.icon = null;
         _goods["data"] = "";
      }
      
      private function __selectedAreaChangeHandler(param1:SelectCampaignEvent) : void
      {
         var _loc2_:CampaignTemplate = null;
         var _loc3_:Boolean = false;
         clean();
         if(model.selectedArea == null)
         {
            return;
         }
         _loc2_ = model.selectedArea.getMapByDifficult(1);
         if(CampaignRankManager.instance.rankDic[_loc2_.CampaignId] && CampaignRankManager.instance.rankDic[_loc2_.CampaignId].rank >= 5)
         {
            _loc3_ = true;
         }
         _normalBtn.enable = !!model.normalMap;
         _heroBtn.enable = !!model.heroMap && _loc3_;
         if(_normalBtn.enable == false || _normalBtn.selected == false)
         {
            _normalBtn.alpha = 0.5;
         }
         if(_heroBtn.enable == false || _heroBtn.selected == false)
         {
            _heroBtn.alpha = 0.5;
         }
         if(model.isNormalOpen() && Boolean(model.isHeroOpen()) && Boolean(_heroBtn.enable))
         {
            _buttonGroup.selectIndex = 1;
            _heroBtn.alpha = 1;
         }
         else if(model.isNormalOpen())
         {
            _buttonGroup.selectIndex = 0;
            _normalBtn.alpha = 1;
         }
         if(model.taskCampaignTem)
         {
            _buttonGroup.selectIndex = model.taskCampaignTem.DifficultyGrade - 1;
            _buttonGroup.getSelectedItem().alpha = 1;
            model.taskCampaignTem = null;
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(FreedomTeamManager.instance.hasTeam)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.WarlordsManager.str04"));
            return;
         }
         SoundManager.instance.play("022");
         var _loc2_:String = "";
         if(model.selectedArea == null)
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.instance.InstanceRightView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(model.selectCampaign == null)
         {
            _loc2_ = LanguageMgr.GetTranslation("room.view.pve.instance.InstanceRightView.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(showThewAlert())
         {
            return;
         }
         SingWarSocketSendManager.sendStartCampaignScene(model.selectCampaign.CampaignId,1);
      }
      
      private function __mopupHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(!model.selectCampaign)
         {
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.weary < 20)
         {
            _loc2_ = LanguageMgr.GetTranslation("selectcampaign.view.CampaignInfoView.noWeary");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mopup.MopupManager.noMopupAlert"));
            return;
         }
         MopupManager.instance.model.campaignId = model.selectCampaign.CampaignId;
         FrameControllerManager.instance.openControllerByInfo("mopup",1);
      }
      
      private function showThewAlert() : Boolean
      {
         var _loc8_:TodayNotAlertFrame = null;
         var _loc7_:String = null;
         var _loc2_:String = null;
         var _loc3_:Boolean = PlayerManager.instance.currentPlayerModel.playerInfo.weary < 20;
         var _loc4_:Date = SharedManager.instance.thewCheckDate;
         var _loc5_:Date = new Date();
         var _loc1_:Boolean = false;
         var _loc6_:Boolean = Boolean(SharedManager.instance.thewCheck);
         if(!_loc6_ || _loc4_.month <= _loc5_.month && _loc4_.date < _loc5_.date)
         {
            _loc1_ = true;
         }
         if(_loc3_ && _loc1_)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("core.CampaignNoWearyFrame");
            _loc8_.showNoWeary(useWeary);
            _loc8_.containerY = 18;
            if(model.selectCampaign.DifficultyGrade == 2)
            {
               _loc7_ = LanguageMgr.GetTranslation("selectcampaign.view.CampaignInfoView.countContent");
            }
            else
            {
               _loc7_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist04");
            }
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc8_.show(_loc7_,_loc2_,alerrBack,null,"left",1,true);
         }
         return _loc3_ && _loc1_;
      }
      
      private function useWeary() : void
      {
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:Boolean = false;
         var _loc1_:Array = [2030503,2030502,2030501,2030500];
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            if(GoodsManager.instance.getGoodsNumByTempId(_loc1_[_loc4_]) > 0)
            {
               _loc6_ = true;
               _loc7_ = int(_loc1_[_loc4_]);
               break;
            }
            _loc4_++;
         }
         if(_loc6_)
         {
            _loc3_ = int(GoodsManager.instance.findPosById(_loc7_));
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc7_);
            if(_loc2_.Property1 == 5 && _loc2_.Property2 > 0)
            {
               _loc5_ = int(_loc2_.Property2);
               _loc8_ = 1;
               if(!checkWearyCanGet(_loc5_,_loc3_,_loc8_))
               {
                  return;
               }
               if(!checkWearyTodayCanGet(_loc5_,_loc3_,_loc8_))
               {
                  return;
               }
            }
            SocketSendManager.instance.sendUseItem(_loc3_);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.view.frame.TodayNotAlertFrame.noWearyPromptTips"));
         }
      }
      
      private function checkWearyCanGet(param1:int, param2:int, param3:int = 1) : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc6_:int = 200 - playerInfo.weary;
         if(param1 > _loc6_)
         {
            SimpleAlertHelper.instance.data = [wearyCanGetCallBack,param1,param2,param3];
            _loc4_ = LanguageMgr.GetTranslation("public.confirm");
            _loc5_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("map.campaign.view.frame.SubmitResourcesFrame.titleTextTip");
            _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command07",_loc6_);
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc4_,_loc5_,true,true,true);
            return false;
         }
         return true;
      }
      
      private function checkWearyTodayCanGet(param1:int, param2:int, param3:int = 1) : Boolean
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc6_:int = 600 - playerInfo.wearyLimit;
         if(param1 > _loc6_)
         {
            SimpleAlertHelper.instance.data = [wearyTodayCanGetCallBack,param1,param2,param3,true];
            _loc4_ = LanguageMgr.GetTranslation("public.confirm");
            _loc5_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("map.campaign.view.frame.SubmitResourcesFrame.titleTextTip");
            _loc8_ = LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerBagCellClickMediator.command06",600,_loc6_);
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc4_,_loc5_,true,true,true);
            return false;
         }
         return true;
      }
      
      private function wearyCanGetCallBack(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:int = 1) : void
      {
         if(param1)
         {
            if(checkWearyTodayCanGet(param3,param4,param5))
            {
               SocketSendManager.instance.sendUseItem(param4,param5);
            }
         }
      }
      
      private function wearyTodayCanGetCallBack(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:int = 1, param6:Boolean = false) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendUseItem(param4,param5);
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function alerrBack(param1:Boolean) : void
      {
         SharedManager.instance.thewCheck = param1;
         SharedManager.instance.thewCheckDate = new Date();
         SharedManager.instance.saveThewCheck();
         SingWarSocketSendManager.sendStartCampaignScene(model.selectCampaign.CampaignId,1);
      }
      
      private function __selectedChangeHandler(param1:Event) : void
      {
         var _loc2_:CampaignTemplate = null;
         if(!_buttonGroup.getSelectedItem() || !model.selectedArea)
         {
            return;
         }
         if(_buttonGroup.getSelectedItem() == _normalBtn)
         {
            _loc2_ = model.selectedArea.getMapByDifficult(1);
            if(_loc2_)
            {
               model.selectCampaign = _loc2_;
            }
         }
         else if(_buttonGroup.getSelectedItem() == _heroBtn)
         {
            _loc2_ = model.selectedArea.getMapByDifficult(2);
            if(_loc2_)
            {
               model.selectCampaign = _loc2_;
            }
         }
         if(_normalBtn.enable == false || _normalBtn.selected == false)
         {
            _normalBtn.alpha = 0.5;
            _heroBtn.alpha = 1;
         }
         if(_heroBtn.enable == false || _heroBtn.selected == false)
         {
            _normalBtn.alpha = 1;
            _heroBtn.alpha = 0.5;
         }
         refreshMapView(_loc2_);
      }
      
      private function refreshMapView(param1:CampaignTemplate) : void
      {
         _mapIcon.icon = PathManager.mapInstanceBigIconPath(param1.CampaignId);
         _mapNameIcon.icon = PathManager.mapInstanceRoomName(param1.CampaignId);
         if(param1.state == 1)
         {
            _mopupBtn.visible = true;
         }
         else
         {
            _mopupBtn.visible = false;
         }
         _goods.data = param1.Item;
         for each(var _loc2_:RankInfo in rankInfoList)
         {
            if(_loc2_.campaignId == param1.CampaignId)
            {
               _optimizeProfile.setFrame(_loc2_.rank);
            }
         }
      }
      
      private function get rankInfoList() : SimpleDictionary
      {
         return CampaignRankManager.instance.rankDic;
      }
      
      private function get model() : SelectCampaignModel
      {
         return FrameControllerManager.instance.selectCampaignControler.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get mopupBtn() : BaseButton
      {
         return _mopupBtn;
      }
      
      public function get startBtn() : BaseButton
      {
         return _startBtn;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeViolentMc(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_heroBtn);
         _heroBtn = null;
         ObjectUtils.disposeObject(_normalBtn);
         _normalBtn = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_goods);
         _goods = null;
         ObjectUtils.disposeObject(_mapIcon);
         _mapIcon = null;
         ObjectUtils.disposeObject(_mapNameIcon);
         _mapNameIcon = null;
         ObjectUtils.disposeObject(_mapMask);
         _mapMask = null;
         ObjectUtils.disposeObject(_optimizeTxt);
         _optimizeTxt = null;
         ObjectUtils.disposeObject(_optimizeProfile);
         _optimizeProfile = null;
         ObjectUtils.disposeObject(_buttonGroup);
         _buttonGroup = null;
         ObjectUtils.disposeObject(_checkFallGoodsBtn);
         _checkFallGoodsBtn = null;
         ObjectUtils.disposeObject(_info9CornerBg);
         _info9CornerBg = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         ObjectUtils.disposeObject(_mopupBtn);
         _mopupBtn = null;
         ObjectUtils.disposeObject(_mopupBtnSprite);
         _mopupBtnSprite = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

