package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FarmInfo;
   import farm.data.FarmLandInfo;
   import farm.event.FarmEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PlayerManager;
   
   public class FarmAnimalArea extends Sprite implements IEnterFrame
   {
      
      private static const AREA_POS:Object = {
         0:0,
         1:1
      };
      
      private var _lineArea:MovieClip;
      
      private var _type:int;
      
      private var _userId:int;
      
      private var _data:FarmInfo;
      
      private var _points:Array;
      
      private var _animalObj:Object;
      
      private var _posFlagObj:Object;
      
      private var _w:int;
      
      private var _h:int;
      
      private var _indexArr:Array;
      
      private var _animalSprite:Sprite;
      
      private var _tempArr:Array;
      
      public function FarmAnimalArea(param1:int, param2:Array)
      {
         super();
         _w = param2[0].length;
         _h = param2.length;
         _type = param1;
         _points = param2;
         _animalObj = {};
         initPosFlagObj();
         initView();
         addEvent();
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      private function initPosFlagObj() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _posFlagObj = {};
         _indexArr = [];
         _loc1_ = 0;
         while(_loc1_ < _w)
         {
            _loc2_ = 0;
            while(_loc2_ < _h)
            {
               _indexArr.push([_loc1_,_loc2_]);
               _loc2_++;
            }
            _loc1_++;
         }
         _indexArr = randomArray(_indexArr);
      }
      
      private function randomArray(param1:Array) : Array
      {
         var arr:Array = param1;
         var random_fun:* = function(param1:*, param2:*):int
         {
            if(Math.random() < 0.5)
            {
               return -1;
            }
            return 1;
         };
         return arr.sort(random_fun);
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      public function get userId() : int
      {
         _userId = PlayerManager.instance.currentPlayerModel.userInfo.userId;
         return _userId;
      }
      
      private function initView() : void
      {
         this.mouseEnabled = false;
         _lineArea = ComponentFactory.Instance.creatCustomObject("PastureView.lineArea");
         _animalSprite = new Sprite();
         addChild(_lineArea);
         addChild(_animalSprite);
      }
      
      private function addAnimalItem(param1:FarmLandInfo) : void
      {
         var _loc2_:FarmAnimalItem = _animalObj[param1.pos];
         if(_loc2_ == null)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("farm.FarmAnimalItem",[this,_w,_h,_points]);
            _animalObj[param1.pos] = _loc2_;
         }
         if(param1.hasCrop)
         {
            _animalSprite.addChild(_loc2_);
         }
         _loc2_.data = param1;
      }
      
      public function enterFrame() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Object = null;
         var _loc3_:int = 0;
         _tempArr = [];
         _loc2_ = 0;
         while(_loc2_ < this._animalSprite.numChildren)
         {
            _loc1_ = this._animalSprite.getChildAt(_loc2_);
            _tempArr.push({
               "obj":_loc1_,
               "x":_loc1_.x,
               "y":_loc1_.y,
               "index":_loc2_
            });
            _loc2_++;
         }
         _tempArr = _tempArr.sortOn(["y","x","index"],[16,16,16]);
         _loc3_ = 0;
         while(_loc3_ < this._animalSprite.numChildren)
         {
            this._animalSprite.setChildIndex(_tempArr[_loc3_].obj,_loc3_);
            _loc3_++;
         }
      }
      
      public function updateView() : void
      {
         var _loc1_:FarmAnimalItem = null;
         var _loc4_:int = 0;
         var _loc5_:FarmLandInfo = null;
         for(var _loc2_:String in _animalObj)
         {
            _loc1_ = _animalObj[_loc2_];
            if(this._animalSprite.contains(_loc1_))
            {
               _animalSprite.removeChild(_loc1_);
            }
         }
         if(!data)
         {
            return;
         }
         var _loc3_:Array = data.animalList;
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_];
            addAnimalItem(_loc5_);
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         _lineArea.addEventListener("click",_onbackClick);
         model.addEventListener("SELECTED_CHANGE",__selectedFarmChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _lineArea.removeEventListener("click",_onbackClick);
         model.removeEventListener("SELECTED_CHANGE",__selectedFarmChangeHandler);
      }
      
      private function _onbackClick(param1:MouseEvent) : void
      {
         if(model.checkIsSelf(data.userId))
         {
            FarmManager.instance.openBagFrame();
         }
      }
      
      private function __selectedFarmChangeHandler(param1:FarmEvent) : void
      {
         data = param1.data as FarmInfo;
      }
      
      public function set data(param1:FarmInfo) : void
      {
         if(_data == param1)
         {
            return;
         }
         FarmManager.instance.closeBagFrame();
         _data = param1;
         updateView();
      }
      
      public function get data() : FarmInfo
      {
         return _data;
      }
      
      private function _onBgClick(param1:MouseEvent) : void
      {
         if(model.checkIsSelf(model.masterId))
         {
            farmManager.openBagFrame();
         }
      }
      
      private function get farmManager() : FarmManager
      {
         return FarmManager.instance;
      }
      
      public function getInitPoint() : Point
      {
         var _loc3_:Point = null;
         var _loc1_:int = 0;
         var _loc2_:String = null;
         _loc1_ = 0;
         while(_loc1_ < _indexArr.length)
         {
            _loc2_ = getIndexStr(_indexArr[_loc1_][0],_indexArr[_loc1_][1]);
            if(_posFlagObj[_loc2_] != 1)
            {
               _loc3_ = new Point(_indexArr[_loc1_][0],_indexArr[_loc1_][1]);
               _posFlagObj[_loc2_] = 1;
               return _loc3_;
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      public function hasAnimalByPos(param1:int, param2:int) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:String = getIndexStr(param1,param2);
         if(_posFlagObj[_loc4_] == 1)
         {
            _loc3_ = true;
         }
         else
         {
            _posFlagObj[_loc4_] = 1;
         }
         return _loc3_;
      }
      
      public function cleanAnimalByPos(param1:int, param2:int) : void
      {
         var _loc3_:String = getIndexStr(param1,param2);
         _posFlagObj[_loc3_] = 0;
      }
      
      private function getIndexStr(param1:int, param2:int) : String
      {
         return param1 + "_" + param2;
      }
      
      public function dispose() : void
      {
         removeEvent();
         _data = null;
         _points = null;
         _posFlagObj = null;
         _indexArr = null;
         for each(var _loc1_:FarmAnimalItem in _animalObj)
         {
            if(_loc1_ != null)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
         }
         _animalObj = null;
         if(_lineArea)
         {
            ObjectUtils.disposeObject(_lineArea);
         }
         _lineArea = null;
         ObjectUtils.disposeObject(_animalSprite);
         ObjectUtils.disposeAllChildren(this);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

