package avatar.view
{
   import avatar.data.AvatarStaticData;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import map.campaign.CampaignManager;
   import map.internals.MapData;
   import map.internals.view.hero.HeroAvatarView;
   import map.space.SpaceManager;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.templates.PetTemplate;
   import yishi.manager.PathManager;
   import yishi.scene.SceneManager;
   import yishi.view.tools.SimpleMovie;
   
   public class ChildrenAvatarView extends HeroAvatarView
   {
      
      public static var _petPath:Array;
      
      public static const FOLLOW_DISTANCE:uint = 150;
      
      public static var petNormalPos:Point = new Point(-80,-65);
      
      public static var petMountPos:Point = new Point(-80,-80);
      
      private var _petQuaity:MovieClip;
      
      public var followTarget:HeroAvatarView;
      
      public var isFlying:Boolean;
      
      protected var _gradeImg:Bitmap;
      
      protected var _gradeText:FilterFrameText;
      
      private var _bitData1:BitmapData;
      
      private var _bitData2:BitmapData;
      
      private var offsetX:int;
      
      private var offsetY:int;
      
      public var isSelf:Boolean;
      
      private var _lastFollowTime:int = 0;
      
      private var _bodyUrl:String;
      
      public var followType:int = 1;
      
      public var tail:Shape;
      
      private var _tailIndex:int = 0;
      
      private var _petWalkIndex:int;
      
      public function ChildrenAvatarView()
      {
         super();
         _bitData1 = ComponentFactory.Instance.creatBitmapData("asset.map.ChildrenGradeImg");
         _bitData2 = ComponentFactory.Instance.creatBitmapData("asset.map.childGrade2");
         _gradeImg = new Bitmap();
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("map.ChildrenAvatarView.gradeText");
         addChild(_gradeImg);
         addChild(_gradeText);
         _gradeImg.visible = false;
         _gradeText.text = "";
         mouseChildren = mouseEnabled = false;
         var _loc1_:AIBaseInfo = new BaseArmyAiInfo();
         this.info = _loc1_;
      }
      
      override protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         if(!_npcName)
         {
            _npcName = ComponentFactory.Instance.creatComponentByStylename("map.campaign.ChildrenNameText");
            addChild(_npcName);
         }
         _npcName.text = param1;
         _npcName.setFrame(param5);
         _npcName.x = -_npcName.width / 2;
         _npcName.y = -125;
         if(param5 >= 5)
         {
            if(!_petQuaity)
            {
               _petQuaity = ComponentFactory.Instance.creat("asset.map.PetQuaityAsset");
            }
            if(!_petQuaity.parent)
            {
               addChild(_petQuaity);
               _petQuaity.x = -33;
               _petQuaity.y = _npcName.y;
            }
         }
         else
         {
            ObjectUtils.disposeObject(_petQuaity);
            _petQuaity = null;
         }
      }
      
      private function showGrade(param1:int) : void
      {
         _gradeImg.visible = true;
         _gradeImg.x = -_npcName.textWidth / 2 - 33 - offsetX;
         _gradeImg.y = -130;
         _gradeText.text = param1 + "";
         _gradeText.x = _gradeImg.x + -12 + offsetX * 0.5;
         _gradeText.y = _gradeImg.y + 2;
      }
      
      public function showAvatar(param1:String, param2:int, param3:String, param4:int, param5:int = -1) : void
      {
         var _loc6_:Object = null;
         showName(param1,0,0,0,param2);
         if(param5 >= 0)
         {
            offsetX = 22;
            offsetY = -10;
            showGrade(param5);
            _gradeImg.bitmapData = _bitData2;
         }
         else
         {
            offsetX = 0;
            offsetY = 0;
            showGrade(param4);
            _gradeImg.bitmapData = _bitData1;
         }
         var _loc8_:int = isSelf ? 10 : 4;
         var _loc7_:String = PathManager.resourcePath + "swf/avatar/hychild" + param3 + "/2.bswf";
         if(!_avatar)
         {
            _avatar = new HeroAvatar(false,_loc7_,2,2,true);
            _avatar.angle = 90;
            addChild(_avatar);
         }
         if(_bodyUrl != _loc7_)
         {
            _bodyUrl = _loc7_;
            _avatar.removeAvatar("mount");
            _avatar.body = _loc7_;
            _loc6_ = createResourceLoadInfo(_loc7_,AvatarStaticData.getBaseNumByType("Stand","mount"),AvatarStaticData.getBaseNumByType("Walk","mount"),"mount");
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
            LoaderManagerII.instance.load(_loc7_,4,_loc8_,loaderCompleteHandler,null,null,_loc6_);
         }
         else
         {
            layoutNameView();
         }
      }
      
      public function setAirGardenVisible() : void
      {
         _gradeImg.visible = false;
         _gradeText.text = "";
         _npcName.text = "";
      }
      
      override public function execute() : void
      {
         var _loc1_:int = 0;
         if(followType == 0)
         {
            petMove();
            if(_avatar)
            {
               _avatar.noShadow = true;
            }
         }
         else
         {
            _loc1_ = getTimer();
            if(_loc1_ - _lastFollowTime >= 100)
            {
               doFollow();
               _lastFollowTime = _loc1_;
            }
         }
         super.execute();
         if(_avatar)
         {
            (_avatar as HeroAvatar).stepFrame = getStepFrame();
         }
      }
      
      private function getStepFrame() : int
      {
         if(_isStand)
         {
            return 4;
         }
         return 2;
      }
      
      public function playPetLevelUpMovie() : void
      {
         var _loc2_:MovieClip = ComponentFactory.Instance.creat("asset.map.PetLevelUpMc");
         var _loc1_:SimpleMovie = new SimpleMovie(_loc2_);
         _loc1_.x = -12;
         _loc1_.y = -45;
         addChild(_loc1_);
      }
      
      public function changeFollowType(param1:PetTemplate) : void
      {
         if(param1 && param1.Property1 == 1)
         {
            if(followType == 1)
            {
               return;
            }
            followType = 1;
            if(_avatar)
            {
               _avatar.noShadow = false;
               _avatar.state = 3;
               _avatar.angle = 90;
            }
            removeTail();
         }
         else
         {
            if(_avatar)
            {
               _avatar.noShadow = true;
            }
            followType = 0;
         }
      }
      
      public function drawTail() : void
      {
         var _loc2_:Matrix = null;
         if(!followTarget)
         {
            return;
         }
         if(!followTarget.avatarView)
         {
            return;
         }
         if(!tail)
         {
            tail = new Shape();
            tail.x = 15;
            tail.y = -25;
         }
         if(!tail.parent)
         {
            addChildAt(tail,0);
         }
         var _loc1_:Array = MapData.petTailClips;
         _tailIndex %= 20;
         var _loc3_:BitmapData = _loc1_[_tailIndex];
         _tailIndex = _tailIndex + 1;
         if(_loc3_)
         {
            tail.graphics.clear();
            _loc2_ = new Matrix();
            _loc2_.tx = -35;
            _loc2_.ty = -58;
            tail.graphics.beginBitmapFill(_loc3_,_loc2_,false);
            tail.graphics.drawRect(_loc2_.tx,_loc2_.ty,_loc3_.width,_loc3_.height);
            tail.graphics.endFill();
         }
         tail.scaleX = -(followTarget.avatarView as HeroAvatar).mirror;
         tail.scaleY = 1;
         if(_avatar.frameY > 2)
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
      
      public function removeTail() : void
      {
         if(tail && tail.parent)
         {
            tail.parent.removeChild(tail);
            tail.graphics.clear();
            _tailIndex = 0;
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
      
      public function setAngle(param1:Number) : void
      {
         if(_avatar)
         {
            _avatar.angle = param1;
         }
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
         if(!(_avatar && isPlaying && followTarget && followTarget.avatarView))
         {
            return;
         }
         var _loc4_:int = (followTarget.avatarView as HeroAvatar).mirror;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(followTarget.hasOwnProperty("isMounting") && followTarget["isMounting"])
         {
            _loc1_ = _loc4_ * petMountPos.x;
            _loc2_ = petMountPos.y + followTarget.avatarView.flight;
         }
         else
         {
            _loc1_ = _loc4_ * petNormalPos.x;
            _loc2_ = petNormalPos.y - this.avatarView.flight / 2;
         }
         _avatar.state = 4;
         if(followTarget.isStand)
         {
            if(_petWalkIndex == petPath.length)
            {
               _petWalkIndex = 0;
            }
            _loc3_ = petPath[_petWalkIndex];
            if(_petWalkIndex >= 63)
            {
               if(_loc4_ == 1)
               {
                  this.setAngle(180);
               }
               else
               {
                  this.setAngle(0);
               }
            }
            else if(_loc4_ == 1)
            {
               this.setAngle(0);
            }
            else
            {
               this.setAngle(180);
            }
            _loc1_ += _loc4_ * _loc3_.x;
            _loc2_ += _loc3_.y;
            _petWalkIndex = _petWalkIndex + 1;
            this.removeTail();
         }
         else
         {
            this.setAngle(followTarget.avatarView.angle);
            _petWalkIndex = 0;
            this.drawTail();
         }
         this.x = _loc1_;
         this.y = _loc2_;
         if(_npcName)
         {
            _npcName.y = -80 + this.avatarView.flight / 2;
         }
         if(_gradeImg)
         {
            _gradeImg.y = -85 + this.avatarView.flight / 2;
            _gradeText.y = _gradeImg.y + 2;
         }
         this.avatarView.alpha = followTarget.avatarView.alpha;
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
      
      override protected function layoutNameView() : void
      {
         if(followType == 1)
         {
            if(_avatar)
            {
               _npcName.y = getPosYBySizeType(this._avatar.sizeType,_avatar.flight);
               _gradeImg.y = _npcName.y - 5 + offsetY;
               _gradeText.y = _gradeImg.y + 2 - offsetY;
            }
            if(_petQuaity)
            {
               _petQuaity.y = _npcName.y;
            }
         }
      }
      
      override protected function updateQTree() : void
      {
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         ObjectUtils.disposeObject(_petQuaity);
         _petQuaity = null;
         ObjectUtils.disposeObject(_bitData1);
         _bitData1 = null;
         ObjectUtils.disposeObject(_bitData2);
         _bitData2 = null;
         super.dispose();
      }
   }
}

