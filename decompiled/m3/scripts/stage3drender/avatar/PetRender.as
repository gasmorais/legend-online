package stage3drender.avatar
{
   import avatar.data.AvatarPartInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import map.campaign.CampaignManager;
   import map.internals.MapData;
   import map.internals.view.hero.PetNameView;
   import map.space.SpaceManager;
   import stage3drender.Global;
   import starling.display.Image;
   import starling.textures.Texture;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.templates.PetTemplate;
   import yishi.manager.PathManager;
   import yishi.scene.SceneManager;
   
   public class PetRender extends AvatarRender
   {
      
      public static var _petPath:Array;
      
      public static const FOLLOW_DISTANCE:uint = 125;
      
      public static var petNormalPos:Point = new Point(-80,-65);
      
      public static var petMountPos:Point = new Point(-80,-80);
      
      public var followTarget:AvatarRender;
      
      public var isSelf:Boolean;
      
      public var petTemplate:PetTemplate;
      
      private var _petNameView:PetNameView;
      
      private var _shadowImg:Image;
      
      private var _bodyUrl:String;
      
      private var _lastFollowTime:int = 0;
      
      private var _petWalkIndex:int;
      
      private var tail:Image;
      
      private var _tailIndex:int = 0;
      
      public var followType:int = 0;
      
      public function PetRender()
      {
         super();
         touchable = false;
         _petNameView = new PetNameView();
         _petNameView.heroView = this;
         Global.nameLayer.addChild(_petNameView);
         _nameView = _petNameView;
         _shadowImg = new Image(Global.avatarTextureDic["shadow"]);
         _shadowImg.touchable = false;
         _shadowImg.x = -45;
         _shadowImg.y = -32;
         addChildAt(_shadowImg,0);
         var _loc1_:AIBaseInfo = new BaseArmyAiInfo();
         this.info = _loc1_;
      }
      
      public function showAvatar(param1:String, param2:int, param3:String) : void
      {
         var _loc7_:AvatarPartInfo = null;
         var _loc6_:String = null;
         var _loc4_:String = null;
         _petNameView.refreshView(param1,param2);
         if(!_avatarInfo)
         {
            _avatarInfo = new AvatarInfo();
         }
         var _loc5_:int = isSelf ? 10 : 4;
         if(param3)
         {
            _loc6_ = "body";
            _loc7_ = _avatarInfo.getPartInfo(_loc6_);
            if(!_loc7_)
            {
               _loc7_ = new AvatarPartInfo();
            }
            _loc4_ = PathManager.resourcePath + "swf/avatar" + param3 + "/" + 2 + "";
            if(_loc7_.url != _loc4_)
            {
               flight = 0;
               offsetY = 0;
               _loc7_.partPosition = _loc6_;
               _loc7_.url = _loc4_;
               _avatarInfo.addPartInfo(_loc7_);
            }
         }
         startLoad();
      }
      
      override public function advanceTime(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(followType == 0)
         {
            petMove();
            _shadowImg.visible = false;
         }
         else
         {
            _shadowImg.visible = true;
            _loc2_ = getTimer();
            if(_loc2_ - _lastFollowTime >= 100)
            {
               doFollow();
               _lastFollowTime = _loc2_;
            }
         }
         super.advanceTime(param1);
      }
      
      public function get petPath() : Array
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc1_:Point = null;
         if(!_petPath)
         {
            if(ClassUtils.uiSourceDomain.hasDefinition("asset.map.PetPath"))
            {
               _petPath = [];
               _loc2_ = ComponentFactory.Instance.creat("asset.map.PetPath");
               _loc3_ = 1;
               while(_loc3_ <= _loc2_.totalFrames)
               {
                  _loc2_.gotoAndStop(_loc3_);
                  _loc1_ = new Point(_loc2_["pos"].x + 25,_loc2_["pos"].y);
                  _petPath.push(_loc1_);
                  _loc3_++;
               }
            }
         }
         return _petPath;
      }
      
      private function petMove() : void
      {
         var _loc3_:Point = null;
         if(!(isPlaying && followTarget))
         {
            return;
         }
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(followTarget["isMount"])
         {
            _loc1_ = petMountPos.x;
            _loc2_ = petMountPos.y + followTarget.flight;
         }
         else
         {
            _loc1_ = petNormalPos.x;
            _loc2_ = petNormalPos.y - this.flight / 2;
         }
         if(followTarget.isStand)
         {
            if(currentAction != "W" && currentDirection != 2)
            {
               this.action("W",2);
            }
            if(_petWalkIndex == petPath.length)
            {
               _petWalkIndex = 0;
            }
            if(_petWalkIndex >= 63)
            {
               this.scaleX = -1;
            }
            else
            {
               this.scaleX = 1;
            }
            _loc3_ = petPath[_petWalkIndex];
            _loc1_ += _loc3_.x;
            _loc2_ += _loc3_.y;
            _petWalkIndex = _petWalkIndex + 1;
            removePetTail();
         }
         else
         {
            if(currentAction != followTarget.currentAction && currentDirection != followTarget.currentDirection)
            {
               this.action(followTarget.currentAction,followTarget.currentDirection);
            }
            _petWalkIndex = 0;
            drawPetTail();
         }
         this.x = _loc1_;
         this.y = _loc2_;
         this._avatarContainer.alpha = followTarget.avatarContainer.alpha;
      }
      
      public function drawPetTail() : void
      {
         var _loc2_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:BitmapData = null;
         var _loc1_:Array = MapData.petTailClips;
         _tailIndex %= 20;
         if(!MapData.petTextures)
         {
            _loc2_ = [];
            MapData.petTextures = _loc2_;
            _loc5_ = 0;
            while(_loc5_ < _loc1_.length)
            {
               _loc4_ = _loc1_[_loc5_] as BitmapData;
               if(_loc4_)
               {
                  _loc2_[_loc5_] = Texture.fromBitmapData(_loc4_);
               }
               _loc5_++;
            }
         }
         _loc2_ = MapData.petTextures;
         var _loc3_:Texture = _loc2_[_tailIndex] as Texture;
         _tailIndex = _tailIndex + 1;
         if(!_loc3_)
         {
            return;
         }
         if(!tail)
         {
            tail = new Image(_loc3_);
            tail.pivotX = 35;
            tail.pivotY = 58;
            tail.x = 15;
            tail.y = -25;
         }
         else
         {
            tail.texture = _loc3_;
         }
         if(!tail.parent)
         {
            addChildAt(tail,0);
         }
         tail.width = _loc3_.nativeWidth;
         tail.height = _loc3_.nativeHeight;
         tail.scaleX = -1;
         tail.scaleY = 1;
         if(followTarget.currentDirection > 2)
         {
            tail.scaleY = -1;
         }
         if(tail.scaleX == -1)
         {
            tail.x = -15;
         }
         else
         {
            tail.x = 15;
         }
      }
      
      public function removePetTail() : void
      {
         if(tail && tail.parent)
         {
            tail.parent.removeChild(tail);
            _tailIndex = 0;
         }
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
         else if(distance(this,followTarget) > 125)
         {
            _loc4_ = new Point(followTarget.x - this.x,followTarget.y - this.y);
            _loc3_ = _loc4_.length;
            _loc4_.x = int(_loc4_.x * 50 / _loc3_);
            _loc4_.y = int(_loc4_.y * 50 / _loc3_);
            _loc1_ = new Point(this.x + _loc4_.x,this.y + _loc4_.y);
            _loc1_.x /= 20;
            _loc1_.y /= 20;
            _loc2_ = [this.getTilePos(),_loc1_];
            this.aiInfo.speed = followTarget.aiInfo.speed;
            this.aiInfo.pathInfo = _loc2_;
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
         var _loc1_:Point = this.getTilePos();
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            if(SpaceManager.instance.model.getWalkable(_loc1_.x,_loc1_.y))
            {
               _shadowImg.visible = true;
            }
            else
            {
               _shadowImg.visible = false;
            }
            _loc2_ = Boolean(SpaceManager.instance.model.walkableValueIsPara(4,_loc1_.x,_loc1_.y));
         }
         else if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = Boolean(CampaignManager.instance.mapModel.walkableValueIsPara(4,_loc1_.x,_loc1_.y));
            _shadowImg.visible = true;
         }
         if(_loc2_)
         {
            _avatarContainer.alpha = 0.5;
         }
         else
         {
            _avatarContainer.alpha = 1;
         }
      }
      
      public function changeFollowType(param1:PetTemplate) : void
      {
         followType = 0;
         if(param1 && param1.Property1 == 1)
         {
            followType = 1;
         }
      }
      
      override public function dispose() : void
      {
         if(tail)
         {
            tail.dispose();
            tail = null;
         }
         super.dispose();
      }
   }
}

