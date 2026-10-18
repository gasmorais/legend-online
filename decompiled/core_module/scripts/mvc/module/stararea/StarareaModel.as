package mvc.module.stararea
{
   import bag.helper.GoodsCheck;
   import flash.geom.Point;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.StarareaDropTemplate;
   import yishi.datas.templates.StarareaRoadsTemplate;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.HashMap;
   
   public class StarareaModel
   {
      
      public static const DROP_TYPE_BOX:int = 3;
      
      public static const BIG_BOX_ARRAY:Array = [8,9,85,86];
      
      public var width:int = 2659;
      
      public var height:int = 2320;
      
      public var starViewMap:HashMap;
      
      public var myArmy:StarareaArmy;
      
      public var myPointId:int = -1;
      
      public var nodes:Array;
      
      public var roads:Array;
      
      public var lightCount:int;
      
      public var keyCount:int;
      
      public var actionPower:int;
      
      public var isLockMove:Boolean = false;
      
      public const START_NODE_ID:int = 43;
      
      public const TOTAL_NODE_COUNT:int = 92;
      
      public const TOTAL_NODE_BIG_BOX_COUNT:int = 4;
      
      public var targetType:int;
      
      public var gameRoadId:int;
      
      public var isInit:Boolean = false;
      
      private var _isLight:Boolean;
      
      private var _isKey:Boolean;
      
      public var pointFlashArr:Array = [];
      
      public var roadFlashArr:Array = [];
      
      public function StarareaModel()
      {
         super();
         starViewMap = new HashMap();
         nodes = [];
         roads = [];
      }
      
      public function get isKey() : Boolean
      {
         return _isKey;
      }
      
      public function set isKey(param1:Boolean) : void
      {
         _isKey = param1;
         NotificationManager.instance.sendNotification("event.stararea.key",isKey);
      }
      
      public function get isLight() : Boolean
      {
         return _isLight;
      }
      
      public function set isLight(param1:Boolean) : void
      {
         _isLight = param1;
         NotificationManager.instance.sendNotification("event.stararea.light",isLight);
      }
      
      public function getStarPosById(param1:int) : Point
      {
         if(param1 == -1)
         {
            param1 = 43;
         }
         return starViewMap.getValue(param1) as Point;
      }
      
      public function getRoadType(param1:int) : int
      {
         return roads[param1 - 1];
      }
      
      public function getNodeType(param1:int) : int
      {
         return nodes[param1 - 1];
      }
      
      public function canGo(param1:int) : Boolean
      {
         var _loc2_:StarareaRoadsTemplate = null;
         _loc2_ = TempleteManager.instance.starareaRoadsTempCate.getTemplete(myPointId,param1);
         if(_loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function get totalKey() : int
      {
         return ConfigInfoManager.instance.getKeyToArr("star_area_node")[4 - 1];
      }
      
      public function get totalLight() : int
      {
         return ConfigInfoManager.instance.getKeyToArr("star_area_node")[1 - 1];
      }
      
      public function get totalSmallBox() : int
      {
         return ConfigInfoManager.instance.getKeyToArr("star_area_node")[2 - 1];
      }
      
      public function get totalBigBox() : int
      {
         return ConfigInfoManager.instance.getKeyToArr("star_area_node")[5 - 1];
      }
      
      public function get oneStepActionPower() : int
      {
         return ConfigInfoManager.instance.getKeyToArr("star_area_action_power")[0];
      }
      
      public function get totalActionPower() : int
      {
         return ConfigInfoManager.instance.getKeyToArr("star_area_action_power")[1];
      }
      
      public function get boxScore1() : int
      {
         return ConfigInfoManager.instance.getKeyToArr("star_area_box")[0];
      }
      
      public function get boxScore2() : int
      {
         return ConfigInfoManager.instance.getKeyToArr("star_area_box")[1];
      }
      
      public function get mountsId() : int
      {
         return ConfigInfoManager.instance.getKeyToArr("star_area_mounts_id")[0];
      }
      
      public function get mySmallBoxCount() : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < nodes.length)
         {
            _loc3_ = int(nodes[_loc2_]);
            if(_loc3_ % 50 == 2)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get myBigBoxCount() : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < nodes.length)
         {
            _loc3_ = int(nodes[_loc2_]);
            if(_loc3_ % 50 == 5)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getNodeFashion(param1:int) : Array
      {
         var _loc4_:GoodsTemplateInfo = null;
         var _loc2_:Array = TempleteManager.instance.starAreaDropCate.getTemplatesByTypeAndNode(3,param1);
         var _loc5_:Array = [];
         for each(var _loc3_:StarareaDropTemplate in _loc2_)
         {
            _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_.itemId);
            if(GoodsCheck.isFashion(_loc4_))
            {
               _loc5_.push(_loc4_);
            }
         }
         return _loc5_;
      }
      
      public function clear() : void
      {
         isLockMove = false;
      }
   }
}

