package map.campaign.view.physics.physicsview
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.PvpWarFightModel;
   import map.campaign.data.skill.MapSkillHurtData;
   import map.campaign.data.skill.MapSkillResultInfo;
   import map.campaign.helper.hero.CampaignArmyViewHelper;
   import map.campaign.mediator.npcai.NpcArriveMediator;
   import map.campaign.mediator.npcai.PlayerArriveMediator;
   import map.campaign.view.CampaignMapView;
   import map.campaign.view.physics.GroupfbTrapMovie;
   import map.campaign.view.skill.MapHurtView;
   import map.campaign.view.ui.secretland.ConsortiaTreeExpView;
   import map.internals.constant.NodeState;
   import map.internals.constant.SimpleNodeColorTransform;
   import map.internals.data.CampaignNode;
   import map.internals.data.MapPhysics;
   import map.internals.data.PhysicsEvent;
   import map.internals.data.SnowVehicleDropInfo;
   import map.internals.view.physics.MapPhysicsAttackingBase;
   import yishi.datas.templates.VehicleSkillBuffTemplate;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TaskManage;
   import yishi.manager.TempleteManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tools.SimpleMovie;
   
   public class CampaignNpcView extends MapPhysicsAttackingBase
   {
      
      public static const NAME:String = "map.campaign.view.physics.physicsview.CampaignNpcView";
      
      private static var colorTransform:SimpleNodeColorTransform = new SimpleNodeColorTransform();
      
      private var _mediatorKey:String;
      
      private var _npcName:FilterFrameText;
      
      private var _bloodMc:MovieClip;
      
      private var _bloodTxt:FilterFrameText;
      
      private var _nameBg:ScaleBitmapImage;
      
      private var _hasOperEffect:MovieClip;
      
      private var _givePowerImg:Bitmap;
      
      private var _pickImg:Bitmap;
      
      private var _treeExpView:ConsortiaTreeExpView;
      
      private var _occupyMovie:MovieClip;
      
      private var _pvpMapModel:PvpWarFightModel = CampaignManager.instance.pvpWarFightModel;
      
      private var _mapTopLayer:Sprite = (CampaignManager.instance.mapView as CampaignMapView).topUILayer;
      
      private var _effectLayer:Sprite = (CampaignManager.instance.mapView as CampaignMapView).effectLayer;
      
      public var node:CampaignNode;
      
      private var _bloodTween:TweenMax;
      
      private var _givePowerEffect:SimpleMovie;
      
      private var _parent:DisplayObjectContainer;
      
      private var _trapMovie:GroupfbTrapMovie;
      
      private var towerAttackMc:MovieClip;
      
      public function CampaignNpcView()
      {
         super(1);
      }
      
      override public function set info(param1:MapPhysics) : void
      {
         node = param1 as CampaignNode;
         super.info = param1;
         initMediator();
         param1.info.addEventListener("UP_STATE",__updateNodeStateHandler);
         param1.addEventListener("_visitUserIds",__updateVisitUserIdHandler);
         param1.addEventListener("UPDATE_CUR_HP",__updateCurHpHandler);
         param1.addEventListener("MOVE_POS",__movePosHandler);
         param1.addEventListener("PARA_1",__para1Handler);
         param1.addEventListener("UPDATA_MAP_PHYSICS",__updateNodeHandler);
         if(CampaignArmyViewHelper.checkGroupfbAttackNode(param1 as CampaignNode))
         {
            param1.addEventListener("USE_SKILL",__onUseSkillHandler);
         }
         else if(WorldBossHelper.checkGroupfb(CampaignManager.instance.mapId))
         {
            layouCallBack();
         }
         else if(CampaignArmyViewHelper.checkSnowVehicleTowerNode(param1 as CampaignNode))
         {
            param1.addEventListener("USE_SKILL",__onTowerUseSkillHandler);
         }
         if(CampaignArmyViewHelper.checkTreeNode(param1 as CampaignNode))
         {
            if(!_nameBg)
            {
               _nameBg = ComponentFactory.Instance.creatComponentByStylename("campaign.ConsortiaTreeNameBg");
            }
            addChild(_nameBg);
            if(!_treeExpView)
            {
               _treeExpView = ComponentFactory.Instance.creatCustomObject("campaign.ConsortiaTreeExpView");
            }
            addChild(_treeExpView);
            if(!_hasOperEffect)
            {
               _hasOperEffect = ComponentFactory.Instance.creatCustomObject("campaign.HasOperEffect");
            }
            if(!_givePowerImg)
            {
               _givePowerImg = ComponentFactory.Instance.creatBitmap("asset.campaign.WaterStateImg");
            }
            if(!_pickImg)
            {
               _pickImg = ComponentFactory.Instance.creatBitmap("asset.campaign.PickStateImg");
            }
            ConsortiaManager.instance.model.secretInfo.addEventListener("TREE_STATE_UPDATE",__consortiaTreeStateUpdateHandler);
            refreshTreeViewByState();
         }
         if(CampaignArmyViewHelper.checkFlameTempleEnergyGapNode(node))
         {
            if(!_occupyMovie)
            {
               _occupyMovie = ComponentFactory.Instance.creat("asset.flametemple.ProgressBar");
            }
            _occupyMovie.progress.gotoAndStop(31);
            _occupyMovie.mouseEnabled = false;
            _occupyMovie.progress.mouseChildren = _occupyMovie.progress.mouseEnabled = false;
            _occupyMovie.x = this.x;
            _occupyMovie.y = this.y;
            _mapTopLayer.addChild(_occupyMovie);
         }
         if(CampaignArmyViewHelper.checkNewbieVillageTransNode(param1 as CampaignNode))
         {
            TaskManage.instance.cate.addEventListener("task_added",__updateNewbieVillageTransHandler);
            TaskManage.instance.addEventListener("task_detail_change",__updateNewbieVillageTransHandler);
         }
         if(CampaignArmyViewHelper.checkSteelBirthNode(param1 as CampaignNode))
         {
            if(WorldBossHelper.checkUnrealShooting(mapId))
            {
               buttonMode = mouseEnabled = mouseChildren = false;
            }
         }
         __updateNodeStateHandler(null);
         __updateVisitUserIdHandler(null);
         __updateCurHpHandler(null);
         checkShowVehicleTip();
      }
      
      override protected function __onDannayHandler(param1:PhysicsEvent) : void
      {
         var _loc3_:MapSkillHurtData = null;
         var _loc2_:MapHurtView = null;
         super.__onDannayHandler(param1);
         if(param1.data is MapSkillHurtData)
         {
            _loc3_ = param1.data as MapSkillHurtData;
            _loc2_ = new MapHurtView(_loc3_.effectValue,_loc3_.effectType);
            _loc2_.y = -70;
            if(moviePos)
            {
               _loc2_.y = moviePos.y;
            }
            _loc2_.x += this.x;
            _loc2_.y += this.y;
            _effectLayer.addChild(_loc2_);
         }
      }
      
      override protected function initView() : void
      {
         var _loc4_:Array = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         super.initView();
         _npcName || (_npcName = ComponentFactory.Instance.creatComponentByStylename("campaign.map.NpcNameTxt"));
         if(info.info.names != "")
         {
            if(info as CampaignNode)
            {
               _loc4_ = [4801,4802,4803];
               _loc1_ = int((info as CampaignNode).sonType);
               _loc3_ = _loc4_.indexOf(_loc1_);
               if(_loc3_ != -1)
               {
                  _npcName.text = LanguageMgr.GetTranslation("RapidView.colorTxt" + (info as CampaignNode).param1) + info.info.names;
               }
               else
               {
                  _npcName.text = info.info.names;
               }
            }
            else
            {
               _npcName.text = info.info.names;
            }
         }
         _npcName.x = -_npcName.width / 2;
         _npcName.selectable = _npcName.mouseEnabled = _npcName.mouseWheelEnabled = false;
         var _loc5_:int = int((info as CampaignNode).nameColor);
         _loc5_ = int(_loc5_ == 0 ? 1 : _loc5_);
         if(WorldBossHelper.checkDuskArea(mapId) || Boolean(WorldBossHelper.checkIceFireTemple(mapId)))
         {
            _loc5_ = duskAreaNameColor();
         }
         else if(WorldBossHelper.checkUnrealShooting(mapId))
         {
            _loc5_ = unrealShootingNameColor();
         }
         if(WorldBossHelper.checkGodsEvening(mapId))
         {
            if((info as CampaignNode).param1 == 1)
            {
               _loc5_ = 5;
            }
            else if((info as CampaignNode).param1 == 2)
            {
               _loc5_ = 1;
            }
            else
            {
               _loc5_ = 3;
            }
         }
         updateNameText();
         _npcName.setFrame(_loc5_);
         if(info.info.types == 1001)
         {
            _npcName.x = -110;
            _npcName.y = -90;
            addChild(_npcName);
         }
         var _loc2_:CampaignNode = info as CampaignNode;
         if(_loc2_)
         {
            if(_loc2_.sonType == 4803)
            {
               _npcName.x = -110;
               _npcName.y = -110;
               addChild(_npcName);
            }
            if(info.info.types == 53 && _loc2_.sonType == 10070)
            {
               _npcName.x = -110;
               _npcName.y = -110;
               addChild(_npcName);
            }
            if(info.info.types == 61 && _loc2_.sonType == 10069)
            {
               _npcName.x = -110;
               _npcName.y = -110;
               addChild(_npcName);
            }
            if(info.info.types == 1001)
            {
               if(_npcName.text == "Grande Fogueira")
               {
                  _npcName.x = -45;
               }
            }
         }
      }
      
      private function steelNameColor() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 2;
         if(WorldBossHelper.checkSteel(mapId))
         {
            _loc1_ = int((info as CampaignNode).param1);
            if(_loc1_ == 1)
            {
               _loc2_ = 1;
            }
            else if(_loc1_ == 2)
            {
               _loc2_ = 5;
            }
         }
         return _loc2_;
      }
      
      private function duskAreaNameColor() : int
      {
         var _loc1_:int = 2;
         if((WorldBossHelper.checkDuskArea(mapId) || Boolean(WorldBossHelper.checkIceFireTemple(mapId))) && int((info as CampaignNode).param1) != 0)
         {
            _loc1_ = (info as CampaignNode).param1 == 1 ? 1 : 5;
         }
         return _loc1_;
      }
      
      private function unrealShootingNameColor() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 2;
         if(WorldBossHelper.checkUnrealShooting(mapId))
         {
            _loc1_ = int((info as CampaignNode).param1);
            if(_loc1_ == 1)
            {
               _loc2_ = 1;
            }
            else if(_loc1_ == 2)
            {
               _loc2_ = 5;
            }
            else
            {
               _loc2_ = 2;
            }
         }
         return _loc2_;
      }
      
      private function initMediator() : void
      {
         if(!info || !info.info)
         {
            return;
         }
         var _loc1_:Array = [];
         switch(int(info.info.types) - 141)
         {
            case 0:
               _loc1_.push(NpcArriveMediator);
         }
         if(CampaignArmyViewHelper.checkFlameTempleEnergyGapNode(info as CampaignNode))
         {
            _loc1_.push(PlayerArriveMediator);
         }
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.campaign.view.physics.physicsview.CampaignNpcView");
      }
      
      private function updateNameText() : void
      {
         var _loc3_:Array = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!_npcName)
         {
            return;
         }
         if(info as CampaignNode)
         {
            _loc3_ = [4801,4802,4803];
            _loc1_ = int((info as CampaignNode).sonType);
            _loc2_ = _loc3_.indexOf(_loc1_);
            if(_loc2_ != -1)
            {
               _npcName.text = LanguageMgr.GetTranslation("RapidView.colorTxt" + (info as CampaignNode).param1) + info.info.names;
            }
            else
            {
               _npcName.text = info.info.names;
            }
         }
         else
         {
            _npcName.text = info.info.names;
         }
      }
      
      protected function __updateCurHpHandler(param1:PhysicsEvent) : void
      {
         updateNameText();
         if(node.curHp == 0 || node.totalHp == 0)
         {
            if(_bloodMc)
            {
               if(_bloodMc.parent)
               {
                  _bloodMc.parent.removeChild(_bloodMc);
               }
               _bloodMc.stop();
            }
            if(_bloodTxt)
            {
               _bloodTxt.removeFromParent();
            }
            return;
         }
         if(!_bloodMc)
         {
            if(WorldBossHelper.checkDuskArea(mapId) || Boolean(WorldBossHelper.checkIceFireTemple(mapId)))
            {
               _bloodMc = ComponentFactory.Instance.creatCustomObject("asset.campaign.gvg.NodeBloodAsset");
               _bloodTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.gvg.BloodValueTxt");
            }
            else
            {
               _bloodMc = ComponentFactory.Instance.creatCustomObject("asset.campaign.map.BloodAsset");
               _bloodMc.y = _bloodMc.height;
            }
         }
         addChild(_bloodMc);
         _bloodMc.play();
         var _loc2_:int = node.curHp * 100 / node.totalHp;
         _bloodMc.bloodMc.gotoAndStop(_loc2_);
         if(_bloodMc.bufferBar)
         {
            if(_bloodTween)
            {
               _bloodTween.currentProgress = 1;
            }
            _bloodTween = TweenMax.to(_bloodMc.bufferBar,0.4,{
               "delay":0.6,
               "frame":_loc2_,
               "onComplete":killBloodMaskTweens
            });
         }
         if(_bloodTxt)
         {
            addChild(_bloodTxt);
            _bloodTxt.text = node.curHp + " / " + node.totalHp;
         }
         layouCallBack();
      }
      
      private function killBloodMaskTweens() : void
      {
         if(_bloodTween)
         {
            _bloodTween.kill();
            _bloodTween = null;
         }
      }
      
      private function get mapId() : int
      {
         return CampaignManager.instance.mapModel.mapId;
      }
      
      private function __para1Handler(param1:PhysicsEvent) : void
      {
         if(WorldBossHelper.checkDuskArea(mapId) || Boolean(WorldBossHelper.checkIceFireTemple(mapId)))
         {
            _npcName.setFrame(duskAreaNameColor());
         }
      }
      
      private function __movePosHandler(param1:PhysicsEvent) : void
      {
         x = info.x;
         y = info.y;
      }
      
      private function __updateVisitUserIdHandler(param1:PhysicsEvent) : void
      {
         if(visitUserId)
         {
            info.info.state = 8;
         }
      }
      
      private function get visitUserId() : Boolean
      {
         var _loc1_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.userId);
         if((info as CampaignNode).visitUserIds)
         {
            if((info as CampaignNode).visitUserIds.indexOf(_loc1_) != -1)
            {
               return true;
            }
         }
         return false;
      }
      
      protected function __updateNodeStateHandler(param1:PhysicsEvent) : void
      {
         if(visitUserId && info.info.state != 8)
         {
            info.info.state = 8;
            return;
         }
         switch(info.info.state)
         {
            case 2:
            case 1:
            case 4:
            case 16:
            case 17:
            case 19:
            case 20:
               initView();
               setNomalView();
               __para1Handler(null);
               this.gotoAndPlayCall(NodeState.getStateValue(info.info.state));
               if(!parent && _parent)
               {
                  _parent.addChild(this);
               }
               break;
            case 0:
               setClearView();
               break;
            case 8:
            case 9:
               if(parent)
               {
                  _parent = parent;
                  parent.removeChild(this);
               }
         }
         __updateNewbieVillageTransHandler(null);
      }
      
      private function __updateNewbieVillageTransHandler(param1:Event) : void
      {
         if(CampaignArmyViewHelper.checkNewbieVillageTransNode(info as CampaignNode))
         {
            this.visible = TaskManage.instance.cate.hasTaskAndNotCompleted(CampaignNode(info).param1);
            if(_movie)
            {
               _movie.gotoAndStop(1);
            }
         }
      }
      
      private function __consortiaTreeStateUpdateHandler(param1:ConsortiaEvent) : void
      {
         switch(int(ConsortiaManager.instance.model.secretInfo.oper) - 1)
         {
            case 0:
               disposeTreeOperEffect();
               showGivePowerEffect();
         }
         refreshTreeViewByState();
      }
      
      private function refreshTreeViewByState() : void
      {
         var _loc1_:DisplayObject = null;
         clearHasOperEffect();
         switch(int(ConsortiaManager.instance.model.secretInfo.treeState) - 1)
         {
            case 0:
               _loc1_ = _givePowerImg;
         }
         if(!_loc1_)
         {
            return;
         }
         _hasOperEffect.gotoAndStop(1);
         _hasOperEffect["box"].addChild(_loc1_);
         _hasOperEffect.play();
         addChild(_hasOperEffect);
      }
      
      private function clearHasOperEffect() : void
      {
         if(_givePowerImg && _givePowerImg.parent)
         {
            _givePowerImg.parent.removeChild(_givePowerImg);
         }
         if(_pickImg && _pickImg.parent)
         {
            _pickImg.parent.removeChild(_pickImg);
         }
         if(_hasOperEffect)
         {
            _hasOperEffect.stop();
            if(_hasOperEffect.parent)
            {
               _hasOperEffect.parent.removeChild(_hasOperEffect);
            }
         }
      }
      
      private function clearTreeOperEffect() : void
      {
         _givePowerEffect = null;
      }
      
      private function disposeTreeOperEffect() : void
      {
         if(_givePowerEffect)
         {
            _givePowerEffect.dispose();
         }
         _givePowerEffect = null;
      }
      
      private function showGivePowerEffect() : void
      {
         SoundManager.instance.play("021");
         if(!_givePowerEffect)
         {
            _givePowerEffect = new SimpleMovie(ComponentFactory.Instance.creat("asset.campaign.WaterEffect"),clearTreeOperEffect);
         }
         _givePowerEffect.x = -27;
         _givePowerEffect.y = -160;
         addChild(_givePowerEffect);
      }
      
      override protected function setClearView() : void
      {
         setSwf();
      }
      
      override protected function get resourcesPath() : String
      {
         var _loc2_:String = null;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(info.info.types == 1001 || info.info.types == 1002)
         {
            _loc2_ = (info as CampaignNode).sonType.toString() + (info as CampaignNode).info.state;
            return PathManager.solveMapPhysicsBySonType(int(_loc2_));
         }
         var _loc6_:Array = [4801,4802,4803];
         var _loc4_:Array = ["1053","1043","1033"];
         if(info is CampaignNode)
         {
            _loc1_ = int((info as CampaignNode).sonType);
            _loc5_ = _loc6_.indexOf(_loc1_);
            if(_loc5_ != -1)
            {
               _loc3_ = parseInt(_loc4_[_loc5_] + (info as CampaignNode).param1);
               return PathManager.solveMapPhysicsBySonType(_loc3_);
            }
         }
         return PathManager.solveMapPhysicsBySonType((info as CampaignNode).sonType);
      }
      
      override protected function layouCallBack() : void
      {
         if(!_npcName)
         {
            return;
         }
         if(_isDispose)
         {
            return;
         }
         if(!moviePos && !WorldBossHelper.checkGroupfb(CampaignManager.instance.mapId))
         {
            return;
         }
         var _loc1_:Point = moviePos ? new Point(moviePos.x,moviePos.y) : new Point(0,0);
         _npcName.x = _loc1_.x - _npcName.width / 2;
         _npcName.y = _loc1_.y - 20;
         if(_isPlaying)
         {
            addChild(_npcName);
         }
         if(WorldBossHelper.checkDuskArea(mapId) || Boolean(WorldBossHelper.checkIceFireTemple(mapId)) || Boolean(WorldBossHelper.checkUnrealShooting(mapId)))
         {
            if(_bloodMc)
            {
               _bloodMc.x = _loc1_.x;
               _bloodMc.y = _loc1_.y + 100;
               _npcName.y = _bloodMc.y - 30;
               if(_bloodTxt)
               {
                  _bloodTxt.x = _bloodMc.x - 98;
                  _bloodTxt.y = _bloodMc.y - 9;
               }
            }
         }
         if(_occupyMovie)
         {
            _occupyMovie.y = this.y + _loc1_.y;
         }
      }
      
      private function __updateNodeHandler(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Component = null;
         var _loc3_:CampaignNode = param1.currentTarget as CampaignNode;
         if(!_loc3_)
         {
            return;
         }
         if(_occupyMovie && _occupyMovie.progress)
         {
            _loc4_ = int(_loc3_.tempData) + 1;
            if(_occupyMovie.progress.currentFrame != _loc4_)
            {
               _occupyMovie.progress.gotoAndStop(_loc4_);
            }
            _loc2_ = _occupyMovie.tipView;
            if(!_loc2_)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("campaignNpcView.tipView");
               _loc2_.graphics.clear();
               _loc2_.graphics.beginFill(0,0);
               _loc2_.graphics.drawRect(0,0,40,40);
               _loc2_.graphics.endFill();
               _occupyMovie.addChild(_loc2_);
               _occupyMovie.tipView = _loc2_;
            }
            if(_occupyMovie.progress.blue)
            {
               _loc2_.x = _occupyMovie.progress.blue.x;
               _loc2_.y = _occupyMovie.progress.blue.y;
               _loc2_.tipData = LanguageMgr.GetTranslation("campaignNpcView.occupyMovieTip",LanguageMgr.GetTranslation("blueTeam"));
            }
            else if(_occupyMovie.progress.red)
            {
               _loc2_.x = _occupyMovie.progress.red.x;
               _loc2_.y = _occupyMovie.progress.red.y;
               _loc2_.tipData = LanguageMgr.GetTranslation("campaignNpcView.occupyMovieTip",LanguageMgr.GetTranslation("redTeam"));
            }
            else
            {
               _loc2_.tipData = "";
            }
         }
      }
      
      override public function dispose() : void
      {
         tipData = null;
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         killBloodMaskTweens();
         disposeTreeOperEffect();
         if(_npcName)
         {
            if(_npcName.parent)
            {
               _npcName.parent.removeChild(_npcName);
            }
            _npcName.dispose();
         }
         _npcName = null;
         if(_givePowerImg)
         {
            if(_givePowerImg.parent)
            {
               _givePowerImg.parent.removeChild(_givePowerImg);
            }
            if(_givePowerImg.bitmapData)
            {
               _givePowerImg.bitmapData.dispose();
            }
            _givePowerImg.bitmapData = null;
            _givePowerImg = null;
         }
         if(_pickImg)
         {
            if(_pickImg.parent)
            {
               _pickImg.parent.removeChild(_pickImg);
            }
            if(_pickImg.bitmapData)
            {
               _pickImg.bitmapData.dispose();
            }
            _pickImg.bitmapData = null;
            _pickImg = null;
         }
         if(_hasOperEffect)
         {
            if(_hasOperEffect.parent)
            {
               _hasOperEffect.parent.removeChild(_hasOperEffect);
            }
            _hasOperEffect.stop();
            ObjectUtils.disposeViolentMc(_hasOperEffect);
            _hasOperEffect = null;
         }
         if(_nameBg)
         {
            _nameBg.dispose();
         }
         _nameBg = null;
         if(towerAttackMc)
         {
            ObjectUtils.disposeViolentMc(towerAttackMc);
         }
         towerAttackMc = null;
         if(_treeExpView)
         {
            _treeExpView.dispose();
         }
         _treeExpView = null;
         if(info)
         {
            info.info.removeEventListener("UP_STATE",__updateNodeStateHandler);
            info.removeEventListener("_visitUserIds",__updateVisitUserIdHandler);
            info.removeEventListener("UPDATE_CUR_HP",__updateCurHpHandler);
            info.removeEventListener("MOVE_POS",__movePosHandler);
            info.removeEventListener("PARA_1",__para1Handler);
            info.removeEventListener("USE_SKILL",__onTowerUseSkillHandler);
            info.removeEventListener("UPDATA_MAP_PHYSICS",__updateNodeHandler);
            if(info is CampaignNode)
            {
               info["nodeView"] = null;
            }
            if(info is CampaignNode)
            {
               info["preParent"] = null;
            }
         }
         ObjectUtils.disposeViolentMc(_occupyMovie);
         _occupyMovie = null;
         if(_bloodMc)
         {
            _bloodMc.stop();
            if(_bloodMc.parent)
            {
               _bloodMc.parent.removeChild(_bloodMc);
            }
            ObjectUtils.disposeViolentMc(_bloodMc);
         }
         _bloodMc = null;
         if(_bloodTxt)
         {
            if(_bloodTxt.parent)
            {
               _bloodTxt.parent.removeChild(_bloodTxt);
            }
            _bloodTxt.dispose();
         }
         _bloodTxt = null;
         _parent = null;
         ConsortiaManager.instance.model.secretInfo.removeEventListener("TREE_STATE_UPDATE",__consortiaTreeStateUpdateHandler);
         TaskManage.instance.cate.removeEventListener("task_added",__updateNewbieVillageTransHandler);
         TaskManage.instance.removeEventListener("task_detail_change",__updateNewbieVillageTransHandler);
         super.dispose();
         _pvpMapModel = null;
         _mapTopLayer = null;
         _effectLayer = null;
      }
      
      override public function set isPlaying(param1:Boolean) : void
      {
         super.isPlaying = param1;
         if(param1)
         {
            if(_npcName)
            {
               addChild(_npcName);
            }
         }
         else if(_npcName && _npcName.parent)
         {
            _npcName.parent.removeChild(_npcName);
         }
      }
      
      override public function showName(param1:Boolean) : void
      {
         if(_npcName)
         {
            _npcName.visible = param1;
         }
      }
      
      public function getHitPoint() : Point
      {
         var _loc1_:Point = new Point(this.x,this.y);
         if(moviePos)
         {
            _loc1_.y += moviePos.y + 80;
         }
         return _loc1_;
      }
      
      public function gotoAndPlay(param1:String, param2:int) : void
      {
         if(_movie && _movie.body)
         {
            for each(var _loc3_:FrameLabel in _movie.body.currentLabels)
            {
               if(_loc3_.name == param1)
               {
                  _movie.body.gotoAndPlay(param1);
                  _movie.body.scaleX = param2;
                  break;
               }
            }
         }
      }
      
      private function __onUseSkillHandler(param1:PhysicsEvent) : void
      {
         var _loc2_:MapSkillResultInfo = param1.data as MapSkillResultInfo;
         if(_loc2_)
         {
            if(_trapMovie)
            {
               _trapMovie.dispose();
            }
            _trapMovie = new GroupfbTrapMovie(_loc2_.attackType);
            if(parent)
            {
               parent.addChild(_trapMovie);
            }
            _trapMovie.x = this.x;
            _trapMovie.y = this.y;
         }
      }
      
      private function __onTowerUseSkillHandler(param1:PhysicsEvent) : void
      {
         var skillInfo:MapSkillResultInfo;
         var hurtData:MapSkillHurtData;
         var player:CampaignArmy;
         var npc:CampaignNode;
         var e:PhysicsEvent = param1;
         var skillResult:MapSkillResultInfo = e.data as MapSkillResultInfo;
         if(skillResult)
         {
            if(towerAttackMc)
            {
               ObjectUtils.disposeViolentMc(towerAttackMc);
            }
            towerAttackMc = ComponentFactory.Instance.creatCustomObject("snowVehicle.towerAttackMc");
            if(parent)
            {
               parent.addChild(towerAttackMc);
            }
            towerAttackMc.x = this.x;
            towerAttackMc.y = this.y;
            towerAttackMc.addFrameScript(towerAttackMc.totalFrames - 1,function():void
            {
               towerAttackMc.stop();
            });
            towerAttackMc.gotoAndPlay(1);
         }
         skillInfo = e.data as MapSkillResultInfo;
         if(skillInfo)
         {
            for each(hurtData in skillInfo.playerHurt)
            {
               player = model.getUserArmyByUserId(hurtData.effectId,hurtData.effectServiceName);
               if(player)
               {
                  player.beHurt(hurtData);
               }
            }
            for each(hurtData in skillInfo.npcHurt)
            {
               npc = model.getMapNodeByNodeId(hurtData.effectId);
               if(npc)
               {
                  npc.beHurt(hurtData);
               }
            }
         }
      }
      
      private function checkShowVehicleTip() : void
      {
         if(WorldBossHelper.checkActiveVehicle(CampaignManager.instance.mapId))
         {
            if(node && node.snowVehicleDrops && node.snowVehicleDrops.length > 0)
            {
               this.tipStyle = "yishi.view.tips.ActiveVehicleBoxTip";
               this.tipDirctions = "7,3,6,4,0,5";
               this.isFollowMouse = false;
               this.tipGapV = 0;
               this.tipGapH = 0;
               this.tipData = getDropTipsData();
            }
            else
            {
               this.tipStyle = null;
            }
         }
      }
      
      private function getDropTipsData() : Array
      {
         var _loc4_:SnowVehicleDropInfo = null;
         var _loc3_:int = 0;
         var _loc5_:VehicleSkillTempInfo = null;
         var _loc2_:VehicleSkillBuffTemplate = null;
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < node.snowVehicleDrops.length)
         {
            _loc4_ = node.snowVehicleDrops[_loc3_];
            if(_loc4_.type == 1)
            {
               _loc5_ = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_loc4_.tempId);
               if(_loc5_)
               {
                  _loc1_.push(_loc5_);
               }
            }
            else if(_loc4_.type == 2)
            {
               _loc2_ = TempleteManager.instance.vehicleSkillBuffTemplateCate.getTemplateByIndex(_loc4_.tempId);
               if(_loc2_)
               {
                  _loc1_.push(_loc2_);
               }
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function get model() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
   }
}

