package map.campaign.view.physics.physicsview
{
   import avatar.view.AirGardenHeroShowAvatarView;
   import avatar.view.ChildrenAvatarView;
   import avatar.view.PetAirGardenShowAvatar;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import funny.mountact.MountsAvatarView;
   import managers.AirGardenManager;
   import map.campaign.data.CampaignArmy;
   import map.internals.data.CampaignNode;
   import mvc.module.airgarden.AirGardenCampaignBedInfo;
   import mvc.module.airgarden.AirGardenModel;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.AirGardenBedTempInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.datas.templates.PetTemplate;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.ArmyManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.TempleteManager;
   
   public class AirGardenCampaignShowAvatarView extends Component implements IEnterFrame
   {
      
      private var _heroAvatar:AirGardenHeroShowAvatarView;
      
      private var _mountAvatar:MountsAvatarView;
      
      private var _childAvatar:ChildrenAvatarView;
      
      private var _petAvatar:PetAirGardenShowAvatar;
      
      private var _data:AirGardenCampaignBedInfo;
      
      private var _nodeInfo:CampaignNode;
      
      private var heroDirection:int = 7;
      
      public function AirGardenCampaignShowAvatarView()
      {
         super();
         addEvent();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      public function enterFrame() : void
      {
         if(_childAvatar)
         {
            _childAvatar.execute();
         }
         if(_heroAvatar)
         {
            _heroAvatar.execute();
         }
      }
      
      public function get data() : AirGardenCampaignBedInfo
      {
         return _data;
      }
      
      public function set data(param1:AirGardenCampaignBedInfo) : void
      {
         var _loc4_:AirGardenBedTempInfo = null;
         var _loc2_:ChildTempInfo = null;
         var _loc3_:MountTemplate = null;
         var _loc5_:PetTemplate = null;
         _data = param1;
         if(data)
         {
            _loc4_ = TempleteManager.instance.airGardenBedTempCate.getTemplateById(data.nodeTempId);
            if(!_loc4_)
            {
               return;
            }
            if(_loc4_.NodeType == 901)
            {
               if(data.objId != 0)
               {
                  if(!_heroAvatar)
                  {
                     _heroAvatar = new AirGardenHeroShowAvatarView();
                     addChild(_heroAvatar);
                  }
                  _heroAvatar.data = getShowHeroArmy(data.heroInfo);
                  _heroAvatar.updateDirection(heroDirection);
               }
               else
               {
                  if(_heroAvatar)
                  {
                     ObjectUtils.disposeObject(_heroAvatar);
                  }
                  _heroAvatar = null;
               }
            }
            else if(_loc4_.NodeType == 902)
            {
               _loc2_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(data.tempId,data.grade);
               if(_loc2_)
               {
                  if(!_childAvatar)
                  {
                     _childAvatar = new ChildrenAvatarView();
                     addChild(_childAvatar);
                  }
                  _childAvatar.isFlying = false;
                  _childAvatar.isSelf = airGardenModel.campaignInfo.masterUserId == thane.userId;
                  _childAvatar.followTarget = null;
                  _childAvatar.showAvatar(_loc2_.JobName,1,_loc2_.ResPath,data.grade);
                  _childAvatar.setAirGardenVisible();
               }
               else
               {
                  if(_childAvatar)
                  {
                     ObjectUtils.disposeObject(_childAvatar);
                  }
                  _childAvatar = null;
               }
            }
            else if(_loc4_.NodeType == 903)
            {
               _loc3_ = TempleteManager.instance.mountTemplateDic[data.tempId];
               if(_loc3_)
               {
                  if(!_mountAvatar)
                  {
                     _mountAvatar = new MountsAvatarView();
                     addChild(_mountAvatar);
                  }
                  _mountAvatar.data = _loc3_;
               }
               else
               {
                  if(_mountAvatar)
                  {
                     ObjectUtils.disposeObject(_mountAvatar);
                  }
                  _mountAvatar = null;
               }
            }
            else if(_loc4_.NodeType == 904)
            {
               _loc5_ = TempleteManager.instance.petTemplateCate.getTemplateById(data.tempId);
               if(_loc5_)
               {
                  if(!_petAvatar)
                  {
                     _petAvatar = new PetAirGardenShowAvatar();
                     addChild(_petAvatar);
                  }
                  _petAvatar.data = _loc5_;
               }
               else
               {
                  if(_petAvatar)
                  {
                     ObjectUtils.disposeObject(_petAvatar);
                  }
                  _petAvatar = null;
               }
            }
         }
         else
         {
            if(_childAvatar)
            {
               ObjectUtils.disposeObject(_childAvatar);
            }
            _childAvatar = null;
            if(_petAvatar)
            {
               ObjectUtils.disposeObject(_petAvatar);
            }
            _petAvatar = null;
            if(_heroAvatar)
            {
               ObjectUtils.disposeObject(_heroAvatar);
            }
            _heroAvatar = null;
            if(_mountAvatar)
            {
               ObjectUtils.disposeObject(_mountAvatar);
            }
            _mountAvatar = null;
         }
      }
      
      private function getShowHeroArmy(param1:ThaneInfo) : CampaignArmy
      {
         var _loc2_:CampaignArmy = new CampaignArmy();
         var _loc3_:AIBaseInfo = new BaseArmyAiInfo();
         _loc3_.speed = 0;
         _loc3_.isLiving = true;
         if(_heroAvatar)
         {
            _heroAvatar.info = _loc3_;
         }
         _loc2_.userId = param1.userId;
         _loc2_.nickName = param1.nickName;
         if(nodeInfo)
         {
            _loc2_.curPosX = nodeInfo.curPosX;
            _loc2_.curPosY = nodeInfo.curPosY;
         }
         _loc2_.mountTemplateId = 0;
         _loc2_.online = true;
         _loc2_.baseHero = param1;
         return _loc2_;
      }
      
      public function get nodeInfo() : CampaignNode
      {
         return _nodeInfo;
      }
      
      public function set nodeInfo(param1:CampaignNode) : void
      {
         _nodeInfo = param1;
      }
      
      private function get airGardenModel() : AirGardenModel
      {
         return AirGardenManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_childAvatar)
         {
            ObjectUtils.disposeObject(_childAvatar);
         }
         _childAvatar = null;
         if(_petAvatar)
         {
            ObjectUtils.disposeObject(_petAvatar);
         }
         _petAvatar = null;
         if(_heroAvatar)
         {
            ObjectUtils.disposeObject(_heroAvatar);
         }
         _heroAvatar = null;
         if(_mountAvatar)
         {
            ObjectUtils.disposeObject(_mountAvatar);
         }
         _mountAvatar = null;
         super.dispose();
      }
   }
}

