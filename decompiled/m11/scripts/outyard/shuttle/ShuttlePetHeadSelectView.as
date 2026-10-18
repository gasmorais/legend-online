package outyard.shuttle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.shuttle.ShuttleInfoMsg;
   import flash.events.MouseEvent;
   import mvc.module.pet.PetData;
   import yishi.manager.OutyardManager;
   
   public class ShuttlePetHeadSelectView extends Component
   {
      
      private static const COLUMN_NUM:int = 6;
      
      private static const ROW_NUM:int = 3;
      
      private var _bg:ScaleBitmapImage;
      
      private var _callBack:Function;
      
      private var _petLists:Vector.<ShuttlePetHeadSelectItemView>;
      
      public function ShuttlePetHeadSelectView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:ShuttlePetHeadSelectItemView = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetHeadSelectView.bg");
         addChild(_bg);
         _bg.mouseChildren = _bg.mouseEnabled = false;
         _petLists = new Vector.<ShuttlePetHeadSelectItemView>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc3_ = 0;
            while(_loc3_ < 6)
            {
               _loc1_ = new ShuttlePetHeadSelectItemView();
               _loc1_.tipStyle = "yishi.view.tips.RemotePetTip";
               _loc1_.isFollowMouse = false;
               _loc1_.tipDirctions = "4,6,5,7,0,1,2,3";
               _loc1_.x = _loc3_ * 55 + 10;
               _loc1_.y = _loc2_ * 55 + 8;
               _petLists.push(_loc1_);
               addChild(_loc1_);
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function show(param1:Array, param2:PetData, param3:Function) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         _callBack = param3;
         _loc7_ = 0;
         while(_loc7_ < param1.length)
         {
            if(_petLists.length <= _loc7_)
            {
               break;
            }
            _loc5_ = false;
            _loc6_ = 0;
            for each(_loc4_ in petList)
            {
               if(_loc4_ > 0 && _loc4_ == param1[_loc7_].petId)
               {
                  _loc5_ = true;
               }
            }
            if(!_loc5_)
            {
               _petLists[_loc7_].data = param1[_loc7_];
               _petLists[_loc7_].filters = [];
            }
            _loc7_++;
         }
         addEvent();
         LayerManager.Instance.addToLayer(this,7);
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__mouseClickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__mouseClickHandler);
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:ShuttlePetHeadSelectItemView = null;
         if(param1.target is ShuttlePetHeadSelectItemView)
         {
            _loc2_ = param1.target as ShuttlePetHeadSelectItemView;
         }
         if(_loc2_ && _loc2_.data && _callBack != null)
         {
            _callBack(_loc2_.data);
         }
         dispose();
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         _petLists = null;
      }
      
      private function get petList() : Array
      {
         var _loc1_:ShuttleInfoMsg = OutyardManager.instance.shuttleModel.shuttleMsg;
         if(!_loc1_)
         {
            return [];
         }
         return _loc1_.petList;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         removeEvent();
         uintView();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
         _callBack = null;
      }
   }
}

