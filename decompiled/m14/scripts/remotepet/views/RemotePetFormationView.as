package remotepet.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import events.RemotePetEvent;
   import managers.RemotePetManager;
   import mvc.module.pet.PetData;
   import mvc.module.remotepet.RemotePetModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   
   public class RemotePetFormationView extends Component
   {
      
      private var _back:MutipleImage;
      
      private var _bottoms:Array;
      
      private var posArray:Array = [[],[1,3],[4,6],[7,9],[10,12]];
      
      public function RemotePetFormationView()
      {
         super();
         initView();
         addEvent();
         refresh();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:RemotePetFormationItemView = null;
         _back = ComponentFactory.Instance.creatComponentByStylename("remote.RemotePetFormationView.back");
         addChild(_back);
         _bottoms = [];
         var _loc1_:Array = [{
            "x":276,
            "y":196
         },{
            "x":234,
            "y":254
         },{
            "x":191,
            "y":306
         },{
            "x":141,
            "y":356
         },{
            "x":485,
            "y":196
         },{
            "x":447,
            "y":254
         },{
            "x":401,
            "y":306
         },{
            "x":351,
            "y":356
         }];
         var _loc3_:Array = [3,6,9,12,1,4,7,10];
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc2_ = new RemotePetFormationItemView(_loc3_[_loc4_]);
            _loc2_.x = _loc1_[_loc4_].x;
            _loc2_.y = _loc1_[_loc4_].y;
            addChild(_loc2_);
            _bottoms[_loc4_] = _loc2_;
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         model.addEventListener("COMMIT",__commitHandler);
         model.addEventListener("PET_CHANGE",__petChangeHandler);
         NotificationManager.instance.addEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.addEventListener("END_DRAG",__endDragHandler);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("COMMIT",__commitHandler);
         model.removeEventListener("PET_CHANGE",__petChangeHandler);
         NotificationManager.instance.removeEventListener("START_DRAG",__startDragHandler);
         NotificationManager.instance.removeEventListener("END_DRAG",__endDragHandler);
      }
      
      private function __startDragHandler(param1:NotificationEvent) : void
      {
         var _loc4_:int = 0;
         if(param1.data && param1.data.data && param1.data.data.petId)
         {
            _loc4_ = int(param1.data.data.petId);
         }
         var _loc2_:Array = getCanNotDrops(_loc4_);
         for each(var _loc3_:RemotePetFormationItemView in _bottoms)
         {
            if(_loc2_.indexOf(_loc3_.pos) == -1)
            {
               _loc3_.setBottomVisible(true);
               _loc3_.dark();
            }
         }
      }
      
      private function __endDragHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Array = [];
         for each(var _loc4_:RemotePetFormationItemView in _bottoms)
         {
            _loc4_.setBottomVisible(false);
            _loc4_.normal();
            if(_loc4_.data)
            {
               _loc2_[_loc4_.pos] = _loc4_.data.petId;
            }
            else
            {
               _loc2_[_loc4_.pos] = -1;
            }
         }
         var _loc3_:Array = [_loc2_[1],_loc2_[4],_loc2_[7],_loc2_[10],_loc2_[3],_loc2_[6],_loc2_[9],_loc2_[12]];
         model.petListInfo.formationString = _loc3_.join(",");
      }
      
      private function getCanNotDrops(param1:int) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         for each(var _loc3_:RemotePetFormationItemView in _bottoms)
         {
            if(_loc3_.data && _loc3_.data.petId != param1)
            {
               _loc4_ = Math.ceil(_loc3_.pos / 3);
               _loc2_ = _loc2_.concat(posArray[_loc4_]);
            }
         }
         return _loc2_;
      }
      
      private function __commitHandler(param1:RemotePetEvent) : void
      {
         refresh();
      }
      
      private function __petChangeHandler(param1:RemotePetEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.length == 1)
         {
            addPet(_loc2_[0] as PetData);
         }
         else
         {
            changePet(_loc2_);
         }
         __endDragHandler(null);
      }
      
      private function addPet(param1:PetData) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:Array = getCanNotDrops(param1.petId);
         for each(var _loc3_:RemotePetFormationItemView in _bottoms)
         {
            if(_loc2_.indexOf(_loc3_.pos) == -1)
            {
               _loc3_.data = param1;
               break;
            }
         }
      }
      
      private function changePet(param1:Array) : void
      {
         if(param1[0])
         {
            for each(var _loc2_:RemotePetFormationItemView in _bottoms)
            {
               if(_loc2_.data == param1[0])
               {
                  _loc2_.data = param1[1];
               }
            }
         }
         else
         {
            addPet(param1[1]);
         }
      }
      
      private function refresh() : void
      {
         var _loc1_:Array = model.petListInfo.remotePetFormationOfArray;
         var _loc4_:Array = [-1,_loc1_[0],-1,_loc1_[4],_loc1_[1],-1,_loc1_[5],_loc1_[2],-1,_loc1_[6],_loc1_[3],-1,_loc1_[7]];
         var _loc3_:int = 0;
         for each(var _loc2_:RemotePetFormationItemView in _bottoms)
         {
            _loc2_.setBottomVisible(false);
            _loc3_ = int(_loc4_[_loc2_.pos]);
            _loc2_.data = model.petListInfo.getPet(_loc3_);
         }
      }
      
      private function get model() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      private function uintView() : void
      {
         var _loc1_:* = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         for each(_loc1_ in _bottoms)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _bottoms = null;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         DragManager.getInstance().stopDrag();
         super.dispose();
      }
   }
}

