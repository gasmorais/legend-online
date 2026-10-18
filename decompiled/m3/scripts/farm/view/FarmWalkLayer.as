package farm.view
{
   import com.pickgliss.ui.core.Disposeable;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FarmInfo;
   import farm.view.marrytree.MarryTreeView;
   import flash.display.Sprite;
   import flash.geom.Point;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class FarmWalkLayer extends Sprite implements Disposeable, IEnterFrame
   {
      
      private var _model:FarmModel = FarmManager.instance.model;
      
      private var _pathArray:Array = [];
      
      private var _marryTree:MarryTreeView;
      
      private var _data:FarmInfo;
      
      public function FarmWalkLayer()
      {
         _pathArray[0] = [new Point(904,388),new Point(1020,452),new Point(1176,530),new Point(1307,596),new Point(1176,530),new Point(1020,452),new Point(876,545),new Point(703,661),new Point(623,723)];
         _pathArray[1] = [new Point(904,388),new Point(1020,452),new Point(876,545),new Point(703,661),new Point(623,723),new Point(703,661),new Point(876,545),new Point(1020,452),new Point(1176,530),new Point(1307,596)];
         super();
         initView();
         addEvent();
         EnterFrameManager.instance.registeEnterFrame(this);
         this.data = FarmManager.instance.model.curSelectedFarmInfo;
      }
      
      private function initView() : void
      {
         var _loc1_:AIBaseInfo = new AIBaseInfo();
         _loc1_.speed = 1;
         _marryTree = new MarryTreeView();
         _marryTree.x = 2312;
         _marryTree.y = 695;
         _marryTree.info = null;
         if(_marryTree.feedBtn)
         {
            addChild(_marryTree.lang);
         }
         addChild(_marryTree);
         if(_marryTree.feedBtn)
         {
            addChild(_marryTree.feedBtn);
            _marryTree.feedBtn.visible = false;
         }
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
         if(!_model)
         {
         }
      }
      
      private function selectPathFor(param1:FarmGuardView) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Point = null;
         if(param1)
         {
            param1.clearPath();
            _loc3_ = 1 * Math.random();
            param1.info.pathInfo = _pathArray[_loc3_];
            _loc2_ = _pathArray[_loc3_][0] as Point;
            param1.x = _loc2_.x;
            param1.y = _loc2_.y;
         }
      }
      
      private function set data(param1:FarmInfo) : void
      {
         _data = param1;
      }
      
      public function enterFrame() : void
      {
      }
      
      public function dispose() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         removeEvent();
         if(_marryTree)
         {
            _marryTree.dispose();
         }
         _marryTree = null;
         _model = null;
         data = null;
      }
   }
}

