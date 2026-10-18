package consortia.view.crossguild.war
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.crossguild.CrossGuildModel;
   import utils.LogicUtils;
   import yishi.manager.CrossGuildManager;
   
   public class CrossGuildWarTowerView extends Component
   {
      
      private var _greenContiner:Component;
      
      private var _redContiner:Component;
      
      private var greenList:Vector.<CrossGuildWarTowerNodeView>;
      
      private var redList:Vector.<CrossGuildWarTowerNodeView>;
      
      private var nodePosAryLeft12:Array = [[227,356],[227,650],[640,240],[640,540],[640,830],[1028,240],[1028,540],[1028,830],[1400,196],[1400,410],[1400,650],[1400,880]];
      
      private var nodePosAryRight12:Array = [[1456,356],[1456,650],[1100,240],[1100,540],[1100,830],[720,240],[720,540],[720,830],[323,196],[323,410],[323,650],[323,880]];
      
      public function CrossGuildWarTowerView()
      {
         super();
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         _greenContiner = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarTowerView.greenContiner");
         _redContiner = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarTowerView.redContiner");
         addChild(_greenContiner);
         addChild(_redContiner);
         greenList = new Vector.<CrossGuildWarTowerNodeView>();
         redList = new Vector.<CrossGuildWarTowerNodeView>();
         initNodeView(1,_greenContiner,greenList);
         initNodeView(0,_redContiner,redList);
      }
      
      private function initNodeView(param1:int, param2:Component, param3:Vector.<CrossGuildWarTowerNodeView>) : void
      {
         var _loc6_:int = 0;
         var _loc4_:CrossGuildWarTowerNodeView = null;
         var _loc5_:Array = getPosAry(param1);
         _loc6_ = 1;
         while(_loc6_ <= model.defendNum)
         {
            _loc4_ = new CrossGuildWarTowerNodeView(param1,_loc6_);
            _loc4_.x = _loc5_[_loc6_ - 1][0];
            _loc4_.y = _loc5_[_loc6_ - 1][1];
            param2.addChild(_loc4_);
            param3.push(_loc4_);
            _loc6_++;
         }
      }
      
      private function getPosAry(param1:int) : Array
      {
         return param1 == 0 ? nodePosAryRight12 : nodePosAryLeft12;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:CrossGuildWarTowerNodeView = null;
         var _loc2_:CrossGuildWarTowerNodeView = null;
         _loc3_ = 1;
         while(_loc3_ <= model.defendNum)
         {
            _loc1_ = greenList[_loc3_ - 1];
            _loc1_.data = model.greenTeamInfo.towerDic[_loc3_];
            _loc2_ = redList[_loc3_ - 1];
            _loc2_.data = model.redTeamInfo.towerDic[_loc3_];
            _loc3_++;
         }
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_greenContiner);
         _greenContiner = null;
         ObjectUtils.disposeObject(_redContiner);
         _redContiner = null;
         LogicUtils.disposeDisplayCollection(greenList);
         greenList = null;
         LogicUtils.disposeDisplayCollection(redList);
         redList = null;
         super.dispose();
      }
   }
}

