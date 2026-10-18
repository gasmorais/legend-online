package mvc.module.war2023
{
   import flash.utils.Dictionary;
   import mvc.module.war2023.info.SecretWarInfo;
   import mvc.module.war2023.info.SecretWarNodeInfo;
   import mvc.module.war2023.info.SecretwarPlayInfo;
   import mvc.module.war2023.info.SecretwarResultInfo;
   import mvc.module.war2023.info.SecretwarSelfInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.TempleteManager;
   
   public class SecretWarModel
   {
      
      public var selfPlay:SecretwarPlayInfo;
      
      private const NODE_XY:Array = [[1100,168],[806,342],[1395,342],[1100,448],[542,510],[1658,511],[306,726],[777,726],[1100,726],[1424,726],[1895,727],[542,947],[1100,1005],[1658,946],[807,1110],[1395,1111],[1101,1284]];
      
      private const NODE_CONNECT_STR:String = "1@2,3,4|2@1,5|3@1,6|4@1,9|5@2,7,8|6@3,10,11|7@5,8,12|8@5,7,9,12|9@4,8,10,13|10@6,9,11,14|11@6,10,14|12@7,8,15|13@9,17|14@10,11,16|15@12,17|16@14,17|17@13,15,16";
      
      private var _selfInfo:SecretwarSelfInfo;
      
      private var _warInfo:SecretWarInfo;
      
      private var _resultInfo:SecretwarResultInfo;
      
      private var _nodeInfos:Dictionary;
      
      private var _playerList:Dictionary;
      
      private var _moveTime:int = 10000;
      
      private var _moveMaxStep:int = 250;
      
      private var _occTime:int = 20;
      
      public var shopInfo:Array = [];
      
      public var refreshCounts:int = 0;
      
      public var nodeScoreParms:Array = [];
      
      public function SecretWarModel()
      {
         var _loc1_:Array = null;
         super();
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("secret_war_cd_time");
         if(_loc2_)
         {
            _loc1_ = _loc2_.ConfigValue.split(",");
            _moveTime = int(_loc1_[0]) * 1000;
            _moveMaxStep = _moveTime / 40;
            _occTime = int(_loc1_[1]);
         }
         var _loc3_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("secret_war_node_score");
         if(_loc3_)
         {
            nodeScoreParms = _loc3_.ConfigValue.split(",");
         }
         restData();
      }
      
      public function restData() : void
      {
         _selfInfo = new SecretwarSelfInfo();
         _warInfo = new SecretWarInfo();
         _resultInfo = new SecretwarResultInfo();
         _nodeInfos = new Dictionary();
         _playerList = new Dictionary();
         initNodes();
      }
      
      public function get occTime() : int
      {
         return _occTime;
      }
      
      public function get moveMaxStep() : int
      {
         return _moveMaxStep;
      }
      
      public function get moveTime() : int
      {
         return _moveTime;
      }
      
      public function get resultInfo() : SecretwarResultInfo
      {
         return _resultInfo;
      }
      
      public function get selfInfo() : SecretwarSelfInfo
      {
         return _selfInfo;
      }
      
      public function get warInfo() : SecretWarInfo
      {
         return _warInfo;
      }
      
      public function get playerList() : Dictionary
      {
         return _playerList;
      }
      
      public function get nodeInfos() : Dictionary
      {
         return _nodeInfos;
      }
      
      private function initNodes() : void
      {
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc2_:int = 0;
         var _loc3_:SecretWarNodeInfo = null;
         var _loc4_:Array = "1@2,3,4|2@1,5|3@1,6|4@1,9|5@2,7,8|6@3,10,11|7@5,8,12|8@5,7,9,12|9@4,8,10,13|10@6,9,11,14|11@6,10,14|12@7,8,15|13@9,17|14@10,11,16|15@12,17|16@14,17|17@13,15,16".split("|");
         for each(var _loc1_:String in _loc4_)
         {
            _loc5_ = _loc1_.split("@");
            _loc2_ = int(_loc5_[0]);
            _loc6_ = _loc5_[1];
            _loc3_ = new SecretWarNodeInfo();
            _loc3_.nodeId = _loc2_;
            _loc3_.connects = _loc6_.split(",");
            _loc3_.x = NODE_XY[_loc2_ - 1][0];
            _loc3_.y = NODE_XY[_loc2_ - 1][1];
            if(_loc2_ == 7)
            {
               _loc3_.type = 3;
            }
            else if(_loc2_ == 11)
            {
               _loc3_.type = 4;
            }
            else
            {
               _loc3_.type = 0;
            }
            _nodeInfos[_loc3_.nodeId] = _loc3_;
         }
      }
      
      public function updateNodePlayers(param1:SecretwarPlayInfo) : void
      {
         for each(var _loc2_:SecretWarNodeInfo in _nodeInfos)
         {
            _loc2_.updatePlays(param1);
         }
      }
   }
}

