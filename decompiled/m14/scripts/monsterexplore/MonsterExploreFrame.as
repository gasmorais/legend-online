package monsterexplore
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import monsterexplore.item.MonsterExploreInfoItem;
   import monsterexplore.view.MonsterExploreBattleView;
   import monsterexplore.view.MonsterExploreBossRewardView;
   import monsterexplore.view.MonsterExploreMapView;
   import mvc.ModuleFrameInfo;
   import mvc.module.monsterexplore.MonsterExploreModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.MonsterExploreTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MonsterExploreManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.TokenAmountItem;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterExploreFrame extends Frame implements IManualSize
   {
      
      private var _border:MovieClip;
      
      private var _mapCon:Component;
      
      private var _mapShape:Bitmap;
      
      private var _mapView:MonsterExploreMapView;
      
      private var _battlView:MonsterExploreBattleView;
      
      private var _switchMonsterMc:MovieClip;
      
      private var _switchNodeMc:MovieClip;
      
      private var _nodeNameBack:Image;
      
      private var _nodeNameText:FilterFrameText;
      
      private var _bossCounText:FilterFrameText;
      
      private var _sweepText:FilterFrameText;
      
      private var _checkFallGoodsBtn:TextButton;
      
      private var _rewardView:MonsterExploreBossRewardView;
      
      private var _selectMonsterBtn:IconButton;
      
      private var _fastPassBtn:IconButton;
      
      private var _fastFightBtn:IconButton;
      
      private var _bossBtn:IconButton;
      
      private var _sweepBtn:IconButton;
      
      private var _headHbox:HBox;
      
      private var monsterList:Vector.<MonsterExploreInfoItem>;
      
      private var _rewardContiner:Component;
      
      private var _rewardBg:Bitmap;
      
      private var _rewardTextBit:Bitmap;
      
      private var _goldReward:TokenAmountItem;
      
      private var _expReward:TokenAmountItem;
      
      private var _expUpdateMc:MovieClip;
      
      private var _expText:FilterFrameText;
      
      private var monsterLen:int = 3;
      
      private var exploreTempInfo:MonsterExploreTempInfo;
      
      private var maxBossCount:int;
      
      private var _helpBtn:BaseButton;
      
      public function MonsterExploreFrame()
      {
         super();
         initView();
         initListView();
         addEvent();
         initTempInfo();
         MonsterExploreManager.instance.sendClientRequest(0);
      }
      
      private function initTempInfo() : void
      {
         exploreModel.initChatpterTempInfo();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,945,550);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatCustomObject("MonsterExmploreFrame.border");
         _selectMonsterBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.selectMonsterBtn");
         _fastPassBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.fastPassBtn");
         _sweepBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.SweepBtn");
         _fastFightBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.fastFightBtn");
         _bossBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.bossBtn");
         _headHbox = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.hbox");
         _rewardContiner = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.rewardContiner");
         _rewardBg = ComponentFactory.Instance.creatBitmap("asset.MonsterExmploreFrame.rewardBg");
         _rewardTextBit = ComponentFactory.Instance.creatBitmap("asset.MonsterExmploreFrame.rewardTextBit");
         _mapCon = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.MapContiner");
         _mapShape = ComponentFactory.Instance.creatBitmap("asset.MonsterExploreSelectPassFrame.MapShape");
         _mapView = ComponentFactory.Instance.creatCustomObject("MonsterExmploreFrame.mapView");
         _battlView = ComponentFactory.Instance.creatCustomObject("MonsterExmploreFrame.battlView");
         _switchMonsterMc = ComponentFactory.Instance.creatCustomObject("MonsterExmploreFrame.switchMonsterMc");
         _switchNodeMc = ComponentFactory.Instance.creatCustomObject("MonsterExmploreFrame.switchNodeMc");
         _nodeNameBack = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.nodeNameBack");
         _nodeNameText = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.nodeNameText");
         _bossCounText = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.bossCounText");
         _checkFallGoodsBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreNodeDetailView.checkFallGoodsBtn1");
         _sweepText = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.sweepText");
         _goldReward = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.goldReward");
         _expReward = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.expReward");
         _expText = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.expText");
         _expUpdateMc = ComponentFactory.Instance.creatCustomObject("MonsterExmploreFrame.expUpdateAsset");
         _expUpdateMc.container.addChild(_expText);
         _expUpdateMc.stop();
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterExmploreFrame.helpBtn");
         addToContent(_mapCon);
         addToContent(_border);
         addToContent(_headHbox);
         addToContent(_selectMonsterBtn);
         addToContent(_fastPassBtn);
         addToContent(_fastFightBtn);
         addToContent(_bossBtn);
         addToContent(_bossCounText);
         addToContent(_sweepText);
         addToContent(_battlView);
         addToContent(_switchMonsterMc);
         addToContent(_switchNodeMc);
         addToContent(_nodeNameBack);
         addToContent(_nodeNameText);
         addToContent(_rewardContiner);
         addToContent(_expUpdateMc);
         addToContent(_helpBtn);
         addToContent(_sweepBtn);
         addToContent(_checkFallGoodsBtn);
         _checkFallGoodsBtn.text = LanguageMgr.GetTranslation("selectcampaign.view.CampaignInfoView.checkFallGoodsBtn.text");
         _rewardView = ComponentFactory.Instance.creatCustomObject("MonsterExploreNodeDetailView.rewardView1");
         addToContent(_rewardView);
         _rewardView.visible = false;
         _sweepText.text = LanguageMgr.GetTranslation("mosterSweepFrame.desc");
         _rewardContiner.addChild(_rewardBg);
         _rewardContiner.addChild(_rewardTextBit);
         _rewardContiner.addChild(_goldReward);
         _rewardContiner.addChild(_expReward);
         _mapCon.addChild(_mapView);
         _mapCon.addChild(_mapShape);
         _battlView.mouseChildren = _battlView.mouseEnabled = false;
         _switchNodeMc.visible = false;
         _switchNodeMc.mouseChildren = _switchNodeMc.mouseEnabled = false;
         _switchMonsterMc.visible = false;
         _switchMonsterMc.mouseChildren = _switchMonsterMc.mouseEnabled = false;
         maxBossCount = ConfigInfoManager.instance.getMonsterExploreBossMaxCount();
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MonsterExploreInfoItem = null;
         monsterList = new Vector.<MonsterExploreInfoItem>();
         _loc2_ = monsterLen;
         while(_loc2_ > 0)
         {
            _loc1_ = new MonsterExploreInfoItem(_loc2_);
            _headHbox.addChild(_loc1_);
            monsterList.push(_loc1_);
            _loc2_--;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _selectMonsterBtn.addEventListener("click",__selectMonsterHandler);
         _fastPassBtn.addEventListener("click",__fastPassBtnHandler);
         _sweepBtn.addEventListener("click",__sweepBtnHandler);
         _checkFallGoodsBtn.addEventListener("click",__checkFallGoodsHandler);
         MsgMan.addObserver("MOPUP_BOSS_INFO",this,__mopupBossInfoHandler);
         _fastFightBtn.addEventListener("click",__fastFightBtnHandler);
         _bossBtn.addEventListener("click",__bossClickHandler);
         _helpBtn.addEventListener("click",__helpBtnHandler);
         MsgMan.addObserver("FORMATION_SERVER_BACK",this,__formationMonsterHandler);
         MsgMan.addObserver("BATTLE_INFO_CHANGE",this,__battleInfoHandler);
         MsgMan.addObserver("USER_INFO_CHANGE",this,__battleUserInfoHandler);
         MsgMan.addObserver("MONSTER_INFO_CHANGE",this,__monsterInfoChangeHandler);
         MsgMan.addObserver("EXPLORE_EXP_CHANGE",this,__minExpChangeHandler);
         MsgMan.addObserver("MOPUP_MAINSWEEP_OPEN",this,__monsterOpenHandler);
         MsgMan.addObserver("MOPUP_MAINSWEEP_CLOSE",this,__monsterCloseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _sweepBtn.removeEventListener("click",__sweepBtnHandler);
         if(_checkFallGoodsBtn)
         {
            _checkFallGoodsBtn.removeEventListener("click",__checkFallGoodsHandler);
         }
         MsgMan.removeObserver("MOPUP_BOSS_INFO",this,__mopupBossInfoHandler);
         MsgMan.removeObserver("MOPUP_MAINSWEEP_OPEN",this,__monsterOpenHandler);
         MsgMan.removeObserver("MOPUP_MAINSWEEP_CLOSE",this,__monsterCloseHandler);
         if(_selectMonsterBtn)
         {
            _selectMonsterBtn.removeEventListener("click",__selectMonsterHandler);
         }
         if(_fastPassBtn)
         {
            _fastPassBtn.removeEventListener("click",__fastPassBtnHandler);
         }
         if(_fastFightBtn)
         {
            _fastFightBtn.removeEventListener("click",__fastFightBtnHandler);
         }
         if(_bossBtn)
         {
            _bossBtn.removeEventListener("click",__bossClickHandler);
         }
         MsgMan.removeObserver("FORMATION_SERVER_BACK",this,__formationMonsterHandler);
         MsgMan.removeObserver("BATTLE_INFO_CHANGE",this,__battleInfoHandler);
         MsgMan.removeObserver("USER_INFO_CHANGE",this,__battleUserInfoHandler);
         MsgMan.removeObserver("MONSTER_INFO_CHANGE",this,__monsterInfoChangeHandler);
         MsgMan.removeObserver("EXPLORE_EXP_CHANGE",this,__minExpChangeHandler);
      }
      
      private function __monsterOpenHandler(param1:String, param2:Object) : void
      {
         MsgMan.removeObserver("MOPUP_BOSS_INFO",this,__mopupBossInfoHandler);
      }
      
      private function __monsterCloseHandler(param1:String, param2:Object) : void
      {
         MsgMan.addObserver("MOPUP_BOSS_INFO",this,__mopupBossInfoHandler);
      }
      
      private function __mopupBossInfoHandler(param1:String, param2:Object) : void
      {
         var _loc3_:MonsterExploreTempInfo = TempleteManager.instance.monsterExploreTemplateCate.getTemplateByChapterAndNode(exploreModel.maxChapterId,exploreModel.maxNodeId);
         FrameControllerManager.instance.openControllerByInfo("monsterexplore","WIN_REWARD_FRAME",_loc3_.NodeName);
      }
      
      private function __minExpChangeHandler(param1:String, param2:Object) : void
      {
         var msg:String = param1;
         var obj:Object = param2;
         var expObj:Object = obj;
         if(!expObj || expObj.type != 0)
         {
            return;
         }
         _expText.htmlText = "+" + expObj.exp + " EXP";
         _expUpdateMc.addFrameScript(_expUpdateMc.totalFrames - 1,function():void
         {
            _expUpdateMc.stop();
            _expText.text = "";
         });
         _expUpdateMc.gotoAndPlay(1);
      }
      
      private function __monsterInfoChangeHandler(param1:String, param2:Object) : void
      {
         refreshMonsterView();
      }
      
      private function __checkFallGoodsHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = int((TempleteManager.instance.monsterExploreTemplateCate.getTemplateByChapterAndNode(exploreModel.maxChapterId,exploreModel.maxNodeId) as MonsterExploreTempInfo).BossDrop);
         var _loc3_:Array = TempleteManager.instance.monsterExploreDropTempCate.getTemplatesByDropId(_loc2_);
         if(_loc3_)
         {
            _rewardView.data = _loc3_;
         }
         SoundManager.instance.play("022");
         _rewardView.visible = !_rewardView.visible;
      }
      
      private function __formationMonsterHandler(param1:String, param2:Object) : void
      {
         refreshMonsterView();
      }
      
      private function __battleInfoHandler(param1:String, param2:Object) : void
      {
         if(_battlView)
         {
            _battlView.refreshView(true);
         }
      }
      
      private function __battleUserInfoHandler(param1:String, param2:Object) : void
      {
         refreshExploreView();
         var _loc3_:int = 0;
         setSwitchMcState(exploreModel.isEditSwitch,_switchMonsterMc);
         setSwitchMcState(exploreModel.isNodeSwitch,_switchNodeMc);
         if(exploreModel.isEditSwitch && Boolean(exploreModel.isNodeSwitch))
         {
            _switchMonsterMc.x = 240;
            _switchNodeMc.x = 725;
         }
         else if(exploreModel.isEditSwitch)
         {
            _switchMonsterMc.x = 490;
         }
         else if(exploreModel.isNodeSwitch)
         {
            _switchNodeMc.x = 490;
         }
         if(exploreModel.curNodeId == 0 && exploreModel.curNodeId == 0)
         {
            _sweepBtn.visible = false;
            _checkFallGoodsBtn.visible = false;
            _sweepText.visible = false;
         }
         else
         {
            _sweepBtn.visible = true;
            _checkFallGoodsBtn.visible = true;
            _sweepText.visible = true;
         }
      }
      
      private function setSwitchMcState(param1:Boolean, param2:MovieClip) : void
      {
         if(param1)
         {
            param2.visible = true;
            param2.gotoAndPlay(1);
         }
         else
         {
            param2.visible = false;
            param2.stop();
         }
      }
      
      private function __selectMonsterHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("monsterexplore","FORMATION_FRAME");
      }
      
      private function __fastPassBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("monsterexplore","SELECT_PASS_FRAME");
      }
      
      private function __sweepBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = int(ConfigInfoManager.instance.getMonsterExploreBossMaxCount());
         var _loc3_:int = _loc2_ - exploreModel.bossHasCount;
         if(_loc3_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterExploreNodeDetailView.leftCount.text"));
            return;
         }
         var _loc4_:MonsterSweepFrame = ComponentFactory.Instance.creatComponentByStylename("core.MonsterSweepFrame");
         _loc4_.data = {
            "num":_loc3_,
            "ChapterId":exploreModel.maxChapterId,
            "NodeId":exploreModel.maxNodeId
         };
         _loc4_.show();
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("kingcontract");
         }
      }
      
      private function __fastFightBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("monsterexplore","FAST_FIGHT_FRAME");
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("monsterexplore.MonsterExploreFrame.helpFrame");
         _loc2_.show();
      }
      
      private function __bossClickHandler(param1:MouseEvent) : void
      {
         if(exploreModel.exploreMonsterDic.getList().length < 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterExploreFrame.challengeBoss.noMonsterAlert"));
            return;
         }
         if(!exploreModel.canChallengeBoss())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterExploreFrame.challengeBoss.noCaptainAlert"));
            return;
         }
         MonsterExploreManager.instance.sendClientRequest(5);
      }
      
      private function refreshMonsterView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MonsterExploreInfoItem = null;
         _loc2_ = monsterLen;
         while(_loc2_ > 0)
         {
            _loc1_ = monsterList[monsterLen - _loc2_];
            _loc1_.data = exploreModel.getHeadFormationInfoByIndex(_loc2_);
            _loc2_--;
         }
      }
      
      private function refreshExploreView() : void
      {
         exploreTempInfo = TempleteManager.instance.monsterExploreTemplateCate.getTemplateByChapterAndNode(exploreModel.curChapterId,exploreModel.curNodeId);
         if(!exploreTempInfo)
         {
            return;
         }
         if(_mapView)
         {
            _mapView.initMapView();
         }
         _goldReward.firstText = exploreTempInfo.MinuteGold + "";
         _expReward.firstText = exploreTempInfo.MinuteExp + "";
         _nodeNameText.text = exploreTempInfo.NodeName;
         var _loc1_:int = maxBossCount - exploreModel.bossHasCount;
         _bossCounText.text = LanguageMgr.GetTranslation("MonsterExploreFrame.challengeBoss.rewardCount",_loc1_,maxBossCount);
         SoundManager.instance.playMusic("battle",int(exploreTempInfo.FightMapPath));
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get exploreModel() : MonsterExploreModel
      {
         return MonsterExploreManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(SceneManager.instance.currentType == "CASTLE_SCENE")
         {
            SoundManager.instance.playMusic("castle",0);
         }
         else
         {
            SoundManager.instance.playMusic("space",0);
         }
         MonsterExploreManager.instance.sendClientRequest(1);
         ObjectUtils.disposeViolentMc(_border);
         _border = null;
         ObjectUtils.disposeObject(_mapCon);
         _mapCon = null;
         ObjectUtils.disposeObject(_mapShape);
         _mapShape = null;
         ObjectUtils.disposeObject(_selectMonsterBtn);
         _selectMonsterBtn = null;
         ObjectUtils.disposeObject(_fastPassBtn);
         _fastPassBtn = null;
         ObjectUtils.disposeObject(_fastFightBtn);
         _fastFightBtn = null;
         ObjectUtils.disposeObject(_bossBtn);
         _bossBtn = null;
         ObjectUtils.disposeObject(_headHbox);
         _headHbox = null;
         ObjectUtils.disposeObject(_rewardContiner);
         _rewardContiner = null;
         ObjectUtils.disposeObject(_rewardBg);
         _rewardBg = null;
         ObjectUtils.disposeObject(_nodeNameBack);
         _nodeNameBack = null;
         ObjectUtils.disposeObject(_nodeNameText);
         _nodeNameText = null;
         ObjectUtils.disposeObject(_mapView);
         _mapView = null;
         ObjectUtils.disposeObject(_expText);
         _expText = null;
         LogicUtils.disposeDisplayCollection(monsterList);
         monsterList = null;
         ObjectUtils.disposeObject(_goldReward);
         _goldReward = null;
         ObjectUtils.disposeObject(_expReward);
         _expReward = null;
         ObjectUtils.disposeObject(_rewardTextBit);
         _rewardTextBit = null;
         ObjectUtils.disposeObject(_battlView);
         _battlView = null;
         ObjectUtils.disposeViolentMc(_switchMonsterMc);
         _switchMonsterMc = null;
         ObjectUtils.disposeViolentMc(_switchNodeMc);
         _switchNodeMc = null;
         ObjectUtils.disposeViolentMc(_expUpdateMc);
         _expUpdateMc = null;
         ObjectUtils.disposeObject(_bossCounText);
         _bossCounText = null;
         ObjectUtils.disposeObject(_sweepText);
         _sweepText = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_checkFallGoodsBtn);
         _checkFallGoodsBtn = null;
         ObjectUtils.disposeObject(_rewardView);
         _rewardView = null;
         super.dispose();
      }
   }
}

