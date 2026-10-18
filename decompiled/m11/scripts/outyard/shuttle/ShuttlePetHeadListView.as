package outyard.shuttle
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ArrayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.shuttle.ShuttleInfoMsg;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mvc.module.pet.PetData;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   
   public class ShuttlePetHeadListView extends Component
   {
      
      private var _petHeadList:Vector.<ShuttlePetHeadItemView>;
      
      private var _currentSelectedItem:ShuttlePetHeadItemView;
      
      private var _selectPetView:ShuttlePetHeadSelectView;
      
      private var _petList:Array = [];
      
      private var _petTxtNoteBmp:Bitmap;
      
      private var _petSetBtn:IconButton;
      
      private var _fightBtn:IconButton;
      
      public function ShuttlePetHeadListView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:ShuttlePetHeadItemView = null;
         _petTxtNoteBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.shuttle.petTxtNoteBmp");
         _petSetBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttle.petSetBtn");
         _fightBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.shuttle.fightBtn");
         addChild(_petTxtNoteBmp);
         addChild(_petSetBtn);
         addChild(_fightBtn);
         _petHeadList = new Vector.<ShuttlePetHeadItemView>(3);
         var _loc2_:Array = [{
            "x":0,
            "y":-5
         },{
            "x":64,
            "y":-5
         },{
            "x":128,
            "y":-5
         }];
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc1_ = new ShuttlePetHeadItemView(_loc3_);
            _loc1_.x = _loc2_[_loc3_].x;
            _loc1_.y = _loc2_[_loc3_].y;
            _loc1_.addEventListener("click",__mouseClickHandler);
            addChild(_loc1_);
            _petHeadList[_loc3_] = _loc1_;
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         _petSetBtn.addEventListener("click",__petSetHandler);
         _fightBtn.addEventListener("click",__fightClickHandler);
      }
      
      private function removeEvent() : void
      {
         _petSetBtn.removeEventListener("click",__petSetHandler);
         _fightBtn.removeEventListener("click",__fightClickHandler);
         if(_selectPetView)
         {
            _selectPetView.removeEventListener("dispose",__selectDisposeHandler1);
         }
      }
      
      private function __petSetHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         SoundManager.instance.play("022");
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < _petHeadList.length)
         {
            if(!_petHeadList[_loc3_].data)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         _petHeadList[_loc2_].dispatchEvent(new MouseEvent("click"));
      }
      
      private function __fightClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("outyard",6);
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ShuttleInfoMsg = OutyardManager.instance.shuttleModel.shuttleMsg;
         if(!_loc1_)
         {
            return;
         }
         _petList = ArrayUtils.cloneArray(_loc1_.petList);
         _loc2_ = 0;
         while(_loc2_ < _petHeadList.length)
         {
            if(_petList[_loc2_] != 0)
            {
               _petHeadList[_loc2_].data = getPet(_petList[_loc2_]);
            }
            else
            {
               _petHeadList[_loc2_].data = null;
            }
            _loc2_++;
         }
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(_selectPetView)
         {
            ObjectUtils.disposeObject(_selectPetView);
            _selectPetView = null;
         }
         if(param1.currentTarget is ShuttlePetHeadItemView)
         {
            _currentSelectedItem = param1.currentTarget as ShuttlePetHeadItemView;
            _currentSelectedItem.bright = true;
         }
         if(_currentSelectedItem)
         {
            _selectPetView = new ShuttlePetHeadSelectView();
            _selectPetView.show(playerInfo.petList,_currentSelectedItem["data"],selectPet);
            _selectPetView.addEventListener("dispose",__selectDisposeHandler1);
            _loc2_ = new Point(_currentSelectedItem.displayWidth / 2,0);
            _loc2_ = _currentSelectedItem.localToGlobal(_loc2_);
            _selectPetView.x = _loc2_.x - _selectPetView.displayWidth / 2;
            _selectPetView.y = _loc2_.y + 48;
            if(_selectPetView.x + _selectPetView.displayWidth > StageReferance.stageWidth)
            {
               _selectPetView.x = StageReferance.stageWidth - _selectPetView.displayWidth;
            }
         }
         param1.stopPropagation();
      }
      
      private function selectPet(param1:PetData) : void
      {
         _petList[_currentSelectedItem.pos] = param1.petId;
         OutyardManager.instance.OperateShuttle(2,0,0,0,0,_petList);
         _selectPetView = null;
      }
      
      private function __selectDisposeHandler1(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(_selectPetView)
         {
            _selectPetView.removeEventListener("dispose",__selectDisposeHandler1);
         }
         _selectPetView = null;
         _loc2_ = 0;
         while(_loc2_ < _petHeadList.length)
         {
            _petHeadList[_loc2_].bright = false;
            _loc2_++;
         }
      }
      
      private function getPet(param1:int) : PetData
      {
         var _loc2_:int = 0;
         var _loc3_:Array = PlayerManager.instance.currentPlayerModel.playerInfo.petList;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_].petId == param1)
            {
               return _loc3_[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_petTxtNoteBmp);
         _petTxtNoteBmp = null;
         ObjectUtils.disposeObject(_petSetBtn);
         _petSetBtn = null;
         ObjectUtils.disposeObject(_fightBtn);
         _fightBtn = null;
         if(_petHeadList)
         {
            for each(var _loc1_:Object in _petHeadList)
            {
               _loc1_.removeEventListener("click",__mouseClickHandler);
               ObjectUtils.disposeObject(_loc1_);
            }
            _petHeadList.length = 0;
            _petHeadList = null;
         }
         _currentSelectedItem = null;
         _selectPetView = null;
         _petList = null;
         super.dispose();
      }
   }
}

