package battle.view.ui.top
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import utils.LogicUtils;
   import yishi.datas.BattleModel;
   import yishi.manager.NotificationManager;
   import yishi.utils.MsgMan;
   
   public class BattleGoddessTopView extends Component
   {
      
      private var _hbox:HBox;
      
      private var itemList:Vector.<BattleGoddessTopItem>;
      
      private var side:int;
      
      public function BattleGoddessTopView(param1:int)
      {
         super();
         side = param1;
         initView();
         initListView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _hbox = ComponentFactory.Instance.creatComponentByStylename("BattleGoddessTopView.hbox");
         addChild(_hbox);
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BattleGoddessTopItem = null;
         itemList = new Vector.<BattleGoddessTopItem>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new BattleGoddessTopItem();
            _hbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("GODDESS_BELIEF_CHANGE",this,__updateGoddessBeliefHandler);
         NotificationManager.instance.addEventListener("BATTLE_REINFORCE_HANDLER",__refreshViewHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("GODDESS_BELIEF_CHANGE",this,__updateGoddessBeliefHandler);
         NotificationManager.instance.removeEventListener("BATTLE_REINFORCE_HANDLER",__refreshViewHandler);
      }
      
      private function __refreshViewHandler(param1:BattleEvent) : void
      {
         refreshView();
      }
      
      private function __updateGoddessBeliefHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BattleGoddessTopItem = null;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = itemList[_loc2_];
            _loc1_.data = battleModel.heroList[_loc2_ + "_" + side];
            _loc2_++;
         }
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList;
         super.dispose();
      }
   }
}

