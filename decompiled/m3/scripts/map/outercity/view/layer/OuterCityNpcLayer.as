package map.outercity.view.layer
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import map.internals.data.MapInfo;
   import map.internals.data.WildLand;
   import map.internals.event.OuterCityEvent;
   import map.internals.view.physics.MapPhysicsBase;
   import map.outercity.OuterCityModel;
   import map.outercity.mediator.layer.OutercityNpcActivationMediator;
   import map.outercity.view.mapphysics.OuterCityNpcView;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.MediatorMananger;
   
   public class OuterCityNpcLayer extends Sprite implements IEnterFrame, Disposeable
   {
      
      public static const NAME:String = "map.outercity.view.layer.OuterCityNpcLayer";
      
      private var _mediatorKey:String = "";
      
      private var _model:OuterCityModel;
      
      private var _filter:SimpleBuildingFilter;
      
      private var _avatarList:Array = [];
      
      public function OuterCityNpcLayer()
      {
         super();
         this.mouseEnabled = false;
         this.scrollRect = null;
         _filter = new SimpleBuildingFilter();
         initRegister();
      }
      
      public function set mapData(param1:MapInfo) : void
      {
         _model = param1 as OuterCityModel;
         _model.addEventListener("currentWildLand",__initCurrentWildLandHandler);
         _model.addEventListener("REMOVE_NODE_NPC",__removeNodeHandler);
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function initRegister() : void
      {
         var _loc1_:Array = [OutercityNpcActivationMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.outercity.view.layer.OuterCityNpcLayer");
      }
      
      private function __removeNodeHandler(param1:OuterCityEvent) : void
      {
         var _loc3_:OuterCityNpcView = null;
         var _loc2_:WildLand = param1.data as WildLand;
         if(_loc2_ && _loc2_.nodeView)
         {
            _loc3_ = _loc2_.nodeView as OuterCityNpcView;
            if(_loc3_)
            {
               _loc3_.dispose();
               if(_loc3_.parent)
               {
                  _loc3_.parent.removeChild(this);
               }
            }
            _loc3_ = null;
         }
      }
      
      private function __initCurrentWildLandHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         for each(var _loc3_:WildLand in _loc2_)
         {
            addWildLand(_loc3_);
         }
      }
      
      public function updateWildLand(param1:WildLand) : void
      {
         addWildLand(param1);
      }
      
      private function addWildLand(param1:WildLand) : void
      {
         if(param1.info.types != 21)
         {
            return;
         }
         var _loc2_:OuterCityNpcView = param1.nodeView as OuterCityNpcView;
         if(param1.nodeView && !_loc2_)
         {
            (param1.nodeView as MapPhysicsBase).dispose();
            param1.nodeView = null;
         }
         param1.loadTime = getTimer();
         if(_loc2_)
         {
            if(param1.info.state == 1)
            {
               _loc2_.nodeInfo = param1;
            }
         }
         else if(param1.info.state == 1 || param1.info.state == 4)
         {
            addNpcView(param1);
         }
      }
      
      public function enterFrame() : void
      {
         var _loc3_:Dictionary = _model.allWildLand;
         for each(var _loc1_:Dictionary in _loc3_)
         {
            for each(var _loc2_:WildLand in _loc1_)
            {
               if(_loc2_.nodeView is OuterCityNpcView)
               {
                  (_loc2_.nodeView as OuterCityNpcView).execute();
               }
            }
         }
      }
      
      private function addNpcView(param1:WildLand) : void
      {
         var _loc2_:OuterCityNpcView = new OuterCityNpcView();
         _loc2_.nodeInfo = param1;
         _loc2_.info = new AIBaseInfo();
         _loc2_.info.pathInfo = [];
         _loc2_.filter = _filter;
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         param1.nodeView = _loc2_;
         _avatarList.push(_loc2_);
         addChild(_loc2_);
      }
      
      public function get avatarList() : Array
      {
         return _avatarList;
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:OuterCityNpcView = param1.target as OuterCityNpcView;
         if(_loc2_ && _loc2_.visible)
         {
            return _loc2_.mouseMoveHandler(param1);
         }
         for each(_loc2_ in _avatarList)
         {
            if(_loc2_.visible && _loc2_.mouseMoveHandler(param1))
            {
               return true;
            }
         }
         return false;
      }
      
      public function dispose() : void
      {
         var _loc1_:OuterCityNpcView = null;
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         _model.removeEventListener("currentWildLand",__initCurrentWildLandHandler);
         _model.removeEventListener("REMOVE_NODE_NPC",__removeNodeHandler);
         while(_avatarList.length > 0)
         {
            _loc1_ = _avatarList.pop();
            _loc1_.dispose();
         }
         _avatarList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

