package magicspring
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import magicspring.item.MagicSpringSlotItem;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringModel;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   
   public class MagicSpringSlotTopView extends Component
   {
      
      private var _slotHbox:HBox;
      
      private var slotList:Vector.<MagicSpringSlotItem>;
      
      public function MagicSpringSlotTopView()
      {
         super();
         initView();
         initListView();
         addEvent();
      }
      
      private function initView() : void
      {
         _slotHbox = ComponentFactory.Instance.creatComponentByStylename("MagicSpringSlotTopView.slotHbox");
         addChild(_slotHbox);
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MagicSpringSlotItem = null;
         slotList = new Vector.<MagicSpringSlotItem>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new MagicSpringSlotItem(_loc2_ + 1);
            _loc1_.data = _loc2_ < model.slotList.length ? model.slotList[_loc2_] : null;
            _slotHbox.addChild(_loc1_);
            slotList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__leftTimeHandler);
      }
      
      private function removeEvent() : void
      {
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__leftTimeHandler);
      }
      
      private function __leftTimeHandler(param1:PlayerEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:MagicSpringSlotItem = null;
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = slotList[_loc3_];
            _loc2_.refreshLeftTime();
            _loc3_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MagicSpringSlotItem = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = slotList[_loc2_];
            _loc1_.data = _loc2_ < model.slotList.length ? model.slotList[_loc2_] : null;
            _loc2_++;
         }
      }
      
      public function get model() : MagicSpringModel
      {
         return MagicSpringManager.instance.model;
      }
      
      public function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_slotHbox);
         _slotHbox = null;
         LogicUtils.disposeDisplayCollection(slotList);
         slotList = null;
         super.dispose();
      }
   }
}

