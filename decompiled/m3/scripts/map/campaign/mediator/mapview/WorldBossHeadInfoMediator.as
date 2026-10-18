package map.campaign.mediator.mapview
{
   import battle.view.buffer.BufferIconOnConsortiaEmeDreamBoss;
   import battle.view.ui.top.BossInfoView;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import events.WorldBossEvent;
   import flash.events.Event;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.view.ui.WorldBossInfoView;
   import map.internals.data.CampaignNode;
   import map.internals.view.frame.WorldBossRewardView;
   import mvc.module.consortia.ConsortiaEmeDreamInfo;
   import mvc.module.worldboss.WorldBossModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.BaseManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.WorldBossHelper;
   
   public class WorldBossHeadInfoMediator implements IMediator
   {
      
      private var _bossInfoView:BossInfoView;
      
      private var _rewardView:WorldBossRewardView;
      
      private var _worldBossModel:WorldBossModel;
      
      private var _itemView1:BufferIconOnConsortiaEmeDreamBoss;
      
      private var _itemView2:BufferIconOnConsortiaEmeDreamBoss;
      
      private var _preHp:int;
      
      private var _inited:Boolean;
      
      public function WorldBossHeadInfoMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         loadRes();
      }
      
      private function loadRes() : void
      {
         var _loc1_:String = ComponentSetting.getUISourcePath("worldbossreward");
         LoaderManagerII.instance.load(_loc1_,3,0,completeHandler);
      }
      
      private function completeHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc5_:CampaignNode = null;
         var _loc4_:String = null;
         var _loc7_:Array = null;
         var _loc6_:BufferTemplateInfo = null;
         _bossInfoView = new WorldBossInfoView();
         _worldBossModel = CampaignManager.instance.worldBossModel;
         var _loc3_:Array = CampaignManager.instance.mapModel.mapNodesData;
         for each(var _loc8_:CampaignNode in _loc3_)
         {
            if(_loc8_.info.types == 41 || _loc8_.info.types == 42)
            {
               if(!WorldBossHelper.checkConsortiaEmeDream(CampaignManager.instance.mapModel.mapId))
               {
                  _loc5_ = _loc8_;
                  break;
               }
               if(_loc8_.param1 == ConsortiaEmeDreamInfo.BOSS_TYPE)
               {
                  _loc5_ = _loc8_;
                  break;
               }
            }
         }
         if(!_loc5_ || !_worldBossModel)
         {
            return;
         }
         _bossInfoView.setInfo(createHeroInfo(_loc5_));
         __updateWoundListHandler(null);
         _worldBossModel.addEventListener("UPDATE_WOUND_LIST",__updateWoundListHandler);
         LayerManager.Instance.addToLayer(_bossInfoView,4,false,false,0,0);
         _rewardView = new WorldBossRewardView();
         LayerManager.Instance.addToLayer(_rewardView,4,false,false,0,0);
         var _loc9_:int = 0;
         if(WorldBossHelper.checkConsortiaEmeDream(CampaignManager.instance.mapModel.mapId))
         {
            _loc4_ = ConsortiaManager.instance.model.emeDreamInfo.BufferIds;
            if(_loc4_)
            {
               _loc7_ = _loc4_.split(",");
               _loc9_ = 0;
               _loc6_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc7_[_loc9_]);
               if(_loc6_ && _loc6_.Icon && _loc6_.Icon.length > 0)
               {
                  _itemView1 = new BufferIconOnConsortiaEmeDreamBoss(_loc6_.Icon,_loc6_,_loc9_);
                  LayerManager.Instance.addToLayer(_itemView1,4,false,false,0,0);
               }
               _loc9_ = 1;
               _loc6_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc7_[_loc9_]);
               if(_loc6_ && _loc6_.Icon && _loc6_.Icon.length > 0)
               {
                  _itemView2 = new BufferIconOnConsortiaEmeDreamBoss(_loc6_.Icon,_loc6_,_loc9_);
                  LayerManager.Instance.addToLayer(_itemView2,4,false,false,0,0);
               }
            }
         }
         StageReferance.addEventListener("resize",__stageResizeHandler);
         __stageResizeHandler(null);
      }
      
      private function __updateWoundListHandler(param1:WorldBossEvent) : void
      {
         if(CampaignManager.instance.mapModel.campaignTemplate.Types == 1 && Boolean(BaseManager.instance.wordBossInvincibleState))
         {
            _bossInfoView.setTotalHp(_worldBossModel.totalHp);
            _bossInfoView.setCurrentHp(_worldBossModel.curHp);
            _bossInfoView.bloodTxt.text = LanguageMgr.GetTranslation("worldboss.bloodText.maxValue");
            _inited = false;
            return;
         }
         if(_worldBossModel.totalHp <= 0)
         {
            return;
         }
         if(!_inited)
         {
            _inited = true;
            _bossInfoView.setTotalHp(_worldBossModel.totalHp);
            _bossInfoView.setCurrentHp(_worldBossModel.curHp);
         }
         if(_preHp != 0 && _preHp - _worldBossModel.curHp > 0)
         {
            _bossInfoView.updateWorldBossHp(_worldBossModel.curHp - _preHp);
         }
         _preHp = _worldBossModel.curHp;
      }
      
      private function createHeroInfo(param1:CampaignNode) : HeroRoleInfo
      {
         var _loc2_:HeroRoleInfo = new HeroRoleInfo();
         _loc2_.heroInfo = new ThaneInfo();
         _loc2_.heroInfo.grades = _worldBossModel.bossGrades;
         _loc2_.heroInfo.nickName = param1.info.names;
         _loc2_.heroInfo.templateId = param1.heroTemplateId;
         return _loc2_;
      }
      
      private function layout() : void
      {
         _bossInfoView.x = StageReferance.stageWidth - _bossInfoView.width;
         if(_rewardView)
         {
            _rewardView.x = StageReferance.stageWidth - 360;
            _rewardView.y = 76;
         }
         var _loc1_:int = StageReferance.stageWidth - 270;
         if(_itemView1)
         {
            _itemView1.x = _loc1_;
            _itemView1.y = 90;
            _loc1_ -= 40;
         }
         if(_itemView2)
         {
            _itemView2.x = _loc1_;
            _itemView2.y = 90;
         }
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         layout();
      }
      
      public function unregister(param1:Object) : void
      {
         if(_worldBossModel)
         {
            _worldBossModel.removeEventListener("UPDATE_WOUND_LIST",__updateWoundListHandler);
         }
         _worldBossModel = null;
         StageReferance.removeEventListener("resize",__stageResizeHandler);
         ObjectUtils.disposeObject(_bossInfoView);
         _bossInfoView = null;
         ObjectUtils.disposeObject(_rewardView);
         _rewardView = null;
         ObjectUtils.disposeObject(_itemView1);
         _itemView1 = null;
         ObjectUtils.disposeObject(_itemView2);
         _itemView2 = null;
      }
   }
}

