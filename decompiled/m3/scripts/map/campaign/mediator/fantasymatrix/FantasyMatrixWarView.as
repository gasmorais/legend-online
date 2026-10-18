package map.campaign.mediator.fantasymatrix
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.fantasymatirx.FantasyMatrixNodeMsg;
   import map.campaign.CampaignManager;
   import map.campaign.data.FantasyMatrixModel;
   import map.campaign.data.FantasyMatrixNodeInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.utils.MsgMan;
   
   public class FantasyMatrixWarView extends Component implements IEnterFrame
   {
      
      private var nodeContiner:Component;
      
      private var nodeViewList:Array;
      
      public function FantasyMatrixWarView()
      {
         super();
         initView();
         initNodeListView();
         addEvent();
      }
      
      private function initView() : void
      {
         nodeContiner = ComponentFactory.Instance.creatComponentByStylename("FantasyMatrixWarView.nodeContiner");
         addChild(nodeContiner);
      }
      
      private function initNodeListView() : void
      {
         var _loc4_:FantasyMatrixNodeInfo = null;
         var _loc2_:int = 0;
         var _loc1_:FantasyMatrixWarNodeView = null;
         var _loc3_:int = 0;
         nodeViewList = [];
         _loc2_ = 0;
         while(_loc2_ < model.nodeArr.length)
         {
            _loc4_ = model.nodeArr[_loc2_];
            _loc1_ = new FantasyMatrixWarNodeView();
            _loc1_.data = _loc4_;
            nodeContiner.addChild(_loc1_);
            nodeViewList.push(_loc1_);
            _loc1_.x = (_loc4_.posX + _loc4_.posY) * 100 + 105;
            _loc1_.y = (_loc4_.posY - _loc4_.posX) * 50 + 405;
            _loc2_++;
         }
         nodeViewList.sortOn(["y","x"],[16,16]);
         _loc3_ = 0;
         while(_loc3_ < nodeViewList.length)
         {
            nodeContiner.setChildIndex(nodeViewList[_loc3_],_loc3_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         MsgMan.addObserver("FANTASYMATRIX_MAP_UPDATE",this,__updateNodeListHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         MsgMan.removeObserver("FANTASYMATRIX_MAP_UPDATE",this,__updateNodeListHandler);
      }
      
      private function __updateNodeListHandler(param1:String, param2:Object) : void
      {
         var _loc6_:FantasyMatrixNodeInfo = null;
         var _loc3_:FantasyMatrixWarNodeView = null;
         var _loc5_:Array = param2 as Array;
         for each(var _loc4_:FantasyMatrixNodeMsg in _loc5_)
         {
            _loc6_ = model.getNodeInfoByXY(_loc4_.posX,_loc4_.posY);
            if(_loc6_)
            {
               _loc3_ = getNodeViewByXY(_loc6_.posX,_loc6_.posY);
               if(_loc3_)
               {
                  _loc3_.data = _loc6_;
               }
            }
         }
      }
      
      public function getNodeViewByXY(param1:int, param2:int) : FantasyMatrixWarNodeView
      {
         for each(var _loc3_:FantasyMatrixWarNodeView in nodeViewList)
         {
            if(param1 == _loc3_.data.posX && param2 == _loc3_.data.posY)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function enterFrame() : void
      {
         for each(var _loc1_:FantasyMatrixWarNodeView in nodeViewList)
         {
            _loc1_.execute();
         }
      }
      
      public function get model() : FantasyMatrixModel
      {
         return CampaignManager.instance.fantasyMatrixModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(nodeContiner);
         nodeContiner = null;
         for each(var _loc1_:FantasyMatrixWarNodeView in nodeViewList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         nodeViewList = null;
         super.dispose();
      }
   }
}

