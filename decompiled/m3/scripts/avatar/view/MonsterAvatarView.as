package avatar.view
{
   import avatar.data.AvatarStaticData;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.ui.ComponentFactory;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import map.campaign.CampaignManager;
   import map.internals.data.CampaignNode;
   import map.internals.view.hero.HeroAvatarView;
   import map.space.SpaceManager;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.manager.PathManager;
   import yishi.scene.SceneManager;
   
   public class MonsterAvatarView extends HeroAvatarView
   {
      
      public static const FOLLOW_DISTANCE:uint = 150;
      
      public var followTarget:HeroAvatarView;
      
      protected var _cInfo:CampaignNode;
      
      private var _lastFollowTime:int = 0;
      
      public function MonsterAvatarView()
      {
         super();
         this.mouseEnabled = this.mouseChildren = false;
         var _loc1_:AIBaseInfo = new BaseArmyAiInfo();
         this.info = _loc1_;
      }
      
      public function setName(param1:String) : void
      {
         if(!_npcName)
         {
            _npcName = ComponentFactory.Instance.creatComponentByStylename("map.campaign.ChildrenNameText");
         }
         _npcName.text = param1;
         _npcName.x = -_npcName.width / 2;
         _npcName.y = -125;
      }
      
      private function initSpeed() : void
      {
         info.speed = 7;
      }
      
      public function refreshAvatarView(param1:String) : void
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         if(!avatarView)
         {
            avatarView = new HeroAvatar(true,param1,2,0,true);
         }
         _loc3_ = PathManager.getAvatarResourcePath(param1,-1,1,"body",-1,2);
         _loc2_ = createResourceLoadInfo(_loc3_,AvatarStaticData.getBaseNumByType("Stand","body"),AvatarStaticData.getBaseNumByType("Walk","body"),"body");
         LoaderManagerII.instance.load(_loc3_,4,7,loaderCompleteHandler,null,null,_loc2_);
      }
      
      override protected function layoutNameView() : void
      {
         if(_npcName)
         {
            _npcName.y = getPosYBySizeType(this._avatar.sizeType,_avatar.flight);
            if(_npcName && !_npcName.parent)
            {
               addChild(_npcName);
            }
         }
      }
      
      override public function execute() : void
      {
         var _loc1_:int = getTimer();
         if(_loc1_ - _lastFollowTime >= 100)
         {
            doFollow();
            _lastFollowTime = _loc1_;
         }
         super.execute();
         if(_avatar)
         {
            (_avatar as HeroAvatar).stepFrame = getStepFrame();
         }
      }
      
      public function get mirror() : int
      {
         if(_avatar is HeroAvatar)
         {
            return (_avatar as HeroAvatar).mirror;
         }
         return 1;
      }
      
      private function getStepFrame() : int
      {
         if(_isStand)
         {
            return 4;
         }
         return 2;
      }
      
      private function doFollow() : void
      {
         var _loc4_:Point = null;
         var _loc3_:Number = NaN;
         var _loc1_:Point = null;
         var _loc2_:Array = null;
         if(!followTarget)
         {
            return;
         }
         if(!stage)
         {
            this.x = followTarget.x;
            this.y = followTarget.y;
         }
         else if(distance(this,followTarget) > 150)
         {
            _loc4_ = new Point(followTarget.x - this.x,followTarget.y - this.y);
            _loc3_ = _loc4_.length;
            if(_loc3_ > 1000)
            {
               this.x = followTarget.x;
               this.y = followTarget.y;
            }
            else
            {
               _loc4_.x *= 0.4;
               _loc4_.y *= 0.4;
               _loc1_ = new Point(this.x + _loc4_.x,this.y + _loc4_.y);
               _loc1_.x /= 20;
               _loc1_.y /= 20;
               _loc2_ = [this.getTilePos(),_loc1_];
               this.info.speed = followTarget.info.speed;
               this.info.pathInfo = _loc2_;
            }
         }
      }
      
      private function distance(param1:Object, param2:Object) : Number
      {
         var _loc3_:Number = param2.x - param1.x;
         var _loc4_:Number = param2.y - param1.y;
         return Math.sqrt(_loc3_ * _loc3_ + _loc4_ * _loc4_);
      }
      
      override protected function playMovie() : void
      {
         var _loc2_:Boolean = false;
         super.playMovie();
         if(!_avatar)
         {
            return;
         }
         var _loc1_:Point = this.getTilePos();
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            _avatar.noShadow = false;
            if(followTarget.hasOwnProperty("isFlying") && followTarget["isFlying"] && !SpaceManager.instance.model.getWalkable(_loc1_.x,_loc1_.y))
            {
               _avatar.noShadow = true;
            }
            _loc2_ = Boolean(SpaceManager.instance.model.walkableValueIsPara(4,_loc1_.x,_loc1_.y));
         }
         else if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = Boolean(CampaignManager.instance.mapModel.walkableValueIsPara(4,_loc1_.x,_loc1_.y));
            _avatar.noShadow = false;
         }
         if(_loc2_)
         {
            _avatar.alpha = 0.5;
         }
         else
         {
            _avatar.alpha = 1;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

