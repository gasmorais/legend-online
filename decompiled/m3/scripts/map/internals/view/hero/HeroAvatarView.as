package map.internals.view.hero
{
   import avatar.view.Avatar;
   import avatar.view.HeroAvatar;
   import avatar.view.HumanAvatar;
   import com.pickgliss.loader.LoaderHeaderList;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import map.internals.interfaces.ISelectMovie;
   import map.internals.utils.MapUtisl;
   import yishi.interfaces.IBuildingFilter;
   
   public class HeroAvatarView extends AvatarBaseView implements ISelectMovie
   {
      
      protected var _filter:IBuildingFilter;
      
      protected var _avatar:Avatar;
      
      protected var _npcName:FilterFrameText;
      
      private var _color:ColorTransform;
      
      protected var _angle:Number = 0;
      
      protected var _endPoint:Point;
      
      protected var stepX:Number = 0;
      
      protected var stepY:Number = 0;
      
      public function HeroAvatarView()
      {
         super();
      }
      
      protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         _npcName || (_npcName = ComponentFactory.Instance.creatComponentByStylename("core.NpcNameText"));
         _npcName.cacheAsBitmap = true;
         if(param1 != "")
         {
            _npcName.text = param1;
         }
         _npcName.x = -_npcName.width / 2;
         _npcName.selectable = _npcName.mouseEnabled = _npcName.mouseWheelEnabled = false;
         if(_isPlaying)
         {
            addChild(_npcName);
         }
         param5 = int(param5 == 0 ? 1 : param5);
         _npcName.setFrame(param5);
         _npcName.y = -110;
      }
      
      public function set filter(param1:IBuildingFilter) : void
      {
         _filter = param1;
      }
      
      public function set avatarView(param1:Avatar) : void
      {
         if(_avatar)
         {
            if(_avatar.parent)
            {
               _avatar.parent.removeChild(_avatar);
            }
            _avatar.dispose();
         }
         _avatar = null;
         _avatar = param1;
         (_avatar as HumanAvatar).isShowWeapons = true;
         _avatar.angle = 2;
         if(_isPlaying)
         {
            addChild(_avatar);
         }
      }
      
      private function __onSizeTypeChangeHandler(param1:Event) : void
      {
      }
      
      public function getCurrentPixels() : int
      {
         if(_avatar)
         {
            return (_avatar as HumanAvatar).getCurrentPixels();
         }
         return 0;
      }
      
      public function get avatarView() : Avatar
      {
         return _avatar;
      }
      
      override public function execute() : void
      {
         super.execute();
         if(_avatar && _isPlaying)
         {
            _avatar.run();
            if(!_isStand)
            {
               _avatar.state = 4;
            }
         }
      }
      
      override protected function walkOver() : void
      {
         super.walkOver();
         standImp();
      }
      
      public function updateDirection(param1:Number) : void
      {
         if(_avatar)
         {
            _avatar.angle = param1;
         }
      }
      
      protected function standImp() : void
      {
         if(_avatar)
         {
            _avatar.state = 3;
         }
      }
      
      override public function dispose() : void
      {
         _filter = null;
         if(_avatar)
         {
            _avatar.filters = null;
            _avatar.dispose();
         }
         _avatar = null;
         if(_npcName)
         {
            if(_npcName.parent)
            {
               ObjectUtils.disposeObject(_npcName);
            }
            _npcName.dispose();
         }
         _npcName = null;
         _color = null;
         super.dispose();
      }
      
      override protected function nextWalk(param1:Point) : void
      {
         _nextPoint = param1.clone();
         _endPoint = new Point(_nextPoint.x * 20 + 10,_nextPoint.y * 20 + 10);
         _angle = Math.atan2(_endPoint.y - this.y,_endPoint.x - this.x);
         var _loc3_:Number = _angle * 180 / 3.141592653589793;
         if(_loc3_ < 0)
         {
            _loc3_ += 360;
         }
         updateDirection(_loc3_);
         this.stepX = _info.speed * Math.cos(this._angle);
         this.stepY = _info.speed * Math.sin(this._angle);
         var _loc2_:Number = Point.distance(_endPoint,new Point(this.x,this.y));
         info.totalFrame = int(_loc2_ / _info.speed);
         var _loc4_:Number = this.x + info.totalFrame * this.stepX;
         var _loc5_:Number = this.y + info.totalFrame * this.stepY;
         if(!(_loc4_ >= _nextPoint.x * 20 && _loc4_ < (_nextPoint.x + 1) * 20 && _loc5_ >= _nextPoint.y * 20 && _loc5_ < (_nextPoint.y + 1) * 20))
         {
            info.currentFrame = info.totalFrame + 1;
         }
         info.currentFrame = 0;
         if(info.totalFrame <= 0)
         {
            return;
         }
      }
      
      override protected function playMovie() : void
      {
         this.x += stepX;
         this.y += stepY;
      }
      
      public function beginSelectMovie() : void
      {
         _color = _avatar.transform.colorTransform;
      }
      
      public function resetSelectMovie() : void
      {
         if(_avatar)
         {
            if(_color)
            {
               _avatar.transform.colorTransform = _color;
            }
            _avatar.filters = [];
         }
      }
      
      public function get selectMovie() : DisplayObject
      {
         return _avatar;
      }
      
      protected function loaderCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(_avatar)
         {
            (_avatar as HumanAvatar).loaderCompleteHandler(param1.args as ResourceLoaderInfo,param2);
         }
         layoutNameView();
      }
      
      protected function layoutNameView() : void
      {
      }
      
      protected function createResourceLoadInfo(param1:String, param2:Array, param3:Array, param4:String) : ResourceLoaderInfo
      {
         var _loc5_:ResourceLoaderInfo = new ResourceLoaderInfo();
         _loc5_.packageName = MapUtisl.getPackageName(param1);
         _loc5_.stand = param2;
         _loc5_.walk = param3;
         _loc5_.position = param4;
         _loc5_.url = param1;
         return _loc5_;
      }
      
      protected function getPosYBySizeType(param1:int, param2:int = 0) : int
      {
         var _loc8_:String = _avatar != null ? _avatar.body : "";
         var _loc3_:Object = LoaderHeaderList.avatarShowNamePos[_loc8_];
         if(_loc3_ && _loc3_.hasOwnProperty("showNamePosY") && _loc3_.showNamePosY != 0)
         {
            return int(_loc3_.showNamePosY) + param2;
         }
         var _loc6_:HeroAvatar = _avatar as HeroAvatar;
         var _loc7_:String = _loc6_ != null ? _loc6_.mount : "";
         var _loc4_:Object = LoaderHeaderList.avatarShowNamePos[_loc7_];
         if(_loc4_ && _loc4_.hasOwnProperty("showNamePosY") && _loc4_.showNamePosY != 0)
         {
            return int(_loc4_.showNamePosY) + param2;
         }
         var _loc5_:int = -125;
         switch(param1 - 1)
         {
            case 0:
               _loc5_ = -125;
               break;
            case 1:
               _loc5_ = -150;
               break;
            case 2:
            case 9:
               _loc5_ = -165;
               break;
            case 4:
               _loc5_ = -150;
               break;
            case 6:
               _loc5_ = -80;
         }
         return _loc5_ + param2;
      }
      
      override public function mouseHitTest() : Boolean
      {
         if(!mouseEnabled)
         {
            return false;
         }
         if(!parent)
         {
            return false;
         }
         if(_avatar)
         {
            return (_avatar as HumanAvatar).getCurrentPixels() > 50;
         }
         var _loc1_:Point = localToGlobal(new Point(this.mouseX,this.mouseY));
         return this.hitTestPoint(_loc1_.x,_loc1_.y,true);
      }
   }
}

