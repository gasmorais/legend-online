package armyII.viewII.stone
{
   import armyII.viewII.stone.item.StoneCardItem;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   
   public class ArmyShowGetFrame extends Frame
   {
      
      private var _listPanle:SimpleTileList;
      
      private var _one:StoneCardItem;
      
      private var _confrimBtn:IconButton;
      
      private var _itemList:Array = [];
      
      private var _mcList:Array = [];
      
      public function ArmyShowGetFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _listPanle = ComponentFactory.Instance.creatCustomObject("army.stone.getShow.SimpleTileList",[5]);
         _confrimBtn = ComponentFactory.Instance.creatComponentByStylename("armyII.getShow.ConfrimBtn");
         _one = new StoneCardItem();
         _one.x = 239;
         _one.y = -21;
         addToContent(_listPanle);
         addToContent(_one);
         addToContent(_confrimBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confrimBtn.addEventListener("click",confirmHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confrimBtn.removeEventListener("click",confirmHandler);
      }
      
      private function confirmHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_listPanle);
         _listPanle = null;
         ObjectUtils.disposeObject(_one);
         _one = null;
         ObjectUtils.disposeObject(_confrimBtn);
         _confrimBtn = null;
         super.dispose();
      }
      
      public function show(param1:String) : void
      {
         var _loc4_:GoodsInfo = null;
         var _loc8_:Array = null;
         var _loc7_:String = null;
         var _loc2_:StoneCardItem = null;
         var _loc5_:int = 0;
         var _loc6_:Array = param1.split("|");
         var _loc3_:int = int(_loc6_.length);
         if(_loc3_ == 1)
         {
            _loc7_ = _loc6_[0];
            _loc8_ = _loc7_.split(",");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = int(_loc8_[0]);
            _loc4_.count = int(_loc8_[1]);
            _one.updateView(_loc4_,0.2);
         }
         else
         {
            _listPanle.beginChanges();
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc2_ = new StoneCardItem();
               _loc7_ = _loc6_[_loc5_];
               _loc8_ = _loc7_.split(",");
               _loc4_ = new GoodsInfo();
               _loc4_.templateId = int(_loc8_[0]);
               _loc4_.count = int(_loc8_[1]);
               _loc2_.updateView(_loc4_,0.2 * _loc5_);
               _itemList[_loc5_] = _loc2_;
               _listPanle.addChild(_loc2_);
               _loc5_++;
            }
            _listPanle.commitChanges();
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

