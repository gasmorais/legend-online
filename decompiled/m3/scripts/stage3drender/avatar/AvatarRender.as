package stage3drender.avatar
{
   import avatar.data.AvatarPartInfo;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import map.internals.data.ArmyPetInfo;
   import map.internals.utils.QTree;
   import map.internals.view.hero.BaseNameView;
   import stage3drender.AvatarAtfLoader;
   import stage3drender.Global;
   import stage3drender.utils.AtfDecoder;
   import starling.animation.IAnimatable;
   import starling.display.Sprite;
   import starling.filters.FragmentFilter;
   
   public class AvatarRender extends MoveAbleObject implements IAnimatable
   {
      
      protected var _avatarPartList:Array = [];
      
      protected var _avatarInfo:AvatarInfo;
      
      protected var _avatarContainer:Sprite;
      
      private var _isLoadComplete:Boolean = false;
      
      protected var _isMount:Boolean = false;
      
      private var _sizeType:int = 1;
      
      public var flight:int;
      
      public var offsetY:int;
      
      protected var _petPart:PetRender;
      
      private var _isPlaying:Boolean = true;
      
      protected var loaderPriority:int = 0;
      
      public var qtree:QTree;
      
      private var _loader:AvatarAtfLoader;
      
      protected var _stepFrame:int = 2;
      
      protected var _step:Number = 0;
      
      public var debug:Boolean;
      
      protected var _nameView:BaseNameView;
      
      private var _petWalkIndex:int = 20;
      
      private var _petwalkDirection:int = 1;
      
      public function AvatarRender()
      {
         super();
         _avatarContainer = new Sprite();
         addChild(_avatarContainer);
      }
      
      override public function set x(param1:Number) : void
      {
         var _loc3_:Point = null;
         var _loc2_:Point = null;
         var _loc4_:int;
         super.x = _loc4_ = param1 + 0.5;
         if(_nameView)
         {
            if(parent)
            {
               _loc3_ = localToGlobal(new Point());
               _loc2_ = _nameView.parent.globalToLocal(_loc3_);
               _nameView.x = _loc2_.x;
            }
            else
            {
               _nameView.x = super.x;
            }
         }
         updateQTree();
      }
      
      override public function set y(param1:Number) : void
      {
         var _loc3_:Point = null;
         var _loc2_:Point = null;
         var _loc4_:int;
         super.y = _loc4_ = param1 + 0.5;
         if(_nameView)
         {
            if(parent)
            {
               _loc3_ = localToGlobal(new Point());
               _loc2_ = _nameView.parent.globalToLocal(_loc3_);
               _nameView.y = _loc2_.y;
            }
            else
            {
               _nameView.y = super.y;
            }
         }
         updateQTree();
      }
      
      private function updateQTree() : void
      {
         if(!qtree)
         {
            qtree = Global.qtree.add(this,this.x,this.y);
         }
         else
         {
            qtree = qtree.readd(this,this.x,this.y);
         }
      }
      
      protected function startLoad() : void
      {
         var _loc1_:AvatarPart = null;
         var _loc2_:AvatarPartInfo = null;
         if(_avatarInfo.avatarPartInfoList.length > 0)
         {
            _isLoadComplete = false;
            _loc2_ = _avatarInfo.avatarPartInfoList.pop();
            _loc1_ = this.getAvatarPart(_loc2_.partPosition);
            if(_loc1_)
            {
               removePart(_loc1_);
               _loc1_.dispose();
            }
            if(!_loc2_.url)
            {
               startLoad();
               return;
            }
            if(_loc2_.partPosition == "pet")
            {
               startLoad();
               return;
            }
            _loc1_ = new AvatarPart(_avatarContainer,_loc2_.url);
            _avatarPartList.push(_loc1_);
            _loc1_.partPosition = _loc2_.partPosition;
            if(Global.avatarPartParams[_loc2_.url])
            {
               if(_loc2_.partPosition != "pet")
               {
                  handlerWithParams(Global.avatarPartParams[_loc2_.url]);
               }
               startLoad();
            }
            else
            {
               _loader = new AvatarAtfLoader(loaderPriority);
               _loader.partInfo = _loc2_;
               _loader.addEventListener("complete",__completeHandler);
               _loader.load(_loc2_.url);
            }
         }
         else
         {
            _isLoadComplete = true;
            defaultView();
         }
      }
      
      protected function showPet(param1:ArmyPetInfo) : void
      {
         if(param1 && param1.petTemplate)
         {
            if(!_petPart)
            {
               _petPart = new PetRender();
            }
         }
         else
         {
            if(_petPart)
            {
               _petPart.dispose();
            }
            _petPart = null;
         }
      }
      
      protected function defaultView() : void
      {
         action("S",3);
         showOther();
         if(_nameView)
         {
            _nameView.layout();
         }
      }
      
      public function getAvatarPart(param1:String) : AvatarPart
      {
         for each(var _loc2_:AvatarPart in _avatarPartList)
         {
            if(_loc2_.partPosition == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function removePart(param1:AvatarPart) : void
      {
         var _loc2_:int = _avatarPartList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            if(param1.partPosition == "mount" || param1.partPosition == "mount_mount")
            {
               flight = 0;
               offsetY = 0;
            }
            _avatarPartList.splice(_loc2_,1);
         }
      }
      
      protected function clearAllParts() : void
      {
         var _loc1_:AvatarPart = null;
         flight = 0;
         offsetY = 0;
         if(!_avatarPartList)
         {
            return;
         }
         while(_avatarPartList.length > 0)
         {
            _loc1_ = _avatarPartList.pop() as AvatarPart;
            _loc1_.dispose();
         }
         this.sizeType = 1;
      }
      
      protected function showOther() : void
      {
      }
      
      private function __completeHandler(param1:Event) : void
      {
         var _loc3_:AvatarAtfLoader = param1.currentTarget as AvatarAtfLoader;
         if(_loc3_.atfData)
         {
            AtfDecoder.avatarAtfDecode(_loc3_.path,_loc3_.atfData,_loc3_.atlData);
         }
         var _loc2_:Object = Global.avatarPartParams[_loc3_.path];
         if(_loc3_.partInfo.partPosition != "pet")
         {
            handlerWithParams(_loc2_);
         }
         if(_loc3_ == _loader)
         {
            _loader = null;
         }
         startLoad();
      }
      
      private function handlerWithParams(param1:Object) : void
      {
         if(param1)
         {
            if(param1.hasOwnProperty("sizeType") && param1.sizeType != 0)
            {
               sizeType = getMaxSizeType(sizeType,param1.sizeType);
            }
            if(param1.hasOwnProperty("flight") && param1.flight != 0)
            {
               flight = param1.flight;
            }
            if(param1.hasOwnProperty("offsetY") && param1.offsetY != 0)
            {
               offsetY = param1.offsetY;
            }
         }
      }
      
      private function getMaxSizeType(param1:int, param2:int) : int
      {
         var _loc3_:int = int(AvatarPart.sizeMax[param1].size);
         var _loc4_:int = int(AvatarPart.sizeMax[param2].size);
         if(_loc3_ > _loc4_)
         {
            return param1;
         }
         return param2;
      }
      
      private function fitDirectionByAction(param1:String, param2:int) : int
      {
         var _loc3_:int = 0;
         if(param1 == "S")
         {
            _loc3_ = 2;
            if(sizeType != 10)
            {
               if(param2 == 1 || param2 == 0)
               {
                  _loc3_ = 0;
               }
               else if(param2 == 3 || param2 == 2)
               {
                  _loc3_ = 1;
               }
            }
            else
            {
               _loc3_ = 0;
            }
            return _loc3_;
         }
         return param2;
      }
      
      protected function setFrame() : void
      {
         if(_currentAction == "S")
         {
            _stepFrame = 5;
         }
         else if(isMount)
         {
            _stepFrame = 2;
         }
         else
         {
            _stepFrame = 3;
         }
      }
      
      override public function action(param1:String, param2:int) : void
      {
         var _loc4_:AvatarPart = null;
         var _loc5_:int = 0;
         var _loc8_:String = null;
         var _loc6_:Dictionary = null;
         var _loc7_:Dictionary = null;
         if(!_isLoadComplete)
         {
            return;
         }
         param2 = fitDirectionByAction(param1,param2);
         _currentAction = param1;
         _currentDirection = param2;
         setFrame();
         for each(_loc4_ in _avatarPartList)
         {
            _loc4_.initDepth(param1,param2);
         }
         _avatarPartList.sortOn("depth",0x10 | 2);
         var _loc3_:int = int(_avatarPartList.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _avatarPartList[_loc5_];
            _loc8_ = _loc4_.partName + "_" + param1 + "_" + param2;
            _loc6_ = Global.avatarPartPostion[_loc8_];
            _loc7_ = Global.avatarHitData[_loc8_];
            _loc4_.changeAnimation(param1,param2,_loc6_,_loc7_);
            _loc5_++;
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:AvatarPart = null;
         _step = _step + 1;
         execute();
         if(_petPart)
         {
            _petPart.advanceTime(param1);
         }
         if(_nameView)
         {
            _nameView.execute();
         }
         if(_step % _stepFrame == 0 && _avatarPartList)
         {
            _loc2_ = int(_avatarPartList.length);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = _avatarPartList[_loc4_];
               if(_loc3_.partPosition == "mount" || _loc3_.partPosition == "mount_mount")
               {
                  _loc3_.offsetY = flight;
               }
               else if(_loc3_.partPosition == "pet" || _loc3_.partPosition == "pet_mount")
               {
                  _loc3_.offsetY = 0;
               }
               else
               {
                  _loc3_.offsetY = flight + offsetY;
               }
               _loc3_.advanceTime(param1);
               _loc4_++;
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_loader)
         {
            _loader.removeEventListener("complete",__completeHandler);
            _loader.dispose();
         }
         _avatarContainer = null;
         _avatarInfo = null;
         if(_petPart)
         {
            _petPart.dispose();
            _petPart = null;
         }
         if(_nameView)
         {
            _nameView.dispose();
            _nameView = null;
         }
         for each(var _loc1_:AvatarPart in _avatarPartList)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _avatarPartList = null;
         if(qtree)
         {
            qtree.remove(this,this.x,this.y);
            qtree = null;
         }
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      public function set isPlaying(param1:Boolean) : void
      {
         _isPlaying = param1;
         if(_nameView)
         {
            _nameView.isPlaying = param1;
         }
      }
      
      public function get sizeType() : int
      {
         return _sizeType;
      }
      
      public function set sizeType(param1:int) : void
      {
         if(_sizeType == param1)
         {
            return;
         }
         _sizeType = param1;
         var _loc2_:Object = AvatarPart.sizeMax[param1];
         if(!_loc2_)
         {
            return;
         }
      }
      
      public function setAvatarFilter(param1:FragmentFilter) : void
      {
         if(_avatarContainer)
         {
            _avatarContainer.filter = param1;
         }
      }
      
      public function getPointIsHitable(param1:Point) : Boolean
      {
         if(this.hitTest(param1,true))
         {
            for each(var _loc2_:AvatarPart in _avatarPartList)
            {
               if(_loc2_.getPointIsHitable(param1))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get avatarContainer() : Sprite
      {
         return _avatarContainer;
      }
      
      public function get isMount() : Boolean
      {
         return _isMount;
      }
      
      public function set isMount(param1:Boolean) : void
      {
         _isMount = param1;
      }
   }
}

