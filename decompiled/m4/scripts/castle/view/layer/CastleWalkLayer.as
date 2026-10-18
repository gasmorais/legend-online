package castle.view.layer
{
   import castle.view.CastleBuildingView;
   import castle.view.CastleNPCView;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.CatHouseManager;
   import managers.PerkinLabManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.MineralCarInfo;
   import mvc.module.buildings.BuildInfo;
   import org.events.DictionaryEvent;
   import utils.LogicUtils;
   import yishi.ai.AiPlayerConfig;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.PlayerEvent;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IBuildingFilter;
   import yishi.interfaces.ICheck;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.CampaignRankManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.MagicPubManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.WaterTreeTipInfo;
   
   public class CastleWalkLayer extends Sprite implements Disposeable, IEnterFrame
   {
      
      private static const jobFilter:Object = {
         "1":[1441,2441],
         "2":[1441,2441],
         "3":[1442,2442],
         "4":[1441,2441],
         "5":[1441,2441],
         "6":[1442,2442]
      };
      
      private var _buildingsDic:Dictionary;
      
      public var _viewList:Array;
      
      private var _buildingFilter:IBuildingFilter;
      
      private var _config:AiPlayerConfig;
      
      private var _mediatorKey:String;
      
      private var _nameLayer:CastleNameLayer;
      
      private var _hasSeminary:Boolean;
      
      private var _seminaryStrip:StripView;
      
      private var _filter:UIFilter;
      
      private var _hasOperEffects:Vector.<MovieClip>;
      
      private var _levyHasOperEffect:MovieClip;
      
      private var _labGainsHasOperEffect:MovieClip;
      
      private var _labRobGainsHasOperEffect:MovieClip;
      
      private var _mazeHasOperEffect:MovieClip;
      
      private var _exploreHasOperEffect:MovieClip;
      
      private var _homeGainsHasOperEffect:MovieClip;
      
      private var _catHouseGainsHasOperEffect:MovieClip;
      
      private var _seminaryGainsHasOperEffect:MovieClip;
      
      private var _npcDic:Dictionary;
      
      private var count:int = 0;
      
      public function CastleWalkLayer(param1:CastleNameLayer)
      {
         super();
         _filter = new UIFilter();
         _nameLayer = param1;
         initAIConfig();
         initBuild();
         initWalker();
         initView();
         initEvent();
      }
      
      private function initAIConfig() : void
      {
         _config = new AiPlayerConfig();
         _viewList = [];
         _npcDic = new Dictionary(true);
         _buildingsDic = new Dictionary(true);
         _buildingFilter = new SimpleBuildingFilter();
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function initBuild() : void
      {
         var _loc1_:* = null;
         var _loc2_:SimpleDictionary = BuildingManager.instance.model.buildingListByID;
         for each(_loc1_ in _loc2_)
         {
            if(!(_loc1_.templeteInfo.MasterType == 13 || _loc1_.templeteInfo.MasterType == 14))
            {
               updateBuildingView(_loc1_);
            }
         }
         initClientBuild();
      }
      
      public function updateBuildingView(param1:BuildInfo) : void
      {
         var _loc3_:BuildingTempInfo = param1.templeteInfo;
         var _loc2_:CastleBuildingView = _buildingsDic[param1.buildingId] as CastleBuildingView;
         if(param1.sonType == 1511)
         {
            return;
         }
         if(_loc2_)
         {
            _loc2_.x = param1.templeteInfo.PosX;
            _loc2_.y = param1.templeteInfo.PosY;
            _loc2_.buildingLevelUpdated(parent.scaleX);
            _loc2_.buildingInfo = param1;
         }
         else
         {
            if(_loc3_.SonType == 501)
            {
               _hasSeminary = true;
               ObjectUtils.disposeAllChildren(_seminaryStrip);
               ObjectUtils.disposeObject(_seminaryStrip);
               _seminaryStrip = null;
            }
            _loc2_ = new CastleBuildingView(_buildingFilter,_nameLayer);
            _loc2_.buttonMode = true;
            _loc2_.x = param1.templeteInfo.PosX;
            _loc2_.y = param1.templeteInfo.PosY;
            _loc2_.buildingInfo = param1;
            _viewList.push(_loc2_);
            _buildingsDic[param1.buildingId] = _loc2_;
         }
      }
      
      private function updateClientBuild(param1:BuildInfo) : void
      {
         var _loc2_:CastleBuildingView = new CastleBuildingView(_buildingFilter,_nameLayer);
         _loc2_.buttonMode = true;
         _loc2_.x = param1.templeteInfo.PosX;
         _loc2_.y = param1.templeteInfo.PosY;
         _loc2_.buildingInfo = param1;
         _viewList.push(_loc2_);
         _buildingsDic[param1.buildingId] = _loc2_;
      }
      
      private function initClientBuild() : void
      {
         createSeminary();
         createTransferBuild();
         createTree();
         createMazeBuild();
         createMagicHotel();
         createPerkinLab();
      }
      
      private function createSeminary() : void
      {
         var _loc4_:Bitmap = null;
         var _loc1_:ScaleBitmapImage = null;
         var _loc2_:FilterFrameText = null;
         var _loc3_:WaterTreeTipInfo = null;
         if(_hasSeminary)
         {
            return;
         }
         if(!_seminaryStrip)
         {
            _seminaryStrip = ComponentFactory.Instance.creatCustomObject("castle.SeminaryStripView");
            _loc4_ = ComponentFactory.Instance.creatBitmap("asset.castle.SeminaryAsset");
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("castle.NameBack2");
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("castle.BuildNameTxt2");
            _loc2_.text = LanguageMgr.GetTranslation("HigherGradeOpenTipView.content10");
            _loc1_.width = _loc2_.textWidth + 12;
            _buildingFilter.setGrayFilter(_loc4_);
            _seminaryStrip.addChild(_loc4_);
            _seminaryStrip.addChild(_loc1_);
            _loc1_.x = 52;
            _loc1_.y = 310;
            _seminaryStrip.addChild(_loc2_);
            _loc2_.x = 57;
            _loc2_.y = 314;
            addChild(_seminaryStrip);
            _loc3_ = new WaterTreeTipInfo();
            _loc3_.title = LanguageMgr.GetTranslation("HigherGradeOpenTipView.content10");
            _loc3_.content = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",18);
            _seminaryStrip.tipData = _loc3_;
         }
      }
      
      private function createTransferBuild() : void
      {
         var _loc1_:BuildInfo = null;
         if(!_buildingsDic[-11])
         {
            _loc1_ = BuildingManager.instance.model.buildingListByID[-11];
            if(_loc1_)
            {
               updateClientBuild(_loc1_);
            }
         }
         else
         {
            CastleBuildingView(_buildingsDic[-11]).updateShowFilter();
         }
      }
      
      private function createMagicHotel() : void
      {
         var _loc1_:BuildInfo = null;
         if(!_buildingsDic[-28])
         {
            _loc1_ = new BuildInfo();
            _loc1_.buildingId = -28;
            _loc1_.templateId = 160101;
            BuildingManager.instance.model.addBuildInfo(_loc1_);
            updateClientBuild(_loc1_);
         }
         else
         {
            CastleBuildingView(_buildingsDic[-28]).updateShowFilter();
         }
      }
      
      private function createPerkinLab() : void
      {
         var _loc1_:BuildInfo = null;
         if(!_buildingsDic[-29])
         {
            _loc1_ = new BuildInfo();
            _loc1_.buildingId = -29;
            _loc1_.templateId = 170101;
            BuildingManager.instance.model.addBuildInfo(_loc1_);
            updateClientBuild(_loc1_);
         }
         else
         {
            CastleBuildingView(_buildingsDic[-29]).updateShowFilter();
         }
      }
      
      private function createTree() : void
      {
         var _loc1_:BuildInfo = null;
         if(!_buildingsDic[-9])
         {
            _loc1_ = new BuildInfo();
            _loc1_.buildingId = -9;
            _loc1_.templateId = 150901;
            BuildingManager.instance.model.addBuildInfo(_loc1_);
            updateClientBuild(_loc1_);
         }
         else
         {
            CastleBuildingView(_buildingsDic[-9]).updateShowFilter();
         }
      }
      
      private function createMazeBuild() : void
      {
         var _loc1_:BuildInfo = null;
         if(!_buildingsDic[-7])
         {
            _loc1_ = new BuildInfo();
            _loc1_.buildingId = -7;
            _loc1_.templateId = 150701;
            BuildingManager.instance.model.addBuildInfo(_loc1_);
            updateClientBuild(_loc1_);
         }
         else
         {
            CastleBuildingView(_buildingsDic[-7]).updateShowFilter();
         }
      }
      
      private function initWalker() : void
      {
         var _loc1_:String = PathManager.resourcePath + "swf/castle/npc/castleNpc.swf";
         LoaderManagerII.instance.load(_loc1_,3,8,__onComplete);
      }
      
      private function __onComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(!_buildingsDic)
         {
            return;
         }
         createNPCByType(4);
      }
      
      private function createCampaignNpc() : void
      {
         if(CampaignRankManager.instance.rankDic[1001])
         {
            createNPCByType(2);
         }
         if(CampaignRankManager.instance.rankDic[1005])
         {
            createNPCByType(3);
         }
         if(CampaignRankManager.instance.rankDic[1106])
         {
            createNPCByType(1);
         }
      }
      
      private function createBuildNpc() : void
      {
         var _loc1_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(1506);
         if(_loc1_)
         {
            createNPCByType(5);
         }
         _loc1_ = BuildingManager.instance.getBuildingInfoBySonType(1504);
         if(_loc1_)
         {
            createNPCByType(6);
         }
         _loc1_ = BuildingManager.instance.getBuildingInfoBySonType(1510);
         if(_loc1_)
         {
            createNPCByType(7);
         }
         _loc1_ = BuildingManager.instance.getBuildingInfoBySonType(101);
         if(_loc1_)
         {
            createNPCByType(8);
         }
      }
      
      private function createNPCByType(param1:int) : void
      {
         if(_npcDic[param1])
         {
            return;
         }
         var _loc4_:MovieClip = getMovieByDirectionAndType(1,param1);
         var _loc5_:MovieClip = getMovieByDirectionAndType(2,param1);
         var _loc6_:MovieClip = getMovieByDirectionAndType(3,param1);
         var _loc3_:MovieClip = getMovieByDirectionAndType(4,param1);
         var _loc2_:MovieClip = getMovieByDirectionAndType(5,param1);
         var _loc7_:CastleNPCView = new CastleNPCView(_loc4_,_loc5_,_loc6_,_loc3_,_loc2_);
         var _loc8_:AIBaseInfo = new AIBaseInfo();
         _loc8_.speed = 0.7;
         _loc8_.pathInfo = _config.getPathByType(param1);
         _loc7_.info = _loc8_;
         _loc7_.type = param1;
         _loc7_.specialPoint = _config.getSpecialByType(param1);
         _loc7_.x = _loc8_.pathInfo[0].x;
         _loc7_.y = _loc8_.pathInfo[0].y;
         _npcDic[param1] = _loc7_;
         _viewList.push(_loc7_);
      }
      
      private function getMovieByDirectionAndType(param1:int, param2:int) : MovieClip
      {
         if(param2 == 4 || param2 == 8 || param2 == 7)
         {
            if(param1 == 1 || param1 == 2 || param1 == 4)
            {
               return null;
            }
         }
         return ComponentFactory.Instance.creat("asset.castle.Npc_" + param1 + "_" + param2);
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DisplayObject = null;
         _loc2_ = 0;
         while(_loc2_ < _viewList.length)
         {
            _loc1_ = _viewList[_loc2_] as DisplayObject;
            addChild(_loc1_);
            _loc2_++;
         }
         initBubbles();
      }
      
      private function initEvent() : void
      {
         CampaignRankManager.instance.rankDic.addEventListener("addDictionary",__campaignRankAddHandler);
         thane.addEventListener("THANE_LEVEL_UPDATE",__levelUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         CampaignRankManager.instance.rankDic.removeEventListener("addDictionary",__campaignRankAddHandler);
         thane.removeEventListener("THANE_LEVEL_UPDATE",__levelUpdateHandler);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      private function __levelUpdateHandler(param1:PlayerEvent) : void
      {
         initClientBuild();
         refreshBubbles();
      }
      
      private function __campaignRankAddHandler(param1:DictionaryEvent) : void
      {
      }
      
      private function upgradeDepth(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:DisplayObject = null;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1[_loc3_]["obj"] as DisplayObject;
            if(!_loc2_.parent || getChildIndex(_loc2_) != _loc3_)
            {
               addChild(_loc2_);
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _hasOperEffects.length)
         {
            addChild(_hasOperEffects[_loc3_]);
            _loc3_++;
         }
         refreshBubbles();
      }
      
      public function enterFrame() : void
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ICheck in _viewList)
         {
            _loc1_.push({
               "obj":_loc2_,
               "x":_loc2_.checkRect.x,
               "y":_loc2_.checkRect.y
            });
            if(_loc2_ is CastleNPCView)
            {
               (_loc2_ as CastleNPCView).execute();
            }
         }
         _loc1_ = _loc1_.sort(checkDepth);
         upgradeDepth(_loc1_);
         _loc1_.splice(0,_loc1_.length);
         _loc1_ = null;
      }
      
      private function checkDepth(param1:Object, param2:Object) : int
      {
         var _loc3_:int = int(param1.y);
         var _loc4_:int = int(param2.y);
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return -1;
      }
      
      private function initBubbles() : void
      {
         _hasOperEffects = new Vector.<MovieClip>();
         _levyHasOperEffect = getEffectMcByImage("castle.gold",453,135);
         _labRobGainsHasOperEffect = getEffectMcByImage("castle.rob",122,283);
         _labGainsHasOperEffect = getEffectMcByImage("castle.dye",222,283);
         _mazeHasOperEffect = getEffectMcByImage("castle.maze",390,440);
         _exploreHasOperEffect = getEffectMcByImage("castle.magicHotel",614,442);
         _homeGainsHasOperEffect = getEffectMcByImage("castle.pick",1130,190);
         _catHouseGainsHasOperEffect = getEffectMcByImage("castle.catHouse",1130,190);
         _seminaryGainsHasOperEffect = getEffectMcByImage("castle.seminary",790,145);
      }
      
      private function getEffectMcByImage(param1:String, param2:int, param3:int) : MovieClip
      {
         var _loc4_:MovieClip = ComponentFactory.Instance.creatCustomObject("castle.HasOperEffect");
         _loc4_["box"].addChild(ComponentFactory.Instance.creatComponentByStylename(param1));
         _loc4_.visible = false;
         _loc4_.mouseChildren = _loc4_.mouseEnabled = false;
         _loc4_.x = param2;
         _loc4_.y = param3;
         _hasOperEffects.push(_loc4_);
         return _loc4_;
      }
      
      public function refreshBubbles() : void
      {
         checkBubbleVisable(_levyHasOperEffect,canLevy());
         checkBubbleVisable(_labGainsHasOperEffect,canLabGains());
         checkBubbleVisable(_labRobGainsHasOperEffect,canLabRob());
         checkBubbleVisable(_mazeHasOperEffect,canMaze());
         checkBubbleVisable(_exploreHasOperEffect,canExplore());
         checkBubbleVisable(_homeGainsHasOperEffect,canHomeGains());
         checkBubbleVisable(_catHouseGainsHasOperEffect,canCatHouseGains());
         checkBubbleVisable(_seminaryGainsHasOperEffect,canSeminary());
      }
      
      private function checkBubbleVisable(param1:MovieClip, param2:Boolean) : void
      {
         if(!param1 || !_filter)
         {
            return;
         }
         if(param2)
         {
            _filter.setNormalFilter(param1);
            param1.play();
            param1.visible = true;
         }
         else
         {
            param1.gotoAndStop(1);
            param1.visible = false;
         }
      }
      
      private function canLevy() : Boolean
      {
         var _loc1_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(901);
         if(_loc1_ && _loc1_.property2 - _loc1_.property1 > 0 && thane.grades >= 14)
         {
            return _loc1_.property2 - _loc1_.property1 > 0;
         }
         return false;
      }
      
      private function canLabGains() : Boolean
      {
         return thane.vocationGrades > 0 && Boolean(PerkinLabManager.instance.checkHasPick);
      }
      
      private function canLabRob() : Boolean
      {
         if(thane.vocationGrades <= 0)
         {
            return false;
         }
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("perkin_lab_rob_count");
         var _loc2_:int = int(_loc1_.ConfigValue) - PerkinLabManager.instance.model.robCount;
         return _loc2_ > 0;
      }
      
      private function get selfCarInfo() : MineralCarInfo
      {
         return CampaignManager.instance.mineralModel.selfCarInfo;
      }
      
      private function canMaze() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:int = currentPlayerModel.towerInfo1.freeEnterCount - currentPlayerModel.towerInfo1.enterCount;
         var _loc3_:int = currentPlayerModel.towerInfo2.maxEnterCount - currentPlayerModel.towerInfo2.freeEnterCount;
         if(currentPlayerModel.towerInfo2.enterCount >= currentPlayerModel.towerInfo2.freeEnterCount)
         {
            _loc2_ = currentPlayerModel.towerInfo2.maxEnterCount - currentPlayerModel.towerInfo2.enterCount;
         }
         else
         {
            _loc2_ = currentPlayerModel.towerInfo2.maxEnterCount - currentPlayerModel.towerInfo2.freeEnterCount;
         }
         var _loc4_:int = currentPlayerModel.towerInfo3.maxEnterCount - currentPlayerModel.towerInfo3.freeEnterCount;
         if(currentPlayerModel.towerInfo3.enterCount >= currentPlayerModel.towerInfo3.freeEnterCount)
         {
            _loc1_ = currentPlayerModel.towerInfo3.maxEnterCount - currentPlayerModel.towerInfo3.enterCount;
         }
         else
         {
            _loc1_ = currentPlayerModel.towerInfo3.maxEnterCount - currentPlayerModel.towerInfo3.freeEnterCount;
         }
         return _loc5_ > 0 && _loc5_ <= currentPlayerModel.towerInfo1.freeEnterCount || _loc2_ > 0 && _loc2_ <= _loc3_ && currentPlayerModel.towerInfo2.campaignId >= 0 || _loc1_ > 0 && _loc1_ <= _loc4_ && currentPlayerModel.playerInfo.vocationGrades > 0;
      }
      
      private function canSeminary() : Boolean
      {
         var _loc2_:* = null;
         var _loc4_:BuildingTempInfo = null;
         var _loc5_:Array = BuildingManager.instance.model.buildingListByID.getList();
         var _loc1_:int = 0;
         for each(_loc2_ in _loc5_)
         {
            if(_loc2_.templeteInfo.MasterType == 5)
            {
               _loc1_ = int(_loc2_.templeteInfo.BuildingGrade);
               break;
            }
         }
         if(_loc1_ == 0)
         {
            return false;
         }
         var _loc3_:int = int(ResourceManager.instance.waterCrystal.count);
         if(jobFilter[thane.job])
         {
            for each(_loc2_ in _loc5_)
            {
               if(jobFilter[thane.job].indexOf(_loc2_.templeteInfo.SonType) != -1)
               {
                  _loc4_ = _loc2_.templeteInfo.nextTemp;
                  if(_loc4_)
                  {
                     if(_loc3_ >= _loc4_.CrystalsConsume)
                     {
                        return true;
                     }
                  }
               }
            }
         }
         return false;
      }
      
      private function getNextGrade(param1:BuildingTempInfo) : BuildingTempInfo
      {
         if(param1.NextGradeTemplateId != 0)
         {
            return TempleteManager.instance.buildTemplateCate.getTemplateByID(int(param1.NextGradeTemplateId));
         }
         return null;
      }
      
      private function get currentPlayerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function canExplore() : Boolean
      {
         if(thane.grades < 32)
         {
            return false;
         }
         return MagicPubManager.instance.canChatCount() > 0;
      }
      
      private function canHomeGains() : Boolean
      {
         return FarmManager.instance.checkHasPick > 0;
      }
      
      private function canCatHouseGains() : Boolean
      {
         return CatHouseManager.instance.getCattoysHarvestCount() > 0;
      }
      
      public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onComplete);
         removeEvent();
         for(var _loc2_:String in _npcDic)
         {
            ObjectUtils.disposeObject(_npcDic[_loc2_]);
            _npcDic[_loc2_] = null;
            delete _npcDic[_loc2_];
         }
         LogicUtils.disposeDisplayCollection(_buildingsDic);
         _buildingsDic = null;
         for each(var _loc1_:Object in _viewList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _viewList.length = 0;
         var _loc3_:SimpleDictionary = BuildingManager.instance.model.buildingListByID;
         for each(var _loc4_:BuildInfo in _loc3_)
         {
            if(_loc4_.templeteInfo)
            {
               ObjectUtils.disposeObject(_loc4_.templeteInfo.view);
               ObjectUtils.disposeObject(_loc4_.templeteInfo.effect);
               _loc4_.templeteInfo.view = null;
               _loc4_.templeteInfo.effect = null;
            }
         }
         ObjectUtils.disposeObject(_seminaryStrip);
         _seminaryStrip = null;
         _nameLayer = null;
         _viewList = null;
         _npcDic = null;
         _config = null;
         _filter = null;
         if(_buildingFilter)
         {
            _buildingFilter.dispose();
         }
         _buildingFilter = null;
         ObjectUtils.disposeViolentMc(_levyHasOperEffect);
         _levyHasOperEffect = null;
         ObjectUtils.disposeViolentMc(_labGainsHasOperEffect);
         _labGainsHasOperEffect = null;
         ObjectUtils.disposeViolentMc(_labRobGainsHasOperEffect);
         _labRobGainsHasOperEffect = null;
         ObjectUtils.disposeViolentMc(_mazeHasOperEffect);
         _mazeHasOperEffect = null;
         ObjectUtils.disposeViolentMc(_exploreHasOperEffect);
         _exploreHasOperEffect = null;
         ObjectUtils.disposeViolentMc(_homeGainsHasOperEffect);
         _homeGainsHasOperEffect = null;
         ObjectUtils.disposeViolentMc(_catHouseGainsHasOperEffect);
         _catHouseGainsHasOperEffect = null;
         ObjectUtils.disposeViolentMc(_seminaryGainsHasOperEffect);
         _seminaryGainsHasOperEffect = null;
         LogicUtils.disposeDisplayCollection(_hasOperEffects);
         _hasOperEffects = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get buildingsDic() : Dictionary
      {
         return _buildingsDic;
      }
   }
}

