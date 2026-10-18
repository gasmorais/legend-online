package farm.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.PetLandInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.datas.ai.AIPhysicsBase;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.interfaces.IBuildingFilter;
   import yishi.manager.PlayerManager;
   import yishi.view.community.PetMovieClip;
   
   public class FarmGuardView extends AIPhysicsBase
   {
      
      private var _changeBtn:IconButton;
      
      private var _model:FarmModel = FarmManager.instance.model;
      
      private var _simpleFilter:IBuildingFilter = new SimpleBuildingFilter();
      
      private var _petAvatar:PetMovieClip;
      
      private var _petContainer:Sprite;
      
      private var _petMenu:FarmPetSelectMeun;
      
      private var _isRollOver:Boolean;
      
      private var _timeId:int = 0;
      
      private var _data:PetLandInfo;
      
      private var _avatarKey:String;
      
      private var _sleepTimerId:int = 0;
      
      private var _isSleeping:Boolean = false;
      
      private var _mirror:int = 1;
      
      private var _angle:Number;
      
      public function FarmGuardView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _petAvatar = new PetMovieClip();
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("farm.ChangePetBtn");
         _changeBtn.visible = false;
         _petContainer = new Sprite();
         _petContainer.addChild(_petAvatar);
         addChild(_petContainer);
         addChild(_changeBtn);
         _petAvatar.state = 4;
         _petAvatar.play();
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_changeBtn);
         _changeBtn = null;
         ObjectUtils.disposeObject(_petAvatar);
         _petAvatar = null;
         _petMenu = null;
         _simpleFilter = null;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("rollOver",__rollOverHandler);
         this.addEventListener("rollOut",__rollOutHandler);
         FarmManager.instance.model.addEventListener("FARM_CURRENT_USER_CHANGE",onCurrentUser);
         _petAvatar.addEventListener("complete",__loadCompleteHandler);
      }
      
      private function removeEvent() : void
      {
         FarmManager.instance.model.removeEventListener("FARM_CURRENT_USER_CHANGE",onCurrentUser);
         this.removeEventListener("rollOver",__rollOverHandler);
         this.removeEventListener("rollOut",__rollOutHandler);
         if(_petMenu)
         {
            _petMenu.removeEventListener("dispose",__petMenuDisposeHandler);
         }
         if(_petAvatar)
         {
            _petAvatar.removeEventListener("complete",__loadCompleteHandler);
         }
      }
      
      private function __showPetMenuHandler(param1:MouseEvent) : void
      {
         if(!inSelfFarm)
         {
            return;
         }
         var _loc5_:Array = PlayerManager.instance.currentPlayerModel.playerInfo.petList;
         if(_loc5_.length == 0)
         {
            return;
         }
         var _loc4_:int = 0;
         if(_data)
         {
            _loc4_ = int(data.petId);
         }
         if(_petMenu)
         {
            _petMenu.removeEventListener("dispose",__petMenuDisposeHandler);
            _petMenu.dispose();
            _petMenu = null;
         }
         var _loc2_:Point = new Point(_changeBtn.x + _changeBtn.width,_changeBtn.y + _changeBtn.height);
         _loc2_ = localToGlobal(_loc2_);
         _petMenu = ComponentFactory.Instance.creatComponentByStylename("farm.FarmPetSelectMeun",[_loc4_,-1,2]);
         _petMenu.show();
         _petMenu.x = _loc2_.x + 60;
         _petMenu.y = _loc2_.y - 80;
         var _loc3_:int = int(StageReferance.stageWidth);
         var _loc6_:int = int(StageReferance.stageHeight);
         if(_petMenu.x + _petMenu.width + 30 > _loc3_)
         {
            _petMenu.x = _loc2_.x - _petMenu.width - 100;
         }
         if(_petMenu.y + _petMenu.height > _loc6_)
         {
            _petMenu.y = _loc6_ - _petMenu.height - 80;
         }
         _petMenu.addEventListener("dispose",__petMenuDisposeHandler);
      }
      
      private function __petMenuDisposeHandler(param1:Event) : void
      {
         (param1.currentTarget as FarmPetSelectMeun).removeEventListener("dispose",__petMenuDisposeHandler);
         _petMenu = null;
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
            _timeId = 0;
         }
         _simpleFilter.setBuildingOverFilter(this);
         _isRollOver = true;
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         _timeId = setTimeout(rollOut,100);
      }
      
      private function rollOut() : void
      {
         if(_simpleFilter)
         {
            _simpleFilter.setBuildingOutFilter(this);
         }
         if(_changeBtn)
         {
            _changeBtn.visible = false;
         }
         _isRollOver = false;
         nextWalk(_nextPoint);
      }
      
      private function __loadCompleteHandler(param1:Event) : void
      {
         if(_changeBtn)
         {
            _changeBtn.y = -_petAvatar.height - _changeBtn.displayHeight + 3;
         }
      }
      
      private function get inSelfFarm() : Boolean
      {
         return _model.curSelectedFarmInfo == _model.myFarm;
      }
      
      public function get data() : PetLandInfo
      {
         return _data;
      }
      
      public function set data(param1:PetLandInfo) : void
      {
         _data = param1;
      }
      
      private function onCurrentUser(param1:Event) : void
      {
         var _loc2_:String = null;
         if(FarmManager.instance.model.curSelectedFarmInfo == null)
         {
            return;
         }
         var _loc3_:PetLandInfo = FarmManager.instance.model.curSelectedFarmInfo.defender;
         if(_loc3_ && _loc3_.petTemplate)
         {
            _loc2_ = _loc3_.petTemplate.PetAvatar;
            _petAvatar.urlKey = _loc2_;
         }
         else
         {
            _avatarKey = "";
            if(_petAvatar)
            {
               _petAvatar.urlKey = "";
            }
         }
      }
      
      override protected function walkOver() : void
      {
         var _loc1_:Array = null;
         super.walkOver();
         if(this.info && this.info.pathInfo)
         {
            _loc1_ = this.info.pathInfo.concat();
            _loc1_.reverse();
            this.info.pathInfo = _loc1_;
         }
      }
      
      override public function execute() : void
      {
         if(_isSleeping || _isRollOver)
         {
            if(_petAvatar)
            {
               _petAvatar.state = 3;
            }
            return;
         }
         super.execute();
      }
      
      override protected function nextWalk(param1:Point) : void
      {
         var point:Point = param1;
         super.nextWalk(point);
         _isSleeping = true;
         _petAvatar.state = 3;
         if(_sleepTimerId != 0)
         {
            clearTimeout(_sleepTimerId);
            _sleepTimerId = 0;
         }
         _sleepTimerId = setTimeout(function():void
         {
            _isSleeping = false;
            if(_petAvatar)
            {
               _petAvatar.state = 4;
            }
         },3000);
      }
      
      override protected function checkDirection(param1:Point, param2:int = 1) : int
      {
         var _loc3_:int = twoPointAngle(param1.x,param1.y,this.x,this.y);
         angle = _loc3_;
         return _loc3_;
      }
      
      public function twoPointAngle(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc5_:int = param1 - param3;
         var _loc6_:int = param2 - param4;
         _loc5_ = int(Math.abs(_loc5_) < 10 ? 0 : _loc5_);
         _loc6_ = int(Math.abs(_loc6_) < 10 ? 0 : _loc6_);
         var _loc7_:Number = Math.atan2(_loc6_,_loc5_);
         _loc7_ = _loc7_ * 180 / 3.141592653589793;
         if(_loc7_ < 0)
         {
            _loc7_ += 360;
         }
         return _loc7_;
      }
      
      public function set angle(param1:Number) : void
      {
         var _loc4_:int = 0;
         if(_angle == param1)
         {
            return;
         }
         _angle = param1;
         if(!_petAvatar)
         {
            return;
         }
         var _loc2_:int = int(_petAvatar.frameY);
         var _loc3_:int = _mirror;
         if(param1 >= 260 && param1 < 280)
         {
            _loc4_ = 4;
            _mirror = 1;
         }
         else if(param1 >= 280 && param1 < 350)
         {
            _loc4_ = 3;
            _mirror = 1;
         }
         else if(param1 >= 350 || param1 < 10)
         {
            _loc4_ = 2;
            _mirror = 1;
         }
         else if(param1 >= 10 && param1 < 80)
         {
            _loc4_ = 1;
            _mirror = 1;
         }
         else if(param1 >= 80 && param1 < 100)
         {
            _loc4_ = 0;
            _mirror = 1;
         }
         else if(param1 < 170 && param1 >= 100)
         {
            _loc4_ = 1;
            _mirror = -1;
         }
         else if(param1 < 190 && param1 >= 170)
         {
            _loc4_ = 2;
            _mirror = -1;
         }
         else if(param1 < 260 && param1 >= 190)
         {
            _loc4_ = 3;
            _mirror = -1;
         }
         if(_loc2_ != _loc4_)
         {
         }
         _petAvatar.play();
         _petAvatar.frameY = _loc4_;
         _petAvatar.scaleX = _mirror;
      }
      
      public function clearPath() : void
      {
         if(_sleepTimerId != 0)
         {
            clearTimeout(_sleepTimerId);
            _sleepTimerId = 0;
         }
         this.info.pathInfo = null;
      }
      
      override public function dispose() : void
      {
         if(_sleepTimerId != 0)
         {
            clearTimeout(_sleepTimerId);
            _sleepTimerId = 0;
         }
         if(_timeId != 0)
         {
            clearTimeout(_timeId);
            _timeId = 0;
         }
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

